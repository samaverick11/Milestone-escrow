Milestone-Escrow Smart Contract

Overview

The **Milestone-Escrow** smart contract is a trustless STX escrow system built with **Clarity** for the Stacks blockchain.  
It enables secure, milestone-based fund releases between a payer and a beneficiary without requiring intermediaries.

Funds are locked upfront and released incrementally as predefined milestones are completed, ensuring accountability and transparency for both parties.

---

 Key Features

- Trustless STX escrow using Clarity
- Multiple milestones with proportional fund releases
- Secure upfront fund locking
- Controlled milestone approval and release
- Cancellation and safety mechanisms
- Read-only functions for full transparency
- Clarinet-compatible and audit-friendly

---

Use Cases

- Freelance and contractor payments
- Grant and research funding
- Startup and DAO milestone funding
- Construction or service-based agreements
- Any conditional payment workflow on Stacks

---

How It Works

1. **Escrow Creation**
   - A payer creates an escrow and deposits STX
   - Milestones and release amounts are defined upfront

2. **Milestone Progression**
   - Milestones are completed sequentially
   - Each approved milestone unlocks a portion of funds

3. **Fund Release**
   - Beneficiary withdraws released STX
   - Remaining funds stay locked until next milestone

4. **Cancellation**
   - Unreleased funds can be safely returned if the escrow is cancelled

---

Contract Architecture

Core Data Structures
- Escrow records (payer, beneficiary, total amount)
- Milestone tracking (status, release amount)
- Withdrawal tracking to prevent double spending

Roles
- **Payer**: Funds the escrow and defines milestones
- **Beneficiary**: Receives STX upon milestone completion

---

Public Functions

- `create-escrow` — Create a new milestone-based escrow
- `release-milestone` — Approve and release a milestone payment
- `withdraw` — Withdraw released STX
- `cancel-escrow` — Cancel escrow and reclaim remaining funds

---

Read-Only Functions

- `get-escrow` — View escrow details
- `get-milestone` — View milestone status
- `get-withdrawable-balance` — Check available STX

---

Security Considerations

- No external contract calls
- Deterministic execution
- Explicit role-based access checks
- Prevents over-withdrawals
- Designed for auditability and simplicity

---

Development & Testing

Requirements
- [Clarinet](https://docs.hiro.so/clarinet)
- Stacks CLI (optional)

Run Tests
```bash
clarinet test
