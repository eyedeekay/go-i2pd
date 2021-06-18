
i2pd_release_version=2.38.0

export GOPATH=$(HOME)/go
export USE_STATIC=yes

lib: clone libs

clone:
#	rm -rf "$(GOPATH)/src/github.com/eyedeekay/go-i2pd/goi2pd/i2pd"
#	git clone --depth=1 https://github.com/PurpleI2P/i2pd "$(GOPATH)/src/github.com/eyedeekay/go-i2pd/goi2pd/i2pd" -b $(i2pd_release_version)
	cp -v $(HOME)/Workspace/GIT_WORK/i2pd/libi2pd/capi.* "$(GOPATH)/src/github.com/eyedeekay/go-i2pd/goi2pd/i2pd/libi2pd/"

libs:
	cd "$(GOPATH)/src/github.com/eyedeekay/go-i2pd/goi2pd/i2pd" && \
		make api api_client
