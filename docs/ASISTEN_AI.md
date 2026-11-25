# Asisten Belajar "Kak Boxy" (DeepSeek)

Kak Boxy adalah chatbot **pembimbing proses berpikir matematis**, bukan mesin penjawab soal.
Ia memandu siswa melewati tahap literasi matematika dan tahap Rigorous Mathematical Thinking (RMT), mengelola beban kognitif, dan memberi bantuan bertingkat **tanpa menyebut jawaban akhir**.

## 1. Fungsi Pedagogis

| Kebutuhan | Cara Kak Boxy melakukannya |
|---|---|
| **1. Membimbing literasi matematika bertahap** | Lima tahap berurutan: **Pahami → Rencana → Hitung → Cek → Tafsir** (kerangka PISA: merumuskan, menerapkan, menafsirkan). Satu tahap per giliran. Tahap aktif ditampilkan di layar. |
| **2. Mengelola beban kognitif** | **Intrinsik:** soal dipecah jadi langkah kecil, satu unsur per giliran, persen dan harga tidak dibahas sekaligus. **Ekstrinsik:** maksimal 3 kalimat pendek (≤ 15 kata), satu pertanyaan per giliran, istilah konsisten, sinonim dijelaskan. **Germane:** siswa diminta menjelaskan alasan, membandingkan, dan menyimpulkan sendiri. |
| **3. Bantuan sesuai kesulitan, tidak langsung menjawab** | **Tangga bantuan 0–4** (lihat §3). Naik hanya jika siswa masih kesulitan, turun lagi jika lancar. Permintaan "langsung jawabannya" ditolak dengan ramah. Kunci jawaban dikirim ke model sebagai konteks **rahasia** untuk menilai, tidak untuk disebut. |
| **4. Tahapan RMT** | Empat fase (Kinard & Kozulin, 2008) dipakai sebagai cara memediasi (lihat §2). Fase aktif ditampilkan di layar. |

