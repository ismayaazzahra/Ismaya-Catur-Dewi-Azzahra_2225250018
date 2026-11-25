# 📦 BoxBuster

**Bongkar kotaknya, temukan beratnya!**

BoxBuster adalah aplikasi web progresif (PWA) untuk siswa SMP yang sedang belajar **Bruto, Netto (Neto), dan Tara** dalam materi **Aritmetika Sosial** (Kurikulum Merdeka, Fase D, kelas VII).
Siswa "membongkar" kemasan virtual untuk melihat isi (netto), bungkus (tara), dan keseluruhan (bruto), lalu berlatih dari soal sederhana sampai soal cerita literasi.

- 🌐 Bisa dibuka di browser HP maupun laptop.
- 📲 Bisa **di-install ke HP Android/iPhone tanpa Play Store/App Store**.
- ✈️ Berjalan **offline** setelah dibuka sekali.
- 🔒 Tanpa login, tanpa pengumpulan data pribadi.

> Status: **prototipe** — dokumen perencanaan lengkap dan prototipe web sudah bisa dicoba. Implementasi React + Vite dimulai dari Milestone M0 ([ROADMAP](docs/ROADMAP.md)).

## 🔗 Coba Sekarang
**https://ismayaazzahra.github.io/Ismaya-Catur-Dewi-Azzahra_2225250018/**

Buka di Chrome (HP Android) → ketuk **"Pasang BoxBuster di HP"** atau menu **⋮ → Instal aplikasi**. Setelah dibuka sekali, bisa dipakai tanpa internet.

Isi prototipe ada di folder [`web/`](web/) dan diterbitkan otomatis oleh GitHub Actions ([`.github/workflows/pages.yml`](.github/workflows/pages.yml)) setiap ada push ke `main`.

## Dasar Pengembangan
Desain aplikasi berangkat dari **wawancara beban kognitif** dengan siswa (6 November 2026). Temuan utama: tara dan netto mudah tertukar, persen tara membingungkan ("persennya dari mana?"), sinonim istilah membingungkan, dan soal cerita dengan banyak angka sulit diterjemahkan. Rinciannya ada di [docs/ANALISIS_KEBUTUHAN.md](docs/ANALISIS_KEBUTUHAN.md).

## Fitur
| Modul | Untuk apa |
|---|---|
| 📦 Bongkar Kotak | Melihat langsung bruto = netto + tara lewat animasi kemasan & bar model |
| 📖 Kamus Istilah | "Berat kemasan" = tara, "berat bersih" = netto, dan sinonim lain |
| 👣 Contoh Bertahap | Contoh soal langkah demi langkah, tempo diatur sendiri |
| ✏️ Latihan 5 Level | Hitung langsung → cari yang hilang → persen tara → soal cerita + harga → multi-langkah |
| 🔎 Misi Literasi | Pahami → Rencanakan → Hitung → Cek Kewajaran → Tafsirkan |
| 🧮 Alat Hitung | Isi dua nilai, dapatkan nilai ketiga beserta langkahnya |
| 🏁 Uji Pemahaman | Kuis akhir + rapor per tujuan pembelajaran |
| 🏅 Progres & Lencana | Disimpan di HP; rapor bisa dibagikan |

## Tech Stack
- **JavaScript:** React 18, Vite 5, React Router (HashRouter), Zustand, Tailwind CSS, Framer Motion, vite-plugin-pwa
- **Python:** generator & validator bank soal (Pydantic, pytest)
- **Uji:** Vitest, React Testing Library, Playwright, Lighthouse
- **Hosting:** GitHub Pages + GitHub Actions

## Prasyarat
- Node.js 20 LTS
- Python 3.11+
- Git

## Menjalankan (setelah M0 selesai)
```bash
# JavaScript
npm install
npm run dev            # server pengembangan (buka URL yang tampil; gunakan --host untuk mencoba di HP satu Wi-Fi)
npm test               # unit test
npx playwright test    # e2e test
npm run build          # build produksi ke dist/
npm run preview        # pratinjau build (PWA aktif)

# Python (tooling soal)
pip install -r tools/requirements.txt
python tools/generate_soal.py    # opsional
python tools/validate_soal.py    # wajib sebelum commit
pytest tools/tests
```

## Struktur Folder (rencana)
```
BoxBuster/
├── CLAUDE.md          panduan untuk Claude Code
├── docs/              dokumen perencanaan
├── public/            ikon PWA
├── src/               aplikasi React (routes, components, lib, store, data, assets)
├── tests/             unit & e2e
└── tools/             skrip Python untuk bank soal
```
Detail: [docs/ARSITEKTUR.md](docs/ARSITEKTUR.md#3-struktur-folder).

## Asisten AI "Kak Boxy"
Chatbot pembimbing berpikir (DeepSeek) yang memandu tahap literasi PISA dan fase RMT. Kak Boxy memberi bantuan bertingkat tanpa memberi jawaban akhir.
API key disimpan di server perantara Cloudflare Worker ([`server/`](server/)), bukan di repo.
- Desain pedagogis: [docs/ASISTEN_AI.md](docs/ASISTEN_AI.md)
- Cara memasang server: [server/README.md](server/README.md)

Web dibangun ulang dari sumber prototipe dengan: `powershell -File tools\build-web.ps1`

## Dokumen Perencanaan
| Dokumen | Isi |
|---|---|
| [PRD.md](docs/PRD.md) | Kebutuhan produk: tujuan, pengguna, user stories, fitur, non-fungsional |
| [ANALISIS_KEBUTUHAN.md](docs/ANALISIS_KEBUTUHAN.md) | Wawancara → temuan beban kognitif → kebutuhan desain |
| [DESAIN_PEMBELAJARAN.md](docs/DESAIN_PEMBELAJARAN.md) | CP/TP, Cognitive Load Theory, CPA, literasi PISA, umpan balik |
| [KONTEN_DAN_SOAL.md](docs/KONTEN_DAN_SOAL.md) | Materi, glosarium, skema JSON soal, 40 soal awal, misi literasi |
| [UI_UX.md](docs/UI_UX.md) | Design system, wireframe, microcopy, aksesibilitas |
| [ARSITEKTUR.md](docs/ARSITEKTUR.md) | Stack, struktur folder, logika, PWA/offline, tooling Python |
| [ROADMAP.md](docs/ROADMAP.md) | Milestone M0–M6 dan definition of done |
| [TESTING.md](docs/TESTING.md) | Uji teknis, uji perangkat, validasi ahli, uji coba siswa |
| [DEPLOYMENT.md](docs/DEPLOYMENT.md) | GitHub Pages, cara install di HP, QR brosur |

## Pengembang
Ismaya Catur Dewi Azzahra — S1 Pendidikan Matematika (NIM 2225250018, Kelas 3A)
