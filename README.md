# KENSEI — 1,111 Samurai NFT Collection on BNB Chain

Samurai-themed ERC-721 collection, max **1,111 NFTs**, built for BNB Chain.
Bilingual minting page: English (main) + Japanese. Social handle: @kenseisamurai.

## Status — read this first

- **Smart contract: DEPLOYED on BSC Mainnet on 2026-10-30.**
  - Contract address: `0x1a92F81bFE06EbAB072743Fe61cf3c12449c6902`
  - BscScan: https://bscscan.com/address/0x1a92F81bFE06EbAB072743Fe61cf3c12449c6902
  - Deploy tx: `0xb88998b10680fd225e83fa44ad13e2eed1c2fdd56484a7e2c8abd0edfbe9ec4b`
  - TransferOwnership tx: `0x24e7fc556bc97f92b154e2479f4b974a9aa9f40719b6e62ed44c9894f9b238fa`
  - Deployer on BscScan (temporary wallet, since deleted): `0xeA61B9C30EDd9E95c9E4b3896227569D6a781456`
  - Final owner: `0x504b36A0846Eb67F3f9Cdd5CDf074E26186d38E8`
  - Do NOT use any Remix VM address as a production contract address,
    mint address, or mainnet proof — VM addresses are local only and
    cannot be verified on BscScan.
- **Mint is still NOT OPEN:** metadata is not yet frozen on IPFS and
  baseURI is still empty. Do not mint / announce mint until the 1,111
  IPFS metadata files are pinned and the owner sets baseURI.
- Deployer / owner (confirmed): `0x504b36A0846Eb67F3f9Cdd5CDf074E26186d38E8`
- Name: Kensei — Symbol: KENSEI — Initial baseURI: empty (to be set via
  `setBaseURI` before mint opens, after the 1,111 IPFS metadata files are done)
- Mint stays closed until metadata is frozen and baseURI is set.

## Contract

- File: `contract/Kensei.sol` (Solidity ^0.8.20, OpenZeppelin 5, ERC721 + Ownable + ReentrancyGuard)
- Max supply: 1,111, sequential mint, max 10 per wallet, exact payment required, gas paid by minter
- Phase 1, token #1–#555: **0.0002 BNB** per NFT (creator commission)
- Phase 2, token #556–#1,111: **0.001 BNB** per NFT
- Maximum creator total if all sell: 0.667 BNB (gas excluded)
- Owner-only: `setBaseURI`, `setMintPaused`, `withdraw`
- `tokenURI` = baseURI + tokenId + `.json` (e.g. `ipfs://<CID>/1.json`)

## Rarity (enforced in metadata, not in the mint function)

The 1,111 metadata JSONs must be built with exactly:

- Ronin: 700 (63.01%)
- Rare: 300 (27.00%)
- Epic: 99 (8.91%)
- Legendary: 12 (1.08%), editions #001/012–#012/012, truly distinct design

## Deployment — cheap route

- Network: BSC Mainnet, Chain ID 56
- Compiler: Solidity 0.8.28, optimizer ON, runs 200
- Creation bytecode (optimizer runs 200): 7,468 bytes, est. deployment gas ~1.62M
- Est. deploy cost at gas checked 2026-10-29: ~0.00009 BNB at LOW gas,
  ~0.00014 BNB at MEDIUM gas. Use gas LOW unless speed is urgent.
  Check the exact preview in your wallet before signing; never sign blind.
- BscScan verification: free. No paid audit in this route.
- Full step-by-step: `mainnet/DEPLOY-STEP-BY-STEP.md`
- Testnet trial notes (superseded by direct mainnet choice, kept for reference):
  `testnet/README-TESTNET.md`

## Contents

- `contract/Kensei.sol` — contract source
- `mainnet/` — mainnet deploy guide, ABI, bytecode
- `testnet/` — testnet trial notes, ABI, bytecode
- Artwork (`.webp`) is intentionally NOT in this first push: the GitHub
  snapshot push used here only supports UTF-8 text files. Artwork can be
  uploaded separately via the GitHub web UI later.

## No promises

No promise of price, resale value, or financial return. Utility proposed
(community access/voting, exclusive versions, raffle/airdrop eligibility,
personal-use rights) is not a guarantee.
