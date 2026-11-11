# 📡 API Documentation - Traveller Platform

Base URL: `http://localhost:8000/api`

## Authentication

All authenticated endpoints require a JWT token in the Authorization header:
```
Authorization: Bearer <your_access_token>
```

### Obtain Token
**POST** `/token/`

Request:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

Response:
```json
{
  "access": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

### Refresh Token
**POST** `/token/refresh/`

Request:
```json
{
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

---

## User Accounts

### Register
**POST** `/accounts/register/`

Request:
```json
{
  "email": "newuser@example.com",
  "username": "traveler123",
  "password": "securepassword",
  "password2": "securepassword",
  "first_name": "John",
  "last_name": "Doe"
}
```

### Get Current User
**GET** `/accounts/current/` 🔒

Response:
```json
{
  "id": 1,
  "email": "user@example.com",
  "username": "traveler123",
  "first_name": "John",
  "last_name": "Doe",
  "profile": {
    "bio": "Travel enthusiast",
    "location": "New York",
    "countries_visited": 15,
    "cities_visited": 42
  }
}
```

### Get User Profile
**GET** `/accounts/<username>/`

### Update Profile
**PUT/PATCH** `/accounts/profile/update/` 🔒

Request:
```json
{
  "bio": "Love exploring new places!",
  "location": "San Francisco",
  "website": "https://mysite.com"
}
```

---

## Destinations

### List Destinations
**GET** `/destinations/`

Query Parameters:
- `search` - Search by name, description, city
- `category` - Filter by category (mountain, beach, historical, etc.)
- `country` - Filter by country
- `city` - Filter by city
- `ordering` - Sort by: average_rating, total_reviews, views, created_at

Example:
```
GET /destinations/?category=beach&country=Greece&ordering=-average_rating
```

Response:
```json
{
  "count": 42,
  "next": "http://localhost:8000/api/destinations/?page=2",
  "previous": null,
  "results": [
    {
      "id": 1,
      "name": "Santorini",
      "city": "Santorini",
      "country": "Greece",
      "category": "beach",
      "main_image": "http://...",
      "average_rating": 4.8,
      "total_reviews": 124,
      "views": 1523
    }
  ]
}
```

### Get Destination Detail
**GET** `/destinations/<id>/`

Response:
```json
{
  "id": 1,
  "name": "Santorini",
  "description": "Beautiful Greek island...",
  "country": "Greece",
  "state": "",
  "city": "Santorini",
  "category": "beach",
  "latitude": "36.3932",
  "longitude": "25.4615",
  "main_image": "http://...",
  "images": [...],
  "average_rating": 4.8,
  "total_reviews": 124,
  "views": 1523,
  "is_saved": true,
  "created_at": "2025-01-01T10:00:00Z"
}
```

### Create Destination
**POST** `/destinations/` 🔒

Request:
```json
{
  "name": "Machu Picchu",
  "description": "Ancient Incan citadel...",
  "country": "Peru",
  "city": "Cusco",
  "category": "historical",
  "latitude": -13.1631,
  "longitude": -72.5450
}
```

### Save Destination
**POST** `/destinations/<id>/save/` 🔒

### Unsave Destination
**POST** `/destinations/<id>/unsave/` 🔒

### Get Saved Destinations
**GET** `/destinations/saved/` 🔒

### Get Popular Destinations
**GET** `/destinations/popular/`

### Get Categories
**GET** `/destinations/categories/`

Response:
```json
[
  {"value": "mountain", "label": "Mountain"},
  {"value": "beach", "label": "Beach"},
  {"value": "historical", "label": "Historical"}
]
```

---

## Blog Posts

### List Posts
**GET** `/posts/`

Query Parameters:
- `search` - Search by title, content
- `destination` - Filter by destination ID
- `author` - Filter by author ID
- `rating` - Filter by rating (1-5)
- `ordering` - Sort by: created_at, likes_count, comments_count, views

Response:
```json
{
  "count": 156,
  "results": [
    {
      "id": 1,
      "title": "Amazing Trip to Paris",
      "content": "Just returned from...",
      "destination": 5,
      "destination_name": "Eiffel Tower",
      "author_username": "traveler123",
      "rating": 5,
      "featured_image": "http://...",
      "likes_count": 42,
      "comments_count": 15,
      "views": 234,
      "is_liked": true,
      "created_at": "2025-01-15T14:30:00Z"
    }
  ]
}
```

### Get Post Detail
**GET** `/posts/<id>/`

Response includes full post with comments:
```json
{
  "id": 1,
  "title": "Amazing Trip to Paris",
  "content": "Full post content...",
  "destination": {
    "id": 5,
    "name": "Eiffel Tower",
    "city": "Paris"
  },
  "author_username": "traveler123",
  "rating": 5,
  "images": [...],
  "comments": [
    {
      "id": 1,
      "author_username": "user2",
      "content": "Great post!",
      "created_at": "2025-01-16T10:00:00Z",
      "replies": []
    }
  ],
  "likes_count": 42,
  "is_liked": true
}
```

### Create Post
**POST** `/posts/` 🔒

Request (multipart/form-data):
```
title: "My Trip to Tokyo"
content: "Amazing experience..."
destination: 3
rating: 5
featured_image: [file]
```

### Like Post
**POST** `/posts/<id>/like/` 🔒

### Unlike Post
**POST** `/posts/<id>/unlike/` 🔒

### Add Comment
**POST** `/posts/<id>/add_comment/` 🔒

Request:
```json
{
  "content": "Great post! Thanks for sharing.",
  "parent": null  // or parent comment ID for replies
}
```

### Get My Posts
**GET** `/posts/my_posts/` 🔒

### Get Popular Posts
**GET** `/posts/popular/`

---

## Reviews

### List Reviews
**GET** `/reviews/`

Query Parameters:
- `destination` - Filter by destination ID
- `user` - Filter by user ID
- `rating` - Filter by rating (1-5)
- `ordering` - Sort by: created_at, rating, helpful_count

Response:
```json
{
  "count": 89,
  "results": [
    {
      "id": 1,
      "destination": 1,
      "destination_name": "Santorini",
      "user_username": "traveler123",
      "rating": 5,
      "title": "Absolutely Amazing!",
      "review_text": "Best place I've ever visited...",
      "visit_date": "2024-12-01",
      "helpful_count": 23,
      "is_helpful": true,
      "created_at": "2025-01-10T09:00:00Z"
    }
  ]
}
```

### Create Review
**POST** `/reviews/` 🔒

Request:
```json
{
  "destination": 1,
  "rating": 5,
  "title": "Wonderful Experience",
  "review_text": "Had an amazing time...",
  "visit_date": "2024-12-15"
}
```

Note: One review per user per destination.

### Mark Review as Helpful
**POST** `/reviews/<id>/helpful/` 🔒

### Unmark Review as Helpful
**POST** `/reviews/<id>/unhelpful/` 🔒

### Get Destination Review Stats
**GET** `/reviews/destination_stats/?destination=<id>`

Response:
```json
{
  "average_rating": 4.65,
  "total_reviews": 124,
  "rating_distribution": {
    "1": 2,
    "2": 5,
    "3": 18,
    "4": 43,
    "5": 56
  }
}
```

### Get My Reviews
**GET** `/reviews/my_reviews/` 🔒

---

## Response Codes

- `200 OK` - Request successful
- `201 Created` - Resource created successfully
- `400 Bad Request` - Invalid request data
- `401 Unauthorized` - Authentication required
- `403 Forbidden` - Permission denied
- `404 Not Found` - Resource not found
- `500 Internal Server Error` - Server error

---

## Pagination

All list endpoints support pagination:
- Default page size: 12 items
- Use `?page=2` to get next page
- Response includes `next` and `previous` URLs

Example:
```json
{
  "count": 156,
  "next": "http://localhost:8000/api/posts/?page=2",
  "previous": null,
  "results": [...]
}
```

---

## Rate Limiting

Currently no rate limiting is implemented for development. 
In production, consider implementing rate limiting to prevent abuse.

---

## Testing with cURL

### Login
```bash
curl -X POST http://localhost:8000/api/token/ \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"password123"}'
```

### Get Destinations
```bash
curl http://localhost:8000/api/destinations/
```

### Create Post (with auth)
```bash
curl -X POST http://localhost:8000/api/posts/ \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"title":"My Trip","content":"...","destination":1,"rating":5}'
```

---

## WebSocket Support

Currently not implemented. Future features may include:
- Real-time notifications
- Live chat
- Real-time comment updates

---

🔒 = Authentication Required
