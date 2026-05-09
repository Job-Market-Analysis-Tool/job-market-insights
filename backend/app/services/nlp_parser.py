import fitz  # PyMuPDF
from docx import Document
import io

# Cybersecurity focused skill keywords
SKILL_KEYWORDS = [
    "python", "javascript", "typescript", "react", "flutter",
    "sql", "mongodb", "docker", "kubernetes",
    "machine learning", "tensorflow", "deep learning",
    "cybersecurity", "linux", "aws", "azure", "gcp",
    "network security", "penetration testing", "ethical hacking",
    "incident response", "threat analysis", "security auditing",
    "cloud security", "zero trust", "container security",
    "security automation", "compliance", "cryptography",
    "firewall", "vpn", "siem", "soc", "malware analysis",
    "vulnerability assessment", "risk management", "iso 27001",
    "nist", "gdpr", "java", "c++", "bash", "powershell"
]

def extract_text_from_pdf(file_bytes: bytes) -> str:
    doc = fitz.open(stream=file_bytes, filetype="pdf")
    return " ".join(page.get_text() for page in doc)

def extract_text_from_docx(file_bytes: bytes) -> str:
    doc = Document(io.BytesIO(file_bytes))
    return " ".join(para.text for para in doc.paragraphs)

def extract_skills(text: str) -> list:
    text_lower = text.lower()
    found = [skill for skill in SKILL_KEYWORDS if skill in text_lower]
    return list(set(found))  # remove duplicates

def calculate_match(user_skills: list, target_skills: list) -> dict:
    user_set = set(s.lower() for s in user_skills)
    target_set = set(s.lower() for s in target_skills)
    
    matched = list(user_set.intersection(target_set))
    missing = list(target_set.difference(user_set))
    
    percentage = round((len(matched) / len(target_set)) * 100) if target_set else 0
    
    return {
        "match_percentage": percentage,
        "matched_skills": matched,
        "missing_skills": missing
    }

# Target skills for Cybersecurity Engineer role
CYBERSECURITY_TARGET_SKILLS = [
    "network security", "python", "linux",
    "incident response", "threat analysis",
    "cloud security", "zero trust",
    "container security", "security automation",
    "compliance", "cryptography", "security auditing"
]
