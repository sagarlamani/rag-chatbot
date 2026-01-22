# Deploy Frontend to Streamlit Cloud (Easiest Solution)

Since Railway isn't allowing custom start commands, the **easiest solution** is to deploy the frontend to **Streamlit Cloud** (free and designed for Streamlit apps).

## ✅ Why Streamlit Cloud?

- ✅ **Free hosting** for public repos
- ✅ **Auto-detects Streamlit** apps
- ✅ **No configuration needed** - just connect GitHub
- ✅ **Designed for Streamlit** - works perfectly out of the box
- ✅ **Takes 2 minutes** to set up

## 🚀 Step-by-Step Deployment

### 1. Go to Streamlit Cloud
- Visit: https://share.streamlit.io
- Sign in with your **GitHub account**

### 2. Create New App
1. Click **"New app"** button
2. You'll see a form to configure your app

### 3. Configure the App

**Repository:**
- Select: `sagarlamani/rag-chatbot`

**Branch:**
- Select: `main`

**Main file path:**
- Enter: `app/frontend.py`

**App URL (optional):**
- Leave default or customize

### 4. Add Environment Variable

Click **"Advanced settings"** and add:

**Key:** `API_URL`  
**Value:** `https://your-backend.railway.app`

*(Replace with your actual Railway backend URL)*

### 5. Deploy!

Click **"Deploy"** and Streamlit Cloud will:
- Clone your repo
- Install dependencies from `requirements.txt`
- Run `streamlit run app/frontend.py`
- Give you a public URL

### 6. Access Your App

You'll get a URL like: `https://your-app-name.streamlit.app`

## 🔗 Connect Frontend to Backend

The frontend will automatically connect to your Railway backend using the `API_URL` environment variable you set.

## ✅ That's It!

Your setup will be:
- **Backend:** Railway (FastAPI) - `https://your-backend.railway.app`
- **Frontend:** Streamlit Cloud (Streamlit UI) - `https://your-app.streamlit.app`

The frontend will communicate with the backend via HTTP requests.

## 🎯 Benefits

- No Railway configuration headaches
- Streamlit Cloud is optimized for Streamlit apps
- Free hosting
- Automatic deployments on git push
- Built-in analytics

## 📝 Notes

- Streamlit Cloud requires your repo to be **public** (for free tier)
- Or you can use Streamlit Cloud Teams for private repos
- Updates automatically when you push to GitHub
