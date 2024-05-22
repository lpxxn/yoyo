package tools

import (
	"crypto/aes"
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"testing"
)

func TestEncrypt(t *testing.T) {
	key := "examplekey123456" // 16 bytes for AES-128
	plainText := "Hello, World!"

	// Encrypt the plaintext
	encrypted, err := ECBEncryptString(plainText, key)
	if err != nil {
		fmt.Println("Error encrypting:", err)
		return
	}
	fmt.Println("Encrypted:", encrypted)

	// Decrypt the ciphertext
	decrypted, err := ECBDecryptString(encrypted, key)
	if err != nil {
		fmt.Println("Error decrypting:", err)
		return
	}
	fmt.Println("Decrypted:", decrypted)
}

const (
	blockSize = 16
	keySize   = 32
)

func TestEncrypt1(t *testing.T) {
	// Generate a random key
	key := make([]byte, keySize)
	_, err := rand.Read(key)
	if err != nil {
		fmt.Println(err)
		return
	}

	// Set the plaintext
	plaintext := []byte("Hello, World!")

	// Encrypt the plaintext
	block, err := aes.NewCipher(key)
	if err != nil {
		fmt.Println(err)
		return
	}
	ciphertext := make([]byte, len(plaintext))
	block.Encrypt(ciphertext, plaintext)

	// Print the ciphertext
	fmt.Println(base64.StdEncoding.EncodeToString(ciphertext))

	// Decrypt the ciphertext
	block, err = aes.NewCipher(key)
	if err != nil {
		fmt.Println(err)
		return
	}
	decrypted := make([]byte, len(ciphertext))
	block.Decrypt(decrypted, ciphertext)

	// Print the decrypted plaintext
	fmt.Println(string(decrypted))
}
