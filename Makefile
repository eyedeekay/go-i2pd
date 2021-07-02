
i2pd_release_version=2.38.0

export GOPATH=$(HOME)/go

export USE_STATIC=yes
USE_STATIC=yes

#Trying to achieve fully-static builds, this doesn't work yet.
#FLAGS=-static /usr/lib/x86_64-linux-gnu/libboost_system.a /usr/lib/x86_64-linux-gnu/libboost_date_time.a /usr/lib/x86_64-linux-gnu/libboost_filesystem.a /usr/lib/x86_64-linux-gnu/libboost_program_options.a /usr/lib/x86_64-linux-gnu/libssl.a /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/lib/x86_64-linux-gnu/libz.a

example: fmt
	go build -tags netgo -x -v -a \
		-ldflags '-w -extldflags "$(FLAGS)"' 2>&1 | tee -a make.log

fmt:
	find . -name '*.go' -exec gofmt -w -s {} \;