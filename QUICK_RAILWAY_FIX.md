# Quick Fix: Railway Frontend Start Command

## The Problem
Railway UI might not let you set a custom start command if it detects `railway.json` in the repo.

## ✅ Solution: Use Railway Service Settings Properly

### Step-by-Step:

1. **In Railway Dashboard:**
   - Go to your **Frontend Service** (the second service you created)
   - Click on **Settings** (gear icon)

2. **Check the Deploy Section:**
   - Look for **"Deploy"** or **"Build & Deploy"** section
   - Find **"Start Command"** field
   - If it's grayed out, try this:

3. **Enable Override (if available):**
   - Look for a toggle/checkbox that says **"Override Start Command"** or **"Use Custom Command"**
   - Enable it first, then you can enter the command

4. **Enter the Start Command:**
   ```
   streamlit run app/frontend.py --server.port $PORT --server.address 0.0.0.0 --server.headless true
   ```

## 🔄 Alternative: Temporarily Remove railway.json Detection

If the above doesn't work:

1. **For Frontend Service Only:**
   - Go to **Settings** → **Source**
   - Try changing the **Root Directory** to a subdirectory (this might not work, but worth trying)
   - OR disconnect and reconnect the GitHub source

2. **Or Use Railway CLI:**
   ```bash
   # Install Railway CLI first: npm i -g @railway/cli
   railway link
   railway service:update --start-command "streamlit run app/frontend.py --server.port \$PORT --server.address 0.0.0.0 --server.headless true"
   ```

## 🎯 Most Reliable Solution: Use a Startup Script

We've created `start-frontend.sh` in the repo. Try this:

1. In Railway Frontend service → **Settings** → **Deploy**
2. Set **Start Command** to: `bash start-frontend.sh`

If that doesn't work, try: `./start-frontend.sh` or `sh start-frontend.sh`

## 📋 What to Check:

1. ✅ Are you in the **Frontend Service** settings (not Backend)?
2. ✅ Is the service properly connected to GitHub?
3. ✅ Are you looking in **Settings** → **Deploy** section?
4. ✅ Is there a toggle/checkbox to enable custom commands?

## 🆘 If Nothing Works:

**Option 1: Deploy Frontend to Streamlit Cloud (Free)**
- Go to https://share.streamlit.io
- Connect your GitHub repo
- Set `API_URL` environment variable to your Railway backend URL
- Streamlit Cloud will auto-detect and deploy

**Option 2: Contact Railway Support**
- They can enable custom start commands for your account
- Or help configure the service properly

## ✅ Quick Test After Setting:

1. Save the start command
2. Go to **Deployments** tab
3. Trigger a new deployment
4. Check **Logs** to see what command Railway is actually running
5. If it's wrong, the logs will show you what Railway detected
