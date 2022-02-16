
#GO111MODULE=off
#export GO111MODULE=off

i2pd_prerelease_version=c-wrapper-libi2pd-api
i2pd_release_version=2.40.0

VERSION=$(i2pd_release_version)

export GOPATH=$(HOME)/go

export USE_STATIC=yes
USE_STATIC=yes

export LDFLAGS=-static
LDFLAGS=-static

GXXFLAGS=-static
export GXXFLAGS=-static

CXXFLAGS=-static
export CXXFLAGS=-static

CGO_GXXFLAGS=-static
export CGO_GXXFLAGS=-static

CGO_CFLAGS=-static
export CGO_CFLAGS=-static

CGO_CXXFLAGS=-static
export CGO_CXXFLAGS=-static

CGO_CPPFLAGS=-static
export CGO_CPPFLAGS=-static

#CGO_LDFLAGS=-static
#export CGO_LDFLAGS=-static


#OK OSX builds can work now on OSX machines which was probably going to happen all along. Windows next.
# That's going to suuuuuuuuuuuuuuck.
export LINUXFLAGS=$(shell which hdiutil || echo /usr/lib/x86_64-linux-gnu/libboost_system.a /usr/lib/x86_64-linux-gnu/libboost_date_time.a /usr/lib/x86_64-linux-gnu/libboost_filesystem.a /usr/lib/x86_64-linux-gnu/libboost_program_options.a /usr/lib/x86_64-linux-gnu/libssl.a /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/lib/x86_64-linux-gnu/libz.a)
export OSXFLAGS=$(shell which hdiutil && echo /usr/local/opt/boost/lib/libboost_system.a /usr/local/opt/boost/lib/libboost_date_time.a /usr/local/opt/boost/lib/libboost_filesystem.a /usr/local/opt/boost/lib/libboost_program_options.a /usr/local/opt/openssl@1.1/lib/libssl.a /usr/local/opt/openssl@1.1/lib/libcrypto.a)

FLAGS=$(OSXFLAGS) $(LINUXFLAGS)

echo:
	echo $(FLAGS)

go-i2pd:
	git clone https://github.com/eyedeekay/go-i2pd go-i2pd

example: fmt lib wrapper
	go build -x -v --tags=netgo \
		-ldflags '-w -linkmode=external -extldflags "-static -ldl $(FLAGS)"' 2>&1 | tee -a make.log

fmt:
	find . -name '*.go' -exec gofmt -w -s {} \;

lib: i2pd/i2pd
	rm -rf i2pd/.git i2pd/i2pd i2pd/obj
	cp gitignore-i2pd i2pd/.gitignore
	git add i2pd/*

osxlib:
	echo /usr/local/opt/boost/lib/libboost_system.a /usr/local/opt/boost/lib/libboost_date_time.a /usr/local/opt/boost/lib/libboost_filesystem.a /usr/local/opt/boost/lib/libboost_program_options.a /usr/local/opt/openssl@1.1/lib/libssl.a /usr/local/opt/openssl@1.1/lib/libcrypto.a

i2pd/i2pd: i2pd
	cd i2pd && make

i2pd: 
	git clone https://github.com/PurpleI2P/i2pd --branch $(i2pd_release_version) --single-branch i2pd

wrapper: i2pd/i2pd
	cd i2pd && make libi2pdwrapper.a

clean:
	rm -rf go-i2pd i2pd

#echo:
#	echo gothub release -p -u eyedeekay -r $(BINARY) -t "$(VERSION)" -d "`cat README.md`"; true

#version:
#	gothub release -p -u eyedeekay -r $(BINARY) -t "$(VERSION)" -d "`cat README.md`"; true