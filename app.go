package main

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"net/http"
)

// App struct
type App struct {
	ctx context.Context
}

// NewApp creates a new App application struct
func NewApp() *App {
	return &App{}
}

// startup is called when the app starts. The context is saved
// so we can call the runtime methods
func (a *App) startup(ctx context.Context) {
	a.ctx = ctx
}

// Greet returns a greeting for the given name
func (a *App) Greet(name string) string {
	return fmt.Sprintf("Hello %s, It's show time!", name)
}

type Result struct {
	StatusCode   int    `json:"statusCode"`
	HttpStatus   string `json:"httpStatus"`
	BodyContent  string `json:"bodyContent"`
	ErrorContent string `json:"errorContent"`
}

func (a *App) Run(method string, url string, body string, contentType string) (Result, error) {
	var err error
	var result Result
	req, err := http.NewRequest(method, url, bytes.NewReader([]byte(body)))
	req.Header.Set("Content-Type", contentType)
	cli := http.Client{}
	response, err := cli.Do(req)
	if err != nil {
		return result, fmt.Errorf("http Do failed: %v", err)
	}
	defer response.Body.Close()
	result.StatusCode = response.StatusCode
	result.HttpStatus = response.Status
	buf, err := io.ReadAll(response.Body)
	if err != nil {
		return result, fmt.Errorf("read body error: %v", err)
	}

	result.BodyContent = string(buf)
	return result, nil

}
