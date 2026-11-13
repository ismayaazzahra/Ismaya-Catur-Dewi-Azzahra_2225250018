# Desain Pembelajaran BoxBuster

## 1. Posisi Kurikulum
- **Kurikulum:** Kurikulum Merdeka, Fase D (SMP kelas VII–IX).
- **Elemen:** Bilangan — Aritmetika Sosial.
- **Capaian Pembelajaran (ringkas):** peserta didik dapat menerapkan konsep rasio dan persen untuk menyelesaikan masalah dalam kehidupan sehari-hari, termasuk masalah jual-beli dan berat barang (bruto, neto, tara).
- **Rujukan buku:** Matematika untuk SMP/MTs Kelas VII, Penerbit Erlangga, subbab 5.4.2 *Pengertian Bruto, Tara, dan Neto*.

## 2. Tujuan Pembelajaran (TP)
| Kode | Tujuan | Level di aplikasi |
|---|---|---|
| **TP1** | Membedakan bruto, netto, dan tara (termasuk sinonimnya) pada kemasan nyata | Bongkar Kotak, Kamus, L1 |
| **TP2** | Menghitung salah satu dari bruto, netto, tara jika dua lainnya diketahui | L1, L2 |
| **TP3** | Menghitung tara, netto, atau bruto jika tara dinyatakan dalam persen dari bruto | L3 |
| **TP4** | Menyelesaikan masalah kontekstual yang melibatkan bruto, netto, tara, dan harga | L4, L5, Misi Literasi |

## 3. Landasan Teori

### 3.1 Cognitive Load Theory (Sweller)
| Jenis beban | Strategi di BoxBuster |
|---|---|
| **Intrinsik** (kompleksitas materi) | Segmentasi: satu konsep per level; urutan dari nilai langsung → persen → multi-langkah; satu model relasi (Bruto = Netto + Tara) menggantikan tiga rumus |
| **Ekstrinsik** (penyajian) | Kalimat ≤ 15 kata; warna konsep konsisten; SVG tajam; teks & gambar berdekatan (*spatial contiguity*); tanpa dekorasi yang mengganggu; tempo diatur siswa |
| **Germane** (membangun skema) | Self-explanation (*Jelaskan ke Teman*), Cek Kewajaran, variasi konteks, umpan balik berbasis miskonsepsi |

Efek CLT yang dimanfaatkan:
- **Worked-example effect** → modul Contoh Bertahap.
- **Fading / guidance fading** → contoh ke-2 dan ke-3 menghilangkan langkah.
- **Split-attention effect** dihindari → angka ditulis langsung di dalam bar model, bukan di keterangan terpisah.
- **Redundancy effect** dihindari → tidak menampilkan teks yang sama dengan isi gambar.
- **Expertise reversal** → petunjuk berkurang seiring level naik; Uji Pemahaman tanpa petunjuk.

### 3.2 Pendekatan CPA (Concrete – Pictorial – Abstract, Bruner)
| Tahap | Wujud di aplikasi |
|---|---|
| Konkret | Kemasan nyata (foto/ilustrasi realistis): keripik, susu kaleng, beras karung; animasi timbangan |
| Piktorial | Bar model berwarna: █ Bruto = █ Netto + █ Tara |
| Abstrak | Notasi: B = N + T; T = p% × B |

Setiap level dimulai dari tahap konkret/piktorial sebelum ke simbol (sesuai temuan K01, GL03).

### 3.3 Literasi Matematika (kerangka PISA 2022)
| Proses | Langkah di Misi Literasi |
|---|---|
| **Merumuskan** (*formulate*) situasi secara matematis | 1. Pahami (labeli angka) · 2. Rencanakan (pilih yang dicari & operasi) |
| **Menerapkan** (*employ*) konsep, fakta, prosedur | 3. Hitung |
| **Menafsirkan & mengevaluasi** (*interpret/evaluate*) hasil | 4. Cek Kewajaran · 5. Tafsirkan (kesimpulan dalam konteks) |
| Penalaran matematis | Jelaskan ke Teman |

Konteks soal mengikuti kategori PISA:
- **Personal**: membeli jajanan, membandingkan harga dua merek.
- **Pekerjaan**: pedagang beras, petani kopi, kurir ekspedisi.
- **Sosial**: bantuan sembako, koperasi sekolah.
- **Ilmiah**: penimbangan pada timbangan digital, satuan & konversi.

## 4. Alur Belajar

```
Bongkar Kotak ──► Kamus Istilah ──► Contoh Bertahap ──► Latihan Lx ──► Misi Literasi ──► Uji Pemahaman
   (konkret)        (bahasa)        (worked example)    (berjenjang)    (literasi)        (evaluasi)
                                         ▲                    │
                                         └── umpan balik ◄────┘  (salah 2× → disarankan ulang contoh)
```

