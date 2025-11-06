# Base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies required for faiss, chroma-hnswlib, etc.
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy dependency file
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of your code
COPY . .

# Expose Streamlit or FastAPI port
EXPOSE 7860

# Default command (for Streamlit)
CMD ["streamlit", "run", "main.py", "--server.port=7860", "--server.address=0.0.0.0"]
