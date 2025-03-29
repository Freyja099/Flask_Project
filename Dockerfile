FROM python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Create volume for database
VOLUME ["/app/instance"]

# Environment variables
ENV FLASK_APP=app.py
ENV FLASK_ENV=production
ENV PORT=5050
ENV DATABASE_URL=sqlite:///instance/users.db
ENV SECRET_KEY=your-super-secret-key

# Expose port
EXPOSE 5050

# Run the application
CMD ["python", "app.py"]