# PRD — BoxBuster

**Product Requirements Document**
Versi 1.0 · 11 November 2026 · Penyusun: Ismaya Catur Dewi Azzahra

> *BoxBuster* — "bongkar kotaknya, temukan beratnya!"
> Aplikasi web progresif (PWA) untuk belajar **Bruto, Netto (Neto), dan Tara** pada materi Aritmetika Sosial SMP.

---

## 1. Latar Belakang
Materi bruto, netto, dan tara diajarkan di kelas VII (Kurikulum Merdeka, Fase D). Wawancara dengan siswa S01 (lihat [ANALISIS_KEBUTUHAN.md](ANALISIS_KEBUTUHAN.md)) menunjukkan sumber beban kognitif utama:
- istilah tara dan netto mudah tertukar, dan siswa lupa mana yang paling besar;
- siswa merasa harus menghafal tiga rumus terpisah;
- **persen tara** paling sulit: siswa tidak yakin persen dihitung dari mana dan sering menghitungnya dari netto;
- sinonim istilah ("berat kemasan" = tara) membingungkan;
- soal cerita dengan banyak angka sulit diterjemahkan;
- penjelasan guru terasa cepat dan gambar soal kurang jelas.

Siswa juga menunjukkan kekuatan yang bisa dibangun: paham lewat contoh nyata, terbiasa mengecek "netto < bruto", dan pernah menjelaskan ke teman.

## 2. Pernyataan Masalah
Siswa SMP kesulitan memahami dan membedakan bruto, netto, dan tara—terutama saat tara dinyatakan dalam persen—karena penyajian materi menuntut hafalan rumus, memakai istilah yang beragam, dan tidak memberi kesempatan belajar sesuai tempo sendiri.

## 3. Tujuan Produk
| # | Tujuan | Indikator keberhasilan |
|---|---|---|
| G1 | Siswa dapat membedakan bruto, netto, tara | ≥ 85% benar pada soal identifikasi (Level 1–2) saat uji coba |
| G2 | Siswa dapat menghitung tara/netto dari persen tara | ≥ 80% benar pada soal persen tara (Level 3) |
| G3 | Siswa dapat menyelesaikan masalah kontekstual (literasi) | Kenaikan rata-rata skor pre-test → post-test ≥ 20 poin |
| G4 | Aplikasi mengurangi beban kognitif ekstrinsik | Skor rata-rata skala Paas menurun dibanding pembelajaran biasa |
| G5 | Aplikasi mudah dipakai di HP | Skor SUS ≥ 70 |
| G6 | Mudah diakses & di-install tanpa Play Store | Lighthouse PWA lolos "installable"; berjalan offline; muat < 3 detik di 4G |

