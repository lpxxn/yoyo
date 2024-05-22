package tools

import (
	"bytes"
	"crypto/aes"
	"encoding/base64"
)

// PKCS7Padding pads the plaintext to be a multiple of the block size.
func PKCS7Padding(data []byte, blockSize int) []byte {
	padding := blockSize - len(data)%blockSize
	padText := bytes.Repeat([]byte{byte(padding)}, padding)
	return append(data, padText...)
}

// PKCS7UnPadding removes the padding from the plaintext.
func PKCS7UnPadding(data []byte) []byte {
	length := len(data)
	unpadding := int(data[length-1])
	return data[:(length - unpadding)]
}

// ECBEncrypt encrypts data using ECB mode.
func ECBEncrypt(plainText, key []byte) ([]byte, error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	bs := block.BlockSize()
	plainText = PKCS7Padding(plainText, bs)
	cipherText := make([]byte, len(plainText))

	for start := 0; start < len(plainText); start += bs {
		block.Encrypt(cipherText[start:start+bs], plainText[start:start+bs])
	}

	return cipherText, nil
}
func ECBEncryptString(plainText, key string) (string, error) {
	cipherText, err := ECBEncrypt([]byte(plainText), []byte(key))
	if err != nil {
		return "", err
	}
	return base64.StdEncoding.EncodeToString(cipherText), nil
}
func ECBDecryptString(cipherText, key string) (string, error) {
	cipherTextBytes, err := base64.StdEncoding.DecodeString(cipherText)
	if err != nil {
		return "", err
	}
	rev, err := ECBDecrypt(cipherTextBytes, []byte(key))
	return string(rev), err
}

// ECBDecrypt decrypts data using ECB mode.
func ECBDecrypt(cipherText, key []byte) ([]byte, error) {
	block, err := aes.NewCipher(key)
	if err != nil {
		return nil, err
	}

	bs := block.BlockSize()
	plainText := make([]byte, len(cipherText))

	for start := 0; start < len(cipherText); start += bs {
		block.Decrypt(plainText[start:start+bs], cipherText[start:start+bs])
	}

	plainText = PKCS7UnPadding(plainText)
	return plainText, nil
}
