# Traveller Platform - Quick Setup Script for Windows
# Run this script to set up both backend and frontend

Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Traveller Platform Setup" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Backend Setup
Write-Host "Setting up Django Backend..." -ForegroundColor Yellow
Write-Host ""

Set-Location backend

# Create virtual environment
Write-Host "Creating virtual environment..." -ForegroundColor Green
python -m venv venv

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Green
& .\venv\Scripts\Activate.ps1

# Install dependencies
Write-Host "Installing Python dependencies..." -ForegroundColor Green
pip install --upgrade pip
pip install -r requirements.txt

# Run migrations
Write-Host "Running database migrations..." -ForegroundColor Green
python manage.py makemigrations
python manage.py migrate

# Prompt for superuser creation
Write-Host ""
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Create Admin Account" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
$createSuperuser = Read-Host "Do you want to create an admin account? (y/n)"

if ($createSuperuser -eq "y" -or $createSuperuser -eq "Y") {
    python manage.py createsuperuser
}

# Populate sample data
Write-Host ""
$populateData = Read-Host "Do you want to populate sample data? (y/n)"

if ($populateData -eq "y" -or $populateData -eq "Y") {
    Write-Host "Populating sample data..." -ForegroundColor Green
    python manage.py populate_data
}

Write-Host ""
Write-Host "Backend setup complete! ✓" -ForegroundColor Green
Write-Host ""

# Return to root directory
Set-Location ..

# Frontend Setup
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Setting up React Frontend..." -ForegroundColor Yellow
Write-Host ""

Set-Location frontend

# Install dependencies
Write-Host "Installing npm dependencies..." -ForegroundColor Green
npm install

Write-Host ""
Write-Host "Frontend setup complete! ✓" -ForegroundColor Green
Write-Host ""

# Return to root directory
Set-Location ..

# Final instructions
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Setup Complete! 🎉" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "To start the application:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Backend (Django):" -ForegroundColor Cyan
Write-Host "   cd backend" -ForegroundColor White
Write-Host "   .\venv\Scripts\activate" -ForegroundColor White
Write-Host "   python manage.py runserver" -ForegroundColor White
Write-Host "   -> http://localhost:8000" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Frontend (React) - In a new terminal:" -ForegroundColor Cyan
Write-Host "   cd frontend" -ForegroundColor White
Write-Host "   npm run dev" -ForegroundColor White
Write-Host "   -> http://localhost:5173" -ForegroundColor Gray
Write-Host ""
Write-Host "Admin Panel: http://localhost:8000/admin" -ForegroundColor Magenta
Write-Host ""
Write-Host "Happy Coding! 🚀" -ForegroundColor Green
