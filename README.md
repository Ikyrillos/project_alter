# project_alter (dart frog) 

This is a simple project of Auth API using Dart_frog

## EndPoints

Main Endpoints:

- Registration flow
  - `POST /api/v1/auth/register` - Register a new user
  - `POST /api/v1/auth/login` - Login a user

 Explanation of the Endpoints:

- `POST /api/v1/auth/register` - Register a new user
  - Request Body:
    - `username` - String - Required
    - `password` - String - Required
    - `email` - String - Required
  - Response Body:
    - `username` - String
    - `email` - String
    - `token` - String
    - `id` - Integer
    - `message` - String

- `POST /api/v1/auth/login` - Login a user
  - Request Body:
    - `username` - String - Required
    - `password` - String - Required

  - Response Body:
    - `username` - String
    - `email` - String
    - `token` - String
    - `id` - Integer
    - `message` - String
