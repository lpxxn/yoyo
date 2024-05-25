package env

type Config struct {
	PWD PWDInfo `toml:"pwd"`
}

type PWDInfo struct {
	EncryptKey         string `toml:"encryptKey"`
	ScreenEncryptedPWD string `toml:"screenEncryptedPWD"`
}
