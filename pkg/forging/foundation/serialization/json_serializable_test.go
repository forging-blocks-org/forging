package serialization

import (
    "testing"
)

type testStruct struct {
    Name string
    Age  int
}

func TestJSONSerializable_ToDataAndFromData(t *testing.T) {
    original := &JSONSerializable{Value: testStruct{Name: "Alice", Age: 30}}
    data, err := original.ToData()
    if err != nil {
        t.Fatalf("ToData failed: %v", err)
    }

    copy := &JSONSerializable{Value: &testStruct{}}
    err = copy.FromData(data)
    if err != nil {
        t.Fatalf("FromData failed: %v", err)
    }

    result, ok := copy.Value.(*testStruct)
    if !ok {
        t.Fatalf("Type assertion failed")
    }
    if result.Name != "Alice" || result.Age != 30 {
        t.Errorf("Expected Alice, 30; got %s, %d", result.Name, result.Age)
    }
}
