package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/knadh/koanf/parsers/toml"
	"github.com/knadh/koanf/providers/file"
	"github.com/knadh/koanf/v2"
	"github.com/lpxxn/yoyo/robot-srv/api"
	"github.com/lpxxn/yoyo/robot-srv/env"
)

// Global koanf instance. Use . as the key path delimiter. This can be / or anything.
var (
	k      = koanf.New(".")
	parser = toml.Parser()
)

func main() {
	//robotgo.TypeStr("Hello World")
	//robotgo.TypeStr("だんしゃり", 0, 1)
	//// robotgo.TypeStr("テストする")
	//
	//robotgo.TypeStr("Hi, Seattle space needle, Golden gate bridge, One world trade center.")
	//robotgo.TypeStr("Hi galaxy, hi stars, hi MT.Rainier, hi sea. こんにちは世界.")
	//robotgo.Sleep(1)
	//test := robotgo.CaptureImg(10, 10, 100, 100)
	//if err := robotgo.Save(test, "test.png"); err != nil {
	//	log.Fatal(err)
	//}
	//
	//robotgo.Scroll(0, -10)
	//robotgo.Scroll(100, 0)
	//
	//robotgo.MilliSleep(100)
	//robotgo.ScrollSmooth(-10, 6)
	//// robotgo.ScrollRelative(10, -100)
	//
	//robotgo.Move(10, 20)
	//robotgo.MoveRelative(0, -10)
	//robotgo.DragSmooth(10, 10)
	//
	//robotgo.Click("wheelRight")
	//robotgo.Click("left", true)
	//robotgo.Click("right", true)
	//robotgo.MoveSmooth(100, 200, 1.0, 10.0)
	//
	//robotgo.Toggle("right")
	//robotgo.Toggle("right", "up")
	// create a type that satisfies the `api.ServerInterface`, which contains an implementation of every operation from the generated code
	defaultConf := env.DefaultConfig()
	if err := k.Load(file.Provider("env/app.toml"), parser); err != nil {
		log.Fatalf("error loading config: %v", err)
	}
	type AppConf struct {
		PWD string `koanf:"pwd"`
	}
	conf := &AppConf{}
	if err := k.Unmarshal("", conf); err != nil {
		panic(err)
	}

	b, _ := k.Marshal(parser)
	fmt.Println(string(b))

	os.WriteFile("env/app.toml", b, 0755)

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
