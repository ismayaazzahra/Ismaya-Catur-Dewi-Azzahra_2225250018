# Server Kak Boxy (Cloudflare Worker)

Server kecil ini menyimpan **API key DeepSeek secara rahasia** dan menambahkan prompt pedagogis Kak Boxy.
Aplikasi BoxBuster hanya tahu alamat server ini, tidak pernah tahu API key-nya.

## Langkah Pemasangan (lewat browser, tanpa coding)

### A. Siapkan API key (pilih salah satu)

**Pilihan 1: GRATIS lewat OpenRouter (model DeepSeek versi `:free`)**
1. Buka **https://openrouter.ai**, lalu daftar atau masuk (bisa dengan akun Google).
2. Buka **https://openrouter.ai/models?q=deepseek%20free**. Pilih model DeepSeek yang namanya berakhiran **`:free`**, lalu salin nama modelnya (tombol salin di sebelah nama), misalnya `deepseek/....:free`.
3. Buka menu **Keys** → **Create Key** → salin key (diawali `sk-or-`).
4. Batasan: model gratis punya kuota harian dan bisa sewaktu-waktu diganti atau dihapus oleh OpenRouter. Cukup untuk uji coba, belum tentu cukup untuk satu kelas sekaligus. Jika kuota habis, Kak Boxy menampilkan pesan "kuota hari ini sudah habis".

**Pilihan 2: DeepSeek resmi (berbayar, lebih stabil)**
1. Buka **https://platform.deepseek.com**, lalu daftar atau masuk.
2. Di menu **Top up**, isi saldo (dibayar per pemakaian; nominal kecil cukup untuk uji coba).
3. Buka menu **API keys** → **Create new API key** → salin key (diawali `sk-`).

Simpan key baik-baik dan **jangan** ditempel di repo, grup chat, atau dokumen publik.

### B. Buat Worker di Cloudflare
1. Buka **https://dash.cloudflare.com** lalu daftar gratis dan masuk.
2. Menu kiri **Workers & Pages** → **Create application** (di versi lama: **Create**).
   Jika ada tab **Workers** dan **Pages**, pilih tab **Workers**, bukan Pages.
   Lalu pilih **Start with Hello World!** (atau **Create Worker**). Jangan pilih *Import a repository*.
3. Beri nama `boxbuster-kak-boxy` → **Deploy**.
4. Klik **Edit code**. Hapus semua isi `worker.js` di editor, lalu tempel seluruh isi file [`worker.js`](worker.js) dari folder ini → **Deploy**.

### C. Pasang API key & izin
1. Buka Worker tadi → **Settings** → **Variables and Secrets** → **Add**:

   | Type | Name | Value | Dipakai untuk |
   |---|---|---|---|
   | **Secret** | `AI_API_KEY` | key dari langkah A | keduanya |
   | Text | `ALLOWED_ORIGINS` | `https://ismayaazzahra.github.io` | keduanya |
   | Text | `API_URL` | `https://openrouter.ai/api/v1/chat/completions` | **hanya OpenRouter (gratis)** |
   | Text | `MODEL` | nama model `...:free` yang disalin | **hanya OpenRouter (gratis)** |

   Untuk DeepSeek resmi, cukup dua baris pertama (`API_URL` dan `MODEL` otomatis memakai DeepSeek).

2. Klik **Deploy** atau **Save**.

### D. Cek & hubungkan
1. Salin alamat Worker, misalnya `https://boxbuster-kak-boxy.namaanda.workers.dev`.
2. Buka alamat itu di browser. Harus muncul `{"ok":true, ..., "siap":true}`.
   Jika `"siap":false`, berarti Secret `AI_API_KEY` belum terpasang. Bagian `"penyedia"` dan `"model"` menunjukkan layanan AI yang sedang dipakai.
3. Isi alamat itu di [`web/config.js`](../web/config.js):
   ```js
   window.BOXBUSTER_CHAT_URL = 'https://boxbuster-kak-boxy.namaanda.workers.dev';
   ```
4. Commit dan push. GitHub Pages akan terbit ulang otomatis, lalu tab **Kak Boxy** di aplikasi langsung aktif.
   (Alamat Worker bukan rahasia, jadi aman berada di repo publik.)

## Pengaturan Tambahan (opsional)
| Variabel | Default | Fungsi |
|---|---|---|
| `RATE_LIMIT` | `40` | Batas pesan per perangkat per 10 menit |
| `MODEL` | `deepseek-chat` | Model DeepSeek yang dipakai |

## Jika Ada Masalah
| Pesan di aplikasi | Penyebab | Solusi |
|---|---|---|
| "Kak Boxy belum terhubung" | `web/config.js` masih kosong | Isi alamat Worker (langkah D) |
| "Asal permintaan tidak diizinkan" | `ALLOWED_ORIGINS` salah | Isi persis `https://ismayaazzahra.github.io` (tanpa `/` di akhir) |
| "Server belum diberi API key" | Secret belum ada | Tambah Secret `AI_API_KEY` |
| "API key tidak valid" | Key salah atau sudah dihapus | Buat key baru, ganti Secret |
| "Saldo akun AI habis" | Saldo 0 (DeepSeek resmi) | Top up di platform.deepseek.com |
| "Model AI tidak ditemukan" | Nama `MODEL` salah atau model gratis sudah dihapus | Salin ulang nama model `:free` yang masih ada di OpenRouter |
| "Kuota Kak Boxy hari ini sudah habis" | Batas harian model gratis | Tunggu besok, atau pindah ke DeepSeek resmi |

**Jika key pernah bocor**, hapus key itu di platform.deepseek.com, buat key baru, lalu ganti Secret di Cloudflare.
