// Parser config/env.md — satu-satunya sumber baseUrl, konfigurasi login, dan kredensial
// (aturan docs/agent-guide.md: jangan pernah menebak URL/selector login/kredensial).
// Jangan pernah mencetak password ke log/report.
const fs = require('fs');
const path = require('path');

const PLACEHOLDER_RE = /ISI_DISINI|ISI_SETELAH_EXPLORE/i;
const LOGIN_KEYS = [
  'loginPath',
  'loginSuccessUrlPattern',
  'loginEmailSelector',
  'loginPasswordSelector',
  'loginButtonSelector',
];
const HEADER_WORDS = new Set(['Key', 'No']);

// Pecah baris tabel markdown menjadi sel; `\|` di dalam nilai dibaca sebagai pipa literal.
function splitCells(line) {
  return line
    .replace(/\\\|/g, '\u0000')
    .split('|')
    .map((c) => c.replace(/\u0000/g, '|').trim());
}

// Nilai kosong / placeholder -> null. Backtick pembungkus dan "(contoh: ...)" dibuang.
function cleanValue(raw) {
  const v = (raw || '')
    .replace(/\(contoh:[^)]*\)/i, '')
    .trim()
    .replace(/^`(.*)`$/, '$1')
    .trim();
  return !v || PLACEHOLDER_RE.test(v) ? null : v;
}

function parseEnv() {
  const file = path.join(__dirname, '..', '..', 'config', 'env.md');
  const md = fs.readFileSync(file, 'utf8');
  const app = {};
  const accounts = [];
  for (const line of md.split('\n')) {
    const cells = splitCells(line);
    if (cells.length < 4) continue;
    // Baris tabel Aplikasi: | key | nilai | keterangan |
    if (/^[A-Za-z]\w*$/.test(cells[1]) && !HEADER_WORDS.has(cells[1])) {
      app[cells[1]] = cleanValue(cells[2]);
      continue;
    }
    // Baris tabel Akun: | 1 | email | password | role | keterangan |
    if (cells.length >= 6 && /^\d+$/.test(cells[1])) {
      const email = cleanValue(cells[2]);
      const password = cells[3] && !PLACEHOLDER_RE.test(cells[3]) ? cells[3] : null;
      if (email && email.includes('@') && password) {
        accounts.push({ email, password, role: cells[4] });
      }
    }
  }

  let baseUrl = app.baseUrl;
  if (!baseUrl) {
    throw new Error('config/env.md: baseUrl belum diisi — hentikan dan minta user mengisinya.');
  }
  if (!/^https?:\/\//.test(baseUrl)) baseUrl = 'https://' + baseUrl;
  if (accounts.length === 0) {
    throw new Error('config/env.md: tidak ada akun dengan email+password terisi.');
  }
  const login = {};
  for (const k of LOGIN_KEYS) login[k] = app[k] || null;
  return { baseUrl, login, accounts, main: accounts[0] };
}

// Dipakai fixture login: semua key login harus sudah terisi (bukan ISI_SETELAH_EXPLORE).
function requireLogin(env) {
  const missing = LOGIN_KEYS.filter((k) => !env.login[k]);
  if (missing.length) {
    throw new Error(
      `config/env.md: key login belum dikalibrasi: ${missing.join(', ')}. ` +
        'Jalankan /explore (kalibrasi login) lalu isi nilainya di tabel Aplikasi.'
    );
  }
  return env.login;
}

module.exports = { parseEnv, requireLogin, LOGIN_KEYS };
