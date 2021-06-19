
i2pd_release_version=2.38.0

export GOPATH=$(HOME)/go
export USE_STATIC=yes

example:
	go build -x -v -a
