# 🚀 Supabase Vanilla Project

A lightweight CRUD application built with plain HTML, CSS, and JavaScript, powered by a local Supabase environment.

## 🛠️ Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (Must be running)
- [Node.js](https://nodejs.org/)

## 🏗️ Local Setup
1. **Clone the repo:**
   `git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git`
2. **Start Supabase:**
   `npx supabase start`
3. **Get your keys:**
   `npx supabase status`
4. **Setup Keys:**
   Create a `js/config.js` file (ignored by Git) and add your `SUPABASE_URL` and `SUPABASE_ANON_KEY`.

## 📖 Features
- **Read:** View profiles from the local PostgreSQL DB.
- **Create:** Add new profiles via a web form.
- **Delete:** Remove entries using unique UUIDs.