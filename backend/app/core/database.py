from motor.motor_asyncio import AsyncIOMotorClient
import os

MONGO_URL = os.getenv(
    "MONGO_URL",
    "mongodb+srv://masab:h4ck3rm4ss0@job-market-cluster.e4ypxmm.mongodb.net/job_market_tool?retryWrites=true&w=majority&appName=job-market-cluster"
)

client = AsyncIOMotorClient(MONGO_URL)
db = client["job_market_tool"]

profiles_collection = db["profiles"]
alerts_collection = db["alerts"]
results_collection = db["skill_gap_results"]
