# Complete Railway Deployment Guide (Backend + Frontend)

This guide will help you deploy both the **FastAPI Backend** and **Streamlit Frontend** to Railway.

## 🏗️ Architecture

- **Backend Service**: FastAPI API (port 8000)
- **Frontend Service**: Streamlit UI (port 8501)
- **Connection**: Frontend connects to Backend via `API_URL` environment variable

## 📋 Prerequisites

1. ✅ Code pushed to GitHub (already done: `https://github.com/sagarlamani/rag-chatbot.git`)
2. Railway account at https://railway.app
3. API keys ready (OpenAI or HuggingFace)

## 🚀 Deployment Steps

### Step 1: Create Railway Project

1. Go to https://railway.app and sign in
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"**
4. Choose your repository: `sagarlamani/rag-chatbot`

### Step 2: Deploy Backend Service (First Service)

Railway will automatically create the first service. This will be your **Backend**.

1. Railway will detect it's a Python project
2. It will use `railway.json` or `Procfile` to start the FastAPI server
3. Wait for deployment to complete

**Configure Backend Environment Variables:**

Go to the Backend service → **Variables** tab, add:

```env
# Choose ONE LLM option:

# Option A: OpenAI (Recommended)
OPENAI_API_KEY=sk-your-key-here
MODEL_NAME=gpt-3.5-turbo
EMBEDDING_MODEL=text-embedding-ada-002

# Option B: HuggingFace (Free - leave OPENAI_API_KEY empty)
# No API key needed - uses free local models

# Optional: Storage paths
CHROMA_DB_PATH=./data/chroma
UPLOAD_DIR=./data/uploads
```

**Get Backend URL:**
- After deployment, Railway will provide a URL like: `https://your-backend.railway.app`
- **Copy this URL** - you'll need it for the frontend!

### Step 3: Deploy Frontend Service (Second Service)

1. In your Railway project dashboard, click **"+ New"** button
2. Select **"GitHub Repo"** again
3. Choose the **same repository**: `sagarlamani/rag-chatbot`
4. Railway will create a second service

**Configure Frontend Service:**

1. Click on the new service (Frontend)
2. Go to **Settings** → **Service Name** → Rename it to "Frontend" (optional, for clarity)
3. Go to **Variables** tab, add:

```env
# REQUIRED: Backend API URL
API_URL=https://your-backend.railway.app

# Replace 'your-backend.railway.app' with your actual backend URL from Step 2
```

4. Go to **Settings** → **Deploy** → **Start Command**
5. Set the start command to:
```bash
streamlit run app/frontend.py --server.port $PORT --server.address 0.0.0.0 --server.headless true
```

**Alternative:** Railway should auto-detect, but if it doesn't, you can also:
- Create a `Procfile` in the root with: `web: streamlit run app/frontend.py --server.port $PORT --server.address 0.0.0.0 --server.headless true`
- Or use the `railway-frontend.json` configuration

### Step 4: Verify Deployment

**Backend:**
- Test: `https://your-backend.railway.app/health`
- API Docs: `https://your-backend.railway.app/docs`

**Frontend:**
- Access: `https://your-frontend.railway.app`
- The frontend should connect to the backend automatically

## 🔧 Alternative: Using Railway Service Configuration

If Railway doesn't auto-detect correctly, you can:

1. **For Backend Service:**
   - Use `railway.json` (already configured) OR
   - Use `Procfile` (already configured)

2. **For Frontend Service:**
   - Create a separate `Procfile` or use service-specific settings
   - Or manually set the start command in Railway dashboard

## 📝 Environment Variables Summary

### Backend Service Variables:
```env
OPENAI_API_KEY=sk-...          # If using OpenAI
MODEL_NAME=gpt-3.5-turbo       # Optional
EMBEDDING_MODEL=text-embedding-ada-002  # Optional
CHROMA_DB_PATH=./data/chroma   # Optional
UPLOAD_DIR=./data/uploads      # Optional
```

### Frontend Service Variables:
```env
API_URL=https://your-backend.railway.app  # REQUIRED - Backend URL
```

## 🔗 Service Communication

- Frontend connects to Backend via HTTP requests
- Backend URL is set via `API_URL` environment variable in Frontend service
- Both services can be on different ports (Railway handles this automatically)

## ⚠️ Important Notes

1. **Storage**: Railway uses ephemeral storage. Data will be lost on restart unless you add a Railway Volume.

2. **CORS**: Backend already has CORS enabled for all origins (`allow_origins=["*"]`), so frontend can connect.

3. **Ports**: Railway automatically sets `$PORT` - don't set it manually.

4. **Updates**: Push to GitHub, and Railway will auto-redeploy both services.

## 🧪 Testing

1. **Backend Health Check:**
   ```bash
   curl https://your-backend.railway.app/health
   ```

2. **Frontend:**
   - Open `https://your-frontend.railway.app`
   - Click "🔌 Check API Connection" in the sidebar
   - Should show "✅ Connected to API"

3. **Full Flow:**
   - Upload a document via the frontend
   - Ask questions about the document
   - Verify RAG is working

## 🆘 Troubleshooting

**Frontend can't connect to Backend:**
- Verify `API_URL` in Frontend service matches Backend URL exactly
- Check Backend is deployed and healthy
- Check CORS settings in backend (should allow all origins)

**Services not starting:**
- Check Railway logs in dashboard
- Verify environment variables are set
- Ensure `requirements.txt` has all dependencies

**Storage issues:**
- Remember: Railway storage is ephemeral
- Add Railway Volume for persistence if needed

## 📚 Next Steps

- Add custom domains for both services
- Set up monitoring and alerts
- Configure persistent storage with Railway Volumes
- Set up CI/CD for automatic deployments
