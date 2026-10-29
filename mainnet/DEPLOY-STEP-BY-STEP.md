# Deploy Kensei ke BSC Mainnet — Langkah Demi Langkah (Remix)

Parameter sudah dikunci Chang pada 2026-10-29 17:07 WIB. JANGAN ubah parameter
ini tanpa konfirmasi baru, karena simbol tidak bisa diubah setelah deploy.

- Jaringan: BSC Mainnet, Chain ID 56
- Deployer / owner: 0x504b36A0846Eb67F3f9Cdd5CDf074E26186d38E8
- Nama: Kensei — Simbol: KENSEI
- Constructor: baseURI = "" (string kosong, ditulis sebagai "" di Remix)
- Max supply: 1.111 — Fase 1: 0,0002 BNB — Fase 2: 0,001 BNB — Max 10/wallet
- Compiler: Solidity 0.8.28, Optimizer ON, runs 200
- Gas: LOW (jangan pakai HIGH — pada cek terakhir HIGH melonjak ke 1,59 gwei)
- Saldo deployer terakhir dicek: 0,0065 BNB (cukup, dengan buffer)

Perkiraan biaya deploy pada gas terakhir dicek (2026-10-29 17:07 WIB):
- LOW 0,0577 gwei x ~1,62 juta gas = ~0,000094 BNB (~$0,07)
- MEDIUM 0,0811 gwei = ~0,000131 BNB (~$0,10)
- HIGH 1,5866 gwei = ~0,00257 BNB (~$1,93) — HINDARI, tidak sepadan untuk deploy
Biaya final adalah yang ditampilkan wallet Anda di layar konfirmasi transaksi.
Periksa dulu angka itu sebelum menekan Confirm. Kalau angkanya jauh di atas
~0,0002 BNB, batalkan dulu dan laporkan ke Muse — jangan tanda tangan membabi buta.

## Langkah di Remix (remix.ethereum.org)
1. Buka Remix di browser desktop (lebih mudah daripada HP).
2. Buat file baru `Kensei.sol`, lalu salin seluruh isi file
   `workspace/kensei/contract/Kensei.sol` ke dalamnya.
3. Tab "Solidity Compiler": pilih versi 0.8.28, centang "Enable optimization",
   isi Runs = 200, lalu Compile. Pastikan tidak ada error merah.
   (Remix akan mengambil import OpenZeppelin dari internet — pastikan koneksi
   internet aktif; kalau import gagal, gunakan Hardhat dengan
   @openzeppelin/contracts 5.4.0 yang sudah teruji di sini.)
4. Tab "Deploy & Run Transactions":
   - Environment: "Injected Provider" (mis. MetaMask / wallet Web3 Anda).
   - Pastikan wallet yang terhubung adalah
     0x504b36A0846Eb67F3f9Cdd5CDf074E26186d38E8 dan jaringan BSC Mainnet (56).
     Kalau alamatnya berbeda, JANGAN lanjutkan — ganti akun dulu.
   - Pilih contract "Kensei".
   - Di kolom constructor, isi: "" (dua tanda kutip, artinya string kosong).
   - Klik Deploy, lalu di pop-up wallet: periksa To = (pembuatan kontrak, tanpa
     alamat tujuan), Value = 0 BNB, dan gas fee sesuai perkiraan di atas.
     Pilih gas LOW / Custom dan isi gas price sekitar harga LOW saat itu
     kalau wallet Anda mengizinkannya.
   - Tekan Confirm HANYA setelah semua angka di atas cocok.
5. Tunggu konfirmasi di BSC (biasanya belasan detik di gas LOW).
6. Salin: transaction hash (0x...) dan contract address yang muncul di Remix.
   Kirim keduanya ke Muse untuk diverifikasi.

## Setelah deploy (Muse akan verifikasi)
- Muse cek di BscScan: contract address, name = Kensei, symbol = KENSEI,
  MAX_SUPPLY = 1111, owner = alamat deployer, dan baseURI masih kosong.
- Verifikasi source code di BscScan (gratis, dengan setting compiler yang sama).
- Mint TETAP TUTUP sampai metadata IPFS 1.111 selesai dan baseURI di-set
  lewat setBaseURI oleh owner, lalu dibekukan sebelum mint dibuka.
- Jangan kirim private key / seed phrase ke siapa pun, termasuk ke Muse.

## Kalau ada yang tidak cocok
Batalkan transaksi di wallet, jangan tekan Confirm, dan kirim screenshot/angka
yang muncul ke Muse. Deploy yang gagal dikonfirmasi tidak menghabiskan biaya
deploy (hanya bisa ada biaya gas kecil kalau transaksi sudah terkirim lalu gagal
di chain — karena itu periksa preview SEBELUM Confirm).
