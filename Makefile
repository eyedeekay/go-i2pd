
#GO111MODULE=off
#export GO111MODULE=off

i2pd_prerelease_version=c-wrapper-libi2pd-api
i2pd_release_version=2.38.0

export GOPATH=$(HOME)/go

export USE_STATIC=yes
USE_STATIC=yes

GXXFLAGS=-static
LDFLAGS=-static
export GXXFLAGS=-static
export LDFLAGS=-static

#Trying to achieve fully-static builds, this doesn't work yet.
FLAGS= /usr/lib/x86_64-linux-gnu/libboost_system.a /usr/lib/x86_64-linux-gnu/libboost_date_time.a /usr/lib/x86_64-linux-gnu/libboost_filesystem.a /usr/lib/x86_64-linux-gnu/libboost_program_options.a /usr/lib/x86_64-linux-gnu/libssl.a /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/lib/x86_64-linux-gnu/libz.a

example: fmt clean lib
	go build -x -v -a \
		-ldflags '-w -extldflags "$(FLAGS)"' 2>&1 | tee -a make.log

fmt:
	find . -name '*.go' -exec gofmt -w -s {} \;

lib: i2pd/i2pd
	rm -rf i2pd/.git i2pd/i2pd i2pd/obj
	cp gitignore-i2pd i2pd/.gitignore
	git add i2pd/*

i2pd/i2pd: i2pd
	cd i2pd && make

i2pd: 
	git clone git@github.com:eyedeekay/i2pd -b $(i2pd_prerelease_version) i2pd

clean:
	rm -rf go-i2pd i2pd