# Set Railway Start Command Using CLI

If you want to stick with Railway, you can use the Railway CLI to set the start command programmatically.

## 📦 Install Railway CLI

### Option 1: Using npm (Node.js required)
```bash
npm install -g @railway/cli
```

### Option 2: Using Homebrew (Mac)
```bash
brew install railway
```

### Option 3: Using Scoop (Windows)
```bash
scoop install railway
```

### Option 4: Direct Download
- Visit: https://docs.railway.app/develop/cli
- Download for your OS

## 🔗 Link Your Project

1. **Login to Railway:**
   ```bash
   railway login
   ```
   This will open your browser to authenticate.

2. **Link to your project:**
   ```bash
   railway link
   ```
   - Select your Railway project
   - Select the **Frontend service** (not backend)

## ⚙️ Set Start Command

Run this command to set the start command for the frontend service:

```bash
railway variables set RAILWAY_START_COMMAND="streamlit run app/frontend.py --server.port \$PORT --server.address 0.0.0.0 --server.headless true"
```

**OR** if Railway CLI supports direct service update:

```bash
railway service
# Select your frontend service
railway variables set START_COMMAND="streamlit run app/frontend.py --server.port \$PORT --server.address 0.0.0.0 --server.headless true"
```

## 🔍 Verify

1. Check Railway dashboard → Frontend service → Variables
2. You should see the start command variable
3. Trigger a new deployment
4. Check logs to verify it's using the correct command

## 🆘 Troubleshooting

**If CLI doesn't work:**
- Make sure you're logged in: `railway whoami`
- Make sure you're in the right project: `railway status`
- Check Railway CLI docs: https://docs.railway.app/develop/cli

## 💡 Alternative: Use Railway API

If CLI doesn't work, you can use Railway's REST API:
- Docs: https://docs.railway.app/reference/api
