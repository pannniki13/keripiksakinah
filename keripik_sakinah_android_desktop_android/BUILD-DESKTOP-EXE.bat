@echo off
setlocal
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 (
  echo Node.js belum terpasang.
  echo Pasang Node.js versi 22 atau lebih baru dari https://nodejs.org lalu jalankan lagi.
  pause
  exit /b 1
)
echo Memasang dependency dan membangun installer Windows...
call npm install
if errorlevel 1 goto fail
call npm run dist:win
if errorlevel 1 goto fail
echo.
echo Selesai. Installer ada di folder release.
pause
exit /b 0
:fail
echo Build gagal. Periksa koneksi internet dan pesan error di atas.
pause
exit /b 1
