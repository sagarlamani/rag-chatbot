# Railway Direct Setup (No railway.json)

This guide shows you how to set up Railway services directly using CLI commands, without relying on `railway.json` files.

## 📦 Prerequisites

### Install Railway CLI

**Windows (PowerShell):**
```powershell
# Using npm (requires Node.js)
npm install -g @railway/cli

# OR using Scoop
scoop install railway
```

**Mac/Linux:**
```bash
# Using npm
npm install -g @railway/cli

# OR using Homebrew (Mac)
brew install railway
```

## 🔐 Step 1: Login to Railway

```bash
railway login
```

This will open your browser to authenticate.

## 🚀 Step 2: Create/Select Project

```bash
# Create a new project
railway init

# OR link to existing project
railway link
```

Select your project when prompted.

## 🔧 Step 3: Set Up Backend Service

### 3.1 Create Backend Service (if not exists)

```bash
# List services
railway service

# If backend doesn't exist, create it
railway service:create backend
```

### 3.2 Select Backend Service

```bash
railway service
# Select "backend" from the list
```

### 3.3 Set Backend Start Command

```bash
railway variables set START_COMMAND="uvicorn app.main:app --host 0.0.0.0 --port \$PORT"
```

### 3.4 Set Backend Environment Variables

```bash
# OpenAI (choose one option)
railway variables set OPENAI_API_KEY="sk-your-key-here"
railway variables set MODEL_NAME="gpt-3.5-turbo"
railway variables set EMBEDDING_MODEL="text-embedding-ada-002"

# OR for HuggingFace (free)
# Just don't set OPENAI_API_KEY, or set it empty
railway variables set OPENAI_API_KEY=""
```

### 3.5 Optional: Set Storage Paths

```bash
railway variables set CHROMA_DB_PATH="./data/chroma"
railway variables set UPLOAD_DIR="./data/uploads"
```

## 🎨 Step 4: Set Up Frontend Service

### 4.1 Create Frontend Service

```bash
railway service:create frontend
```

### 4.2 Select Frontend Service

```bash
railway service
# Select "frontend" from the list
```

### 4.3 Set Frontend Start Command

```bash
railway variables set START_COMMAND="streamlit run app/frontend.py --server.port \$PORT --server.address 0.0.0.0 --server.headless true"
```

### 4.4 Set Frontend Environment Variables

```bash
# Get your backend URL first (from Railway dashboard or use railway status)
# Then set API_URL
railway variables set API_URL="https://your-backend.railway.app"
```

**To get backend URL:**
```bash
# Switch to backend service
railway service
# Select backend

# Get the URL
railway status
# Or check Railway dashboard
```

## 📋 Complete Command List

Here's the complete sequence of commands:

```bash
# 1. Login
railway login

# 2. Link to project
railway link

# 3. Create backend service
railway service:create backend

# 4. Configure backend
railway service
# Select "backend"
railway variables set START_COMMAND="uvicorn app.main:app --host 0.0.0.0 --port \$PORT"
railway variables set OPENAI_API_KEY="sk-your-key-here"
railway variables set MODEL_NAME="gpt-3.5-turbo"
railway variables set EMBEDDING_MODEL="text-embedding-ada-002"

# 5. Create frontend service
railway service:create frontend

# 6. Configure frontend
railway service
# Select "frontend"
railway variables set START_COMMAND="streamlit run app/frontend.py --server.port \$PORT --server.address 0.0.0.0 --server.headless true"
railway variables set API_URL="https://your-backend.railway.app"
```

## 🔍 Verify Setup

### Check Backend Variables:
```bash
railway service
# Select backend
railway variables
```

### Check Frontend Variables:
```bash
railway service
# Select frontend
railway variables
```

### Check Service Status:
```bash
railway status
```

## 🚀 Deploy

After setting up, Railway will automatically deploy when you push to GitHub, or you can trigger manually:

```bash
railway up
```

## 📝 Notes

- Replace `sk-your-key-here` with your actual OpenAI API key
- Replace `https://your-backend.railway.app` with your actual backend URL
- Use `\$PORT` (with backslash) in the START_COMMAND to escape the dollar sign
- You can view all variables with: `railway variables`
- You can delete a variable with: `railway variables delete VARIABLE_NAME`

## 🆘 Troubleshooting

**If service:create doesn't work:**
- Services might already exist in Railway dashboard
- Create them manually in Railway dashboard, then use `railway link`

**If variables don't set:**
- Make sure you're in the correct service: `railway service`
- Check with: `railway variables`

**To see what service you're in:**
```bash
railway status
```
