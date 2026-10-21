# LeapYear Contract 📅

[![Solidity](https://img.shields.io/badge/Solidity-0.8.24-363636?style=flat&logo=solidity&logoColor=white)](https://docs.soliditylang.org/)
[![License: LGPL-3.0-only](https://img.shields.io/badge/License-LGPL--3.0--only-blue.svg)](https://www.gnu.org/licenses/lgpl-3.0)
[![EVM](https://img.shields.io/badge/EVM-Compatible-627EEA?style=flat&logo=ethereum&logoColor=white)](https://ethereum.org/)
[![Status](https://img.shields.io/badge/Status-Educational-success.svg)]()

Smart contract en Solidity que determina si un año es bisiesto, aplicando la lógica del calendario gregoriano directamente en la blockchain.

---

## Descripción

`LeapYear` es un contrato sencillo y didáctico que recibe un año y devuelve si es bisiesto o no. Incorpora una validación para rechazar años anteriores al año actual y emite un evento cada vez que se realiza una consulta, dejando traza on-chain de la interacción.

Este proyecto forma parte de un curso de Blockchain y está pensado como una introducción práctica a conceptos clave de Solidity: modifiers, eventos, y la diferencia entre funciones `public`, `internal` y `pure`.

## Características

- **Cálculo de año bisiesto** — Implementa la regla gregoriana completa: divisible entre 4, salvo los divisibles entre 100 que no lo sean entre 400.
- **Validación de entrada** — Rechaza y revierte la transacción si el año introducido es anterior al año actual de referencia.
- **Trazabilidad mediante eventos** — Emite un evento en cada consulta, permitiendo el seguimiento off-chain de las interacciones.
- **Separación de responsabilidades** — La lógica de cálculo se aísla en una función interna sin efectos secundarios ni acceso al estado.

## Tecnologías Utilizadas

- **Solidity** `0.8.24`
- **Ethereum Virtual Machine (EVM)**
- **Remix IDE** / Hardhat / Foundry (cualquier entorno compatible)

## Uso

### 1. Comprobar si un año es bisiesto

Llama a la función pública del contrato pasando el año que quieras verificar. La función valida el año, registra la consulta mediante un evento y devuelve un valor booleano indicando el resultado.

### 2. Reglas del cálculo

Un año se considera bisiesto cuando:

- Es divisible entre **4**, y
- **No** es divisible entre **100**, salvo que
- También sea divisible entre **400**.

De este modo, años como 2024 o 2000 son bisiestos, mientras que 1900 o 2027 no lo son.

### 3. Validación de años pasados

El contrato solo admite años iguales o posteriores al año de referencia. Cualquier consulta sobre un año anterior revierte la transacción, evitando cálculos sobre fechas no válidas para el caso de uso.

---

## Licencia

Distribuido bajo la licencia **LGPL-3.0-only**. Consulta el identificador SPDX en la cabecera del contrato para más detalles.
