#!/bin/bash

# Traveller Platform - Quick Setup Script
# Run with: bash setup.sh

echo "=================================="
echo "Traveller Platform Setup"
echo "=================================="
echo ""

# Backend Setup
echo "Setting up Django Backend..."
echo ""

cd backend

# Create virtual environment
echo "Creating virtual environment..."
python -m venv venv

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate  # For Linux/Mac
# source venv/Scripts/activate  # For Git Bash on Windows

# Install dependencies
echo "Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Run migrations
echo "Running database migrations..."
python manage.py makemigrations
python manage.py migrate

# Prompt for superuser creation
echo ""
echo "=================================="
echo "Create Admin Account"
echo "=================================="
read -p "Do you want to create an admin account? (y/n): " createSuperuser

if [ "$createSuperuser" = "y" ] || [ "$createSuperuser" = "Y" ]; then
    python manage.py createsuperuser
fi

# Populate sample data
echo ""
read -p "Do you want to populate sample data? (y/n): " populateData

if [ "$populateData" = "y" ] || [ "$populateData" = "Y" ]; then
    echo "Populating sample data..."
    python manage.py populate_data
fi

echo ""
echo "Backend setup complete! ✓"
echo ""

# Return to root directory
cd ..

# Frontend Setup
echo "=================================="
echo "Setting up React Frontend..."
echo ""

cd frontend

# Install dependencies
echo "Installing npm dependencies..."
npm install

echo ""
echo "Frontend setup complete! ✓"
echo ""

# Return to root directory
cd ..

# Final instructions
echo "=================================="
echo "Setup Complete! 🎉"
echo "=================================="
echo ""
echo "To start the application:"
echo ""
echo "1. Backend (Django):"
echo "   cd backend"
echo "   source venv/bin/activate"
echo "   python manage.py runserver"
echo "   -> http://localhost:8000"
echo ""
echo "2. Frontend (React) - In a new terminal:"
echo "   cd frontend"
echo "   npm run dev"
echo "   -> http://localhost:5173"
echo ""
echo "Admin Panel: http://localhost:8000/admin"
echo ""
echo "Happy Coding! 🚀"
