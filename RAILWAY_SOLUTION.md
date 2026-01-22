# Railway Start Command Solution

## The Problem
Railway automatically reads `railway.json` and uses it for the start command, which prevents you from setting a custom command in the UI.

## ✅ Solution: Service-Specific Configuration

Since Railway reads `railway.json` automatically, here's how to handle both services:

### For Backend Service (First Service):
- ✅ Keep `railway.json` as is - it's already configured correctly
- Railway will automatically use: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`

### For Frontend Service (Second Service):

**Option 1: Temporarily Rename railway.json (Recommended)**

1. In your GitHub repo, temporarily rename `railway.json` to `railway-backend.json`
2. Push the change
3. In Railway Frontend service, Railway won't find `railway.json` anymore
4. Now you can set the custom start command in Railway UI:
   ```
   streamlit run app/frontend.py --server.port $PORT --server.address 0.0.0.0 --server.headless true
   ```
5. For Backend service, manually set the start command to:
   ```
   uvicorn app.main:app --host 0.0.0.0 --port $PORT
   ```

**Option 2: Use Procfile (If Railway Supports It)**

We've created `Procfile-frontend`. Some Railway setups might detect this, but it's not guaranteed.

**Option 3: Use Railway Service Settings - Source Configuration**

1. In Railway Frontend service → **Settings** → **Source**
2. Try setting a different **Root Directory** (this might not work, but worth trying)
3. Or disconnect the GitHub source and reconnect it
4. This might allow Railway to not auto-detect `railway.json`

**Option 4: Use Railway CLI**

```bash
# Install Railway CLI
npm i -g @railway/cli

# Link to your project
railway link

# Select the frontend service
railway service

# Update the start command
railway variables set RAILWAY_START_COMMAND="streamlit run app/frontend.py --server.port \$PORT --server.address 0.0.0.0 --server.headless true"
```

**Option 5: Deploy Frontend to Streamlit Cloud (Easiest)**

Since Railway is being difficult with the frontend:

1. Go to https://share.streamlit.io
2. Sign in with GitHub
3. Click "New app"
4. Select your repo: `sagarlamani/rag-chatbot`
5. Set **Main file path**: `app/frontend.py`
6. Add environment variable:
   - Key: `API_URL`
   - Value: `https://your-backend.railway.app` (your Railway backend URL)
7. Deploy!

Streamlit Cloud is free and will auto-detect Streamlit apps.

## 🎯 Recommended Approach

**Best Solution:** Use Option 1 (rename railway.json temporarily) OR Option 5 (Streamlit Cloud for frontend).

Here's why:
- Option 1 gives you full control over both services on Railway
- Option 5 is the easiest and Streamlit Cloud is designed for Streamlit apps

## 📝 Step-by-Step for Option 1:

1. **Rename the file:**
   ```bash
   git mv railway.json railway-backend.json
   git commit -m "Rename railway.json to allow frontend custom start command"
   git push
   ```

2. **In Railway Backend Service:**
   - Go to Settings → Deploy
   - Set Start Command: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
   - (Or Railway might auto-detect from Procfile)

3. **In Railway Frontend Service:**
   - Go to Settings → Deploy  
   - Now you should be able to set Start Command: `streamlit run app/frontend.py --server.port $PORT --server.address 0.0.0.0 --server.headless true`

## 🚀 Quick Fix Right Now

The fastest solution is **Option 5 - Streamlit Cloud**:
- Takes 2 minutes to set up
- Free hosting
- Auto-detects Streamlit
- Just needs the `API_URL` environment variable

Would you like me to help you set up either approach?
