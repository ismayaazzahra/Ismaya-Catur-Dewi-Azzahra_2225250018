# Analisis Kebutuhan BoxBuster

> Dokumen ini menerjemahkan hasil wawancara beban kognitif menjadi kebutuhan desain aplikasi.
> **Setiap fitur BoxBuster harus dapat dilacak ke minimal satu temuan di dokumen ini.**

## 1. Ringkasan Wawancara

| Informasi | Isian |
|---|---|
| Pewawancara | Ismaya Catur Dewi Azzahra (NIM 2225250018, Kelas 3A, S1 Pendidikan Matematika) |
| Narasumber | Siswa kode **S01**, kelas 9C (pernah mempelajari materi saat kelas VII) |
| Tanggal | 6 November 2026 |
| Durasi | 20:01 menit, direkam dengan persetujuan narasumber |
| Materi | Berat suatu barang dan kemasannya (bruto, netto, tara) — Aritmetika Sosial |
| Artefak pemicu | Buku Matematika SMP/MTs Kelas VII, Penerbit Erlangga (Kurikulum Merdeka), subbab 5.4.2 *Pengertian Bruto, Tara, dan Neto* |
| Bukti belajar | Buku tulis siswa berisi catatan dan contoh soal bruto, netto, tara |

### Skema pengodean
- **K** – Konteks pembelajaran (bagaimana materi pernah dipelajari)
- **IL** – *Intrinsic Load* (beban dari kompleksitas materi itu sendiri)
- **EL** – *Extraneous Load* (beban dari cara penyajian/lingkungan, tidak membantu belajar)
- **GL** – *Germane Load* (usaha kognitif yang membangun skema/pemahaman)
- **DS** – Desain/usulan siswa

## 2. Temuan per Kode → Kebutuhan Desain

### 2.1 Konteks (K)
| Kode | Temuan | Implikasi desain | Fitur |
|---|---|---|---|
| K01 | Awalnya bingung; paham setelah guru memakai **kemasan jajanan nyata** | Mulai dari benda konkret yang akrab | **Bongkar Kotak** dengan ilustrasi kemasan jajanan, mi, susu, beras |
| K02 | Pola kelas: contoh barang → papan tulis → catat → contoh soal | Pertahankan urutan yang sudah familiar: konkret → tulisan → latihan | Alur belajar: Bongkar Kotak → Contoh Bertahap → Latihan |
| K03 | Ingat netto = berat isi, **"biasanya ada di kemasan"** | Manfaatkan label kemasan asli sebagai jangkar ingatan | **Kamus Istilah** dengan gambar label "Berat bersih / Netto 75 g" |

### 2.2 Beban Intrinsik (IL)
| Kode | Temuan | Implikasi desain | Fitur |
|---|---|---|---|
| IL01 | Tertukar tara vs netto ("sama-sama berat, satu isi satu bungkus"), lupa mana yang paling besar | Beri representasi visual tetap: **bruto = keseluruhan (terbesar)**, netto & tara = bagian | **Bar model** dengan warna konsep tetap: Bruto 🟦 biru, Netto 🟩 hijau, Tara 🟧 oranye; animasi kotak dibongkar |
| IL02 | Harus mengingat semua rumus bruto, netto, tara | Ganti 3 rumus dengan **1 relasi**: Bruto = Netto + Tara | Model "cari bagian yang hilang": keseluruhan dicari → tambah; bagian dicari → kurang |
| IL03 | Prasyarat: bisa berhitung & hafal rumus | Kurangi ketergantungan hafalan; dukung hitungan | **Alat Hitung BoxBuster**; petunjuk bertahap |
| IL04 | Sulit saat tara diberikan dalam **persen** ("persennya dari mana?") | Tegaskan: persen tara **selalu dari bruto** (bruto = 100%) | Modul khusus **Persen Tara** dengan bar persen 100% |
| IL05 | Salah operasi (harusnya kurang malah tambah); persen tara dihitung **dari netto** | Umpan balik spesifik per miskonsepsi | Pengecoh soal berbasis miskonsepsi + pesan umpan balik yang menjelaskan kesalahan |

### 2.3 Beban Ekstrinsik (EL)
| Kode | Temuan | Implikasi desain | Fitur |
|---|---|---|---|
| EL01 | "Berat kemasan" dan "tara" dikira dua hal berbeda | Ajarkan sinonim secara eksplisit | **Kamus Istilah** + istilah dalam soal diberi sorotan warna konsep (tap → muncul arti) |
| EL02 | Tidak fokus karena guru menjelaskan terlalu cepat | Siswa mengatur tempo sendiri | Penjelasan dipotong per langkah, tombol **Lanjut** & **Ulangi** |
| EL03 | Gambar soal tidak jelas | Gambar harus tajam di semua layar | Ilustrasi **SVG** (tidak pecah), bisa diperbesar (*tap to zoom*) |
| EL04 | Penjelasan urut tapi cepat | Pertahankan urutan, kendalikan kecepatan | Sama dengan EL02; indikator langkah "2 dari 4" |
| EL05 | Banyak angka, bingung "ini angka apanya" | Latih identifikasi peran angka sebelum menghitung | Aktivitas **Labeli Angka** (tap angka → pilih Bruto/Netto/Tara/Harga/Tidak dipakai) |

