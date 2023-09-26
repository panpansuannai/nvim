module myplugin

go 1.19

require (
	github.com/martinlindhe/notify v0.0.0-20181008203735-20632c9a275a
	github.com/neovim/go-client v1.2.1
	github.com/xanzy/go-gitlab v0.91.1
)

require (
	github.com/deckarep/gosx-notifier v0.0.0-20180201035817-e127226297fb // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/google/go-querystring v1.1.0 // indirect
	github.com/hashicorp/go-cleanhttp v0.5.2 // indirect
	github.com/hashicorp/go-retryablehttp v0.7.2 // indirect
	github.com/nu7hatch/gouuid v0.0.0-20131221200532-179d4d0c4d8d // indirect
	golang.org/x/net v0.8.0 // indirect
	golang.org/x/oauth2 v0.6.0 // indirect
	golang.org/x/time v0.3.0 // indirect
	google.golang.org/appengine v1.6.7 // indirect
	google.golang.org/protobuf v1.29.1 // indirect
	gopkg.in/toast.v1 v1.0.0-20180812000517-0a84660828b2 // indirect
)

replace github.com/neovim/go-client => ./go-client@v1.2.1
