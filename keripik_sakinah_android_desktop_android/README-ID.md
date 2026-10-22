# Keripik Sakinah — Android WebView app

Proyek ini membungkus UI HTML Keripik Sakinah menjadi aplikasi Android menggunakan WebView. HTML yang ada di folder `app/src/main/assets/index.html` menjadi tampilan aplikasi.

## Cara membuat APK lewat Android Studio

1. Pasang Android Studio pada komputer dan buka proyek folder `KeripikSakinah` ini.
2. Biarkan Android Studio menyinkronkan Gradle dan mengunduh Android SDK yang diperlukan (Android SDK Platform 35).
3. Pilih **Build → Build Bundle(s) / APK(s) → Build APK(s)**.
4. APK debug akan muncul di `app/build/outputs/apk/debug/app-debug.apk`.

## Cara build lewat GitHub Actions

1. Buat repository GitHub baru dan unggah seluruh isi folder proyek ini ke branch `main`.
2. Buka tab **Actions**, pilih **Build Keripik Sakinah APK**, lalu klik **Run workflow**.
3. Setelah workflow selesai, buka hasil workflow dan unduh artifact `keripik-sakinah-debug-apk`. Di dalamnya ada `app-debug.apk`.

## Catatan

- Build debug memakai application ID `com.keripiksakinah.app.debug`.
- CSS dan ikon utama dibundel secara lokal. Beberapa foto produk lama masih berasal dari URL eksternal, sehingga memerlukan koneksi internet agar tampil.
- Fitur chat AI di HTML saat ini mengosongkan variabel API key (`const apiKey = ""`); balasan AI langsung belum aktif sampai integrasi API diamankan melalui backend atau konfigurasi yang sesuai. Jangan menanam API key rahasia langsung di APK.
- Ini merupakan prototipe aplikasi. Pesanan dan pembayaran masih berupa simulasi di HTML, bukan transaksi produksi.


## Perubahan optimasi UI

- CSS Tailwind dibangun statis ke `app/src/main/assets/tailwind.css`, sehingga aplikasi tidak perlu menjalankan Tailwind CDN saat dibuka.
- Font ikon Font Awesome yang dipakai dibundel lokal di `app/src/main/assets/vendor/fontawesome/`; font Google dihapus dan diganti font sistem.
- Efek blur/glass dan transisi diperingan agar lebih hemat render pada WebView.
- Di layar kecil/Android, tampilan menjadi full-screen; bingkai perangkat dan judul prototipe hanya dipertahankan untuk preview desktop.
- Kategori **Minuman** sekarang hanya memuat **Jahe Instan** dan **Kunir Instan**. Kategori **Lainnya** sengaja kosong.
- Ilustrasi kemasan sementara tersedia di `app/src/main/assets/images/jahe-instan.svg` dan `kunir-instan.svg`. Ganti file SVG tersebut dengan foto produk asli (atau ubah nilai di objek `productImages` pada `index.html`) saat foto final tersedia.
- Harga kedua produk instan dibiarkan `null` karena harga belum diberikan. Ubah nilai `price` pada `homeProductsData` sebelum produk bisa ditambahkan ke keranjang.
- Keranjang dibuka dalam kondisi kosong, bukan berisi contoh pesanan.

Foto produk lama selain dua produk instan masih memakai URL eksternal, sehingga foto-foto tersebut tetap dapat membutuhkan koneksi internet. Kode harga, nama, dan gambar produk dapat disesuaikan langsung di `app/src/main/assets/index.html`.


## Jalankan sebagai software desktop/laptop (Windows)

Proyek ini juga menyertakan pembungkus desktop Electron. APK Android dan aplikasi desktop memakai file UI serta katalog dari `app/src/main/assets/`, jadi perubahan produk bisa dipakai bersama. Tampilan desktop memiliki jendela aplikasi sendiri, sidebar navigasi, serta layout lebar untuk laptop.

### Menjalankan dari source

1. Pasang Node.js versi 22 atau lebih baru dan pastikan komputer terhubung ke internet untuk mengunduh dependency pertama kali.
2. Ekstrak ZIP proyek dan buka folder proyek tersebut.
3. Klik dua kali `JALANKAN-DESKTOP.bat` atau jalankan `npm install` lalu `npm start` di terminal.

### Membuat installer Windows (.exe)

1. Klik dua kali `BUILD-DESKTOP-EXE.bat`, atau jalankan `npm install` lalu `npm run dist:win`.
2. Installer `Keripik-Sakinah-Setup-1.0.0.exe` akan dibuat di folder `release`. Installer tersebut dapat memasang aplikasi dan membuat shortcut desktop/Start Menu.
3. Untuk versi portable yang tidak memakai installer, jalankan `npm run dist:portable`; hasilnya juga ada di folder `release`.

### Build installer melalui GitHub Actions

Unggah proyek ke repository GitHub, buka tab **Actions**, pilih **Build Keripik Sakinah Desktop**, lalu jalankan workflow. Setelah selesai, unduh artifact `keripik-sakinah-windows-installer`.

Catatan: file installer Windows belum disertakan langsung di ZIP ini karena dependency Electron perlu diunduh dari registry npm saat build. APK Android tetap dibangun melalui Android Studio atau workflow APK yang sudah tersedia.
