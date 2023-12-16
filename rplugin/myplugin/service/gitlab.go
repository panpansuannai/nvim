package service

import "github.com/xanzy/go-gitlab"

type GitLabService struct {
	gitlabCli *gitlab.Client
}

func (s *GitLabService) CreateMR(argss []string) ([]string, error) {
}
