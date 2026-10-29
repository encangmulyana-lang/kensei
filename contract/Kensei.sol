// SPDX-License-Identifier: MIT
// Kensei — DRAFT FOR REVIEW ONLY. DO NOT DEPLOY until the owner reviews
// every parameter below, confirms the deployer wallet, and confirms the
// IPFS base URI. Deploying is irreversible: name, symbol, supply and
// pricing logic cannot be changed afterwards except where a function
// below explicitly allows it.
//
// Collection (as approved by the owner on 2026-10-29):
//   Name:        Kensei
//   Symbol:      KENSEI  (DRAFT proposal — owner has not yet confirmed it)
//   Chain:       BNB Chain (BSC), ERC-721, Solidity ^0.8.20
//   Max supply:  1,111 — hard cap, no minting beyond it, no team reserve
//   Phase 1:     token IDs 1–555, 0.0002 BNB each (creator fee; "free mint"
//                in the owner's wording — the 0.0002 BNB is still charged)
//   Phase 2:     token IDs 556–1,111, 0.001 BNB each
//   Max / wallet: 10 (DRAFT, matches the minting page — owner to confirm)
//   Gas:         paid separately by the minter, on top of the price above
//   Rarity:      Ronin 700 / Rare 300 / Epic 99 / Legendary 12 = 1,111.
//                Rarity is a METADATA trait, not enforced by this mint
//                function. The 1,111 metadata JSON files must be built
//                with exactly that distribution (700/300/99/12) and
//                published to IPFS before mint opens; token IDs are
//                sequential, so the metadata file for each ID must carry
//                its tier. Legendary files must carry edition numbers
//                #001/012 … #012/012. Changing metadata after mint opens
//                would break the published rarity promise, so baseURI
//                should be frozen (see setBaseURI note below).
//   Contract address: TBD — nothing has been deployed.
//   Owner wallet: TBD — the deployer becomes the initial owner.
//
// Dependencies (install before compiling, e.g. via npm):
//   @openzeppelin/contracts ^5.0.0
// Compile in Remix / Hardhat and verify on BscScan after deployment.
// CHEAP-DEPLOY SETTING (owner-approved 2026-10-29, "biaya deploy yang murah"):
//   Optimizer ON, runs 200. Local compile check: creation bytecode
//   7,468 bytes (vs 14,558 without optimizer), est. deployment gas
//   ~1.62M (vs ~3.14M), i.e. ~0.00009 BNB at LOW gas / ~0.00014 BNB
//   at MEDIUM gas at the gas prices checked on 2026-10-29. Use gas
//   level LOW unless confirmation speed is urgent, and show the
//   exact deployment preview to the owner before signing anything.
// CONFIRMED DEPLOY PARAMETERS (Chang, 2026-10-29 17:07 WIB):
//   Network: BSC Mainnet (chain 56, direct mainnet, testnet skipped)
//   Deployer/owner: 0x504b36A0846Eb67F3f9Cdd5CDf074E26186d38E8
//   Name: Kensei, Symbol: KENSEI (confirmed, unchangeable after deploy)
//   Constructor baseURI: "" (empty, to be set via setBaseURI before mint opens)

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Kensei is ERC721, Ownable, ReentrancyGuard {
    uint256 public constant MAX_SUPPLY = 1111;
    uint256 public constant PHASE1_LIMIT = 555;
    uint256 public constant PHASE1_PRICE = 0.0002 ether;
    uint256 public constant PHASE2_PRICE = 0.001 ether;
    uint256 public constant MAX_MINT_PER_WALLET = 10;

    uint256 public totalMinted;
    uint256 public nextTokenId = 1;
    bool public mintPaused;
    string private _baseTokenURI;

    mapping(address => uint256) public mintedByWallet;

    event Minted(address indexed minter, uint256 indexed tokenId, uint256 price);
    event BaseURISet(string baseURI);
    event MintPausedChanged(bool paused);

    constructor(string memory baseURI_) ERC721("Kensei", "KENSEI") Ownable(msg.sender) {
        _baseTokenURI = baseURI_;
    }

    /// @notice Price for the NEXT token to be minted, based on supply sold.
    function currentPrice() public view returns (uint256) {
        return totalMinted < PHASE1_LIMIT ? PHASE1_PRICE : PHASE2_PRICE;
    }

    /// @notice Mint `quantity` NFTs. Exact payment required — no overpay,
    ///         no refund path, so a wrong amount fails cleanly instead
    ///         of silently keeping extra BNB.
    function mint(uint256 quantity) external payable nonReentrant {
        require(!mintPaused, "Kensei: minting paused");
        require(quantity > 0, "Kensei: quantity is zero");
        require(
            mintedByWallet[msg.sender] + quantity <= MAX_MINT_PER_WALLET,
            "Kensei: exceeds 10 per wallet"
        );
        require(totalMinted + quantity <= MAX_SUPPLY, "Kensei: sold out");

        uint256 totalPrice = 0;
        for (uint256 i = 0; i < quantity; i++) {
            totalPrice += (totalMinted + i) < PHASE1_LIMIT ? PHASE1_PRICE : PHASE2_PRICE;
        }
        require(msg.value == totalPrice, "Kensei: wrong BNB amount");

        for (uint256 i = 0; i < quantity; i++) {
            uint256 tokenId = nextTokenId;
            nextTokenId++;
            totalMinted++;
            mintedByWallet[msg.sender]++;
            _safeMint(msg.sender, tokenId);
            emit Minted(msg.sender, tokenId, (tokenId <= PHASE1_LIMIT ? PHASE1_PRICE : PHASE2_PRICE));
        }
    }

    /// @notice Owner-only. REVIEW NOTE: this lets the owner point the
    ///         collection at a new metadata folder. For the published
    ///         rarity promise to be trustworthy, set the final IPFS
    ///         base URI before mint opens and do not change it after
    ///         minting starts, unless the community is told first.
    function setBaseURI(string memory baseURI_) external onlyOwner {
        _baseTokenURI = baseURI_;
        emit BaseURISet(baseURI_);
    }

    function setMintPaused(bool paused_) external onlyOwner {
        mintPaused = paused_;
        emit MintPausedChanged(paused_);
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    /// @notice Metadata URL = baseURI + tokenId + ".json", e.g.
    ///         ipfs://<CID>/1.json … ipfs://<CID>/1111.json
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Kensei: token does not exist");
        string memory baseURI_ = _baseURI();
        return bytes(baseURI_).length > 0
            ? string(abi.encodePacked(baseURI_, Strings.toString(tokenId), ".json"))
            : "";
    }

    /// @notice Owner-only withdrawal of collected mint fees.
    ///         Withdrawal address = owner wallet; change ownership
    ///         deliberately (transferOwnership) if that must change.
    function withdraw() external onlyOwner nonReentrant {
        uint256 balance = address(this).balance;
        require(balance > 0, "Kensei: nothing to withdraw");
        (bool ok, ) = payable(owner()).call{value: balance}("");
        require(ok, "Kensei: withdraw failed");
    }
}
