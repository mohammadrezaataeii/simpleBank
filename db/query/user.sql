-- CREATE

-- name: CreateUser :one
INSERT INTO users (
 username,
hashed_password,
full_name,
email
) VALUES (
  $1, $2 , $3, $4
) RETURNING *;


-- READ

-- name: GetUser :one
SELECT * FROM users
WHERE username = $1 LIMIT 1;

--set nullable parameters

-- name: UpdateUser :one
UPDATE users
SET hashed_password = COALESCE(sqlc.narg(hashed_password),hashed_password),
  full_name = COALESCE(sqlc.narg(full_name),full_name),
  email = COALESCE(sqlc.narg(email),email),
  username = sqlc.arg(username)
  RETURNING *;

