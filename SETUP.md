# 🚀 Quick Setup Guide - Traveller Platform

## Prerequisites
- Python 3.8+ installed
- Node.js 16+ and npm installed
- Git (optional, for version control)

## Backend Setup (Django)

### 1. Navigate to Backend Directory
```powershell
cd backend
```

### 2. Create Virtual Environment
```powershell
python -m venv venv
```

### 3. Activate Virtual Environment
```powershell
.\venv\Scripts\activate
```

### 4. Install Dependencies
```powershell
pip install -r requirements.txt
```

### 5. Create Environment File
```powershell
copy .env.example .env
```

Edit `.env` file and update these values:
- `SECRET_KEY` - Generate a new secret key
- `DEBUG=True` for development
- Configure Cloudinary credentials (optional, for image uploads)

### 6. Run Database Migrations
```powershell
python manage.py makemigrations
python manage.py migrate
```

### 7. Create Superuser (Admin)
```powershell
python manage.py createsuperuser
```

Follow the prompts to create an admin account.

### 8. Start Backend Server
```powershell
python manage.py runserver
```

Backend will be running at: http://localhost:8000
Admin panel: http://localhost:8000/admin

---

## Frontend Setup (React)

### 1. Open New Terminal & Navigate to Frontend
```powershell
cd frontend
```

### 2. Install Dependencies
```powershell
npm install
```

### 3. Create Environment File
```powershell
copy .env.example .env
```

The default `.env` should work for local development:
```
VITE_API_URL=http://localhost:8000/api
```

### 4. Start Frontend Server
```powershell
npm run dev
```

Frontend will be running at: http://localhost:5173

---

## 🎯 Testing the Application

### 1. Access the Application
Open your browser and go to: http://localhost:5173

### 2. Create Test Data (via Admin Panel)
1. Go to http://localhost:8000/admin
2. Login with your superuser credentials
3. Add some destinations:
   - Navigate to "Destinations"
   - Click "Add Destination"
   - Fill in details (name, city, country, category, description)
   - Save

### 3. Register a User
1. Click "Sign Up" in the navbar
2. Fill in registration form
3. Login with your credentials

### 4. Test Features
- ✅ Browse destinations on Explore page
- ✅ View destination details
- ✅ Create a blog post
- ✅ Like and comment on posts
- ✅ Save destinations
- ✅ View your dashboard
- ✅ Write reviews

---

## 📁 Project Structure

```
traveller/
├── backend/                    # Django Backend
│   ├── accounts/              # User authentication & profiles
│   ├── destinations/          # Tourist destinations management
│   ├── posts/                 # Blog posts & comments
│   ├── reviews/               # Destination reviews
│   ├── traveller_project/     # Django settings
│   ├── manage.py
│   └── requirements.txt
│
├── frontend/                  # React Frontend
│   ├── src/
│   │   ├── components/       # Reusable UI components
│   │   ├── pages/            # Page components
│   │   ├── services/         # API service layer
│   │   ├── context/          # React Context (Auth)
│   │   ├── App.jsx
│   │   └── main.jsx
│   ├── package.json
│   └── index.html
│
└── README.md
```

---

## 🔑 Key API Endpoints

### Authentication
- POST `/api/token/` - Login (get JWT token)
- POST `/api/token/refresh/` - Refresh token
- POST `/api/accounts/register/` - Register new user

### Destinations
- GET `/api/destinations/` - List destinations
- GET `/api/destinations/{id}/` - Get destination details
- POST `/api/destinations/{id}/save/` - Save destination
- GET `/api/destinations/popular/` - Get popular destinations

### Posts
- GET `/api/posts/` - List posts
- POST `/api/posts/` - Create post
- POST `/api/posts/{id}/like/` - Like post
- POST `/api/posts/{id}/add_comment/` - Add comment

### Reviews
- GET `/api/reviews/` - List reviews
- POST `/api/reviews/` - Create review
- POST `/api/reviews/{id}/helpful/` - Mark review as helpful

---

## 🎨 Optional: Configure Image Storage

### Using Cloudinary (Recommended)
1. Sign up at https://cloudinary.com
2. Get your credentials from dashboard
3. Update `.env` file:
```
CLOUDINARY_CLOUD_NAME=your-cloud-name
CLOUDINARY_API_KEY=your-api-key
CLOUDINARY_API_SECRET=your-api-secret
```

4. In `settings.py`, uncomment:
```python
DEFAULT_FILE_STORAGE = 'cloudinary_storage.storage.MediaCloudinaryStorage'
```

---

## 🐛 Troubleshooting

### Backend Issues

**Import errors:**
```powershell
pip install --upgrade pip
pip install -r requirements.txt --force-reinstall
```

**Database errors:**
```powershell
python manage.py makemigrations --empty accounts
python manage.py migrate --run-syncdb
```

### Frontend Issues

**Module not found:**
```powershell
rm -r node_modules
rm package-lock.json
npm install
```

**CORS errors:**
- Ensure backend is running
- Check CORS settings in `backend/traveller_project/settings.py`

---

## 📝 Next Steps

1. **Customize Design**: Modify Tailwind colors in `tailwind.config.js`
2. **Add More Features**:
   - Map integration with Leaflet
   - Advanced search & filters
   - Email notifications
   - Social media sharing
3. **Deploy**:
   - Backend: Heroku, DigitalOcean, AWS
   - Frontend: Vercel, Netlify
   - Database: PostgreSQL on production

---

## 🌟 Features Implemented

✅ User authentication (JWT)
✅ User profiles
✅ Tourist destinations CRUD
✅ Blog posts with images
✅ Comments on posts
✅ Like posts
✅ Reviews & ratings
✅ Save destinations
✅ User dashboard
✅ Search & filter destinations
✅ Admin panel
✅ Responsive design

---

## 📚 Technologies Used

**Backend:**
- Django 5.0
- Django REST Framework
- JWT Authentication
- PostgreSQL/SQLite
- Cloudinary

**Frontend:**
- React 18
- React Router
- Tailwind CSS
- React Query
- Axios
- React Hook Form

---

Happy Coding! 🚀
