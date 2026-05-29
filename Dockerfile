# Use an official lightweight Python runtime
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy dependency definitions and install them
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY app.py .

# Expose the port the app runs on
EXPOSE 5000

# Define the command to run the application
CMD ["python", "app.py"]