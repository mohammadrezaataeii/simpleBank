package api

import (
	"github.com/gin-gonic/gin"

	db "github.com/simplebank/db/sqlc"
)

// Server serves HTTP requests for our banking service.
type Server struct {
	store  *db.Store
	router *gin.Engine
}

func NewServer(store *db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()
	server.router = router

	router.POST("/accounts", server.createAccount)

	return server
}
