package env

import (
	"bytes"
	_ "embed"
	"fmt"
	"os"
	"path/filepath"

	"github.com/BurntSushi/toml"
	"github.com/lpxxn/yoyo/robot-srv/tools"
)

//go:embed default/config.toml
var defaultConfigContent string

const prodConfigFile = "env/prod/config.toml"

func DefaultConfig() (*Config, error) {
	config := &Config{}
	_, err := toml.Decode(defaultConfigContent, &config)
	if err != nil {
		return nil, err
	}
	return config, nil
}

func GetProdConfig() (*Config, error) {
	// Get the current working directory
	wd, err := os.Getwd()
	if err != nil {
		fmt.Println("Failed to get the current working directory:", err)
		return nil, err
	}

	fmt.Println("Current working directory:", wd)
	exeDir := filepath.Dir(wd)
	configFilePath := filepath.Join(exeDir, prodConfigFile)
	if err := tools.EnsureDir(filepath.Dir(configFilePath)); err != nil {
		return nil, err
	}
	_, err = os.Stat(configFilePath)
	if err == nil {
		config := &Config{}
		_, err = toml.DecodeFile(defaultConfigContent, &config)
		return config, nil
	} else {
		return DefaultConfig()
	}
}

func SaveProdConfig(config *Config) error {
	wd, err := os.Getwd()
	if err != nil {
		fmt.Println("Failed to get the current working directory:", err)
		return err
	}

	fmt.Println("Current working directory:", wd)
	exeDir := filepath.Dir(wd)

	configFilePath := filepath.Join(exeDir, prodConfigFile)
	if err := tools.EnsureDir(filepath.Dir(configFilePath)); err != nil {
		return err
	}

	buffer := bytes.Buffer{}
	if err := toml.NewEncoder(&buffer).Encode(config); err != nil {
		return err
	}
	return os.WriteFile(configFilePath, buffer.Bytes(), 0777)
}
