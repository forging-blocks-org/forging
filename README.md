# Forging

## 🌱 Overview

> Not a framework — a **toolkit** of composable contracts and abstractions.

**ForgingBlocks** helps you create codebases that are:
- **Clean** — with clear boundaries and intent
- **Testable** — by design, through explicit interfaces
- **Maintainable** — by isolating concerns and dependencies

It doesn’t dictate your architecture.
Instead, it provides **foundations and reusable** abstractions for **forging** your own **blocks**.

Isolate external concerns from your core logic you will achieve systems that are adaptable and resilient.
If you **forge** your own **block** you will achieve software with intent and clarity
If you use **blocks** you will achieve consistency and reusability.
**ForgingBlocks** helps you build systems that last.

You can use it to:
- Learn and apply **architecture and design principles**
- Build **decoupled applications** that scale safely
- Model systems with **type safety and explicit intent**
- Experiment with **Clean**, **Hexagonal**, **DDD**, or **Message-Driven** styles

## Serialization

The `foundation/serialization` package provides transport-agnostic serialization via the `Serializable` interface:

```go
// Serializable defines a transport-agnostic interface for serialization.
type Serializable interface {
    ToData() ([]byte, error)
    FromData([]byte) error
}
```

A JSON implementation is provided:

```go
// JSONSerializable implements Serializable using JSON encoding.
type JSONSerializable struct {
    Value interface{}
}
```

### Testing

Tests for the JSON implementation are in `json_serializable_test.go`.
Run all tests with:

```
make test
```

Show coverage:

```
make coverage
```

Check and enforce minimum coverage (default 80%):

```
make check-coverage
```

Automate release tagging:

```
make release VERSION=0.1.0
```

## Contributor Instructions

- Run all tests before submitting a PR:
  ```
  make test
  ```
- Check and enforce code coverage:
  ```
  make check-coverage
  ```
- Do not commit coverage.out or build artifacts; these are ignored via .gitignore.
- Use idiomatic Go formatting and linting.
- For new features or bug fixes, add or update tests as needed.
