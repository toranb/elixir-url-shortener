# Url Shortener

Elixir web application to help me learn Phoenix, Ecto and OTP

## Installation

Clone this repository and install the deps with mix

```
mix deps.get
```

Create the database and run migrations

```
mix ecto.create
mix ecto.migrate
```

Spin up Phoenix from the command line

```
iex -S mix phx.server
```

Create a user to login with

```
curl --request POST \
--url http://localhost:4000/api/users \
--header 'content-type: application/json' \
--data '{"user": {"username": "toranb", "password": "abc123"}}'
```

Login with the username and password above

```
curl --request POST \
--url http://localhost:4000/login \
--data 'username=toranb&password=abc123' \
--verbose
```

Take the set-cookie value from the login above^ and create a short url

```
curl --request POST \
--url http://localhost:4000/api/urls \
--header 'content-type: application/json' \
--data '{"link": {"url": "google.com"}}' \
--cookie '_example_key=FOO;'
```

With each evolution and learning included here I blog about it at [https://toranbillups.com](https://toranbillups.com)
