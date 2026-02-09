package foundation

import (
	"encoding/json"
)

type JSONSerializable struct {
 	 Value interface{}
}

func (j *JSONSerializable) ToData() ([]byte, error) {
 	 return json.Marshal(j.Value)
}

func (j *JSONSerializable) FromData(data []byte) error {
 	 return json.Unmarshal(data, &j.Value)
}
