# QuickLiv 🛵

A full-stack mobile food delivery application connecting clients, delivery drivers, and merchants on a single platform. Built as a final-year university project.

> **Live portfolio overview:** [tayebbgh.fr](https://tayebbgh.fr/projects/quickliv)

---

## Overview

QuickLiv handles the entire delivery workflow: a client places an order from a merchant, the system assigns the nearest available driver using AI, and the client tracks the delivery live on a map. Authentication uses JWT combined with a custom Telegram bot for 2FA OTP delivery.

---

## Features

- **Real-time GPS tracking** — Socket.IO + Google Maps SDK. The client sees the driver's position update live from pickup to doorstep.
- **AI vehicle assignment** — Mistral AI analyses each order's weight and volume to automatically dispatch the right vehicle type (scooter or car) to the nearest driver.
- **OTP via Telegram bot** — custom 2FA flow, secure and free with no SMS provider needed.
- **Multi-basket system** — up to 5 simultaneous baskets (one per merchant), persisted across app restarts.
- **Loyalty & coupons** — points accumulate with every order and can be redeemed for delivery discounts (30%, 60%, or 100% off).
- **Two distinct interfaces** — separate Flutter apps for clients and drivers, both built on Clean Architecture.

---

## Architecture

```
QuickLiv/
├── client-app/          # Flutter app (client interface)
├── driver-app/          # Flutter app (driver interface)
└── backend/             # Node.js / Express REST API
    ├── src/
    │   ├── routes/
    │   ├── controllers/
    │   ├── models/
    │   └── sockets/     # Socket.IO real-time layer
    └── ...
```

The backend is a Node.js/Express REST API backed by PostgreSQL (16 relational tables). The architecture was designed using UML diagrams (use-case, sequence, class) following the Unified Process methodology.

---

## Tech Stack

| Layer | Technologies |
|---|---|
| Mobile | Flutter, Dart |
| Backend | Node.js, Express.js |
| Database | PostgreSQL |
| Real-time | Socket.IO |
| Maps | Google Maps SDK |
| AI | Mistral AI API |
| Auth | JWT, Telegram Bot API |
| Media | Cloudinary |

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.0.0`
- Node.js `>=18`
- PostgreSQL instance

### Backend

```bash
cd backend
npm install
cp .env.example .env   # fill in your credentials
npm run dev
```

### Mobile apps

```bash
cd client-app   # or driver-app
flutter pub get
flutter run
```

---

## Environment Variables

```env
DATABASE_URL=
JWT_SECRET=
TELEGRAM_BOT_TOKEN=
MISTRAL_API_KEY=
CLOUDINARY_URL=
GOOGLE_MAPS_API_KEY=
```
