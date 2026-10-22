@echo off
setlocal
set "KSPROJECT=%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$root=$env:KSPROJECT; $file=Join-Path $root 'app\src\main\assets\index.html'; if (!(Test-Path -LiteralPath $file)) { Write-Error 'File aplikasi tidak ditemukan. Ekstrak ZIP terlebih dahulu.'; exit 2 }; $url=([Uri](Resolve-Path -LiteralPath $file).Path).AbsoluteUri + '?mode=desktop'; $browsers=@( (Join-Path $env:ProgramFiles 'Microsoft\Edge\Application\msedge.exe'), (Join-Path ${env:ProgramFiles(x86)} 'Microsoft\Edge\Application\msedge.exe'), (Join-Path $env:LOCALAPPDATA 'Microsoft\Edge\Application\msedge.exe'), (Join-Path $env:ProgramFiles 'Google\Chrome\Application\chrome.exe'), (Join-Path ${env:ProgramFiles(x86)} 'Google\Chrome\Application\chrome.exe'), (Join-Path $env:LOCALAPPDATA 'Google\Chrome\Application\chrome.exe') ); $browser=$browsers | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1; if (!$browser) { Write-Error 'Microsoft Edge atau Google Chrome tidak ditemukan.'; exit 3 }; Start-Process -FilePath $browser -ArgumentList @('--app=' + $url)"
if errorlevel 1 (
  echo Aplikasi desktop tidak bisa dibuka. Pastikan Edge atau Chrome tersedia.
  pause
)
