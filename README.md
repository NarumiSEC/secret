# Auto Secret Script - Fish It (Roblox)

## ⚠️ PERINGATAN PENTING

Script ini **HANYA untuk tujuan TESTING dan EDUKASI** saja!

**JANGAN gunakan script ini dalam permainan aktual karena:**
- Melanggar Terms of Service Roblox
- Dapat mengakibatkan ban permanen pada akun
- Merusak pengalaman bermain pemain lain
- Tidak etis dan tidak fair play

## 📋 Deskripsi

Script Lua ini adalah contoh struktur untuk auto secret detection di game Roblox "Fish It". Script ini dibuat untuk:
- Memahami cara kerja script automation
- Testing dan eksperimen
- Belajar struktur game Roblox

## 🔧 Cara Menggunakan (Untuk Testing)

> 📖 **Panduan Lengkap**: Lihat file [`CARA_PAKAI.md`](CARA_PAKAI.md) untuk instruksi detail!

### Quick Start:
1. **Install Executor** (Multiget, Synapse X, Script-Ware, Krnl, Fluxus, dll)
2. **Buka game "Fish It"** di Roblox
3. **Inject executor** ke Roblox
4. **Load script** `auto_secret_fishit.lua` (copy-paste atau load file)
5. **Execute script** - UI akan muncul di pojok kiri atas
6. **Klik "ENABLED"** untuk mengaktifkan script
7. **Monitor status** melalui UI yang menampilkan:
   - Lokasi mancing saat ini
   - Jumlah ikan secret yang terdeteksi
   - Status script (Active/Inactive)

### ⚠️ Catatan tentang Multiget
**Multiget adalah Download Manager**, bukan executor Roblox. Untuk execute script, kamu perlu **Roblox Executor** seperti:
- **Script-Ware** (Recommended)
- **Krnl** (Gratis)
- **Fluxus** (Gratis)
- **Synapse X** (Berbayar)

Kamu bisa pakai **Multiget untuk download executor**, lalu pakai executor tersebut untuk execute script. Lihat [`CARA_PAKAI.md`](CARA_PAKAI.md) dan [`PENTING_MULTIGET.txt`](PENTING_MULTIGET.txt) untuk penjelasan lengkap.

## 📝 Fitur Script

- ✅ **Auto detect ikan secret** (El Gren, Maja, Megalodon, Loch Ness, dll)
- ✅ **Deteksi lokasi mancing** saat ini (beach, ocean, lake, river, dll)
- ✅ **Auto click ikan secret** (jika dalam jangkauan)
- ✅ **Multi-method interaction** (ClickDetector, RemoteEvent, ProximityPrompt, Touch)
- ✅ **Auto collect rewards**
- ✅ **Real-time UI monitoring** (lokasi, jumlah ikan secret, status)
- ✅ **Debug logging** untuk monitoring
- ✅ **Configurable settings**

## ⚙️ Konfigurasi

Edit bagian `config` di awal script:

```lua
local config = {
    enabled = true,           -- Enable/disable script
    checkInterval = 0.5,      -- Interval pengecekan (detik)
    autoClick = true,         -- Auto click ikan secret
    autoCollect = true,       -- Auto collect rewards
    debugMode = true,         -- Tampilkan log
    maxDistance = 100         -- Max jarak untuk click ikan secret (studs)
}
```

## 🐟 Daftar Ikan Secret yang Didukung

Script ini mencari ikan secret berikut:
- **El Gren**
- **Maja**
- **Megalodon**
- **Loch Ness** / **Lockness**
- **Leviathan**
- **Kraken**
- **Cthulhu**
- **Poseidon**
- **Titan**
- **Behemoth**
- **Hydra**
- **Serpent**
- **Dragon Fish**
- **Ancient**
- **Legendary**

*(Daftar ini bisa ditambah/edit di bagian `secretFishes` dalam script)*

## 🔍 Catatan Penting

**Script ini adalah TEMPLATE/STRUKTUR DASAR** dan perlu disesuaikan dengan:
- Nama objek/part yang digunakan game
- Remote events yang digunakan game
- Struktur UI game
- Nama service dan events spesifik game

**Script mungkin TIDAK BEKERJA langsung** karena:
- Setiap game memiliki struktur berbeda
- Nama objek dan events berbeda
- Perlu reverse engineering game untuk mendapatkan struktur yang tepat

## 🛠️ Cara Menyesuaikan Script

1. **Cari nama objek ikan secret**: 
   - Gunakan Developer Console untuk inspect objects
   - Cek nama model/part ikan secret di game
   - Update daftar `secretFishes` jika ada ikan secret lain

2. **Cari lokasi mancing**:
   - Inspect model/part yang menandakan lokasi mancing
   - Update fungsi `getCurrentFishingLocation()` dengan nama lokasi yang benar

3. **Cari remote events**: 
   - Gunakan RemoteSpy untuk melihat events yang digunakan
   - Update daftar `remoteNames` di fungsi `autoClickSecret()` dengan nama event yang benar

4. **Update metode interaksi**:
   - Script sudah support ClickDetector, RemoteEvent, ProximityPrompt, dan Touch
   - Jika game menggunakan metode lain, tambahkan di fungsi `autoClickSecret()`

5. **Update fungsi `autoCollectRewards()`**: 
   - Sesuaikan dengan struktur UI game
   - Cari tombol/text yang menandakan reward tersedia

## 📚 Disclaimer

Script ini dibuat **semata-mata untuk tujuan edukasi dan testing**. 
Penulis tidak bertanggung jawab atas:
- Penggunaan script untuk cheating
- Ban akun akibat penggunaan script
- Kerugian apapun yang timbul dari penggunaan script

**Gunakan dengan bijak dan tanggung jawab sendiri!**
