# Auto-Installer Mod Subtitle Bahasa Indonesia - Dark Souls: Remastered

Skrip pasang dan uninstall otomatis (`install_mod.bat` & `uninstall_mod.bat`) untuk **Dark Souls: Remastered - Bahasa Indonesia** oleh **ShDitz**.

> **Penting:** Repository ini **hanya berisi skrip installer**, bukan file mod utamanya. Unduh dulu file mod utamanya (`DSRSubtitleindo.zip`) di halaman Nexus Mods resmi:  
> https://www.nexusmods.com/darksoulsremastered/mods/1590

---

## Cara Menggunakan

1. **Unduh file mod utama** (`DSRSubtitleindo.zip`) dari [Nexus Mods](https://www.nexusmods.com/darksoulsremastered/mods/1590), lalu ekstrak hingga muncul folder **`DSRSubindo`**.
2. **Unduh skrip dari halaman GitHub ini:**
   - Klik tombol hijau **`<> Code`** di kanan atas, lalu pilih **`Download ZIP`**.
   - Ekstrak file ZIP hasil unduhan GitHub tersebut untuk mengambil **`install_mod.bat`** dan **`uninstall_mod.bat`**.
3. **Masukkan kedua file `.bat` ke dalam folder `DSRSubindo`**, sejajar dengan folder `msg` dan `SeamlessCoop`:
   ```text
   DSRSubindo/
   ├── msg/
   ├── SeamlessCoop/
   ├── CARA_INSTALL.txt
   ├── install_mod.bat      <-- taruh di sini
   └── uninstall_mod.bat    <-- taruh di sini
   ```
4. **Pasang mod:**
   - Pastikan game dalam keadaan tertutup.
   - Klik ganda **`install_mod.bat`** dan tunggu hingga muncul pesan `Mod Bahasa Indonesia berhasil dipasang`.
   - Jika folder game tidak terdeteksi otomatis, cukup tempel (*paste*) path folder `DARK SOULS REMASTERED` Anda saat diminta.
5. **Aktifkan subtitle di dalam game:**
   - Buka *Dark Souls: Remastered*, masuk ke **Pengaturan > Tampilan**, lalu ubah **Subtitle = AKTIF**.

---

## Cara Uninstall (Kembali ke Bahasa Inggris)

- Pastikan game tertutup, lalu klik ganda **`uninstall_mod.bat`** di dalam folder `DSRSubindo`.
- Seluruh file asli yang otomatis dibackup ke folder `original` saat instalasi akan langsung dikembalikan.

---

## Apa yang Dilakukan Skrip Ini?

- Mendeteksi lokasi instalasi `DARK SOULS REMASTERED` secara otomatis (dari Steam Registry dan drive `C`–`Z`).
- Mem-backup file asli (`item.msgbnd.dcx`, `menu.msgbnd.dcx`, serta `SeamlessCoop` jika terpasang) ke folder `original/` sebelum menimpa.
- Menyalin file lokalisasi Bahasa Indonesia ke folder game dan memperbarui locale serta pengumuman *Seamless Co-op* jika terdeteksi (dikembalikan penuh oleh `uninstall_mod.bat`).
- Seluruh isi kode terbuka dan bisa langsung Anda periksa di `install_mod.bat` dan `uninstall_mod.bat`.

---

## Dukungan

Mod ini gratis sepenuhnya. Jika terbantu dan ingin mendukung proyek terjemahan berikutnya:  
https://trakteer.id/shditz/tip
