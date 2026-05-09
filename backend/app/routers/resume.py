from fastapi import APIRouter, UploadFile, File, HTTPException
from ..services.nlp_parser import (
    extract_text_from_pdf,
    extract_text_from_docx,
    extract_skills,
    calculate_match,
    CYBERSECURITY_TARGET_SKILLS
)

router = APIRouter(prefix="/resume", tags=["Resume"])

@router.post("/analyze")
async def analyze_resume(file: UploadFile = File(...)):
    # Validate file type
    if not file.filename.endswith((".pdf", ".doc", ".docx")):
        raise HTTPException(
            status_code=400,
            detail="Invalid file type. Only PDF, DOC, DOCX allowed."
        )
    
    # Read file bytes
    file_bytes = await file.read()
    
    # Extract text based on file type
    if file.filename.endswith(".pdf"):
        text = extract_text_from_pdf(file_bytes)
    else:
        text = extract_text_from_docx(file_bytes)
    
    # Extract skills from text
    user_skills = extract_skills(text)
    
    # Calculate match against cybersecurity role
    analysis = calculate_match(user_skills, CYBERSECURITY_TARGET_SKILLS)
    
    return {
        "filename": file.filename,
        "extracted_skills": user_skills,
        "target_role": "Cybersecurity Engineer",
        "match_percentage": analysis["match_percentage"],
        "matched_skills": analysis["matched_skills"],
        "missing_skills": analysis["missing_skills"],
        "total_skills_found": len(user_skills)
    }
