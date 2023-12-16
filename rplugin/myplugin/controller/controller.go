package controller

import (
	"fmt"
	"myplugin/utils"
	"time"

	"github.com/martinlindhe/notify"
	"github.com/neovim/go-client/nvim/plugin"
	"github.com/xanzy/go-gitlab"
)

const NeovimStr = "neovim"
const PluginName = "mypluin"

type Controller struct {
	*plugin.Plugin
	gitlabCli *gitlab.Client
}

func NewController(p *plugin.Plugin) *Controller {
	ctrl := &Controller{
		Plugin: p,
	}
	client, err := gitlab.NewClient("edJh58BvMRzUkZcG69mR", gitlab.WithBaseURL("https://code.byted.org/"))
	if err != nil {
		ctrl.nvimNotify("plugin initial error", "```\ninitialize gitlab client error:  %v\n```", err)
		return ctrl
	}
	ctrl.gitlabCli = client
	return ctrl
}

func (ctrl *Controller) Serve() error {
	ctrl.HandleAutocmd(&plugin.AutocmdOptions{
		Event:   "VimEnter",
		Group:   "myplugin",
		Pattern: "*",
	}, func() {
		ctrl.startBackGroupJobs()
	})

	ctrl.HandleFunction(&plugin.FunctionOptions{Name: "Plugtest"}, ctrl.plugTest)
	ctrl.HandleFunction(&plugin.FunctionOptions{Name: "CreateMR"}, ctrl.createMR)
	ctrl.HandleFunction(&plugin.FunctionOptions{Name: "ListOpenedMR"}, ctrl.listOpenedMRs)
	ctrl.HandleFunction(&plugin.FunctionOptions{Name: "ApproveMR"}, ctrl.approveMR)
	return nil
}

func (ctrl *Controller) plugTest(args []string) (string, error) {
	defer func() {
		if e := recover(); e != nil {
			notify.Alert(NeovimStr, PluginName, fmt.Sprintf("panic: %v", utils.Marshal(e)), "")
		}
	}()
	content, _ := ctrl.getCursorFunction()
	ctrl.nvimNotify(PluginName, fmt.Sprintf("```go\n%v\n```", content))
	return "2", nil
}

func (ctrl *Controller) startBackGroupJobs() {
	go func() {
		for range time.Tick(time.Second * 10) {
			// notify.Notify("neovim", "", "该休息了哦", "")
			/*
				pos, err := ctrl.getPosition()
				if err != nil {
					ctrl.nvimNotify(PluginName, "getPosition err: %v", err)
					continue
				}
				ctrl.nvimNotify(PluginName, ctrl.Marshal(pos))
			*/
		}
	}()
}
