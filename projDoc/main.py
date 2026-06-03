from fastapi import FastAPI
from tasks import send_email_task

app = FastAPI()

@app.get("/")
def home():
    return {"status": "FastAPI chal raha hai! 🚀"}

@app.get("/health")
def health():
    return {"status": "ok"}

@app.post("/send-email")
def send_email(email: str):
    task = send_email_task.delay(email)
    return {
        "message": f"{email} queue mein daal diya",
        "task_id": task.id
    }