package api

import (
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/go-vgo/robotgo"
	"github.com/lpxxn/yoyo/robot-srv/env"
	"github.com/lpxxn/yoyo/robot-srv/tools"
)

// ensure that we've conformed to the `ServerInterface` with a compile-time check
var _ ServerInterface = (*Server)(nil)

type Server struct{}

func (s Server) PostScreenPwd(c *gin.Context) {
	param := &PostScreenPwdJSONRequestBody{}
	if err := c.ShouldBindJSON(param); err != nil {
		c.JSON(http.StatusOK, &CommonData{
			Code: "InvalidParam",
			Desc: "invalid param",
		})
		return
	}
	conf, _ := env.GetProdConfig()

	encryptKey, err := tools.ECBEncryptString(param.Pwd, conf.GetPWD().EncryptKey)
	if err != nil {
		c.JSON(http.StatusOK, &CommonData{
			Code: "InvalidParam",
			Desc: "invalid param",
		})
		return
	}
	conf.GetPWD().ScreenEncryptedPWD = encryptKey
	if err := env.SaveProdConfig(conf); err != nil {
		panic(err)
	}
	c.JSON(http.StatusOK, CommonData{
		Code: "OK",
	})
}

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

// GetUnlock Given permission to the Terminal app for Screen Recording and Accessibility under: System Settings > Privacy and Security >  Accessibility, Screen Recording.
func (s Server) GetUnlock(c *gin.Context) {
	robotgo.Click("left", true)
	//robotgo.MouseSleep = 100
	//robotgo.KeySleep = 100
	//err := robotgo.KeyTap(robotgo.Enter)
	//if err != nil {
	//	fmt.Print("keytap enter err", err)
	//}
	conf, _ := env.GetProdConfig()
	pwd, err := tools.ECBDecryptString(conf.GetPWD().ScreenEncryptedPWD, conf.GetPWD().EncryptKey)
	if err != nil {
		c.JSON(http.StatusOK, CommonData{
			Code: "Invalid PWD",
		})
		return
	}
	robotgo.TypeStr(pwd)
	robotgo.KeyTap(robotgo.Enter)
	c.JSON(http.StatusOK, CommonData{
		Code: "OK",
	})
}
