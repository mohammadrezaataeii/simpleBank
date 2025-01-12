package gapi

import "google.golang.org/genproto/googleapis/rpc/errdetails"

func fieldValidation(field string, err error) *errdetails.BadRequest_FieldViolation {
	return &errdetails.BadRequest_FieldViolation{
		Field:       field,
		Description: err.Error(),
	}
}

func invalidArgumentError(validations []*errdetails.BadRequest_FieldViolation) error {
	badrequests := make([]*errdetails.BadRequest_FieldViolation, 0, len(validations))
}
