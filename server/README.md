# Server Kak Boxy (Cloudflare Worker)

Server kecil ini menyimpan **API key DeepSeek secara rahasia** dan menambahkan prompt pedagogis Kak Boxy.
Aplikasi BoxBuster hanya tahu alamat server ini, tidak pernah tahu API key-nya.

## Langkah Pemasangan (lewat browser, tanpa coding)

### A. Siapkan API key DeepSeek
1. Buka **https://platform.deepseek.com** lalu daftar atau masuk.
2. Menu **Top up**: isi saldo (pemakaian dibayar per token; nominal kecil cukup untuk uji coba).
3. Menu **API keys** → **Create new API key** → salin key (diawali `sk-`).
   Simpan baik-baik dan **jangan** ditempel di repo, grup chat, atau dokumen publik.

### B. Buat Worker di Cloudflare
1. Buka **https://dash.cloudflare.com** lalu daftar gratis dan masuk.
2. Menu kiri **Workers & Pages** → **Create** → **Create Worker** (templat *Hello World*).
3. Beri nama `boxbuster-kak-boxy` → **Deploy**.
4. Klik **Edit code**. Hapus semua isi `worker.js` di editor, lalu tempel seluruh isi file [`worker.js`](worker.js) dari folder ini → **Deploy**.

### C. Pasang API key & izin
1. Buka Worker tadi → **Settings** → **Variables and Secrets** → **Add**:

   | Type | Name | Value |
   |---|---|---|
   | **Secret** | `DEEPSEEK_API_KEY` | key `sk-...` dari langkah A |
   | Text | `ALLOWED_ORIGINS` | `https://ismayaazzahra.github.io` |

2. Klik **Deploy** atau **Save**.

### D. Cek & hubungkan
1. Salin alamat Worker, misalnya `https://boxbuster-kak-boxy.namaanda.workers.dev`.
2. Buka alamat itu di browser. Harus muncul `{"ok":true, ..., "siap":true}`.
   Jika `"siap":false`, berarti Secret `DEEPSEEK_API_KEY` belum terpasang.
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
| "Server belum diberi API key" | Secret belum ada | Tambah Secret `DEEPSEEK_API_KEY` |
| "API key DeepSeek tidak valid" | Key salah atau sudah dihapus | Buat key baru, ganti Secret |
| "Saldo akun DeepSeek habis" | Saldo 0 | Top up di platform.deepseek.com |

**Jika key pernah bocor**, hapus key itu di platform.deepseek.com, buat key baru, lalu ganti Secret di Cloudflare.
