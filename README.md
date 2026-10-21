# LeapYear Contract

[![Solidity](https://img.shields.io/badge/Solidity-0.8.24-363636?logo=solidity&logoColor=white)](https://docs.soliditylang.org/)
[![License: LGPL-3.0-only](https://img.shields.io/badge/License-LGPL--3.0--only-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)
[![EVM](https://img.shields.io/badge/EVM-Compatible-627EEA?logo=ethereum&logoColor=white)](https://ethereum.org/)
![Status](https://img.shields.io/badge/Status-Educational-success.svg)

A Solidity smart contract that determines whether a given year is a leap year, applying the full Gregorian calendar rule on-chain. It validates its input, logs every query as an event and keeps the calculation logic isolated in a pure internal function.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Leap Year Rule](#leap-year-rule)
- [Contract Reference](#contract-reference)
- [Getting Started](#getting-started)
- [Usage Examples](#usage-examples)
- [Concepts Demonstrated](#concepts-demonstrated)
- [License](#license)

---

## Overview

`LeapYear` receives a year and returns `true` if it is a leap year or `false` otherwise. Queries for years earlier than the contract's reference year are rejected, and each valid query emits an event so interactions can be tracked off-chain.

The project was built as part of a blockchain course and serves as a hands-on introduction to core Solidity concepts: modifiers, events, custom input validation and the difference between `public`, `internal` and `pure` functions.

## Features

- **Gregorian leap year calculation** — implements the complete rule, including the century exceptions
- **Input validation** — reverts when the year is earlier than the reference year
- **On-chain traceability** — emits an event on every query
- **Separation of concerns** — the calculation lives in a side-effect-free `internal pure` function
- **Gas-conscious types** — years are stored as `uint16` (supports values up to 65,535)

## Leap Year Rule

A year is a leap year when:

1. It is divisible by **4**, **and**
2. It is **not** divisible by **100**, **unless**
3. It is also divisible by **400**.

```solidity
(year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
```

| Year | Divisible by 4 | Divisible by 100 | Divisible by 400 | Leap year? |
| --- | :---: | :---: | :---: | :---: |
| 2027 | ✗ | ✗ | ✗ | No |
| 2028 | ✓ | ✗ | ✗ | **Yes** |
| 2100 | ✓ | ✓ | ✗ | No |
| 2400 | ✓ | ✓ | ✓ | **Yes** |

## Contract Reference

Source: [`Leap-year-Contract.sol`](./Leap-year-Contract.sol)

### State

| Variable | Type | Default | Description |
| --- | --- | --- | --- |
| `currentYear` | `uint16` | `2026` | Reference year. Earlier years are rejected. |
| `yearToCheck` | `uint16` | `2027` | Default year value stored in the contract. |

### Functions

| Function | Visibility | Returns | Description |
| --- | --- | --- | --- |
| `isLeapYear(uint16 year_)` | `public` | `bool` | Validates `year_`, emits `yearEntered` and returns whether it is a leap year. |
| `checkYear(uint16 yearToCheck_)` | `internal pure` | `bool` | Applies the Gregorian rule. Reads no state. |

### Modifiers

| Modifier | Description |
| --- | --- |
| `checkPastYears(uint16 inputYear)` | Reverts if `inputYear` is lower than `currentYear`. |

### Events

| Event | Description |
| --- | --- |
| `yearEntered(uint16 yearToCheck)` | Emitted on every successful call to `isLeapYear`. |

## Getting Started

The contract is a single file with no external dependencies, so it runs in any Solidity environment.

### Remix IDE (quickest)

1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create a new file and paste the contents of `Leap-year-Contract.sol`.
3. In the **Solidity Compiler** tab, select version `0.8.24` and compile.
4. In the **Deploy & Run Transactions** tab, choose the *Remix VM* environment and deploy `LeapYear`.
5. Expand the deployed contract and call `isLeapYear` with a year such as `2028`.

### Foundry

```bash
git clone https://github.com/jlaran/leap-year-contract.git
cd leap-year-contract
forge build --contracts Leap-year-Contract.sol
```

## Usage Examples

Because `isLeapYear` emits an event, it is a state-changing function. Calling it in a transaction records the event on-chain; to read the boolean result without sending a transaction, use a static call (`eth_call`).

| Input | Result |
| --- | --- |
| `isLeapYear(2028)` | `true` |
| `isLeapYear(2027)` | `false` |
| `isLeapYear(2100)` | `false` |
| `isLeapYear(2400)` | `true` |
| `isLeapYear(2025)` | Reverts (earlier than `currentYear`) |

Using [Cast](https://book.getfoundry.sh/cast/) against a deployed instance:

```bash
# Read the result without a transaction
cast call <CONTRACT_ADDRESS> "isLeapYear(uint16)(bool)" 2028 --rpc-url <RPC_URL>

# Send a transaction (emits the event)
cast send <CONTRACT_ADDRESS> "isLeapYear(uint16)" 2028 \
  --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>
```

## Concepts Demonstrated

| Concept | Where |
| --- | --- |
| Custom modifiers | `checkPastYears` guards `isLeapYear` |
| Events | `yearEntered` logs each query |
| `public` vs `internal` | `isLeapYear` is the entry point; `checkYear` is only callable from within the contract |
| `pure` functions | `checkYear` neither reads nor writes state |
| Reverts | Invalid input aborts the transaction and rolls back state |

## License

Distributed under the **GNU Lesser General Public License v3.0** (`LGPL-3.0-only`). See [`LICENCE`](./LICENCE) for details.
