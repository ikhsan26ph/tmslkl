#!/usr/bin/env python3
"""Konversi JSON reporter Playwright -> skema results/ (docs/agent-guide.md).

Usage:
    python3 scripts/playwright_to_results.py results/_playwright/last-run.json <modul>

- Judul test harus berformat "SCN-xxxx: ..." — ID dipakai untuk menyalin metadata
  (id/title/category/priority/requirements/screen) apa adanya dari scenario/<modul>/*_scenarios.json.
- Screenshot kegagalan disalin ke artifacts/screenshots/<runId>/<SCN-ID>.png.
- Jika setup login gagal, seluruh skenario ditandai blocked.

Baris terakhir stdout = path file hasil (dipakai scripts/run-playwright.sh).
"""
import json
import re
import shutil
import sys
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SCN_RE = re.compile(r"^(SCN-\d+)")
ANSI_RE = re.compile(r"\x1b\[[0-9;]*m")
PLACEHOLDER_RE = re.compile(r"ISI_DISINI|ISI_SETELAH_EXPLORE", re.I)
HEADER_WORDS = {"Key", "No"}

STATUS_MAP = {
    "passed": "passed",
    "failed": "failed",
    "timedOut": "failed",
    "interrupted": "blocked",
    "skipped": "skipped",
}


def _split_cells(line):
    """Pecah baris tabel markdown; `\\|` di dalam nilai dibaca sebagai pipa literal."""
    return [c.replace("\x00", "|").strip() for c in line.replace("\\|", "\x00").split("|")]


def _clean(raw):
    v = re.sub(r"\(contoh:[^)]*\)", "", raw or "", flags=re.I).strip()
    v = re.sub(r"^`(.*)`$", r"\1", v).strip()
    return None if not v or PLACEHOLDER_RE.search(v) else v


def parse_env_md():
    """Baca tabel Aplikasi (baseUrl + key login*) dan akun utama dari config/env.md.

    Struktur tabel harus sama dengan yang di-parse tests/helpers/env.js. Hanya baseUrl,
    user, dan role yang dipakai untuk field `environment` di results/ — password tidak pernah dibaca.
    """
    app, user, role = {}, None, None
    for line in (ROOT / "config" / "env.md").read_text(encoding="utf-8").splitlines():
        cells = _split_cells(line)
        if len(cells) < 4:
            continue
        if re.fullmatch(r"[A-Za-z]\w*", cells[1]) and cells[1] not in HEADER_WORDS:
            app[cells[1]] = _clean(cells[2])
        elif len(cells) >= 6 and cells[1].isdigit() and user is None:
            email = _clean(cells[2])
            if email and "@" in email and cells[3] and not PLACEHOLDER_RE.search(cells[3]):
                user, role = email, cells[4]
    base_url = app.get("baseUrl")
    if base_url and not base_url.startswith("http"):
        base_url = "https://" + base_url
    return {"baseUrl": base_url, "user": user, "role": role}


def load_scenario_meta(module):
    files = list((ROOT / "scenario" / module).glob("*_scenarios.json")) or \
        list((ROOT / "scenario" / module).glob("*.scenarios.json"))
    if not files:
        sys.exit(f"scenario/{module}/*_scenarios.json (atau *.scenarios.json) tidak ditemukan")
    data = json.loads(files[0].read_text(encoding="utf-8"))
    return {s["id"]: s for s in data.get("scenarios", [])}


def walk_specs(suite, out):
    for spec in suite.get("specs", []):
        out.append(spec)
    for child in suite.get("suites", []):
        walk_specs(child, out)


def clean(msg):
    return ANSI_RE.sub("", msg or "").strip() or None


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    report_path, module = Path(sys.argv[1]), sys.argv[2]
    report = json.loads(report_path.read_text(encoding="utf-8"))
    meta = load_scenario_meta(module)
    env = parse_env_md()

    stats = report.get("stats", {})
    started = stats.get("startTime")
    started_dt = datetime.fromisoformat(started.replace("Z", "+00:00")) if started else datetime.now(timezone.utc)
    run_id = started_dt.astimezone().strftime("%Y%m%d-%H%M%S")
    duration_ms = stats.get("duration") or 0
    finished_dt = datetime.fromtimestamp(started_dt.timestamp() + duration_ms / 1000, tz=timezone.utc)

    specs = []
    for suite in report.get("suites", []):
        walk_specs(suite, specs)

    shot_dir = ROOT / "artifacts" / "screenshots" / run_id
    scenarios = []
    for spec in specs:
        m = SCN_RE.match(spec.get("title", ""))
        if not m:
            continue  # test non-skenario (mis. setup login)
        scn_id = m.group(1)
        src = meta.get(scn_id, {})
        tests = spec.get("tests", [])
        result = (tests[0].get("results") or [{}])[-1] if tests else {}
        raw_status = result.get("status", "skipped")
        status = STATUS_MAP.get(raw_status, "blocked")

        errors = result.get("errors") or ([result["error"]] if result.get("error") else [])
        error = clean(" | ".join(e.get("message", "") for e in errors)[:1000]) if errors else None

        notes = []
        for t in tests:
            for a in t.get("annotations", []):
                if a.get("description"):
                    prefix = "[skip] " if a.get("type") == "skip" else ""
                    notes.append(prefix + a["description"])

        # Kegagalan login / konfigurasi login dari fixture (tests/helpers/fixtures.js)
        # = environment, bukan bug skenario.
        if error and ("Login TMS gagal" in error or "Login sudah gagal" in error
                      or "key login belum dikalibrasi" in error):
            status = "blocked"

        screenshot = None
        for att in result.get("attachments", []):
            if att.get("name") == "screenshot" and att.get("path") and Path(att["path"]).exists():
                shot_dir.mkdir(parents=True, exist_ok=True)
                dest = shot_dir / f"{scn_id}.png"
                shutil.copyfile(att["path"], dest)
                screenshot = str(dest.relative_to(ROOT))
                break

        scenarios.append({
            "id": src.get("id", scn_id),
            "title": src.get("title", spec.get("title", "")),
            "category": src.get("category", ""),
            "priority": src.get("priority", ""),
            "screen": src.get("screen", ""),
            "requirements": src.get("requirements", []),
            "status": status,
            "durationSec": round((result.get("duration") or 0) / 1000, 1),
            "error": error,
            "screenshot": screenshot,
            "bugCandidate": None,
            "notes": "; ".join(notes),
        })

    scenarios.sort(key=lambda s: s["id"])
    out = {
        "module": module,
        "runId": run_id,
        "startedAt": started_dt.isoformat(),
        "finishedAt": finished_dt.isoformat(),
        "environment": {**env, "executor": "playwright-script"},
        "scenarios": scenarios,
    }
    out_path = ROOT / "results" / f"{module}__{run_id}.json"
    out_path.write_text(json.dumps(out, ensure_ascii=False, indent=2), encoding="utf-8")
    counts = {}
    for s in scenarios:
        counts[s["status"]] = counts.get(s["status"], 0) + 1
    print(f"{len(scenarios)} skenario -> {counts}", file=sys.stderr)
    print(out_path.relative_to(ROOT))


if __name__ == "__main__":
    main()