## 4. Pengguna
### Persona utama — "Raka", siswa kelas VII
- 12–13 tahun, memakai HP Android kelas menengah-bawah (RAM 2–4 GB, layar ~6"), kuota terbatas.
- Lebih mudah paham dengan gambar dan contoh; cepat bosan dengan teks panjang.
- Sering bingung dengan istilah di soal cerita.

### Persona sekunder — Guru matematika
- Membagikan link/QR BoxBuster di kelas atau melalui brosur.
- Meminta siswa menunjukkan **rapor hasil** (screenshot) sebagai bukti belajar.
- *Tidak* memerlukan akun atau dashboard (di luar cakupan versi ini).

## 5. User Stories
| ID | Sebagai… | Saya ingin… | Agar… | Prioritas |
|---|---|---|---|---|
| US01 | siswa | membuka aplikasi dari QR brosur tanpa install dari Play Store | bisa langsung belajar | Wajib |
| US02 | siswa | memasang aplikasi ke layar utama HP | bisa dibuka lagi tanpa internet | Wajib |
| US03 | siswa | melihat kotak "dibongkar" menjadi isi dan kemasan | paham beda bruto, netto, tara | Wajib |
| US04 | siswa | melihat daftar istilah lain dari bruto/netto/tara | tidak bingung membaca soal | Wajib |
| US05 | siswa | mempelajari contoh soal langkah demi langkah dengan tempo sendiri | tidak tertinggal penjelasan | Wajib |
| US06 | siswa | berlatih dari soal mudah ke sulit | percaya diri bertahap | Wajib |
| US07 | siswa | mendapat penjelasan **mengapa** jawabanku salah | tidak mengulang kesalahan yang sama | Wajib |
| US08 | siswa | belajar persen tara dengan visual 100% | tahu persennya dihitung dari bruto | Wajib |
| US09 | siswa | menandai arti setiap angka di soal cerita | tidak salah memakai angka | Wajib |
| US10 | siswa | memakai alat hitung yang menunjukkan langkahnya | bisa mengecek hasil sendiri | Wajib |
| US11 | siswa | mengerjakan uji pemahaman dan melihat rapor | tahu seberapa paham aku | Wajib |
| US12 | siswa | melihat progres & lencana | termotivasi menyelesaikan semua level | Sebaiknya |
| US13 | siswa | membagikan kartu ringkasan/rapor ke teman/guru | bisa menjelaskan ke teman | Sebaiknya |
| US14 | siswa | memakai mode gelap dan memperbesar gambar | nyaman di mata dan jelas | Sebaiknya |
| US15 | guru | membagikan satu link/QR | seluruh kelas bisa mengakses | Wajib |

## 6. Ruang Lingkup

### 6.1 MVP (versi 1.0)
| # | Modul | Deskripsi singkat | Temuan terkait |
|---|---|---|---|
| 1 | **Beranda / Peta Misi** | 5 level kotak terbuka bertahap; tombol cepat ke Kamus & Alat Hitung | DS01 |
| 2 | **Bongkar Kotak** | Eksplorasi interaktif konkret → piktorial → abstrak: pilih kemasan, tap/geser untuk membongkar, angka masuk ke bar model | K01, IL01, IL02 |
| 3 | **Kamus Istilah** | Kartu sinonim + contoh label kemasan; diakses dari mana saja | K03, EL01 |
| 4 | **Contoh Bertahap** | Worked example per level → langkah dihilangkan bertahap (*fading*) | GL01, GL03, EL02, EL04 |
| 5 | **Latihan Berjenjang** | L1 hitung langsung · L2 cari yang hilang · L3 persen tara · L4 soal cerita + harga · L5 multi-langkah | IL02, IL04, GL05, DS02 |
| 6 | **Misi Literasi** | Siklus 5 langkah: Pahami (labeli angka) → Rencanakan → Hitung → Cek Kewajaran → Tafsirkan | EL05, GL02, GL04 |
| 7 | **Alat Hitung BoxBuster** | Isi 2 dari 3 nilai (atau % tara) → hasil + bar model + langkah | IL03, DS01 |
| 8 | **Uji Pemahaman** | 10 soal acak dari bank soal, pengecoh berbasis miskonsepsi, rapor per tujuan pembelajaran | DS01 |
| 9 | **Progres & Lencana** | Disimpan lokal; rapor bisa di-screenshot atau dibagikan (Web Share API) | GL04 |

### 6.2 Versi berikutnya (bukan MVP)
- Narasi suara (*text-to-speech*) untuk teks soal.
- Mode tantangan berwaktu / papan skor antarteman lokal.
- APK sideload via PWABuilder (tetap tanpa Play Store).
- Materi lanjutan aritmetika sosial (diskon, pajak, bunga).

### 6.3 Di luar cakupan
- Login/akun, backend server, database, dashboard guru.
- Pengumpulan data pribadi siswa dalam bentuk apa pun.
- Distribusi melalui Play Store/App Store.

## 7. Kebutuhan Fungsional

### FR-0 Masuk / Daftar (profil lokal)
- FR-0.1 Layar pertama aplikasi: maskot Boxy, judul, tab **Masuk** dan **Daftar baru**.
- FR-0.2 Daftar cukup dengan **nama panggilan** (wajib, maks. 20 huruf), **kelas** (opsional), dan **karakter** (keripik/beras/permen/gula). Tanpa email, tanpa password.
- FR-0.3 Masuk: daftar pemain yang pernah mendaftar di perangkat itu; satu ketukan untuk melanjutkan. Pemain terakhir ditandai.
- FR-0.4 Setiap pemain punya progres sendiri (cocok untuk satu HP dipakai bergantian). Tombol **Ganti pemain** di beranda.
- FR-0.5 Data hanya tersimpan di perangkat (`localStorage`); tidak dikirim ke server. Nama yang sama tidak boleh didaftarkan dua kali.

### FR-1 Beranda / Peta Petualangan
- FR-1.1 Beranda berupa **peta pulau bergaya petualangan** (dilihat dari atas, siswa menggulir dari bawah ke atas). Jalan kayu menghubungkan 5 pulau bertema kemasan, berakhir di **Kotak Misteri** di puncak:
  1. **Pulau Jajanan** → Bongkar Kotak (kantong keripik, kotak jajan)
  2. **Hutan Istilah** → Kamus Istilah (papan nama BRUTO/NETTO/TARA)
  3. **Pasar Beras** → Contoh Bertahap persen tara (karung, timbangan)
  4. **Gudang Kaleng** → Latihan (kaleng, peti)
  5. **Dermaga Paket** → Misi Literasi (kardus, perahu)
  - Rakit **Timbangan Ajaib** → Alat Hitung (selalu terbuka)
- FR-1.2 Pesan pemandu dari maskot Boxy: "Ayo kita menjelajah! … untuk membuka Kotak Misteri", berikut tugas tahap saat ini.
- FR-1.3 Status pulau: selesai (✓ emas), sekarang (berdenyut + label "Ayo!"), terkunci (gembok). Pulau terkunci menampilkan pesan "Selesaikan … dulu".
- FR-1.4 Saat sebuah tahap selesai dan siswa kembali ke peta, **jalan menyala bertahap dan Boxy berjalan** ke pulau berikutnya (± 1,8 detik; tanpa animasi bila `prefers-reduced-motion`).
- FR-1.5 HUD: jumlah koin (20 per pulau, 10 per soal benar) dan "n / 5 pulau". Kotak Misteri terbuka setelah 5 pulau selesai → lencana *Pembongkar Ahli* → lanjut ke Uji Pemahaman.
- FR-1.6 Ilustrasi peta dibuat sendiri (SVG), tidak meniru gim tertentu.
- FR-1.7 Tombol "Pasang Aplikasi" muncul bila browser mendukung `beforeinstallprompt`; di iOS tampil panduan manual.

### FR-2 Bongkar Kotak
- FR-2.1 Pilihan minimal 6 kemasan (keripik, susu kaleng, beras karung, minyak jeriken, paket kardus, biskuit kaleng).
- FR-2.2 Tap/geser membuka kemasan → isi keluar → label **Netto** (hijau), kemasan kosong → **Tara** (oranye), timbangan awal → **Bruto** (biru).
- FR-2.3 Bar model memperlihatkan Bruto = Netto + Tara dengan angka.
- FR-2.4 Mode "Tebak": salah satu nilai disembunyikan; siswa menebak operasi (tambah/kurang) sebelum menghitung.

### FR-3 Kamus Istilah
- FR-3.1 Kartu untuk Bruto, Netto, Tara, Persen Tara beserta sinonim (lihat [KONTEN_DAN_SOAL.md](KONTEN_DAN_SOAL.md)).
- FR-3.2 Di setiap soal, istilah kunci diberi sorotan warna; tap → muncul kartu ringkas (tooltip).

### FR-4 Contoh Bertahap
- FR-4.1 Satu langkah per layar dengan tombol Lanjut/Kembali/Ulangi dan indikator "Langkah n dari m".
- FR-4.2 Contoh ke-2 menyembunyikan 1 langkah, contoh ke-3 menyembunyikan 2 langkah (*fading*).

### FR-5 Latihan
- FR-5.1 Soal diambil dari `soal.json` per level, urutan diacak.
- FR-5.2 Tipe soal: isian angka, pilihan ganda, labeli angka, urutkan langkah.
- FR-5.3 Umpan balik segera: benar → penguatan singkat; salah → pesan sesuai miskonsepsi pengecoh + bar model jawaban benar.
- FR-5.4 Petunjuk bertingkat (maks. 2) sebelum jawaban ditunjukkan.
- FR-5.5 Input angka menerima koma desimal (format Indonesia) dan titik ribuan.

### FR-6 Misi Literasi
- FR-6.1 Lima langkah berurutan: **Pahami** (labeli angka) → **Rencanakan** (pilih yang dicari & operasi) → **Hitung** → **Cek Kewajaran** (centang: netto < bruto? tara < bruto? satuan sama?) → **Tafsirkan** (pilih kalimat kesimpulan yang sesuai konteks).
- FR-6.2 Setelah misi selesai, prompt **"Jelaskan ke Teman"**: siswa menyusun penjelasan dari potongan kalimat; hasilnya jadi kartu yang bisa dibagikan.

### FR-7 Alat Hitung BoxBuster
- FR-7.1 Input: Bruto, Netto, Tara, % Tara; siswa mengisi 2 nilai (atau bruto + % tara / netto + % tara).
- FR-7.2 Output: nilai yang hilang, bar model, langkah perhitungan tertulis.
- FR-7.3 Validasi: menolak input tidak wajar (mis. tara > bruto) dengan pesan ramah.
- FR-7.4 Pemilih satuan (g, kg, ons, kuintal) dengan konversi otomatis.

### FR-8 Uji Pemahaman
- FR-8.1 10 soal: 2 per level, acak dari bank soal.
- FR-8.2 Tanpa petunjuk; umpan balik di akhir.
- FR-8.3 Rapor: skor, rincian per tujuan pembelajaran (TP1–TP4), miskonsepsi yang terdeteksi + saran modul untuk diulang.

### FR-9 Progres & Lencana
- FR-9.1 Progres tersimpan di `localStorage` (tanpa nama asli; siswa boleh mengisi nama panggilan untuk rapor).
- FR-9.2 Lencana contoh: *Pembongkar Pemula*, *Detektif Istilah*, *Ahli Persen Tara*, *Cek Kewajaran*, *Guru Cilik*.
- FR-9.3 Tombol "Bagikan Rapor" (Web Share API; fallback: tampilkan kartu siap di-screenshot).
- FR-9.4 Tombol "Mulai dari awal" dengan konfirmasi di dalam halaman.

## 8. Kebutuhan Non-Fungsional
| ID | Kategori | Kebutuhan |
|---|---|---|
| NFR-1 | Platform | Berjalan di Chrome Android ≥ 100, Safari iOS ≥ 16, browser desktop modern |
| NFR-2 | Instalasi | PWA installable (manifest + service worker + HTTPS) |
| NFR-3 | Offline | 100% fitur berjalan offline setelah kunjungan pertama |
| NFR-4 | Performa | Total unduhan awal < 2 MB; First Contentful Paint < 2 dtk di 4G; Lighthouse Performance ≥ 90 |
| NFR-5 | Responsif | Mobile-first, nyaman di lebar 360 px; juga tablet & desktop |
| NFR-6 | Aksesibilitas | Kontras WCAG AA, target sentuh ≥ 48 px, teks ≥ 16 px, tidak bergantung pada warna saja, hormati `prefers-reduced-motion` |
| NFR-7 | Bahasa | Bahasa Indonesia baku sederhana; kalimat ≤ 15 kata |
| NFR-8 | Privasi | Tanpa login, tanpa analitik pihak ketiga, tanpa data pribadi dikirim ke luar perangkat |
| NFR-9 | Kualitas konten | Semua soal lolos `tools/validate_soal.py` (jawaban dihitung ulang otomatis) |
| NFR-10 | Pemeliharaan | Konten soal terpisah dari kode (JSON) agar mudah ditambah |

## 9. Asumsi & Risiko
| Risiko | Dampak | Mitigasi |
|---|---|---|
| HP siswa kelas bawah / storage penuh | Aplikasi lambat atau gagal install | Bundle kecil, tanpa font eksternal, SVG ringan |
| Siswa tidak paham cara install PWA | Hanya dipakai lewat browser | Panduan install bergambar di aplikasi & brosur |
| iOS tidak mendukung prompt install otomatis | Siswa iPhone bingung | Panduan Safari "Tambah ke Layar Utama" |
| `localStorage` terhapus (bersihkan data browser) | Progres hilang | Beri tahu siswa; progres tidak kritis (bisa diulang) |
| Temuan hanya dari 1 siswa | Desain kurang representatif | Validasi ahli & uji coba lapangan (lihat [TESTING.md](TESTING.md)) |
| Kesalahan kunci jawaban | Siswa belajar hal yang salah | Validator Python menghitung ulang semua jawaban |

## 10. Dokumen Terkait
- [ANALISIS_KEBUTUHAN.md](ANALISIS_KEBUTUHAN.md) · [DESAIN_PEMBELAJARAN.md](DESAIN_PEMBELAJARAN.md) · [KONTEN_DAN_SOAL.md](KONTEN_DAN_SOAL.md)
- [UI_UX.md](UI_UX.md) · [ARSITEKTUR.md](ARSITEKTUR.md) · [ROADMAP.md](ROADMAP.md) · [TESTING.md](TESTING.md) · [DEPLOYMENT.md](DEPLOYMENT.md)
