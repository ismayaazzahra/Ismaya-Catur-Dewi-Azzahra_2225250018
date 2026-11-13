# Arsitektur BoxBuster

## 1. Gambaran Umum
BoxBuster adalah **Progressive Web App (PWA) statis**:
- **JavaScript (React + Vite)** → seluruh aplikasi yang berjalan di browser/HP.
- **Python** → *tooling konten*: membuat dan memvalidasi bank soal (`soal.json`) sebelum build.
- **Tanpa server/backend.** Di-host di **GitHub Pages** (HTTPS gratis). Progres siswa disimpan di `localStorage` perangkat.

```
 ┌──────────── Waktu pengembangan ────────────┐        ┌──────── Perangkat siswa ────────┐
 │                                            │        │                                 │
 │  tools/*.py ──► src/data/soal.json ──┐     │        │  Browser / PWA terpasang        │
 │  (generate + validate, pytest)       │     │ deploy │  ┌──────────────────────────┐   │
 │                                      ▼     │ ─────► │  │ React app (offline)      │   │
 │  src/ (React) ──► vite build ──► dist/ ────┼──GH──► │  │ Service worker (cache)   │   │
 │                   + vite-plugin-pwa        │ Pages  │  │ localStorage (progres)   │   │
 └────────────────────────────────────────────┘        │  └──────────────────────────┘   │
                                                       └─────────────────────────────────┘
```

## 2. Tech Stack
| Lapisan | Pilihan | Alasan |
|---|---|---|
| Bahasa UI | JavaScript (ES2022) + JSX | Sesuai permintaan; tanpa langkah kompilasi tipe |
| Framework | React 18 | Komponen interaktif (bar model, labeli angka) |
| Build tool | Vite 5 | Cepat, output kecil, plugin PWA matang |
| Routing | React Router 6 — `HashRouter` | Aman di GitHub Pages (tanpa konfigurasi rewrite 404) |
| State | Zustand + middleware `persist` | Ringan (~1 KB), mudah disimpan ke `localStorage` |
| Styling | Tailwind CSS 3 + CSS variables (token warna) | Cepat menyusun UI mobile-first; mode gelap via `class` |
| Animasi | Framer Motion (hanya di modul Bongkar Kotak, *lazy-loaded*) | Gestur geser & transisi kemasan |
| PWA | `vite-plugin-pwa` (Workbox, strategi `generateSW`) | Manifest + service worker + precache otomatis |
| Uji JS | Vitest + React Testing Library; Playwright (e2e) | Lihat [TESTING.md](TESTING.md) |
| Tooling konten | Python 3.11+, Pydantic 2, pytest | Validasi skema & hitung ulang jawaban |
| Lint/format | ESLint + Prettier; Ruff (Python) | Konsistensi kode |
| CI/CD | GitHub Actions → GitHub Pages | Otomatis validasi, uji, build, deploy |

Tidak ada pustaka yang dimuat dari CDN saat runtime → semuanya di-bundle agar offline.

