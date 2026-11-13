# UI/UX BoxBuster

## 1. Prinsip Desain
1. **Mobile-first** — dirancang untuk lebar 360 px, lalu diperluas ke tablet/desktop.
2. **Satu tugas per layar** — mengurangi beban ekstrinsik (EL02, DS03).
3. **Warna = makna** — warna konsep tidak pernah dipakai untuk hal lain (IL01).
4. **Teks singkat** — kalimat ≤ 15 kata; tombol 1–2 kata.
5. **Tempo siswa** — tidak ada animasi/penjelasan yang berjalan otomatis tanpa kontrol.
6. **Gambar tajam** — semua ilustrasi SVG, bisa di-tap untuk diperbesar (EL03).

## 2. Design System

### 2.1 Warna konsep (wajib konsisten)
| Token | Konsep | Terang | Gelap | Ikon pendamping |
|---|---|---|---|---|
| `--c-bruto` | Bruto | `#2563EB` | `#60A5FA` | 📦 kotak utuh |
| `--c-netto` | Netto | `#16A34A` | `#4ADE80` | 🍪 isi |
| `--c-tara` | Tara | `#EA580C` | `#FB923C` | 🗑️ bungkus kosong |
| `--c-harga` | Harga/uang | `#7C3AED` | `#A78BFA` | 💰 |

Warna konsep **selalu disertai ikon + teks** (tidak bergantung warna saja, ramah buta warna).

### 2.2 Warna antarmuka
| Token | Terang | Gelap | Pemakaian |
|---|---|---|---|
| `--bg` | `#FFFBF5` (krem kardus muda) | `#1C1917` | latar |
| `--surface` | `#FFFFFF` | `#292524` | kartu |
| `--text` | `#1C1917` | `#F5F5F4` | teks utama |
| `--muted` | `#57534E` | `#A8A29E` | teks sekunder |
| `--brand` | `#B45309` (cokelat kardus) | `#F59E0B` | tombol utama, logo |
| `--ok` | `#15803D` | `#4ADE80` | benar |
| `--err` | `#B91C1C` | `#F87171` | salah |

Semua pasangan teks/latar memenuhi kontras **WCAG AA (≥ 4,5:1)**.

### 2.3 Tipografi
- Font sistem (tanpa unduhan): `system-ui, -apple-system, "Segoe UI", Roboto, sans-serif`.
- Ukuran: isi 16–18 px, angka soal 20 px tebal, judul 22–28 px.
- Angka memakai `font-variant-numeric: tabular-nums` agar sejajar di bar model.

### 2.4 Komponen inti
| Komponen | Keterangan |
|---|---|
| `BarModel` | Batang bruto 100% dibagi netto & tara; menerima nilai/persen; mode tersembunyi (`?`) |
| `KemasanSVG` | Ilustrasi kemasan yang bisa "dibongkar" (state: utuh → terbuka → terpisah) |
| `IstilahChip` | Kata kunci berwarna di dalam teks soal; tap → popover arti & sinonim |
| `AngkaTag` | Angka dalam soal yang bisa dilabeli (Labeli Angka) |
| `StepCard` | Satu langkah penjelasan + indikator "Langkah n dari m" |
| `NumberInput` | Keypad angka besar, menerima koma desimal |
| `FeedbackSheet` | Panel bawah: benar/salah + alasan + bar model + tombol lanjut |
| `HintButton` | Petunjuk bertingkat (maks. 2) |
| `Boxy` | Maskot kotak kardus dengan ekspresi (netral, senang, berpikir, semangat) |
| `InstallBanner` | Ajakan pasang aplikasi / panduan iOS |
| `ConfirmDialog` | Konfirmasi di dalam halaman (bukan `window.confirm`) |

### 2.5 Ukuran & jarak
- Target sentuh ≥ 48 × 48 px; jarak antar tombol ≥ 8 px.
- Padding samping halaman 16 px; skala spasi 4/8/12/16/24/32 px.
- Tombol utama di area jempol (bawah layar), lebar penuh di HP.

### 2.6 Gerak (animasi)
- Durasi 150–400 ms; tidak berulang tanpa henti.
- Animasi bongkar kotak dipicu siswa (tap/geser), bukan otomatis.
- Bila `prefers-reduced-motion: reduce` → transisi diganti fade/instan.

## 3. Wireframe Teks

### 3.1 Beranda / Peta Misi
```
┌──────────────────────────────┐
│ 📦 BoxBuster          ⚙️ 📖  │  ⚙️ pengaturan  📖 kamus
├──────────────────────────────┤
│  Halo, Raka!  [Boxy senang]  │
│  Bongkar kotaknya, temukan   │
│  beratnya!                   │
├──────────────────────────────┤
│ [📦 Bongkar Kotak]  ★★★      │
│ [1] Hitung Langsung  ★★☆     │
│ [2] Cari yang Hilang ★☆☆     │
│ [3] Persen Tara      🔒      │
│ [4] Soal Cerita      🔒      │
│ [5] Misi Besar       🔒      │
├──────────────────────────────┤
│ [🧮 Alat Hitung] [🏁 Uji]    │
├──────────────────────────────┤
│ ⬇ Pasang aplikasi di HP-mu   │
└──────────────────────────────┘
```

### 3.2 Bongkar Kotak
```
┌──────────────────────────────┐
│ ← Bongkar Kotak              │
│ Pilih: [🥔][🥛][🌾][🛢️][📦]   │
│                              │
│      [ ilustrasi keripik ]   │
│      ⚖️ 80 g                 │
│                              │
│   👆 Geser untuk membongkar  │
├──────────────────────────────┤
│ █████████ BRUTO 80 g ███████ │
│ ███ NETTO 75 g ███ │TARA 5 g │
├──────────────────────────────┤
│ Bruto = semuanya.            │
│ Netto = isinya.              │
│ Tara = bungkusnya.           │
│            [ Lanjut → ]      │
└──────────────────────────────┘
```

