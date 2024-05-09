package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/go-vgo/robotgo"
)

// ensure that we've conformed to the `ServerInterface` with a compile-time check
var _ ServerInterface = (*Server)(nil)

type Server struct{}

func NewServer() Server {
	return Server{}
}

// (GET /ping)
func (Server) GetPing(c *gin.Context) {
	resp := Pong{
		Ping: "pong",
	}

	c.JSON(http.StatusOK, resp)
}

func (s Server) GetUnlock(c *gin.Context) {
	robotgo.Click("left", true)
	//robotgo.MouseSleep = 100
	//robotgo.KeySleep = 100
	//err := robotgo.KeyTap(robotgo.Enter)
	//if err != nil {
	//	fmt.Print("keytap enter err", err)
	//}
	robotgo.TypeStr("1231234")
	robotgo.KeyTap(robotgo.Enter)
	//robotgo.Move(100, 200)
	////robotgo.MoveRelative(0, -10)
	//robotgo.MilliSleep(100)
	//robotgo.KeyToggle("a")
	//robotgo.KeyToggle("a", "up")
	c.JSON(http.StatusOK, CommonData{
		Code: "OK",
	})
}
