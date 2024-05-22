package tools

import (
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