### 3.3 Contoh Bertahap
```
┌──────────────────────────────┐
│ ← Contoh 1      Langkah 2/4  │
│ ●●○○                         │
├──────────────────────────────┤
│ Beras 50 kg. Tara 2%.        │
│                              │
│ Persen tara dari bruto.      │
│ 2% × 50 kg = 1 kg            │
│                              │
│ [bar: 100% | 98% hijau|2% or]│
├──────────────────────────────┤
│ [↺ Ulangi] [← Kembali] [Lanjut →]│
└──────────────────────────────┘
```

### 3.4 Latihan (pilihan ganda/isian)
```
┌──────────────────────────────┐
│ ← Level 3     Soal 3/8  💡   │
├──────────────────────────────┤
│ [ilustrasi karung, tap=zoom] │
│ Netto sekarung beras 49 kg.  │
│ (Tara) karung 2% dari (bruto)│  ← chip berwarna
│ Berapa bruto beras itu?      │
├──────────────────────────────┤
│ ( ) 49,98 kg   ( ) 50 kg     │
│ ( ) 51 kg      ( ) 48,02 kg  │
│                              │
│          [ Periksa ]         │
└──────────────────────────────┘
```

### 3.5 Panel Umpan Balik (salah)
```
┌──────────────────────────────┐
│ ✖ Belum tepat  [Boxy mikir]  │
│ Persen tara dihitung dari    │
│ bruto, bukan dari netto.     │
│ [bar model jawaban benar]    │
│ [💡 Lihat langkah] [Coba lagi]│
└──────────────────────────────┘
```

### 3.6 Misi Literasi
```
┌──────────────────────────────┐
│ ← Misi: Beras Bu Sari        │
│ ①Pahami ②Rencana ③Hitung ④Cek ⑤Tafsir │
├──────────────────────────────┤
│ Tap setiap angka, beri label │
│ "...2 karung... [50 kg]...   │
│  [2%]... [Rp12.000]..."      │
│                              │
│ 50 kg → [Bruto▾]             │
│ [Bruto][Netto][Tara][%Tara]  │
│ [Harga][Jumlah][Tidak dipakai]│
│            [ Lanjut → ]      │
└──────────────────────────────┘
```

### 3.7 Alat Hitung
```
┌──────────────────────────────┐
│ ← Alat Hitung        [kg ▾]  │
│ Bruto  [   50   ]            │
│ Netto  [   ?    ]            │
│ Tara   [   2  ] [ % | kg ]   │
│        [ Hitung ]            │
├──────────────────────────────┤
│ Netto = 49 kg                │
│ [bar model]                  │
│ 1) Tara = 2% × 50 = 1 kg     │
│ 2) Netto = 50 − 1 = 49 kg    │
└──────────────────────────────┘
```

### 3.8 Rapor Uji Pemahaman
```
┌──────────────────────────────┐
│ 🏁 Rapor Raka    8/10        │
│ TP1 Membedakan   ██████ 2/2  │
│ TP2 Menghitung   ██████ 3/3  │
│ TP3 Persen tara  ███░░░ 1/2  │
│ TP4 Soal cerita  ████░░ 2/3  │
│ Perlu diulang:               │
│ • Persen dari netto (Level 3)│
│ 🏅 Ahli Cek Kewajaran         │
│ [📤 Bagikan] [↺ Ulangi Level 3]│
└──────────────────────────────┘
```

## 4. Microcopy
| Situasi | Contoh |
|---|---|
| Benar | "Tepat! Kotaknya terbongkar 🎉" · "Mantap, netto ketemu!" |
| Salah (umum) | "Belum tepat. Yuk, lihat lagi." |
| Petunjuk | "Yang dicari keseluruhan atau bagian?" |
| Offline | "Kamu sedang offline. BoxBuster tetap bisa dipakai." |
| Install | "Pasang BoxBuster di HP-mu. Gratis, tanpa Play Store." |
Aturan: kalimat ≤ 15 kata, sapaan "kamu", positif, tanpa menyalahkan.

## 5. Aksesibilitas (checklist)
- [ ] Kontras AA untuk semua teks & ikon penting.
- [ ] Semua tombol punya label teks atau `aria-label`.
- [ ] SVG punya `<title>` / `role="img"` + `aria-label`.
- [ ] Bisa dinavigasi dengan keyboard (desktop), fokus terlihat.
- [ ] Umpan balik benar/salah diumumkan (`aria-live="polite"`).
- [ ] Zoom browser hingga 200% tidak merusak tata letak.
- [ ] Mode gelap mengikuti sistem + pilihan manual di Pengaturan.
- [ ] `prefers-reduced-motion` dihormati.

## 6. Aset
- Logo: kotak kardus terbuka dengan tanda "!" / kilau (SVG).
- Ikon aplikasi PWA: 192×192, 512×512, dan versi *maskable* 512×512 (latar `#B45309`).
- Ilustrasi kemasan SVG (`src/assets/kemasan/`): keripik, susu-kaleng, karung-beras, jeriken-minyak, kardus-paket, biskuit-kaleng, sarden, galon, peti-telur, keranjang-durian.
- Maskot Boxy: 4 ekspresi, SVG ≤ 5 KB per file.
- Semua aset dibuat sendiri/berlisensi bebas; tidak memakai merek dagang produk nyata.
