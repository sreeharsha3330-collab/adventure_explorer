# 🔧 Troubleshooting Guide - Traveller Platform

## Common Issues and Solutions

---

## Backend (Django) Issues

### 1. Import Errors / Module Not Found

**Problem:**
```
ModuleNotFoundError: No module named 'django'
```

**Solution:**
```powershell
# Make sure virtual environment is activated
cd backend
.\venv\Scripts\activate

# Reinstall dependencies
pip install -r requirements.txt
```

---

### 2. Database Migration Errors

**Problem:**
```
django.db.migrations.exceptions.InconsistentMigrationHistory
```

**Solution:**
```powershell
# Delete all migration files (keep __init__.py)
# Then recreate migrations
python manage.py makemigrations
python manage.py migrate --run-syncdb
```

**Nuclear Option (Development Only):**
```powershell
# Delete db.sqlite3
del db.sqlite3

# Delete all migration files in each app's migrations folder
# (Keep __init__.py files)

# Recreate everything
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser
```

---

### 3. CORS Errors

**Problem:**
```
Access to XMLHttpRequest has been blocked by CORS policy
```

**Solution:**

Check `backend/traveller_project/settings.py`:
```python
CORS_ALLOWED_ORIGINS = [
    'http://localhost:3000',
    'http://localhost:5173',
]

# Make sure corsheaders is in INSTALLED_APPS
INSTALLED_APPS = [
    ...
    'corsheaders',
    ...
]

# And in MIDDLEWARE
MIDDLEWARE = [
    ...
    'corsheaders.middleware.CorsMiddleware',
    ...
]
```

---

### 4. JWT Token Issues

**Problem:**
```
{"detail": "Given token not valid for any token type"}
```

**Solutions:**
1. Token expired - refresh or login again
2. Check token format in Authorization header: `Bearer <token>`
3. Clear localStorage and login again

---

### 5. Image Upload Errors

**Problem:**
```
Cannot save image / Upload fails
```

**Solutions:**

1. **Check MEDIA settings in settings.py:**
```python
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'
```

2. **Ensure media URL is in urls.py:**
```python
from django.conf.urls.static import static

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

3. **Create media directory:**
```powershell
mkdir media
```

---

### 6. Admin Panel Not Accessible

**Problem:**
Can't login to `/admin`

**Solution:**
```powershell
# Create superuser
python manage.py createsuperuser

# Make sure admin is in INSTALLED_APPS
# and url pattern exists in urls.py
```

---

### 7. Port Already in Use

**Problem:**
```
Error: That port is already in use
```

**Solution:**
```powershell
# Find process using port 8000
netstat -ano | findstr :8000

# Kill the process (replace PID)
taskkill /PID <PID> /F

# Or use different port
python manage.py runserver 8001
```

---

## Frontend (React) Issues

### 1. npm install Fails

**Problem:**
```
npm ERR! code ERESOLVE
```

**Solutions:**

1. **Clear npm cache:**
```powershell
npm cache clean --force
rm -rf node_modules
rm package-lock.json
npm install
```

2. **Use legacy peer deps:**
```powershell
npm install --legacy-peer-deps
```

---

### 2. Module Not Found Errors

**Problem:**
```
Module not found: Can't resolve 'react-router-dom'
```

**Solution:**
```powershell
# Reinstall dependencies
npm install

# Or install specific package
npm install react-router-dom
```

---

### 3. Vite Dev Server Won't Start

**Problem:**
```
Port 5173 is already in use
```

**Solution:**
```powershell
# Kill process on port 5173
netstat -ano | findstr :5173
taskkill /PID <PID> /F

