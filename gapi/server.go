package gapi

import (
	"fmt"
	"github.com/simplebank/pb"

	db "github.com/simplebank/db/sqlc"
	"github.com/simplebank/token"
	"github.com/simplebank/util"
)

// Server serves gRPC requests for our banking service.
type Server struct {
	pb.UnimplementedSimpleBankServer
	config util.Config
	store  db.Store
	token  token.Maker
}

// NewServer creates a new gRPC server and set up routing.
func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker:%w", err)
	}
	server := &Server{config: config, token: tokenMaker, store: store}
	return server, nil
}