### 2.4 Beban Germane (GL)
| Kode | Temuan | Implikasi desain | Fitur |
|---|---|---|---|
| GL01 | Mencoba latihan; paling ingat contoh guru | Contoh yang dikerjakan lengkap sangat efektif | **Contoh Bertahap** (*worked example*) |
| GL02 | Mengecek: netto pasti lebih kecil dari bruto | Strategi metakognitif ini harus dibakukan | Langkah wajib **Cek Kewajaran** di Misi Literasi |
| GL03 | Harus diberi contoh dulu baru mengerti | Contoh mendahului latihan | *Worked example → faded example → mandiri* |
| GL04 | Pernah menjelaskan ke teman | *Self-explanation* memperkuat skema | Prompt **Jelaskan ke Teman** + kartu ringkasan yang bisa dibagikan |
| GL05 | Menganggap soal hanya beda nama barang & angka | Perlu variasi struktur soal, bukan hanya angka | Variasi konteks (toko, ekspedisi, petani, perbandingan harga) dan variasi yang ditanya |

### 2.5 Usulan Siswa (DS)
| Kode | Usulan | Fitur |
|---|---|---|
| DS01 | Penjelasan visual agar tidak tertukar, alat bantu hitung, latihan soal, uji pemahaman | Bongkar Kotak, Alat Hitung, Latihan, Uji Pemahaman |
| DS02 | Persen tara perlu dijelaskan; tambah-kurang bisa sendiri | Persen Tara mendapat porsi terbesar (Level 3–5) |
| DS03 | Jangan banyak kata, jangan bertele-tele | Aturan microcopy: **kalimat ≤ 15 kata, satu ide per layar** |

## 3. Sintesis: 5 Prinsip Desain BoxBuster

1. **Satu model, bukan tiga rumus** – Bar model Bruto = Netto + Tara dipakai di semua layar. *(IL01, IL02, IL03)*
2. **Persen tara selalu dari bruto** – Ditekankan visual & umpan balik. *(IL04, IL05, DS02)*
3. **Pahami angka sebelum menghitung** – Labeli angka, kamus sinonim. *(EL01, EL05, GL05)*
4. **Contoh dulu, tempo sendiri** – Worked example, langkah demi langkah. *(K01, K02, EL02, EL04, GL01, GL03)*
5. **Ringkas & jelas** – Kalimat pendek, gambar SVG tajam. *(EL03, DS03)*

Ditambah kebiasaan baik yang sudah dimiliki siswa: **cek kewajaran** *(GL02)* dan **menjelaskan ke teman** *(GL04)*.

## 4. Peta Miskonsepsi (dipakai di bank soal)

| Kode | Miskonsepsi | Sumber | Contoh jawaban salah |
|---|---|---|---|
| `tertukar-peran` | Netto dan tara tertukar | IL01 | Menjawab berat kemasan saat ditanya netto |
| `bruto-bukan-terbesar` | Menganggap netto/tara bisa > bruto | IL01, GL02 | Netto 52 kg dari bruto 50 kg |
| `operasi-terbalik` | Menjumlah padahal harus mengurangi (atau sebaliknya) | IL05 | Netto = 50 + 1 = 51 kg |
| `persen-dari-netto` | Persen tara dihitung dari netto | IL04, IL05 | Netto 49 kg, tara 2% → bruto 49,98 kg |
| `persen-jadi-satuan` | 2% dianggap 2 kg | IL04 | Bruto 50 kg, tara 2% → netto 48 kg |
| `sinonim-istilah` | "Berat kemasan", "berat kotor", "berat bersih" tidak dikenali | EL01 | Mengabaikan data "berat kemasan" |
| `satuan-campur` | Menghitung g dan kg tanpa konversi | EL05 | 3,2 kg − 200 g = −196,8 |
| `harga-dari-bruto` | Membayar berdasarkan bruto padahal harga per kg netto | EL05, GL05 | Rp500.000 bukan Rp490.000 |

## 5. Keterbatasan & Rekomendasi Validasi
- Data berasal dari **satu siswa** (S01) → temuan bersifat indikatif, belum dapat digeneralisasi.
- Siswa sudah kelas 9, materi dipelajari 2 tahun lalu → sebagian kesulitan dipengaruhi lupa.
- **Rekomendasi:**
  1. Lakukan wawancara/angket tambahan pada 3–5 siswa kelas VII (target pengguna utama).
  2. Validasi ahli materi dan ahli media sebelum uji coba lapangan.
  3. Uji coba terbatas aplikasi, lalu ukur beban kognitif (skala Paas) dan kegunaan (SUS) — lihat [TESTING.md](TESTING.md).
