package util

import (
	"math/rand"
	"strings"
)

const alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

// RandomInt returns a random integer between min and max (inclusive)
func RandomInt(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

/*
RandomString returns a random string of length n by randomly selecting characters
from a predefined alphabet of uppercase and lowercase letters. It uses math/rand
to generate random indices into the alphabet string and builds the result using
strings.Builder for efficient string concatenation.
*/
func RandomString(n int) string {
	var sb strings.Builder
	k := len(alphabet)

	for i := 0; i < n; i++ {
		c := alphabet[rand.Intn(k)]
		sb.WriteByte(c)
	}

	return sb.String()
}

// RandomOwner generates a random 6-character string for account owner names
func RandomOwner() string {
	return RandomString(6)
}

// RandomMoney generates a random amount of money between 0 and 1000 units
// of the smallest currency denomination (e.g. cents for USD)
func RandomMoney() int64 {
	return RandomInt(0, 1000)
}

// RandomCurrency returns a random currency code from a predefined list of supported currencies
func RandomCurrency() string {
	currencies := []string{"USD", "EUR", "CAD"}
	n := len(currencies)
	return currencies[rand.Intn(n)]
}
