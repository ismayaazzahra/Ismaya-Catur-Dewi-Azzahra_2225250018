# CLAUDE.md — Panduan Claude Code untuk BoxBuster

## Tentang Proyek
BoxBuster adalah **PWA statis** untuk siswa SMP kelas VII belajar **Bruto, Netto, Tara** (Aritmetika Sosial). Dibangun oleh mahasiswa S1 Pendidikan Matematika berdasarkan wawancara beban kognitif siswa.
Tujuan pedagogis: mengurangi beban kognitif ekstrinsik, mencegah tertukarnya istilah, menuntaskan **persen tara**, dan menumbuhkan **literasi matematika**.

Sebelum menambah/mengubah fitur, baca:
- [docs/PRD.md](docs/PRD.md) — apa yang dibangun
- [docs/ANALISIS_KEBUTUHAN.md](docs/ANALISIS_KEBUTUHAN.md) — **mengapa** (setiap fitur harus terlacak ke kode temuan K/IL/EL/GL/DS)
- [docs/ARSITEKTUR.md](docs/ARSITEKTUR.md) — bagaimana
- [docs/ROADMAP.md](docs/ROADMAP.md) — urutan kerja & definition of done

## Perintah
```bash
npm install
npm run dev                      # dev server
npm test                         # Vitest (unit + komponen)
npx playwright test              # e2e (Pixel 5, 360x640, desktop)
npm run lint                     # ESLint + Prettier check
npm run build && npm run preview # cek PWA/offline

pip install -r tools/requirements.txt
python tools/validate_soal.py    # WAJIB setelah mengubah src/data/*.json
python tools/generate_soal.py
pytest tools/tests
ruff check tools
```

## Stack (jangan diganti tanpa persetujuan user)
React 18 + Vite 5 (JavaScript/JSX, **bukan TypeScript**) · React Router `HashRouter` · Zustand + persist · Tailwind CSS · Framer Motion (lazy, hanya Bongkar Kotak) · vite-plugin-pwa · Python 3.11 + Pydantic untuk tooling soal · GitHub Pages.

## Struktur
- `src/routes/` satu file per halaman · `src/components/` komponen UI · `src/lib/` logika murni (hitung, format, satuan, soalEngine, install) · `src/store/` Zustand · `src/data/` JSON konten · `src/assets/` SVG
- `tools/` Python (schema, generator, validator) · `tests/unit`, `tests/e2e`

## Aturan Wajib (berasal dari temuan wawancara)
1. **Warna konsep tetap** di seluruh aplikasi: Bruto biru `--c-bruto`, Netto hijau `--c-netto`, Tara oranye `--c-tara`, Harga ungu `--c-harga`. Jangan pakai warna ini untuk hal lain. Selalu sertakan ikon + teks (bukan warna saja). *(IL01)*
2. **Satu model relasi**: tampilkan Bruto = Netto + Tara via `BarModel`; jangan menyajikan tiga rumus terpisah untuk dihafal. *(IL02)*
3. **Persen tara selalu dihitung dari bruto.** Semua teks, contoh, dan logika harus konsisten. *(IL04, IL05)*
4. **Microcopy ≤ 15 kata per kalimat**, satu ide per layar, sapaan "kamu", Bahasa Indonesia sederhana. *(DS03)*
5. **Tempo dikendalikan siswa**: tidak ada penjelasan/animasi yang maju otomatis. *(EL02, EL04)*
6. **Ilustrasi SVG** (tajam, bisa diperbesar), dengan `role="img"` dan `aria-label`. *(EL03)*
7. **Umpan balik salah harus menyebut miskonsepsinya** (lihat `src/data/miskonsepsi.json`). *(IL05)*
8. **Offline-safe**: tidak ada CDN, font eksternal, API, atau fetch ke luar. Semua aset di-bundle & di-precache.
9. **Privasi**: tidak ada backend, login ke server, analitik, atau data pribadi yang keluar perangkat. "Masuk/Daftar" hanyalah **profil lokal** (nama panggilan, kelas opsional, karakter) tanpa password; daftar profil di `localStorage` key `boxbuster:profil`, progres per profil di `boxbuster:p:<id>`. Semua akses dalam `try/catch`.
10. **Mobile-first**: uji di lebar 360 px; target sentuh ≥ 48 px; teks ≥ 16 px; hormati `prefers-reduced-motion`.
11. Jangan memakai `window.alert/confirm/prompt` — gunakan `ConfirmDialog`.
12. Jangan memakai merek dagang produk nyata pada ilustrasi/soal.

## Konvensi Kode
- Komponen fungsional + hooks; nama komponen `PascalCase.jsx`; util `camelCase.js`.
- Teks UI dalam Bahasa Indonesia; nama variabel/fungsi domain boleh Bahasa Indonesia (`hitungNetto`, `persenTara`) agar sesuai istilah materi; komentar singkat.
- Logika perhitungan **hanya** di `src/lib/` sebagai fungsi murni + unit test. Komponen tidak menghitung sendiri.
- Angka: simpan sebagai `number`; tampilkan dengan `lib/format.js` (koma desimal, titik ribuan); bandingkan jawaban setelah pembulatan 2 desimal ± `toleransi`.
- Konten (soal, contoh, misi, kamus) di JSON, bukan di-hardcode dalam komponen.

## Konten Soal
- Skema & aturan: [docs/KONTEN_DAN_SOAL.md](docs/KONTEN_DAN_SOAL.md#2-skema-json-soal).
- Setiap pengecoh harus punya kode miskonsepsi yang valid.
- Variasikan **yang ditanya** dan konteks, bukan hanya angka. *(GL05)*
- Selalu jalankan `python tools/validate_soal.py` setelah mengubah `src/data/soal.json`; CI akan gagal jika ada kunci jawaban salah.

## Definition of Done (setiap fitur)
- [ ] Terlacak ke kode temuan di ANALISIS_KEBUTUHAN.md
- [ ] Unit test untuk logika baru; e2e untuk alur baru
- [ ] Berfungsi offline (`npm run build && npm run preview`, lalu offline di DevTools)
- [ ] Rapi di 360 px dan mode gelap
- [ ] Lolos lint, `npm test`, `validate_soal.py`
