from fastapi import APIRouter
import random

router = APIRouter(prefix="/admin", tags=["Admin"])

@router.get("/health")
async def get_system_health():
    return {
        "is_secure": True,
        "all_systems_ok": True,
        "cpu_percent": random.randint(35, 55),
        "ram_percent": random.randint(40, 60),
        "uptime": "99.8%",
        "active_sessions": random.randint(200, 300),
        "server": "prod-us-east-1"
    }

@router.get("/alerts")
async def get_alerts():
    return [
        {
            "id": 1,
            "severity": "critical",
            "message": "LinkedIn Scraper Failed (Module 2)",
            "error_code": "503",
            "timestamp": "2 min ago",
            "module": "Module 2"
        },
        {
            "id": 2,
            "severity": "warning",
            "message": "NLP Parser Performance Degraded",
            "error_code": "PERF",
            "timestamp": "15 min ago",
            "module": "Module 3"
        }
    ]

@router.post("/restart-scraper")
async def restart_scraper():
    return {
        "success": True,
        "message": "Scraper service restarted successfully",
        "status": "active"
    }
