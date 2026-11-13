# Roadmap BoxBuster

Estimasi untuk 1 pengembang (mahasiswa) dibantu Claude Code, ±10–15 jam/minggu.
Setiap milestone diakhiri dengan deploy ke GitHub Pages agar bisa dicoba di HP.

| Milestone | Isi | Estimasi | Bergantung pada |
|---|---|---|---|
| **M0** Fondasi | Setup proyek, PWA, CI/CD, design token | 1 minggu | — |
| **M1** Kenali | Bongkar Kotak, Kamus Istilah, BarModel | 1–2 minggu | M0 |
| **M2** Pahami | Contoh Bertahap, mesin soal, Latihan L1–L2, Python validator | 2 minggu | M1 |
| **M3** Persen Tara & Literasi | Latihan L3–L5, Misi Literasi, Labeli Angka | 2 minggu | M2 |
| **M4** Alat & Evaluasi | Alat Hitung, Uji Pemahaman, Rapor, Progres & Lencana | 1–2 minggu | M3 |
| **M5** Pemolesan | Aksesibilitas, performa, mode gelap, uji perangkat | 1 minggu | M4 |
| **M6** Validasi & Uji Coba | Validasi ahli, uji coba siswa, revisi | 2–3 minggu | M5 |
| **Rilis 1.0** | Rilis final + QR brosur | — | M6 |

---

## M0 — Fondasi
- [ ] `npm create vite@latest` (React, JavaScript); pasang Tailwind, React Router, Zustand, vite-plugin-pwa.
- [ ] `vite.config.js`: `base: '/BoxBuster/'`, manifest, ikon PWA sementara.
- [ ] Token warna konsep & antarmuka di `src/styles/index.css` (lihat [UI_UX.md](UI_UX.md#2-design-system)).
- [ ] Layout dasar + halaman Beranda kosong + routing semua halaman (placeholder).
- [ ] `tools/` Python: `requirements.txt`, `schema.py`, `validate_soal.py` minimal.
- [ ] Vitest, Playwright, ESLint, Prettier, Ruff.
- [ ] GitHub Actions: validate → test → build → deploy Pages.

**Definition of Done:** URL GitHub Pages terbuka di HP Android, bisa di-install, dan terbuka saat mode pesawat.

## M1 — Kenali (Bongkar Kotak & Kamus)
- [ ] `lib/hitung.js` + unit test lengkap.
- [ ] Komponen `BarModel` (nilai & persen, mode `?`).
- [ ] 6 ilustrasi `KemasanSVG` dengan 3 state (utuh/terbuka/terpisah).
- [ ] Halaman Bongkar Kotak: pilih kemasan, geser/tap untuk membongkar, mode Tebak.
- [ ] `kamus.json` + halaman Kamus + `IstilahChip` (popover).

**DoD:** Siswa dapat membongkar 6 kemasan; bar model menampilkan angka yang benar; Kamus memuat semua sinonim di [KONTEN_DAN_SOAL.md](KONTEN_DAN_SOAL.md#14-glosarium-sinonim-kamus-istilah).

## M2 — Pahami (Contoh & Latihan Dasar)
- [ ] `StepCard` + halaman Contoh Bertahap dengan *fading*.
- [ ] `soalEngine.js` (ambil, acak, periksa, cocokkan miskonsepsi) + unit test.
- [ ] `NumberInput` (koma desimal) + `lib/format.js` + `lib/satuan.js`.
- [ ] `FeedbackSheet`, `HintButton`, `miskonsepsi.json`.
- [ ] Bank soal L1–L2 (16 soal) lolos `validate_soal.py`.
- [ ] Store progres + bintang per level + buka kunci level.

**DoD:** Alur Beranda → Contoh → Latihan L1/L2 → bintang tersimpan; umpan balik miskonsepsi muncul untuk setiap pengecoh.

## M3 — Persen Tara & Literasi
- [ ] Contoh Bertahap L3 (3 contoh, fading) dengan bar persen 100%.
- [ ] Bank soal L3–L5 (24 soal) + `generate_soal.py` untuk variasi tambahan.
- [ ] Komponen `AngkaTag` + aktivitas Labeli Angka.
- [ ] Halaman Misi Literasi (5 langkah) + 6 misi di `misi.json`.
- [ ] Prompt "Jelaskan ke Teman" (susun potongan kalimat) + kartu yang bisa dibagikan.

**DoD:** 40 soal + 6 misi lolos validator; e2e Playwright menyelesaikan satu misi penuh.

## M4 — Alat & Evaluasi
- [ ] Halaman Alat Hitung (`selesaikan()`, pemilih satuan, validasi kewajaran).
- [ ] Uji Pemahaman (10 soal: 2 per level) + Rapor per TP + saran modul.
- [ ] Lencana & animasi perayaan ringan.
- [ ] Bagikan Rapor (Web Share API, fallback kartu screenshot).
- [ ] Pengaturan: nama panggilan, tema, kurangi gerak, mulai dari awal (dengan `ConfirmDialog`).

**DoD:** Semua modul MVP di [PRD.md](PRD.md#61-mvp-versi-10) berfungsi offline.

## M5 — Pemolesan
- [ ] Audit Lighthouse (Performance, Accessibility, Best Practices, PWA ≥ 90).
- [ ] Checklist aksesibilitas [UI_UX.md](UI_UX.md#5-aksesibilitas-checklist).
- [ ] Uji di ≥ 2 HP Android nyata (satu kelas bawah) + 1 iPhone (jika ada).
- [ ] Review microcopy: semua kalimat ≤ 15 kata.
- [ ] Prompt pembaruan versi (service worker).

**DoD:** Seluruh checklist [TESTING.md](TESTING.md) bagian perangkat lolos.

## M6 — Validasi & Uji Coba
- [ ] Validasi ahli materi & ahli media (lembar validasi).
- [ ] Revisi berdasarkan masukan ahli.
- [ ] Uji coba terbatas (3–5 siswa kelas VII): think-aloud + skala Paas + SUS.
- [ ] Uji coba lapangan (1 kelas): pre-test → pakai aplikasi → post-test.
- [ ] Revisi akhir & analisis data (N-gain, rata-rata SUS, rata-rata Paas).

**DoD:** Indikator di [PRD.md](PRD.md#3-tujuan-produk) terukur dan dilaporkan.

## Rilis 1.0
- [ ] Tag versi `v1.0.0`, catatan rilis.
- [ ] QR code + brosur (lihat [DEPLOYMENT.md](DEPLOYMENT.md#5-qr-code--brosur)).
