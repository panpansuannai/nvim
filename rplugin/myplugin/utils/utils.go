package utils

import (
	"encoding/json"
	"fmt"
	"reflect"
)

func Marshal(target interface{}) string {
	s, _ := json.Marshal(target)
	return string(s)
}

func TransferParameter(param []string, v any) error {
	val := reflect.ValueOf(v)
	if val.Kind() == reflect.Ptr {
		val = val.Elem()
	}
	if val.Kind() != reflect.Struct {
		return fmt.Errorf("not struct")
	}
	fieldNum := val.NumField()
	for i := 0; i < fieldNum; i++ {
		if len(param) < i {
			break
		}
		if err := json.Unmarshal([]byte(`"`+param[i]+`"`), val.Field(i).Addr().Interface()); err != nil {
			return err
		}
	}
	return nil
}