## 3. Struktur Folder
```
BoxBuster/
├── CLAUDE.md
├── README.md
├── docs/                         # dokumen perencanaan
├── index.html
├── package.json
├── vite.config.js                # base '/BoxBuster/', konfigurasi PWA
├── tailwind.config.js
├── public/
│   ├── icons/                    # icon-192.png, icon-512.png, maskable-512.png, apple-touch-icon.png
│   └── favicon.svg
├── src/
│   ├── main.jsx                  # entry, registrasi service worker
│   ├── App.jsx                   # HashRouter + layout
│   ├── routes/                   # satu file per halaman
│   │   ├── Beranda.jsx
│   │   ├── BongkarKotak.jsx
│   │   ├── Kamus.jsx
│   │   ├── ContohBertahap.jsx
│   │   ├── Latihan.jsx
│   │   ├── MisiLiterasi.jsx
│   │   ├── AlatHitung.jsx
│   │   ├── UjiPemahaman.jsx
│   │   ├── Rapor.jsx
│   │   └── Pengaturan.jsx
│   ├── components/               # BarModel, KemasanSVG, IstilahChip, AngkaTag, StepCard,
│   │                             # NumberInput, FeedbackSheet, HintButton, Boxy, InstallBanner, ConfirmDialog
│   ├── lib/
│   │   ├── hitung.js             # logika murni bruto/netto/tara/persen (diuji unit)
│   │   ├── format.js             # format & parse angka Indonesia (koma desimal, titik ribuan)
│   │   ├── satuan.js             # konversi g/ons/kg/kuintal
│   │   ├── soalEngine.js         # ambil/acak soal, cek jawaban, cocokkan miskonsepsi
│   │   └── install.js            # beforeinstallprompt & deteksi iOS/standalone
│   ├── store/
│   │   └── useProgress.js        # Zustand + persist
│   ├── data/
│   │   ├── soal.json             # DIHASILKAN/DIVALIDASI oleh tools/ — jangan edit tanpa validasi
│   │   ├── contoh.json           # worked examples per level
│   │   ├── misi.json             # misi literasi
│   │   ├── kamus.json            # istilah & sinonim
│   │   └── miskonsepsi.json      # kode miskonsepsi → pesan umpan balik
│   ├── assets/
│   │   ├── kemasan/*.svg
│   │   └── boxy/*.svg
│   └── styles/index.css          # Tailwind + token warna (CSS variables)
├── tests/
│   ├── unit/                     # *.test.js(x) — Vitest
│   └── e2e/                      # *.spec.js — Playwright
└── tools/                        # Python
    ├── requirements.txt          # pydantic, pytest, ruff
    ├── schema.py                 # model Pydantic untuk soal
    ├── generate_soal.py          # generator soal parametris
    ├── validate_soal.py          # validator (dipakai CI)
    ├── templates/                # template soal (YAML/JSON) per level
    └── tests/test_*.py
```

## 4. Logika Inti (`src/lib/hitung.js`)
Fungsi murni, tanpa efek samping:
```js
hitungBruto({ netto, tara })              // netto + tara
hitungNetto({ bruto, tara })              // bruto - tara
hitungTara({ bruto, netto })              // bruto - netto
taraDariPersen({ bruto, persen })         // bruto * persen / 100
nettoDariPersen({ bruto, persen })        // bruto * (100 - persen) / 100
brutoDariNettoPersen({ netto, persen })   // netto / ((100 - persen) / 100)
persenTara({ bruto, tara })               // tara / bruto * 100
selesaikan(inputParsial)                  // dipakai Alat Hitung: isi nilai yang hilang + daftar langkah
cekKewajaran({ bruto, netto, tara })      // { valid, pesan[] } — netto ≤ bruto, tara ≤ bruto, ≥ 0
```
- Pembulatan untuk tampilan: maksimal 2 desimal; perbandingan jawaban memakai `toleransi` dari soal (default 0, dibandingkan setelah pembulatan 2 desimal untuk menghindari galat floating point).
- Logika yang sama diimplementasikan ulang di `tools/schema.py` agar validator Python independen dari kode JS (saling mengecek).

## 5. Mesin Soal (`soalEngine.js`)
1. `ambilSoal(level, n)` → acak (Fisher–Yates) dari `soal.json`, hindari soal yang baru dijawab benar.
2. `periksa(soal, jawabanSiswa)` → `{ benar, miskonsepsi | null }`
   - cocokkan nilai dengan `jawaban` (± toleransi);
   - jika salah, cocokkan dengan setiap `pengecoh.nilai` → kembalikan kode miskonsepsi;
   - untuk isian, juga cek pola umum (mis. hasil = penjumlahan saat seharusnya pengurangan).
3. Pesan umpan balik diambil dari `miskonsepsi.json`.

