package controller

import (
	"fmt"
	"myplugin/utils"
	"net/url"
	"regexp"
	"strconv"

	"github.com/martinlindhe/notify"
	"github.com/xanzy/go-gitlab"
)

type createMRParam struct {
	Project      string
	Title        string
	Desc         string
	Source       string
	Target       string
	RemoveSource string
}

func (ctrl *Controller) createMR(args []string) (string, error) {
	defer func() {
		if e := recover(); e != nil {
			notify.Alert(NeovimStr, PluginName, fmt.Sprintf("panic: %v", utils.Marshal(e)), "")
		}
	}()
	param := &createMRParam{}
	if err := utils.TransferParameter(args, param); err != nil {
		ctrl.nvimNotify("create MRs", fmt.Sprintf("* parameter invalid: %v", err))
		return "", err
	}
	remove := param.RemoveSource == "true"
	mr, _, err := ctrl.gitlabCli.MergeRequests.CreateMergeRequest(param.Project, &gitlab.CreateMergeRequestOptions{
		Title:              &param.Title,
		Description:        &param.Desc,
		SourceBranch:       &param.Source,
		TargetBranch:       &param.Target,
		RemoveSourceBranch: &remove,
	})
	if err != nil {
		ctrl.nvimNotify("Create MRs", "* create mr error: %v\n", err)
		return "", err
	}
	ctrl.nvimNotify("Create MR", fmt.Sprintf("* %v\n", mr.WebURL))
	return mr.WebURL, nil
}

func (ctrl *Controller) listOpenedMRs(args []string) (string, error) {
	defer func() {
		if e := recover(); e != nil {
			notify.Alert(NeovimStr, PluginName, fmt.Sprintf("panic: %v", utils.Marshal(e)), "")
		}
	}()
	if len(args) < 1 {
		ctrl.nvimNotify("List MRs", "* parameter invalid\n")
		return "", nil
	}
	source := args[0]
	state := "opened"
	mrs, _, err := ctrl.gitlabCli.MergeRequests.ListMergeRequests(&gitlab.ListMergeRequestsOptions{
		SourceBranch: &source,
		State:        &state,
	})
	if err != nil {
		ctrl.nvimNotify("List MRs", "* list mr error: %v\n", err)
		return "", err
	}
	content := ""
	for _, mr := range mrs {
		content = fmt.Sprintf("%v* %v\n%v -> %v\n", content, mr.Title, mr.SourceBranch, mr.TargetBranch)
	}
	if len(mrs) == 0 {
		content = fmt.Sprintf("current branch %v has no MR", source)
	}
	ctrl.nvimNotify("List MR", content)
	return "", nil
}

type approveMRParam struct {
	URL string
}

var mrRegexp = regexp.MustCompile(`/([^/]+)/([^/]+)/merge_requests/(\d+)`)

func (ctrl *Controller) approveMR(args []string) (string, error) {
	defer func() {
		if e := recover(); e != nil {
			ctrl.nvimNotify("approve MR", fmt.Sprintf("* panic: %v", e))
		}
	}()
	param := &approveMRParam{}
	if err := utils.TransferParameter(args, param); err != nil {
		ctrl.nvimNotify("approve MR", fmt.Sprintf("* parameter invalid: %v", err))
		return "", err
	}
	u, err := url.Parse(param.URL)
	if err != nil {
		ctrl.nvimNotify("approve MR", fmt.Sprintf("* parse url(%s) err: %v", param.URL, err))
		return "", err
	}
	var mrID, project string
	mrMatchers := mrRegexp.FindStringSubmatch(u.Path)
	if len(mrMatchers) == 4 {
		project = mrMatchers[1] + "/" + mrMatchers[2]
		mrID = mrMatchers[3]
	}
	if mrID == "" {
		ctrl.nvimNotify("approve MR", fmt.Sprintf("* parse url(%s) mrID empty", param.URL))
		return "", nil
	}
	mr, _ := strconv.ParseInt(mrID, 10, 64)
	_, _, err = ctrl.gitlabCli.MergeRequestApprovals.ApproveMergeRequest(project, int(mr), &gitlab.ApproveMergeRequestOptions{})
	if err != nil {
		ctrl.nvimNotify("approve MR", fmt.Sprintf("* call approve mr url(%s) err: %v", param.URL, err))
		return "", err
	}
	ctrl.nvimNotify("approve MR", fmt.Sprintf("* approve mr url(%s) success", param.URL))
	return "", nil
}
