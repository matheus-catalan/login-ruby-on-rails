
## API Reference

#### Get user

```http
  GET /api/users
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `token`   | `bearer` | **Required**.              |

#### Get all users

```http
  GET /api/index/users
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `token`   | `bearer` | **Required**.              |

#### Update user

```http
  PUT /api/users
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `token`   | `bearer` | **Required**.              |

#### Create user
```http
  STORE /api/users
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `password`| `string` | **Required**.              |
| `email`   | `string` | **Required**.              |

#### Delete user

```http
  DELETE /api/users
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `userId`  | `integer`| **Required**.              |

#### Login

```http
  STORE /api/login
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `password`| `string` | **Required**.              |
| `email`   | `string` | **Required**.              |

#### Forgot password

```http
  STORE /api/forgot/password
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `email`   | `string` | **Required**.              |

#### Update password

```http
  STORE /api/forgot/password/save
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `password`| `string` | **Required**.              |
| `email`   | `string` | **Required**.              |




## Deployment

To deploy this project run

```bash
  git clone https://github.com/matheus-catalan/login-ruby-on-rails.git
  docker-compose up --build -d 
```

## Authors

- [@katherinepeterson](https://www.github.com/katherinepeterson)