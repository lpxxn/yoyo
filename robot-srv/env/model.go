package env

type IConfig interface {
	GetPWD() *PWDInfo
}
type Config struct {
	PWD *PWDInfo `toml:"pwd"`
}

func (c *Config) GetPWD() *PWDInfo {
	return c.PWD
}

type PWDInfo struct {
	EncryptKey         string `toml:"encryptKey"`
	ScreenEncryptedPWD string `toml:"screenEncryptedPWD"`
}