Ditambah: deteksi 8 miskonsepsi yang sama dengan latihan (lihat [DESAIN_PEMBELAJARAN.md](DESAIN_PEMBELAJARAN.md#6-umpan-balik-berbasis-miskonsepsi)), ditanggapi dengan pertanyaan penuntun, bukan koreksi langsung.

## 2. Tahap Rigorous Mathematical Thinking (RMT)
Mengacu pada Kinard & Kozulin (2008), *Rigorous Mathematical Thinking: Conceptual Formation in the Mathematics Classroom*, yang berlandaskan teori mediasi Feuerstein dan Vygotsky.

| Fase | Kode | Contoh mediasi Kak Boxy |
|---|---|---|
| Konstruksi konsep kognitif | `konstruksi_kognitif` | "Coba bandingkan: mana isinya, mana bungkusnya, mana keseluruhannya?" (memberi label, membandingkan, menemukan hubungan bagian dan keseluruhan) |
| Praktik konsep kognitif | `praktik_kognitif` | "Di karung beras ini, mana yang bagian dan mana yang keseluruhan?" |
| Konstruksi konsep matematis | `konstruksi_matematis` | "Bisakah kamu tulis hubungan bruto, netto, dan tara dengan tanda + atau −?" |
| Praktik konsep matematis | `praktik_matematis` | "Caramu tadi berlaku juga untuk kardus paket? Kenapa?" (penerapan, refleksi, generalisasi) |

Prinsip mediasi yang diminta di prompt: *intentionality & reciprocity* (tujuan jelas dan siswa menanggapi), *transcendence* (kaitkan ke kehidupan sehari-hari), dan *meaning* (makna/manfaat).
Jika istilah masih tertukar, Kak Boxy kembali ke fase konstruksi kognitif.

> Jika ringkasan RMT dari dosen memakai istilah atau urutan lain, cukup ubah bagian **TAHAP RIGOROUS MATHEMATICAL THINKING** di `server/worker.js` dan daftar `RMT_NAMA` di aplikasi.

## 3. Tangga Bantuan
| Level | Bentuk bantuan | Contoh |
|---|---|---|
| 0 | Pertanyaan pemantik terbuka | "Menurutmu, apa yang ditanyakan soal ini?" |
| 1 | Mengarahkan perhatian | "Lihat kata 'berat kemasan'. Itu sama dengan apa?" |
| 2 | Petunjuk strategi | "Yang dicari bagian atau keseluruhan?" |
| 3 | Contoh langkah dengan angka **lain** | "Misalnya bruto 20 kg, tara 1 kg. Nettonya berapa?" |
| 4 | Satu langkah bersama di soal siswa | "Tara = 2% × 50 = 1 kg. Sekarang kamu hitung nettonya." |

## 4. Tampilan di Aplikasi
- Tab **Kak Boxy** di menu bawah untuk obrolan bebas (soal cerita siswa sendiri, pertanyaan istilah).
- Tombol **"Minta bimbingan Kak Boxy"** muncul saat siswa salah menjawab di **Latihan** dan **Misi Literasi**. Soal, jawaban siswa, miskonsepsi yang terdeteksi, dan kunci rahasia ikut terkirim sebagai konteks.
- Layar menampilkan:
  - kartu soal yang dibahas;
  - penanda **tahap literasi** (5 langkah);
  - label **fase RMT**;
  - **fokus beban** ("Langkah kecil dulu" / "Bahasa ringkas" / "Jelaskan alasanmu");
  - **tingkat bantuan** n/4;
  - tombol balasan cepat dari model.
- Model menjawab dalam format JSON (`balas`, `tahap_literasi`, `tahap_rmt`, `level_bantuan`, `fokus_beban`, `saran`). Server merapikannya sebelum dikirim ke aplikasi.

## 5. Arsitektur & Keamanan

```
HP siswa (BoxBuster) ──POST pesan+konteks──► Cloudflare Worker ──+prompt +API key──► DeepSeek API
                      ◄──── JSON rapi ─────                       ◄──── jawaban ─────
```

- **API key hanya di Cloudflare** (Secret `DEEPSEEK_API_KEY`), tidak pernah ada di repo atau aplikasi.
- **Prompt pedagogis ada di server**, sehingga siswa tidak bisa mengubahnya. Pesan berperan "system" dari aplikasi dibuang.
- Hanya web BoxBuster yang boleh memakai server (`ALLOWED_ORIGINS`).
- Batas pemakaian: 40 pesan per perangkat per 10 menit (`RATE_LIMIT`), 14 pesan riwayat, 600 karakter per pesan, dan jawaban maksimal 400 token.
- **Privasi:**
  - Nama dan kelas siswa **tidak dikirim**.
  - Riwayat obrolan hanya ada di memori selama aplikasi terbuka; tidak disimpan di HP maupun di server BoxBuster.
  - Pesan diproses oleh DeepSeek; siswa diingatkan untuk tidak menulis data pribadi.
  - Untuk penelitian dengan siswa di bawah umur, sebutkan pemakaian layanan AI pihak ketiga ini dalam lembar persetujuan orang tua/sekolah.
- **Offline:** fitur lain tetap berjalan tanpa internet; hanya Kak Boxy yang butuh koneksi.
- **Biaya:** DeepSeek berbayar per pemakaian (deposit kecil sudah cukup untuk uji coba kelas). Pantau saldo di platform.deepseek.com.

## 6. Memasang Server (± 10 menit, tanpa coding)
Lihat langkah lengkap di [server/README.md](../server/README.md). Ringkasnya:
1. Buat API key di **platform.deepseek.com** dan isi saldo.
2. Buat Worker di **dash.cloudflare.com**, lalu tempel isi `server/worker.js`.
3. Tambahkan Secret `DEEPSEEK_API_KEY` dan variabel `ALLOWED_ORIGINS`.
4. Salin alamat Worker ke `web/config.js` (`window.BOXBUSTER_CHAT_URL`), commit, dan push.

## 7. Uji yang Sudah Dilakukan
- Logika server diuji dengan DeepSeek tiruan:
  - asal yang benar mendapat 200, asal lain 403;
  - OPTIONS (CORS) mendapat 204;
  - tanpa key mendapat 500, pesan kosong mendapat 400;
  - pesan "system" dari siswa dibuang;
  - kunci jawaban hanya masuk konteks rahasia;
  - keluaran yang tidak valid dirapikan.
- Alur di aplikasi diuji di Edge (ukuran HP), juga dengan DeepSeek tiruan: salah menjawab → tombol bimbingan → kirim pesan → balasan, penanda tahap, dan tombol cepat tampil.
- **Uji dengan model sungguhan (26 November 2026):**
  - Model: `nvidia/nemotron-3-ultra-550b-a55b:free` lewat OpenRouter. Saat itu tidak ada model DeepSeek gratis di OpenRouter.
  - Skenario: siswa menjawab "50 + 2 = 52 kg" untuk bruto 50 kg dengan tara 2%, lalu meminta jawaban langsung.
  - Hasil: Kak Boxy tidak menyebut 49 kg. Ia menjelaskan bahwa 2% berarti 2% dari bruto, lalu bertanya "2% dari 50 kg itu berapa?". Tercatat tahap *pahami*, fase *konstruksi_kognitif*, bantuan level 1, fokus beban intrinsik. Waktu jawab sekitar 11 detik.
  - Perbaikan: tombol cepat sempat berisi angka (pilihan jawaban). Prompt diperketat agar tombol cepat hanya berisi ungkapan proses.
  - Catat nama model yang benar-benar dipakai di laporan penelitian. Jika nanti pindah ke DeepSeek resmi, cukup ganti `AI_API_KEY` dan hapus `API_URL`/`MODEL` di Cloudflare.
- **Masih perlu diuji lebih banyak:** Setelah key dipasang, coba 5–10 skenario: siswa minta jawaban langsung, salah operasi, persen dari netto, dan di luar topik. Pastikan Kak Boxy tidak membocorkan jawaban.
