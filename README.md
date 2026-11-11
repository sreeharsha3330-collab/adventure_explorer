# Travel Blog & Review Platform

A full-stack web application for exploring, reviewing, and blogging about tourist destinations.

## Features

- 🔐 User authentication (JWT-based)
- 📝 Create and manage travel blog posts
- ⭐ Rate and review tourist destinations
- 🗺️ Explore destinations by category, country, and region
- 💬 Comment on blog posts
- ❤️ Like posts and save favorite destinations
- 📊 User dashboard with travel history
- 👨‍💼 Admin panel for content moderation

## Tech Stack

### Backend
- Django 5.0
- Django REST Framework
- PostgreSQL / SQLite
- JWT Authentication
- Cloudinary (image storage)

### Frontend
- React 18
- React Router
- Axios
- Tailwind CSS
- React Query (data fetching)

## Setup Instructions

### Backend Setup

1. Navigate to the backend directory:
```bash
cd backend
```

2. Create a virtual environment:
```bash
python -m venv venv
venv\Scripts\activate  # Windows
# source venv/bin/activate  # Linux/Mac
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Create `.env` file (copy from `.env.example`):
```bash
copy .env.example .env  # Windows
# cp .env.example .env  # Linux/Mac
```

5. Configure your `.env` file with proper values

6. Run migrations:
```bash
python manage.py makemigrations
python manage.py migrate
```

7. Create a superuser:
```bash
python manage.py createsuperuser
```

8. Run the development server:
```bash
python manage.py runserver
```

The API will be available at `http://localhost:8000/api/`

### Frontend Setup

1. Navigate to the frontend directory:
```bash
cd frontend
```

2. Install dependencies:
```bash
npm install
```

3. Create `.env` file:
```bash
VITE_API_URL=http://localhost:8000/api
```

4. Run the development server:
```bash
npm run dev
```

The app will be available at `http://localhost:5173/`

## API Endpoints

### Authentication
- `POST /api/token/` - Obtain JWT token
- `POST /api/token/refresh/` - Refresh JWT token
- `POST /api/accounts/register/` - Register new user

### Destinations
- `GET /api/destinations/` - List all destinations
- `GET /api/destinations/{id}/` - Get destination details
- `POST /api/destinations/` - Create destination (authenticated)
- `GET /api/destinations/popular/` - Get popular destinations
- `POST /api/destinations/{id}/save/` - Save destination
- `GET /api/destinations/saved/` - Get saved destinations

### Posts
- `GET /api/posts/` - List all posts
- `GET /api/posts/{id}/` - Get post details
- `POST /api/posts/` - Create post (authenticated)
- `POST /api/posts/{id}/like/` - Like post
- `POST /api/posts/{id}/add_comment/` - Add comment
- `GET /api/posts/my_posts/` - Get user's posts

### Reviews
- `GET /api/reviews/` - List all reviews
- `GET /api/reviews/{id}/` - Get review details
- `POST /api/reviews/` - Create review (authenticated)
- `POST /api/reviews/{id}/helpful/` - Mark review as helpful
- `GET /api/reviews/destination_stats/` - Get destination review stats

## Project Structure

```
traveller/
├── backend/
│   ├── traveller_project/      # Django project settings
│   ├── accounts/                # User authentication & profiles
│   ├── destinations/            # Tourist destinations
│   ├── posts/                   # Blog posts
│   ├── reviews/                 # Destination reviews
│   ├── manage.py
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   ├── components/          # Reusable components
│   │   ├── pages/               # Page components
│   │   ├── services/            # API services
│   │   ├── context/             # Context providers
│   │   ├── hooks/               # Custom hooks
│   │   └── App.jsx
│   └── package.json
└── README.md
```

## Contributing

Feel free to submit issues and enhancement requests!

## License

MIT License