## 6. State & Penyimpanan
`localStorage` key: **`boxbuster:v1`**
```json
{
  "versiSkema": 1,
  "namaPanggilan": "Raka",
  "pengaturan": { "tema": "sistem", "kurangiGerak": false },
  "level": { "1": { "bintang": 3, "benar": 8, "total": 8, "selesai": true } },
  "bongkarKotakSelesai": true,
  "misiSelesai": ["bu-sari"],
  "miskonsepsiTercatat": { "persen-dari-netto": 2 },
  "lencana": ["pembongkar-pemula"],
  "ujiTerakhir": { "skor": 8, "tanggal": "2026-11-20", "perTP": { "TP1": [2, 2] } }
}
```
- Migrasi skema via opsi `version` + `migrate` di Zustand `persist`.
- Semua akses dibungkus `try/catch`; aplikasi tetap berjalan bila storage tidak tersedia (mode privat).
- Tidak ada data yang dikirim keluar perangkat.

## 7. PWA & Offline
**Manifest** (dibuat oleh `vite-plugin-pwa`):
```js
{
  name: 'BoxBuster — Bongkar Bruto, Netto, Tara',
  short_name: 'BoxBuster',
  description: 'Belajar bruto, netto, dan tara dengan membongkar kotak.',
  lang: 'id',
  start_url: '/BoxBuster/',
  scope: '/BoxBuster/',
  display: 'standalone',
  orientation: 'portrait',
  theme_color: '#B45309',
  background_color: '#FFFBF5',
  icons: [ /* 192, 512, maskable 512 */ ]
}
```
**Service worker** (Workbox `generateSW`):
- `registerType: 'prompt'` → tampilkan "Versi baru tersedia, muat ulang?" saat ada pembaruan.
- `globPatterns: ['**/*.{js,css,html,svg,png,json,woff2}']` → **precache semuanya**, termasuk `soal.json`.
- Navigasi fallback ke `index.html` (aman karena `HashRouter`).

**Instalasi:**
- Android/desktop Chrome/Edge: tangkap `beforeinstallprompt`, tampilkan `InstallBanner` → `prompt()`.
- iOS Safari: deteksi `navigator.standalone === false` + UA iOS → tampilkan panduan "Bagikan → Tambah ke Layar Utama".
- Sembunyikan banner jika `display-mode: standalone`.

## 8. Tooling Python
| Skrip | Fungsi |
|---|---|
| `tools/schema.py` | Model Pydantic `Soal`, `Angka`, `Pengecoh`; enum peran, tipe, miskonsepsi |
| `tools/generate_soal.py` | Membaca `tools/templates/*.yaml` → mengisi angka dari rentang yang menghasilkan angka "bersih" → menghitung jawaban & pengecoh otomatis per miskonsepsi → menggabungkan dengan soal tulisan tangan → `src/data/soal.json` |
| `tools/validate_soal.py` | (1) validasi skema; (2) **hitung ulang jawaban** dari `angka` + `ditanya`; (3) pengecoh ≠ jawaban & unik; (4) id unik; (5) setiap kalimat ≤ 15 kata; (6) file `ilustrasi` ada; (7) minimal 8 soal per level. Keluar dengan kode ≠ 0 jika gagal (dipakai CI) |

Perintah:
```bash
pip install -r tools/requirements.txt
python tools/generate_soal.py      # opsional, menambah soal hasil generator
python tools/validate_soal.py      # wajib sebelum commit
pytest tools/tests
```

## 9. Anggaran Performa
| Item | Batas |
|---|---|
| JS awal (gzip) | ≤ 150 KB (Framer Motion & modul besar di-*lazy-load* per rute) |
| Total precache | ≤ 2 MB |
| Gambar | SVG; PNG hanya untuk ikon PWA |
| Font | font sistem (0 KB) |

## 10. Keamanan & Privasi
- Situs statis tanpa input ke server → permukaan serangan minimal.
- Tidak memakai `dangerouslySetInnerHTML` untuk teks soal; sorotan istilah dirender sebagai komponen React.
- Tanpa cookie, tanpa analitik pihak ketiga.
- Content Security Policy via `<meta http-equiv>`: `default-src 'self'; img-src 'self' data:; style-src 'self' 'unsafe-inline'`.

## 11. Opsi Masa Depan
- **APK sideload** (tetap tanpa Play Store): bungkus PWA dengan PWABuilder (Trusted Web Activity) → file `.apk` dibagikan langsung.
- Narasi suara memakai Web Speech API (offline di sebagian perangkat).