| Level | Fokus | TP | Contoh Bertahap | Latihan | Misi Literasi |
|---|---|---|---|---|---|
| 1 | Hitung langsung bruto/netto | TP1, TP2 | 1 contoh | 8 soal | — |
| 2 | Cari yang hilang + sinonim + satuan | TP1, TP2 | 2 contoh (fading) | 8 soal | 1 misi |
| 3 | Persen tara (selalu dari bruto) | TP3 | 3 contoh (fading) | 8 soal | 1 misi |
| 4 | Soal cerita + harga | TP4 | 2 contoh | 8 soal | 2 misi |
| 5 | Multi-langkah (untung, banyak kemasan) | TP4 | 1 contoh | 8 soal | 2 misi |

## 5. Strategi Inti per Kesulitan

### 5.1 Membedakan istilah (IL01, EL01)
- Warna & ikon tetap: **Bruto 🟦 kotak utuh**, **Netto 🟩 isi**, **Tara 🟧 bungkus kosong**.
- Kalimat jangkar: *"Bruto = semuanya. Netto = isinya. Tara = bungkusnya."*
- Aturan besar-kecil: *"Bruto selalu paling besar."*

### 5.2 Satu model, bukan tiga rumus (IL02, IL03, IL05)
Pertanyaan pemandu sebelum menghitung:
1. *"Yang dicari keseluruhan atau bagian?"*
2. Keseluruhan (bruto) → **tambah** bagian-bagiannya.
3. Bagian (netto/tara) → **kurangi** keseluruhan dengan bagian lain.

### 5.3 Persen tara (IL04, IL05, DS02)
- Bar persen: bruto selalu digambar sebagai **100%**.
- Kalimat jangkar: *"Persen tara selalu dihitung dari bruto."*
- Urutan latihan: (a) bruto & % tara → tara; (b) bruto & % tara → netto; (c) bruto & tara → % tara; (d) netto & % tara → bruto (netto = (100% − p%) × bruto).
- Kasus (d) secara sengaja diberi pengecoh `persen-dari-netto`.

### 5.4 Membaca soal cerita (EL05, GL05)
- Labeli Angka sebelum menghitung.
- Variasi: angka tidak relevan (pengalih), satuan berbeda, harga per kg netto vs ongkir per kg bruto.

## 6. Umpan Balik Berbasis Miskonsepsi
| Miskonsepsi | Pesan umpan balik (≤ 15 kata per kalimat) |
|---|---|
| `tertukar-peran` | "Hmm, itu berat bungkusnya. Netto adalah berat isinya." |
| `bruto-bukan-terbesar` | "Netto tidak mungkin lebih besar dari bruto. Bruto termasuk bungkusnya." |
| `operasi-terbalik` | "Yang dicari bagian, bukan keseluruhan. Coba dikurangi." / "Yang dicari keseluruhan. Coba dijumlah." |
| `persen-dari-netto` | "Persen tara dihitung dari bruto, bukan dari netto." |
| `persen-jadi-satuan` | "2% bukan 2 kg. Hitung dulu 2% dari bruto." |
| `sinonim-istilah` | "'Berat kemasan' artinya sama dengan tara." |
| `satuan-campur` | "Satuannya berbeda. Samakan dulu: 1 kg = 1.000 g." |
| `harga-dari-bruto` | "Harganya per kg isi. Pakai netto, bukan bruto." |

Pola umpan balik: **(1) beri tahu salah dengan ramah → (2) sebutkan alasannya → (3) tunjukkan bar model yang benar → (4) beri kesempatan coba lagi.**

## 7. Rencana Evaluasi Pembelajaran
| Instrumen | Tujuan | Waktu |
|---|---|---|
| Pre-test & post-test (10 soal, paralel, mencakup TP1–TP4) | Mengukur peningkatan pemahaman (N-gain) | Sebelum & sesudah memakai aplikasi |
| Skala beban kognitif Paas (1–9) | Mengukur usaha mental yang dirasakan | Setelah setiap level saat uji coba |
| System Usability Scale (SUS, 10 butir) | Mengukur kegunaan aplikasi | Akhir uji coba |
| Lembar validasi ahli materi & ahli media | Kelayakan isi & tampilan | Sebelum uji coba lapangan |
| Wawancara singkat (think-aloud) | Menemukan kendala yang tidak terlihat dari skor | Saat uji coba terbatas |

Detail pelaksanaan uji coba ada di [TESTING.md](TESTING.md).
