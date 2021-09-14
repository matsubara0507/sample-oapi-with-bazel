package server

import (
	"fmt"
	"net/http"
	"sync"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	front "github.com/matsubara0507/sample-oapi-with-bazel/sample-app/client"
	"github.com/pkg/errors"
)

type Server struct {
	mu     sync.RWMutex
	maxId  int
	todos  map[int]*ToDo
	server *echo.Echo
}

func (s *Server) Start(port string) error {
	return s.server.Start(fmt.Sprintf(":%s", port))
}

func NewServer() (*Server, error) {
	s := &Server{
		todos:  make(map[int]*ToDo),
		server: echo.New(),
	}
	s.server.Use(middleware.Logger())

	RegisterHandlers(s.server.Group("/api"), s)

	staticHandler, err := front.EmbedFileServerHandler("/static/")
	if err != nil {
		return nil, errors.WithStack(err)
	}
	s.server.GET("/static/*", echo.WrapHandler(staticHandler))
	s.server.GET("/*", s.indexHandler)

	return s, nil
}

func (s *Server) AllToDos() []*ToDo {
	todos := make([]*ToDo, 0)
	s.mu.RLock()
	defer s.mu.RUnlock()
	for _, todo := range s.todos {
		todos = append(todos, todo)
	}
	return todos
}

func (s *Server) CreateToDo(todo *ToDo) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.maxId += 1
	todo.Id = s.maxId
	s.todos[s.maxId] = todo
	return
}

func (s *Server) UpdateToDo(todo *ToDo) {
	s.mu.Lock()
	defer s.mu.Unlock()
	s.todos[todo.Id] = todo
	return
}

func (s *Server) DeleteToDo(todoId int) {
	s.mu.Lock()
	defer s.mu.Unlock()
	delete(s.todos, todoId)
	return
}

func (s *Server) GetTodos(ctx echo.Context) error {
	return ctx.JSON(http.StatusOK, s.AllToDos())
}

func (s *Server) PostTodos(ctx echo.Context) error {
	todo := new(ToDo)
	if err := ctx.Bind(todo); err != nil {
		return echo.ErrBadRequest
	}
	s.CreateToDo(todo)
	return ctx.JSON(http.StatusOK, todo)
}

func (s *Server) DeleteTodosTodoId(ctx echo.Context, todoId int) error {
	s.DeleteToDo(todoId)
	return ctx.NoContent(http.StatusNoContent)
}

func (s *Server) PutTodosTodoId(ctx echo.Context, todoId int) error {
	todo := new(ToDo)
	if err := ctx.Bind(todo); err != nil {
		return echo.ErrBadRequest
	}
	todo.Id = todoId
	s.UpdateToDo(todo)
	return ctx.NoContent(http.StatusNoContent)
}

func (s *Server) indexHandler(ctx echo.Context) error {
	return ctx.HTMLBlob(http.StatusOK, front.EmbedIndexHtml())
}
