# 🧠 AI/VR Virtual Job Market Analysis Tool

A full-stack cybersecurity career intelligence system that analyzes resumes, identifies skill gaps, and generates personalized career roadmaps.

## 🔗 Live URLs
- **Frontend:** https://job-market-insights.masabharoon11.workers.dev
- **Backend API:** https://job-market-insights-production.up.railway.app
- **API Docs:** https://job-market-insights-production.up.railway.app/docs
- **GitHub:** https://github.com/Job-Market-Analysis-Tool/job-market-insights

## 👥 Team
| Member | Role |
|--------|------|
| Masab Haroon | Full Stack Developer — Frontend, Backend, Deployment |
| Maryam | Mobile Developer — Flutter Admin Console (Module 8) |

## 📦 Project Structure
```
job-market-insights/
├── src/                  # React Frontend (Module 5)
│   ├── components/       # Sidebar, Resume Intelligence
│   └── routes/           # Skill Gap, Roadmap, Job Matching
├── backend/              # FastAPI Backend (Module 5)
│   ├── app/
│   │   ├── routers/      # resume.py, admin.py
│   │   ├── services/     # nlp_parser.py
│   │   └── core/         # database.py (MongoDB)
└── mobile/               # Flutter Mobile App (Module 8)
    └── lib/main.dart     # Admin Console — Login, Dashboard, Alerts
```

## 🛠 Tech Stack
| Layer | Technology |
|-------|-----------|
| Frontend | React, TypeScript, Vite, TailwindCSS, TanStack Router |
| Backend | FastAPI, Python, Uvicorn |
| Database | MongoDB Atlas |
| Mobile | Flutter (Dart) |
| Deployment | Cloudflare Workers, Railway |

## ⚙️ Module Coverage
| Module | Description | Status |
|--------|-------------|--------|
| Module 5 | Resume Intelligence & Skill Gap Analysis | ✅ Complete |
| Module 8 | Admin Mobile Console | ✅ Complete |

## 🚀 Run Locally

### Frontend
```bash
npm install
npm run dev
```

### Backend
```bash
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

### Mobile
```bash
cd mobile
flutter pub get
flutter run
```

## 🔑 Environment Variables

### Backend (.env)
```
MONGO_URL=your_mongodb_atlas_connection_string
PORT=8000
```

### Frontend (.env)
```
VITE_API_URL=http://localhost:8000
```

## 📱 Module 8 — Admin Console Features
- Admin Login with validation
- Real-time Health Dashboard (CPU, RAM, Load gauges)
- System Alerts with severity levels (Critical, Warning, Info)
- One-tap scraper restart action
- Module status monitoring

## 🧠 Module 5 — Skill Gap Analysis Features
- PDF/DOCX resume upload
- NLP-based skill extraction
- Match percentage calculation against Cybersecurity Engineer role
- Matched vs missing skills visualization
- Career roadmap generation
