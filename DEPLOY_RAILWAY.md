# Quick Railway Deployment Guide

## 🚀 Step-by-Step Deployment

### 1. **Prepare Your Code**
Make sure your code is committed to Git:
```bash
cd rag-chatbot-main
git add .
git commit -m "Ready for Railway deployment"
```

### 2. **Push to GitHub/GitLab/Bitbucket**
```bash
# If you haven't set up a remote yet:
git remote add origin <your-repo-url>
git push -u origin main
```

### 3. **Create Railway Project**

1. Go to [https://railway.app](https://railway.app) and sign in
2. Click **"New Project"**
3. Select **"Deploy from GitHub repo"** (or your Git provider)
4. Select your repository
5. Railway will automatically detect it's a Python project

### 4. **Configure Environment Variables**

In Railway dashboard → Your Service → **Variables** tab, add:

#### **Minimum Required (Choose ONE):**

**Option A: OpenAI (Recommended)**
```
OPENAI_API_KEY=sk-your-actual-key-here
MODEL_NAME=gpt-3.5-turbo
EMBEDDING_MODEL=text-embedding-ada-002
```

**Option B: HuggingFace Free (No API key needed)**
```
# Leave OPENAI_API_KEY empty - will use free local models
```

**Option C: HuggingFace API**
```
HUGGINGFACE_API_TOKEN=hf_your-token-here
HUGGINGFACE_MODEL=google/flan-t5-base
```

#### **Optional (Recommended for Production):**
```
CHROMA_DB_PATH=./data/chroma
UPLOAD_DIR=./data/uploads
```

⚠️ **Note:** Railway uses ephemeral storage. Data will be lost on restart unless you add a Railway Volume.

### 5. **Deploy**

Railway will automatically:
- ✅ Detect Python from `requirements.txt`
- ✅ Install dependencies
- ✅ Run the start command from `Procfile` or `railway.json`
- ✅ Start your FastAPI server

### 6. **Get Your URL**

1. Railway will generate a public URL (e.g., `https://your-app.railway.app`)
2. Test it: `https://your-app.railway.app/health`
3. API docs: `https://your-app.railway.app/docs`

### 7. **Optional: Add Persistent Storage**

To keep your vector database and uploads:

1. In Railway dashboard → **New** → **Volume**
2. Mount path: `/app/data`
3. Update environment variables:
   ```
   CHROMA_DB_PATH=/app/data/chroma
   UPLOAD_DIR=/app/data/uploads
   ```

## ✅ Verification Checklist

- [ ] Code pushed to Git repository
- [ ] Railway project created and connected to repo
- [ ] Environment variables configured (at least one LLM option)
- [ ] Deployment successful (check logs)
- [ ] Health endpoint working: `/health`
- [ ] API accessible at Railway URL

## 🔍 Testing Your Deployment

```bash
# Health check
curl https://your-app.railway.app/health

# Expected response:
{
  "status": "healthy",
  "rag_ready": true,
  "llm_configured": true,
  "embeddings_configured": true
}
```

## 📝 Next Steps

- **Custom Domain**: Add in Railway settings → Generate Domain
- **Monitor**: Check logs in Railway dashboard
- **Update**: Just push to Git, Railway auto-deploys

## 🆘 Troubleshooting

**Build fails?**
- Check `requirements.txt` has all dependencies
- Verify Python version in `runtime.txt` (3.11.0)

**App crashes?**
- Check Railway logs
- Verify environment variables are set
- Ensure `PORT` is NOT manually set (Railway sets it)

**Storage issues?**
- Remember: Railway storage is ephemeral
- Add a Volume for persistence

## 📚 More Info

- Full deployment guide: `RAILWAY_DEPLOYMENT.md`
- Environment variables: `RAILWAY_ENV_VARS.md`


