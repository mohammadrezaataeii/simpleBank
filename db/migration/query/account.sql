-- CREATE

-- name: CreateAccount :one
INSERT INTO accounts (
  owner,
  balance,
  currency 
) VALUES (
  $1, $2 , $3
) RETURNING *;


-- READ

-- name: GetAccount :one
SELECT * FROM accounts
WHERE id = $1 LIMIT 1;

-- name: ListAccounts :many
SELECT * FROM accounts
ORDER BY id
LIMIT $1
OFFSET $2;


-- UPDATE

-- name: UpdateAccount :one
UPDATE accounts SET balance = $2
WHERE id = $1
RETURNING *;

-- DELETE

-- name: DeleteAccount :exec
DELETE FROM accounts WHERE id = $1;