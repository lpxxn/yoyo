package tools

import (
	"fmt"
	"os"
	"path/filepath"
)

func FindFileRealPath(startDir, targetFile string) (string, error) {
	dir := startDir
	for {
		// Check if the target file exists in the current directory
		filePath := filepath.Join(dir, targetFile)
		_, err := os.Stat(filePath)
		if err == nil {
			return filePath, nil
		}

		// Move up one directory
		parentDir := filepath.Dir(dir)
		if parentDir == dir {
			return "", fmt.Errorf("target file not found")
		}
		dir = parentDir
	}
}

func EnsureDir(dirName string) error {
	err := os.MkdirAll(dirName, os.ModeDir)
	if err == nil || os.IsExist(err) {
		return nil
	} else {
		return err
	}
}
