import os
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .routers import resume, admin

app = FastAPI(
    title="AI/VR Job Market Analysis Tool API",
    description="Backend API for Module 5 and Module 8",
    version="1.0.0"
)

# CORS - allows React frontend to call this API
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:8080", "http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(resume.router)
app.include_router(admin.router)

@app.get("/")
async def root():
    return {
        "message": "AI/VR Job Market Analysis Tool API",
        "version": "1.0.0",
        "status": "running"
    }
