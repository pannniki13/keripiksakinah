@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js belum terpasang.
  echo Pasang Node.js versi 22 atau lebih baru dari https://nodejs.org lalu jalankan file ini lagi.
  pause
  exit /b 1
)
if not exist node_modules\electron\dist\electron.exe (
  echo Menyiapkan komponen aplikasi desktop untuk pertama kali...
  call npm install
  if errorlevel 1 (
    echo Gagal mengunduh dependency. Periksa koneksi internet lalu coba lagi.
    pause
    exit /b 1
  )
)
call npm start
