FROM python:3.13.5-alpine3.22

# Set the working directory in the container
WORKDIR /app

# Copy only the requirements file first to leverage Docker's layer caching.
# This layer is only rebuilt if requirements.txt changes.
COPY requirements.txt .
RUN  pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Define the command to run the app
# Use 0.0.0.0 to make it accessible from outside the container.
# Uvicorn is run directly, which is suitable for production.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]