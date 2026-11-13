# Rencana Pengujian BoxBuster

Pengujian dibagi dua: **pengujian teknis** (apakah aplikasi benar & stabil) dan **pengujian pedagogis** (apakah aplikasi membantu siswa belajar).

## 1. Pengujian Teknis

### 1.1 Unit test (Vitest)
| Target | Kasus wajib |
|---|---|
| `lib/hitung.js` | semua fungsi; desimal (24,8; 0,2); persen desimal (1,5%; 2,5%); netto dari persen → bruto (49 kg, 2% → 50 kg); input tidak wajar (tara > bruto, negatif) |
| `lib/format.js` | parse "2,5" → 2.5; "1.050" → 1050; "Rp490.000" → 490000; format 3465000 → "3.465.000" |
| `lib/satuan.js` | 1 kuintal = 100 kg; 3,2 kg − 200 g = 3 kg |
| `lib/soalEngine.js` | jawaban benar dikenali; setiap pengecoh mengembalikan kode miskonsepsi yang tepat; toleransi floating point (0,1 + 0,2) |
| Komponen | `BarModel` proporsi & label; `NumberInput` koma; `FeedbackSheet` menampilkan pesan miskonsepsi; `IstilahChip` membuka popover |

Perintah: `npm test` · target cakupan `src/lib/` ≥ 90%.

### 1.2 Uji tooling Python (pytest)
- `validate_soal.py` menolak: jawaban salah, id ganda, pengecoh = jawaban, kalimat > 15 kata, ilustrasi tidak ada.
- `generate_soal.py` menghasilkan soal yang lolos validator dan berangka "bersih".
- Uji silang: 40 soal bank awal dihitung ulang dan cocok dengan tabel di [KONTEN_DAN_SOAL.md](KONTEN_DAN_SOAL.md#3-bank-soal-awal-40-soal-8-per-level).

Perintah: `pytest tools/tests`

### 1.3 End-to-end (Playwright)
Proyek perangkat: **Pixel 5** (393×851), **layar kecil 360×640**, **Desktop Chrome**.
| Skenario | Langkah | Hasil diharapkan |
|---|---|---|
| E2E-1 Alur belajar | Beranda → Bongkar Kotak → Contoh L1 → Latihan L1 (jawab semua) | Bintang tersimpan, Level 2 terbuka |
| E2E-2 Umpan balik | Latihan L3 → pilih 49,98 kg | Pesan "Persen tara dihitung dari bruto…" |
| E2E-3 Misi literasi | Selesaikan misi Bu Sari 5 langkah | Kartu "Jelaskan ke Teman" muncul |
| E2E-4 Alat hitung | Bruto 50, tara 2% | Netto 49 kg + 2 langkah |
| E2E-5 Offline | Muat aplikasi → `context.setOffline(true)` → reload → navigasi ke semua halaman | Semua halaman tampil |
| E2E-6 Persistensi | Selesaikan level → reload | Progres tetap ada |
| E2E-7 Uji & rapor | Kerjakan Uji Pemahaman | Rapor per TP tampil |

Perintah: `npx playwright test`

### 1.4 Audit otomatis
- **Lighthouse** (mode mobile): Performance, Accessibility, Best Practices ≥ 90; PWA installable ✔.
- **axe-core** (via Playwright) tanpa pelanggaran *serious/critical*.
- Ukuran bundle dicek terhadap anggaran di [ARSITEKTUR.md](ARSITEKTUR.md#9-anggaran-performa).

### 1.5 Uji perangkat manual (checklist)
Perangkat minimal: 1 Android kelas bawah (RAM ≤ 3 GB), 1 Android kelas menengah, 1 iPhone (jika tersedia), 1 laptop.

| # | Cek | Android bawah | Android menengah | iPhone | Laptop |
|---|---|---|---|---|---|
| 1 | Buka via scan QR | ☐ | ☐ | ☐ | — |
| 2 | Prompt/panduan install muncul | ☐ | ☐ | ☐ | ☐ |
| 3 | Ikon di layar utama & terbuka *standalone* | ☐ | ☐ | ☐ | ☐ |
| 4 | Mode pesawat: semua modul jalan | ☐ | ☐ | ☐ | ☐ |
| 5 | Animasi bongkar kotak lancar (tidak patah-patah) | ☐ | ☐ | ☐ | ☐ |
| 6 | Keyboard angka muncul & koma bisa diketik | ☐ | ☐ | ☐ | — |
| 7 | Teks terbaca tanpa zoom; tombol mudah di-tap | ☐ | ☐ | ☐ | ☐ |
| 8 | Gambar tajam saat diperbesar | ☐ | ☐ | ☐ | ☐ |
| 9 | Mode gelap rapi | ☐ | ☐ | ☐ | ☐ |
| 10 | Bagikan rapor berfungsi | ☐ | ☐ | ☐ | ☐ |
| 11 | Pembaruan versi terdeteksi | ☐ | ☐ | ☐ | ☐ |
| 12 | Rotasi layar tidak merusak tampilan | ☐ | ☐ | ☐ | — |

## 2. Pengujian Pedagogis

### 2.1 Validasi ahli (sebelum uji coba siswa)
| Validator | Aspek | Instrumen |
|---|---|---|
| Ahli materi (dosen/guru matematika) | Kebenaran konsep, kesesuaian CP/TP, kualitas soal & pengecoh, bahasa | Lembar validasi skala 1–4 |
| Ahli media | Tampilan, navigasi, keterbacaan, interaktivitas, kinerja | Lembar validasi skala 1–4 |
Kriteria: rata-rata ≥ 3,0 (layak) dengan revisi sesuai saran.

### 2.2 Uji coba terbatas (3–5 siswa kelas VII)
- **Think-aloud**: siswa menyuarakan pikirannya saat memakai aplikasi; catat kebingungan.
- **Skala Paas** (1 = sangat ringan … 9 = sangat berat) setelah setiap level.
- **Wawancara singkat** memakai kode yang sama (K/IL/EL/GL/DS) seperti wawancara awal → bandingkan temuan sebelum & sesudah.
- Fokus pengamatan: apakah IL01 (tertukar istilah), IL04/IL05 (persen tara), EL05 (banyak angka) masih muncul.

### 2.3 Uji coba lapangan (1 kelas)
| Tahap | Kegiatan |
|---|---|
| 1 | Pre-test (10 soal, TP1–TP4) |
| 2 | Siswa memakai BoxBuster (±2 × 40 menit) |
| 3 | Post-test (10 soal paralel) |
| 4 | Angket SUS + skala Paas |

Analisis:
- **N-gain** = (post − pre) / (100 − pre); kategori: tinggi ≥ 0,7; sedang 0,3–0,7; rendah < 0,3.
- **SUS**: skor ≥ 70 = dapat diterima.
- **Paas**: rata-rata per level; level dengan skor tertinggi diprioritaskan untuk revisi.
- Rekap miskonsepsi dari rapor siswa (screenshot) untuk melihat miskonsepsi yang paling sering.

### 2.4 Kriteria keberhasilan
Mengacu ke [PRD.md §3](PRD.md#3-tujuan-produk): ≥ 85% benar TP1, ≥ 80% benar TP3, kenaikan skor ≥ 20 poin, SUS ≥ 70.

## 3. Etika
- Persetujuan sekolah, guru, dan orang tua/wali sebelum uji coba.
- Data siswa dianonimkan (kode S01, S02, …).
- Aplikasi tidak mengumpulkan data; data penelitian dikumpulkan lewat instrumen kertas/form terpisah.
