# Railway Frontend Service - Start Command Fix

If Railway is not letting you set a custom start command, here are several solutions:

## Solution 1: Use Railway Service Source Configuration (Recommended)

1. **In Railway Dashboard:**
   - Go to your **Frontend Service**
   - Click **Settings** → **Source**
   - Set **Root Directory** to: `.` (or leave empty - same as root)
   - Railway should now allow you to set custom settings

2. **Then set the start command:**
   - Go to **Settings** → **Deploy**
   - You should now be able to set **Start Command** to:
   ```bash
   streamlit run app/frontend.py --server.port $PORT --server.address 0.0.0.0 --server.headless true
   ```

## Solution 2: Temporarily Rename railway.json

Railway might be auto-detecting `railway.json` and preventing custom commands. Try this:

1. **For Backend Service:**
   - Keep using `railway.json` (it's already configured correctly)

2. **For Frontend Service:**
   - Railway should use the start command from service settings
   - If it doesn't work, you can temporarily rename `railway.json` to `railway-backend.json` in the repo
   - Then Railway won't auto-detect it for the frontend service

## Solution 3: Use Procfile (Alternative)

Create a `Procfile-frontend` file (Railway might detect this):

```bash
web: streamlit run app/frontend.py --server.port $PORT --server.address 0.0.0.0 --server.headless true
```

But Railway typically only reads `Procfile`, not `Procfile-frontend`.

## Solution 4: Use Railway CLI or API

If the UI doesn't work, you can use Railway CLI:

```bash
railway service:update --start-command "streamlit run app/frontend.py --server.port \$PORT --server.address 0.0.0.0 --server.headless true"
```

## Solution 5: Use Environment Variable (Workaround)

Some Railway setups allow setting start command via environment variable:

1. In Frontend service → **Variables**
2. Add: `RAILWAY_START_COMMAND=streamlit run app/frontend.py --server.port $PORT --server.address 0.0.0.0 --server.headless true`

(Note: This might not work on all Railway plans)

## Solution 6: Create a Startup Script

We've created `start-frontend.sh` in the repo. You can:

1. In Railway Frontend service → **Settings** → **Deploy**
2. Set **Start Command** to: `bash start-frontend.sh`

Or if that doesn't work, try: `sh start-frontend.sh`

## Solution 7: Use Railway's Build Settings

1. Go to Frontend service → **Settings** → **Build**
2. Set **Build Command** (if available)
3. Set **Start Command** in Deploy settings

## Most Likely Solution

**Try this first:**

1. In Railway dashboard, go to your **Frontend service**
2. Click **Settings** → **Deploy**
3. Look for **"Override Start Command"** or **"Custom Start Command"** toggle/checkbox
4. Enable it if there's a toggle
5. Then you should be able to enter the start command

If that section is grayed out or missing:

1. Go to **Settings** → **Source**
2. Make sure the service is properly connected to the GitHub repo
3. Try disconnecting and reconnecting the source
4. Then try setting the start command again

## Still Not Working?

If none of these work, you might need to:

1. **Contact Railway Support** - They can help enable custom start commands
2. **Use Railway's Service Template** - Some templates allow more customization
3. **Deploy Frontend Separately** - Consider deploying the frontend to a different platform (Streamlit Cloud, Render, etc.) and just point it to your Railway backend

## Quick Test

After setting the start command, check the **Logs** tab in Railway to see what command is actually being run. This will help diagnose the issue.
