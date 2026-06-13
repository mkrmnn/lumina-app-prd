from fastapi import APIRouter, Depends, HTTPException, status, Header
from sqlalchemy.orm import Session
from .. import crud, schemas
from ..database import get_db
from ..security import verify_token

router = APIRouter(prefix="/check-ins", tags=["check-ins"])

def get_current_user_email(authorization: str = Header(...)):
    if not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Geçersiz token")
    token = authorization.replace("Bearer ", "")
    email = verify_token(token)
    if not email:
        raise HTTPException(status_code=401, detail="Token geçersiz veya süresi dolmuş")
    return email

@router.post("", response_model=schemas.CheckInRead, status_code=status.HTTP_201_CREATED)
def create_check_in(
    payload: schemas.CheckInCreate,
    db: Session = Depends(get_db),
    current_user: str = Depends(get_current_user_email),
):
    return crud.create_check_in(db, payload, user_email=current_user)

@router.get("", response_model=list[schemas.CheckInRead])
def list_check_ins(
    skip: int = 0,
    limit: int = 50,
    db: Session = Depends(get_db),
    current_user: str = Depends(get_current_user_email),
):
    return crud.list_check_ins(db, skip=skip, limit=limit, user_email=current_user)

@router.get("/{check_in_id}", response_model=schemas.CheckInRead)
def