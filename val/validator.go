package val

import (
	"fmt"
	"net/mail"
	"regexp"
)

var (
	isValidateUserName = regexp.MustCompile(`^[a-z0-9_]+$`)
	isValidateFullName = regexp.MustCompile(`^[a-zA-Z\\s]+$`)
)

func ValidateString(value string, minLength, maxLength int) error {
	n := len(value)
	if n < minLength || n > maxLength {
		return fmt.Errorf("must contain from %d to %d", minLength, maxLength)
	}
	return nil
}

func ValidateUsername(value string) error {
	if err := ValidateString(value, 3, 100); err != nil {
		return err
	}
	if !isValidateUserName.MatchString(value) {
		return fmt.Errorf("username must only contain letters,digets,or underscores")
	}
	return nil
}

func ValidateFullName(value string) error {
	if err := ValidateString(value, 3, 100); err != nil {
		return err
	}
	if !isValidateFullName.MatchString(value) {
		return fmt.Errorf("full name must only contain letters,digets,or underscores")
	}
	return nil
}

func ValidatePassword(value string) error {
	return ValidateString(value, 6, 100)
}

func ValidateEmail(value string) error {
	if err := ValidateString(value, 3, 200); err != nil {
		return err
	}
	if _, err := mail.ParseAddress(value); err != nil {
		return fmt.Errorf("invalid email address")
	}
	return nil
}
