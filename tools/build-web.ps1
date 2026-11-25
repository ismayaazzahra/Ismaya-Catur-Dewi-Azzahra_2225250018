# Membangun web/index.html (PWA) dari sumber prototipe aset/prototipe-boxbuster.html.
# Jalankan dari folder mana saja:  powershell -File tools\build-web.ps1
$ErrorActionPreference = 'Stop'
$proj = Split-Path -Parent $PSScriptRoot
$web  = Join-Path $proj 'web'
$src  = Join-Path $proj 'aset\prototipe-boxbuster.html'
$u = New-Object System.Text.UTF8Encoding $false

$s   = [IO.File]::ReadAllText($src)
$old = [IO.File]::ReadAllText((Join-Path $web 'index.html'))

# pembungkus PWA (head & tombol pasang) diambil dari index.html yang ada
$h0 = $old.IndexOf('<style>:root{color-scheme:light'); $h1 = $old.IndexOf('</style>', $h0) + 8
if($h0 -lt 0){ throw 'Pembungkus PWA tidak ditemukan di web/index.html' }
$headTop = $old.Substring(0, $h1)
if(-not $headTop.Contains('src="config.js"')){
  $headTop = $headTop.Replace('<style>:root{color-scheme:light', "<script src=`"config.js`"></script>`n<style>:root{color-scheme:light")
}
$tail = $old.Substring($old.IndexOf('<button class="install"'))
$i = $s.IndexOf('<style>')
$html = $headTop + "`n" + $s.Substring(0,$i).Replace('<meta name="claude:viewport-fit-sides" content="cover">','') + "</head>`n<body>`n" + $s.Substring($i) + "`n" + $tail
$html = $html.Replace('Ini prototipe tampilan. Versi jadi bisa dipasang di HP tanpa Play Store dan dipakai offline.','Pasang BoxBuster di HP: buka menu browser lalu pilih "Instal aplikasi" atau "Tambahkan ke layar utama". Setelah dibuka sekali, bisa dipakai tanpa internet.')
[IO.File]::WriteAllText((Join-Path $web 'index.html'), $html, $u)

# naikkan versi cache service worker agar HP mengambil versi baru
$swPath = Join-Path $web 'sw.js'
$sw = [IO.File]::ReadAllText($swPath)
$m = [regex]::Match($sw, 'boxbuster-v(\d+)')
$nv = [int]$m.Groups[1].Value + 1
$sw = $sw.Replace($m.Value, "boxbuster-v$nv")
if(-not $sw.Contains("'./config.js'")){ $sw = $sw.Replace("'./index.html',", "'./index.html', './config.js',") }
[IO.File]::WriteAllText($swPath, $sw, $u)
"build ok: web/index.html {0:N0} karakter, cache v{1}" -f $html.Length, $nv
