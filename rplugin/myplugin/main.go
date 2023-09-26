package main

import (
	"myplugin/controller"

	"github.com/neovim/go-client/nvim/plugin"
)

func main() {
	plugin.Main(func(p *plugin.Plugin) error {
		return controller.NewController(p).Serve()
	})
}
