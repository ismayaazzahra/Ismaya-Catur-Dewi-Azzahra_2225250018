# Deployment & Instalasi BoxBuster

BoxBuster dipublikasikan sebagai **PWA di GitHub Pages**. Siswa cukup membuka link (atau scan QR) lalu memasangnya ke layar utama — **tanpa Play Store / App Store**.

URL rencana: `https://<username-github>.github.io/BoxBuster/`

## 1. Persiapan Repository (sekali saja)
1. Buat akun GitHub (gratis) jika belum ada.
2. Buat repository publik bernama **`BoxBuster`**.
3. Di folder proyek:
   ```bash
   git init
   git add .
   git commit -m "Inisialisasi BoxBuster"
   git branch -M main
   git remote add origin https://github.com/<username-github>/BoxBuster.git
   git push -u origin main
   ```
4. Di GitHub: **Settings → Pages → Build and deployment → Source: GitHub Actions**.

> Jika nama repository diubah, ubah juga `base` di `vite.config.js` serta `start_url`/`scope` manifest.

## 2. Alur CI/CD (GitHub Actions)
File: `.github/workflows/deploy.yml` — berjalan setiap *push* ke `main`.

```yaml
name: Deploy BoxBuster
on:
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with: { python-version: '3.11' }
      - run: pip install -r tools/requirements.txt
      - run: python tools/validate_soal.py
      - run: pytest tools/tests
      - uses: actions/setup-node@v4
        with: { node-version: '20', cache: 'npm' }
      - run: npm ci
      - run: npm test -- --run
      - run: npm run build
      - uses: actions/upload-pages-artifact@v3
        with: { path: dist }
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```
Urutan: **validasi soal (Python) → uji Python → uji JS → build → deploy.** Jika ada soal yang kunci jawabannya salah, deploy dibatalkan.

## 3. Rilis Versi Baru
1. Ubah kode/soal → `python tools/validate_soal.py` → `npm test` → commit → push.
2. GitHub Actions men-deploy otomatis (±2 menit).
3. Siswa yang sudah memasang aplikasi melihat pesan **"Versi baru tersedia — Muat ulang"** saat membuka aplikasi dalam keadaan online.

## 4. Cara Memasang Aplikasi (untuk siswa)

### Android (Chrome)
1. Scan QR atau buka link BoxBuster di **Chrome**.
2. Ketuk tombol **"Pasang BoxBuster"** di aplikasi, **atau** menu **⋮ → Instal aplikasi / Tambahkan ke layar utama**.
3. Ketuk **Instal**. Ikon BoxBuster muncul di layar utama.
4. Buka sekali saat online; setelah itu bisa dipakai **tanpa internet**.

> Browser lain (Samsung Internet, Edge) juga mendukung. Browser bawaan aplikasi chat (mis. membuka link dari dalam aplikasi pesan) mungkin tidak bisa memasang — pilih "Buka di Chrome".

### iPhone/iPad (Safari)
1. Buka link di **Safari**.
2. Ketuk ikon **Bagikan (□↑)** → **Tambah ke Layar Utama** → **Tambah**.

### Laptop/PC (Chrome/Edge)
Klik ikon **instal (⊕)** di ujung kanan bilah alamat → **Instal**.

### (Opsional, nanti) File APK
Jika sekolah membutuhkan file `.apk`: buka pwabuilder.com → masukkan URL BoxBuster → **Package for stores → Android** → unduh APK → bagikan langsung (siswa perlu mengizinkan "Instal dari sumber tidak dikenal"). Tetap tanpa Play Store.

## 5. QR Code & Brosur
1. Buat QR code dari URL BoxBuster dengan generator QR apa pun yang menghasilkan PNG/SVG beresolusi tinggi (uji hasil scan dengan 2–3 HP berbeda).
2. Ukuran cetak QR minimal **3 × 3 cm**, dengan margin putih di sekelilingnya.
3. Cantumkan juga URL dalam teks (untuk yang tidak bisa scan).

### Contoh isi brosur
```
📦 BoxBuster
Bongkar kotaknya, temukan beratnya!

Bingung bedain bruto, netto, dan tara?
Belajar sambil "membongkar" kemasan jajanan favoritmu!

✔ Gambar jelas, langkah demi langkah
✔ Latihan dari mudah ke sulit
✔ Bisa dipakai tanpa internet
✔ Gratis, tanpa Play Store

[ QR CODE ]
Scan → buka di Chrome → ketuk "Pasang BoxBuster"
https://<username-github>.github.io/BoxBuster/

Untuk siswa SMP kelas VII · Aritmetika Sosial
Dibuat oleh: Ismaya Catur Dewi Azzahra — S1 Pendidikan Matematika
```

## 6. Pemecahan Masalah
| Masalah | Solusi |
|---|---|
| Tombol pasang tidak muncul | Pastikan dibuka di Chrome (bukan browser dalam aplikasi chat); muat ulang sekali; cek tidak dalam mode Incognito |
| Halaman 404 setelah deploy | Periksa `base: '/BoxBuster/'` di `vite.config.js` sama dengan nama repository |
| Versi lama terus tampil | Tutup semua tab BoxBuster lalu buka lagi saat online; atau Pengaturan situs → Hapus data |
| Progres hilang | Data browser terhapus; progres disimpan per perangkat & per browser |
| Gagal deploy di Actions | Lihat tab **Actions** → langkah yang merah; biasanya `validate_soal.py` menemukan soal yang salah |
