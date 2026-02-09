package foundation

type Serializable interface {
	ToData() ([]byte, error)
	FromData([]byte) error
}