# Or change port in vite.config.js:
server: {
  port: 3000
}
```

---

### 4. API Requests Failing

**Problem:**
```
Network Error / 404 Not Found
```

**Solutions:**

1. **Check backend is running:**
```powershell
# Should see Django server running
http://localhost:8000/admin
```

2. **Check API URL in .env:**
```
VITE_API_URL=http://localhost:8000/api
```

3. **Verify axios configuration:**
```javascript
// src/services/api.js
const API_URL = import.meta.env.VITE_API_URL || '/api'
```

---

### 5. Authentication Not Working

**Problem:**
User can't login or stays logged out

**Solutions:**

1. **Clear browser storage:**
```javascript
// In browser console
localStorage.clear()
sessionStorage.clear()
```

2. **Check token storage:**
```javascript
// In browser console
console.log(localStorage.getItem('accessToken'))
```

3. **Verify JWT settings in Django:**
```python
SIMPLE_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(days=1),
    'REFRESH_TOKEN_LIFETIME': timedelta(days=7),
}
```

---

### 6. Images Not Displaying

**Problem:**
Images return 404 or don't load

**Solutions:**

1. **Check image URLs:**
   - Should be absolute URLs
   - Format: `http://localhost:8000/media/destinations/image.jpg`

2. **Configure media serving in Django:**
```python
# settings.py
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# urls.py
from django.conf.urls.static import static
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

---

### 7. Tailwind Styles Not Working

**Problem:**
CSS classes don't apply

**Solutions:**

1. **Check tailwind.config.js content:**
```javascript
content: [
  "./index.html",
  "./src/**/*.{js,ts,jsx,tsx}",
],
```

2. **Ensure PostCSS is configured:**
```javascript
// postcss.config.js
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
```

3. **Import styles in index.css:**
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

---

## Database Issues

### 1. Database Locked (SQLite)

**Problem:**
```
database is locked
```

**Solution:**
```powershell
# Stop all Django processes
# Close all database browser tools
# Restart server
python manage.py runserver
```

---

### 2. Switching to PostgreSQL

**Steps:**

1. **Install PostgreSQL and create database:**
```sql
CREATE DATABASE traveller_db;
CREATE USER traveller_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE traveller_db TO traveller_user;
```

2. **Install psycopg2:**
```powershell
pip install psycopg2-binary
```

3. **Update settings.py:**
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'traveller_db',
        'USER': 'traveller_user',
        'PASSWORD': 'password',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

4. **Run migrations:**
```powershell
python manage.py migrate
```

---

## General Issues

### 1. Slow Performance

**Solutions:**

1. **Enable Django Debug Toolbar** (development only)
2. **Add database indexes** to frequently queried fields
3. **Use select_related and prefetch_related** in queries
4. **Implement caching** with Redis
5. **Optimize images** before upload

---

### 2. Memory Issues

**Solutions:**

1. **Limit pagination size:**
```python
REST_FRAMEWORK = {
    'PAGE_SIZE': 12,  # Reduce if needed
}
```

2. **Optimize queries:**
```python
# Bad
destinations = Destination.objects.all()

# Good
destinations = Destination.objects.select_related('created_by').only(
    'name', 'city', 'country', 'average_rating'
)
```

---

### 3. Git Issues

**Problem:**
Can't commit due to large files

**Solution:**
```powershell
# Check .gitignore includes:
*.pyc
__pycache__/
db.sqlite3
media/
node_modules/
.env
```

---

## Getting Help

### Still Stuck?

1. **Check logs:**
   - Backend: Terminal running Django server
   - Frontend: Browser console (F12)
   - Network tab for API calls

2. **Enable debug mode:**
```python
# settings.py
DEBUG = True
```

3. **Test API directly:**
```powershell
# Test endpoint
curl http://localhost:8000/api/destinations/
```

4. **Search error messages:**
   - Copy exact error message
   - Search on Stack Overflow
   - Check Django/React documentation

5. **Ask for help:**
   - Open GitHub issue
   - Describe what you tried
   - Include error messages
   - Share relevant code snippets

---

## Preventive Measures

### Best Practices

1. **Always activate virtual environment** before working
2. **Keep dependencies updated** (carefully)
3. **Commit working code** regularly
4. **Test after each change**
5. **Read error messages** carefully
6. **Use version control** (Git)
7. **Document custom changes**

---

## Quick Reset (Nuclear Option)

**WARNING: This deletes all data!**

```powershell
# Backend
cd backend
deactivate
Remove-Item -Recurse -Force venv
Remove-Item db.sqlite3
Remove-Item -Recurse -Force media

# Frontend
cd ../frontend
Remove-Item -Recurse -Force node_modules
Remove-Item package-lock.json

# Run setup again
cd ..
.\setup.ps1
```

---

Last Updated: November 3, 2025
