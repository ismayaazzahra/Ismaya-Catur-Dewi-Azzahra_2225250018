# Konten & Bank Soal BoxBuster

## 1. Materi Inti

### 1.1 Definisi (kalimat jangkar)
| Istilah | Arti | Kalimat jangkar | Warna |
|---|---|---|---|
| **Bruto** | Berat barang beserta kemasannya | "Bruto = semuanya." | 🟦 Biru |
| **Netto (Neto)** | Berat isi/barang saja, tanpa kemasan | "Netto = isinya." | 🟩 Hijau |
| **Tara** | Berat kemasan saja | "Tara = bungkusnya." | 🟧 Oranye |
| **Persen tara** | Tara dinyatakan dalam persen **dari bruto** | "Persen tara selalu dari bruto." | 🟧 Oranye bergaris |

### 1.2 Satu relasi
```
┌──────────────────── BRUTO (100%) ───────────────────┐
│            NETTO (isi)              │  TARA (bungkus) │
└─────────────────────────────────────┴─────────────────┘

Bruto = Netto + Tara
Netto = Bruto − Tara
Tara  = Bruto − Netto

Jika tara p% :  Tara  = p% × Bruto
                Netto = (100% − p%) × Bruto
                Bruto = Netto ÷ (100% − p%)
```
Di aplikasi, rumus turunan **tidak** ditampilkan sebagai daftar hafalan. Siswa dipandu dengan pertanyaan: *"Yang dicari keseluruhan atau bagian?"*

### 1.3 Catatan ejaan
KBBI memakai **"neto"**; buku Erlangga memakai "neto", sedangkan label kemasan dan bahasa sehari-hari sering memakai **"netto"**. BoxBuster menampilkan **"Netto (Neto)"** pada pengenalan pertama, lalu **"Netto"** di seluruh aplikasi, dan Kamus Istilah menjelaskan keduanya sama.

### 1.4 Glosarium sinonim (Kamus Istilah)
| Konsep | Istilah lain yang muncul di soal/kemasan |
|---|---|
| Bruto | berat kotor, berat keseluruhan, berat total, *gross weight* |
| Netto | neto, berat bersih, berat isi, *net weight*, "Berat bersih/Netto" pada label |
| Tara | berat kemasan, berat bungkus, berat wadah, berat karung/peti/kardus, potongan berat |
| Persen tara | tara …%, potongan berat …%, "rabat berat" (jarang) |

### 1.5 Satuan & konversi
| Satuan | Setara |
|---|---|
| 1 kuintal | 100 kg |
| 1 kg | 10 ons = 1.000 g |
| 1 ons | 100 g |
Format angka Indonesia: koma untuk desimal (2,5 kg), titik untuk ribuan (1.050 g).

## 2. Skema JSON Soal

File: `src/data/soal.json` (dihasilkan/divalidasi oleh `tools/`).

```json
{
  "versi": 1,
  "soal": [
    {
      "id": "L3-06",
      "level": 3,
      "tp": ["TP3"],
      "tipe": "pilgan",
      "konteks": "beras karung",
      "kategori_konteks": "pekerjaan",
      "teks": "Netto sekarung beras 49 kg. Tara karung 2% dari bruto. Berapa bruto beras itu?",
      "angka": [
        { "nilai": 49, "satuan": "kg", "peran": "netto" },
        { "nilai": 2, "satuan": "%", "peran": "persen_tara" }
      ],
      "ditanya": "bruto",
      "jawaban": 50,
      "satuan_jawaban": "kg",
      "toleransi": 0,
      "pengecoh": [
        { "nilai": 49.98, "miskonsepsi": "persen-dari-netto" },
        { "nilai": 51, "miskonsepsi": "persen-jadi-satuan" },
        { "nilai": 48.02, "miskonsepsi": "operasi-terbalik" }
      ],
      "langkah": [
        "Bruto = 100%. Tara = 2%. Jadi netto = 98% dari bruto.",
        "98% × bruto = 49 kg.",
        "Bruto = 49 ÷ 0,98 = 50 kg."
      ],
      "petunjuk": [
        "Persen tara dihitung dari bruto, bukan dari netto.",
        "Netto adalah berapa persen dari bruto?"
      ],
      "literasi": { "proses": "merumuskan", "konteks": "pekerjaan" },
      "ilustrasi": "karung-beras"
    }
  ]
}
```

