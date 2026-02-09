COVERAGE_FILE=coverage.out
MIN_COVERAGE=80

.PHONY: test coverage check-coverage clean release

test:
	go test ./...

coverage:
	go test -coverprofile=$(COVERAGE_FILE) ./...
	go tool cover -func=$(COVERAGE_FILE)

check-coverage:
	go test -coverprofile=$(COVERAGE_FILE) ./...
	go tool cover -func=$(COVERAGE_FILE)
	@cov=$(shell go tool cover -func=$(COVERAGE_FILE) | awk '/^total:/ {print $$3+0}') ; \
	if [ $$(echo "$$cov < $(MIN_COVERAGE)" | bc) -eq 1 ]; then \
		echo "FAIL: coverage below $(MIN_COVERAGE)% ($$cov%)"; exit 1; \
	else \
		echo "PASS: coverage is $$cov%"; \
	fi

clean:
	rm -f $(COVERAGE_FILE)

release:
	git tag v$(VERSION)
	git push origin v$(VERSION)
