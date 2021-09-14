package main

import (
	"fmt"
	"os"

	"github.com/matsubara0507/sample-oapi-with-bazel/sample-app/server"
)

func main() {
	if err := run(); err != nil {
		fmt.Fprintf(os.Stderr, "%+v", err)
		os.Exit(1)
	}
	return
}

func run() error {
	s, err := server.NewServer()
	if err != nil {
		return err
	}
	return s.Start("8888")
}