### Aturan field
| Field | Aturan |
|---|---|
| `id` | `L{level}-{nomor 2 digit}`, unik |
| `level` | 1–5 |
| `tp` | subset `TP1`–`TP4` |
| `tipe` | `isian` · `pilgan` · `labeli-angka` · `urutkan` |
| `peran` (angka) | `bruto` · `netto` · `tara` · `persen_tara` · `harga` · `jumlah` · `pengalih` |
| `ditanya` | `bruto` · `netto` · `tara` · `persen_tara` · `harga` · `untung` · `banyak` · `pilihan` |
| `jawaban` | angka (atau string untuk `pilihan`); **dihitung ulang validator** |
| `pengecoh` | min. 3 untuk `pilgan`; setiap pengecoh punya `miskonsepsi` dari daftar di [DESAIN_PEMBELAJARAN.md](DESAIN_PEMBELAJARAN.md#6-umpan-balik-berbasis-miskonsepsi); tidak boleh sama dengan jawaban |
| `teks`, `langkah`, `petunjuk` | setiap kalimat ≤ 15 kata (dicek validator) |
| `ilustrasi` | nama file SVG di `src/assets/kemasan/` |

## 3. Bank Soal Awal (40 soal, 8 per level)
Soal ditulis ulang dengan gaya buku Erlangga, **tidak disalin**. Kolom "Data" memakai B = bruto, N = netto, T = tara.

### Level 1 — Hitung langsung (TP1, TP2)
| ID | Konteks | Data | Ditanya | Jawaban |
|---|---|---|---|---|
| L1-01 | Keripik kentang | N 75 g, T 5 g | Bruto | **80 g** |
| L1-02 | Susu kaleng | B 420 g, T 20 g | Netto | **400 g** |
| L1-03 | Kopi sachet | N 20 g, T 2 g | Bruto | **22 g** |
| L1-04 | Beras karung | B 25 kg, T 0,2 kg | Netto | **24,8 kg** |
| L1-05 | Minyak jeriken | N 5 kg, T 0,4 kg | Bruto | **5,4 kg** |
| L1-06 | Biskuit kaleng | B 750 g, T 150 g | Netto | **600 g** |
| L1-07 | Paket buku (kardus) | N 1,8 kg, T 0,3 kg | Bruto | **2,1 kg** |
| L1-08 | Gula pasir | B 1.050 g, T 50 g | Netto | **1.000 g (1 kg)** |

### Level 2 — Cari yang hilang, sinonim, satuan (TP1, TP2)
| ID | Konteks | Data | Ditanya | Jawaban |
|---|---|---|---|---|
| L2-01 | Cokelat batang | B 110 g, N 100 g | Tara | **10 g** |
| L2-02 | Sarden kaleng | B 425 g, "berat bersih" 375 g | "Berat kemasan" | **50 g** |
| L2-03 | Tepung karung | "berat kotor" 26 kg, "berat bersih" 25 kg | Tara | **1 kg** |
| L2-04 | Air galon | B 19,8 kg, N 19 kg | Tara | **0,8 kg** |
| L2-05 | Mi instan 1 dus | B 3,2 kg, T 200 g | Netto | **3 kg** (konversi) |
| L2-06 | Kopi bubuk toples | N 1 kg, B 1.150 g | Tara | **150 g** (konversi) |
| L2-07 | Durian keranjang | B 12 kg, "berat keranjang" 1,5 kg | Netto | **10,5 kg** |
| L2-08 | Telur dalam peti | B 16 kg, N 15 kg; ada angka pengalih "harga Rp28.000/kg" | Tara | **1 kg** |

### Level 3 — Persen tara (TP3)
| ID | Konteks | Data | Ditanya | Jawaban |
|---|---|---|---|---|
| L3-01 | Beras karung | B 50 kg, tara 2% | Netto | **49 kg** |
| L3-02 | Gula karung | B 100 kg, tara 1,5% | Tara | **1,5 kg** |
| L3-03 | Jagung karung | B 80 kg, tara 2,5% | Netto | **78 kg** |
| L3-04 | Kopi biji karung | B 60 kg, tara 5% | Netto | **57 kg** |
| L3-05 | Bawang merah | B 40 kg, tara 10% | Netto | **36 kg** |
| L3-06 | Beras karung | N 49 kg, tara 2% dari bruto | Bruto | **50 kg** (pengecoh 49,98) |
| L3-07 | Pupuk karung | B 120 kg, T 3 kg | Persen tara | **2,5%** |
| L3-08 | Kedelai karung | N 95 kg, tara 5% | Bruto | **100 kg** |

### Level 4 — Soal cerita + harga (TP4)
| ID | Konteks | Data | Ditanya | Jawaban |
|---|---|---|---|---|
| L4-01 | Toko beras | 1 karung B 50 kg, tara 2%, Rp10.000/kg netto | Uang dibayar | **Rp490.000** |
| L4-02 | Pedagang gula | 5 karung, tiap B 50 kg, tara 1%, Rp14.000/kg netto | Uang dibayar | **Rp3.465.000** |
| L4-03 | Bu Ani beli minyak | 2 jeriken, tiap B 18 kg, T 1 kg, Rp16.000/kg netto | Uang dibayar | **Rp544.000** |
| L4-04 | Ongkir ekspedisi | Paket B 3 kg (isi 2,6 kg), ongkir Rp9.000/kg **bruto** | Ongkir | **Rp27.000** (pengecoh Rp23.400) |
| L4-05 | Petani kopi | 4 karung, tiap B 60 kg, tara 2,5%, Rp30.000/kg netto | Uang diterima | **Rp7.020.000** |
| L4-06 | Toko biskuit | 10 dus, tiap B 4 kg, T 0,5 kg, Rp20.000/kg netto | Uang dibayar | **Rp700.000** |
| L4-07 | Bandingkan keripik | A: N 150 g Rp12.000; B: bruto 220 g, T 20 g, Rp15.000 | Lebih hemat | **Merek B** (Rp75/g vs Rp80/g) |
| L4-08 | Pedagang bawang | 1 kuintal bruto, tara 4%, Rp25.000/kg netto | Uang dibayar | **Rp2.400.000** |

### Level 5 — Multi-langkah (TP4)
| ID | Konteks | Data | Ditanya | Jawaban |
|---|---|---|---|---|
| L5-01 | Untung beras | 3 karung B 50 kg, tara 2%; beli Rp10.000/kg netto, jual Rp12.000/kg | Untung | **Rp294.000** |
| L5-02 | Dua karung | Total B 120 kg, tara 1,5 kg per karung | Netto total | **117 kg** |
| L5-03 | Peti apel | B 25 kg, tara 8%; 10% apel (dari netto) busuk | Apel baik | **20,7 kg** |
| L5-04 | Kemas ulang gula | 4 karung B 50 kg, tara 1%; dijual per bungkus 1 kg netto | Banyak bungkus | **198 bungkus** |
| L5-05 | Kardus susu | 12 kaleng, tiap N 400 g & kaleng 50 g; kardus 300 g | Bruto paket | **5,7 kg** |
| L5-06 | Telur | Peti B 18 kg, T 1,2 kg; 1 kg ≈ 15 butir | Banyak telur | **252 butir** |
| L5-07 | Bandingkan penjual | A: B 50 kg tara 2%; B: B 50 kg tara 1,5 kg | Selisih netto | **0,5 kg** (A lebih banyak) |
| L5-08 | Untung jagung | 2 kuintal bruto, tara 2,5%; beli Rp5.000/kg netto, jual Rp6.000/kg | Untung | **Rp195.000** (20%) |

### Pemeriksaan manual (contoh)
- L3-01: 2% × 50 = 1 kg → netto = 50 − 1 = **49 kg** ✔
- L4-02: 1% × 50 = 0,5 → 49,5 kg × 5 = 247,5 kg × Rp14.000 = **Rp3.465.000** ✔
- L5-03: 8% × 25 = 2 → netto 23 kg; 90% × 23 = **20,7 kg** ✔
- L5-08: 2,5% × 200 = 5 → netto 195 kg; jual Rp1.170.000 − beli Rp975.000 = **Rp195.000** ✔

## 4. Misi Literasi (contoh lengkap)

**Misi "Beras Bu Sari"** (Level 4, konteks pekerjaan)
> Bu Sari membeli 2 karung beras di toko. Setiap karung tertulis "50 kg". Toko memotong berat karung 2% dari bruto. Harga beras Rp12.000 per kg. Bu Sari membawa uang Rp1.200.000.

| Langkah | Aktivitas siswa | Jawaban yang diharapkan |
|---|---|---|
| 1. Pahami | Labeli angka: 2 → jumlah; 50 kg → bruto; 2% → persen tara; Rp12.000 → harga; Rp1.200.000 → pengalih/uang dibawa | — |
| 2. Rencanakan | Yang dicari: uang yang dibayar → perlu netto dulu (bagian → kurang) | Tara → netto → harga |
| 3. Hitung | Tara 1 kg/karung; netto 49 kg × 2 = 98 kg; 98 × 12.000 | **Rp1.176.000** |
| 4. Cek kewajaran | Netto < bruto? ✔ · Satuan sama? ✔ · Hasil < Rp1.200.000? ✔ | — |
| 5. Tafsirkan | Pilih: "Uang Bu Sari cukup dan bersisa Rp24.000." | Sisa **Rp24.000** |

**Jelaskan ke Teman** — susun potongan kalimat:
"Pertama, aku hitung tara dari bruto." → "Lalu, netto = bruto − tara." → "Terakhir, netto dikali harga per kg."

## 5. Panduan Menulis Soal Baru
1. Satu kalimat ≤ 15 kata; satu informasi per kalimat.
2. Pakai benda yang dekat dengan siswa (jajanan, sembako, paket online).
3. Gunakan angka "bersih" (hasil bulat atau 1 desimal) kecuali sengaja melatih desimal.
4. Variasikan **yang ditanya**, bukan hanya angkanya (temuan GL05).
5. Sertakan sinonim istilah secara bertahap mulai Level 2 (temuan EL01).
6. Setiap pengecoh harus mewakili satu miskonsepsi nyata.
7. Jalankan `python tools/validate_soal.py` sebelum commit.
