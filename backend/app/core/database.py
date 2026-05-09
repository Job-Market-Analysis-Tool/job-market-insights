from motor.motor_asyncio import AsyncIOMotorClient
import os

MONGO_URL = os.getenv("MONGO_URL", "mongodb://localhost:27017")
client = AsyncIOMotorClient(MONGO_URL)
db = client["job_market_tool"]

profiles_collection = db["profiles"]
alerts_collection = db["alerts"]
