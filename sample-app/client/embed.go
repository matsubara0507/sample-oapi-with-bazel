package client

import (
	"embed"
	"io/fs"
	"net/http"
)

//go:embed index.html
var indexHtmlFile []byte

func EmbedIndexHtml() []byte {
	return indexHtmlFile
}

//go:embed dist/*
var mainJavaScriptFile embed.FS

func EmbedFileSystem() (http.FileSystem, error) {
	f, err := fs.Sub(mainJavaScriptFile, "dist")
	if err != nil {
		return nil, err
	}
	return http.FS(f), nil
}

func EmbedFileServerHandler(prefix string) (http.Handler, error) {
	f, err := EmbedFileSystem()
	if err != nil {
		return nil, err
	}
	return http.StripPrefix(prefix, http.FileServer(f)), nil
}
