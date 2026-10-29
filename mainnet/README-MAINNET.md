# Kensei — Deploy Langsung BSC Mainnet (Rute Murah)

Status: BELUM DI-DEPLOY. Jaringan sudah dipilih Chang pada 2026-10-29
("Langsung mainet aja", menggantikan uji testnet). Deploy masih menunggu
konfirmasi final Chang atas: simbol, base URI awal, dan alamat wallet deployer.
Mainnet tidak bisa di-undo — simbol tidak bisa diubah setelah deploy.

## Kenapa tidak bisa deploy dari wallet baw
- `baw` CLI 1.12.0 tidak punya perintah deploy; `contract-call preview`
  wajib ada `--to`, jadi tidak bisa men-deploy kontrak baru.
- Deploy mainnet harus pakai wallet EVM biasa milik Chang (mis. wallet Web3 /
  MetaMask) lewat Remix atau Hardhat, dari alamat yang Chang kuasai.
- Wallet `baw` (0xf5C6EE4d1b236CCbBC1F950255Ea2dEb0A09d77A, saldo terakhir
  0,00573 BNB) tidak bisa menandatangani deploy ini, meskipun saldonya secara
  nominal cukup untuk biaya gas deploy.

## Parameter final yang diajukan (mohon dikonfirmasi sebelum deploy)
- Jaringan: BSC Mainnet, Chain ID 56
- RPC: https://bsc-dataseed.binance.org
- Explorer: https://bscscan.com
- Kontrak: Kensei.sol (ERC-721, OpenZeppelin 5.4.0, Solidity 0.8.28)
- Nama: Kensei
- Simbol: KENSEI — DRAFT, belum dikonfirmasi Chang, TIDAK BISA DIUBAH setelah deploy
- Max supply: 1.111, mint berurutan, max 10/wallet
- Harga: Fase 1 (#1–#555) 0,0002 BNB, Fase 2 (#556–#1.111) 0,001 BNB, bayar persis, gas ditanggung minter
- Base URI awal: kosong "" — nanti di-set via setBaseURI (owner only) SEBELUM
  mint dibuka, setelah 1.111 metadata IPFS selesai (700 Ronin / 300 Rare /
  99 Epic / 12 Legendary, Legendary #001/012–#012/012)
- Optimizer: ON, runs 200 (rute murah yang sudah disetujui)
- Gas: level LOW kecuali perlu cepat

## Perkiraan biaya deploy (snapshot gas 2026-10-29, BUKAN harga pasti)
- Bytecode deploy (optimizer runs 200): 7.468 byte, estimasi gas ~1,62 juta
- Gas LOW 0,0555 gwei: ~0,00009 BNB (~$0,07 pada BNB $751)
- Gas MEDIUM 0,0859 gwei: ~0,00014 BNB (~$0,10)
- Biaya final ditentukan saat transaksi deploy dibangun; preview persisnya
  harus disetujui Chang sebelum tanda tangan. Siapkan buffer di wallet deployer,
  mis. 0,002–0,005 BNB, supaya tidak gagal karena gas naik mendadak.
- Verifikasi BscScan: gratis. Tidak ada audit berbayar.

## Langkah deploy mainnet (wallet sendiri, via Remix)
1. Pastikan wallet deployer berisi BNB secukupnya (lihat buffer di atas).
2. Di Remix: upload Kensei.sol + OpenZeppelin 5, compile Solidity 0.8.28,
   optimizer ON runs 200.
3. Deploy dengan constructor baseURI yang sudah dikonfirmasi, dari wallet deployer.
4. Catat contract address, verifikasi di BscScan, cek name/symbol/MAX_SUPPLY.
5. JANGAN buka mint publik sebelum metadata IPFS selesai dan baseURI dibekukan.
   Mint di halaman Kensei tetap nonaktif sampai langkah ini selesai.

## Yang TIDAK boleh dilakukan
- Jangan kirim private key / seed phrase lewat chat.
- Jangan deploy dari alamat yang bukan milik Chang.
- Jangan anggap uji lokal Hardhat sebagai kontrak mainnet — alamat lokal itu
  bukan alamat mainnet.
