package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/lpxxn/yoyo/robot-srv/api"
	"github.com/lpxxn/yoyo/robot-srv/env"
)

func main() {
	config, err := env.GetProdConfig()
	log.Println(config, err)
	//if err := env.SaveProdConfig(config); err != nil {
	//	panic(err)
	//}
	server := api.NewServer()
	r := gin.Default()
	api.RegisterHandlers(r, server)

	// And we serve HTTP until the world ends.
	addr := "0.0.0.0:9087"
	s := &http.Server{
		Handler: r,
		Addr:    addr,
	}
	fmt.Printf("run at %s\n", "http://127.0.0.1:9087")
	// And we serve HTTP until the world ends.
	log.Fatal(s.ListenAndServe())
}
