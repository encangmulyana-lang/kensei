# Kensei — Uji Coba BSC Testnet (Gratis)

Status: KONTRAK LOKAL SUDAH LOLOS UJI, BELUM ADA KONTRAK TESTNET.
Deploy testnet yang sesungguhnya masih menunggu wallet deployer milik Chang
+ tBNB gratis dari faucet. Wallet `baw` TIDAK bisa dipakai untuk testnet:
daftar chain `baw` tidak memuat testnet, dan `contract-call` baw wajib ada
`--to`, jadi tidak bisa men-deploy kontrak baru.

## Hasil uji lokal (Hardhat, 2026-10-29, bukan testnet/mainnet)
- Deploy lokal berhasil, alamat lokal ephemeral: 0x5FbDB2315678afecb367f032d93F642f64180aa3
  (alamat ini HANYA di jaringan lokal Hardhat yang sudah dimatikan — jangan dipakai di tempat lain)
- name: Kensei, symbol: KENSEI, MAX_SUPPLY: 1111
- Harga fase 1: 0.0002 BNB per NFT
- Mint 1 NFT: owner benar, tokenURI = ipfs://test/1.json
- Mint 10 NFT dari satu wallet: berhasil, totalMinted = 10
- Mint ke-11 dari wallet yang sama: DITOLAK (batas 10/wallet berfungsi)
- Bayar kurang dari harga: DITOLAK (exact payment berfungsi)
- Wallet kedua mint token #11: berhasil
- Pause mint: mint DITOLAK saat pause aktif, berhasil lagi setelah unpause
- Withdraw owner: saldo kontrak menjadi 0

## Parameter testnet yang disiapkan
- Jaringan: BSC Testnet, Chain ID 97
- RPC: https://data-seed-prebsc-1-s1.bnbchain.org:8545
- Explorer: https://testnet.bscscan.com
- Faucet resmi: https://testnet.bnbchain.org/faucet-smart
  (satu sumber menyebut 0,3 tBNB per alamat per 24 jam — cukup untuk deploy + uji mint;
  tBNB tidak bernilai uang sungguhan)
- Kontrak: Kensei.sol, optimizer ON runs 200, bytecode di Kensei.bin.txt, ABI di Kensei.abi.json
- Constructor: baseURI awal kosong "" (nanti di-set via setBaseURI sebelum mint dibuka),
  atau "ipfs://test/" untuk uji tokenURI seperti uji lokal di atas
- Simbol: KENSEI (draft, belum dikonfirmasi Chang — tidak bisa diubah setelah deploy)

## Langkah deploy testnet (pakai wallet sendiri, mis. MetaMask / wallet Web3)
1. Tambahkan BSC Testnet ke wallet dengan RPC, Chain ID 97, simbol tBNB, explorer di atas.
2. Minta tBNB gratis di faucet resmi dengan alamat wallet testnet Anda.
3. Di Remix (remix.ethereum.org): upload Kensei.sol + OpenZeppelin 5, compile
   Solidity 0.8.28 dengan optimizer ON runs 200, deploy dengan constructor baseURI
   yang sudah disepakati, dari wallet testnet Anda.
   ATAU di Hardhat: buat proyek dengan config testnet chain 97 dan deploy script
   yang memakai private key wallet testnet Anda sendiri (jangan pernah kirim
   private key itu lewat chat).
4. Verifikasi kontrak di testnet.bscscan.com, lalu uji mint 1 NFT dan cek tokenURI.
5. Kalau semua lolos di testnet, barulah pertimbangkan deploy mainnet dengan
   parameter yang sama — dengan persetujuan Chang atas preview biaya persisnya.

## Yang TIDAK boleh dilakukan
- Jangan pakai alamat kontrak lokal di atas sebagai alamat testnet/mainnet.
- Jangan kirim private key, seed phrase, atau password lewat chat.
- Jangan buka mint publik sebelum metadata IPFS 1.111 selesai dan baseURI dibekukan.
