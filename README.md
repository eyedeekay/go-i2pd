go-i2pd static bindings for Go and libi2pd
==========================================

Creating dynamically linked embedded i2pd builds on Go is possible
using only the SWIG binding in libi2pd_wrapper, but achieving a static
build requires a little more effort. This repository contains the code
required to generate the static libraries for libi2pd and connect them
to the Go wrappers, as well as an API for embedding i2pd in Go
applications.

Slight alterations to this procedure may be required to account for
differences between applications. This is not intended to be a an app
for general use but a demonstration of how to set up an i2pd router
embedded in a Go application.

Cross compilation from Linux to Windows will be supported through [MXE](https://mxe.cc/#tutorial)
for now. Static resources may be included in the future if there is a
clear way to keep them up to date obviating the need for MXE.

Using this repository:
----------------------

First, install the `build-depends` required for i2pd, then add these variables
to your Makefile or export them to your build environment.

``` Makefile
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
LINUXFLAGS=$(which hdiutil || echo /usr/lib/x86_64-linux-gnu/libboost_system.a /usr/lib/x86_64-linux-gnu/libboost_date_time.a /usr/lib/x86_64-linux-gnu/libboost_filesystem.a /usr/lib/x86_64-linux-gnu/libboost_program_options.a /usr/lib/x86_64-linux-gnu/libssl.a /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/lib/x86_64-linux-gnu/libz.a)
OSXFLAGS=$(which hdiutil && echo /usr/local/opt/boost/lib/libboost_system.a /usr/local/opt/boost/lib/libboost_date_time.a /usr/local/opt/boost/lib/libboost_filesystem.a /usr/local/opt/boost/lib/libboost_program_options.a /usr/local/opt/openssl@1.1/lib/libssl.a /usr/local/opt/openssl@1.1/lib/libcrypto.a)
FLAGS="$(OSXFLAGS) $(LINUXFLAGS)"
```

Then, clone the git repository into your project root:

``` bash
git clone https://github.com/eyedeekay/go-i2pd
```

After that, add the following lines to your `go.mod`

``` Go
require github.com/eyedeekay/go-i2pd v0.0.0-20220213070306-9807541b2dfc

replace github.com/eyedeekay/go-i2pd v0.0.0-20220213070306-9807541b2dfc => ./go-i2pd 
```

Now you're all set up to build the software. You can now use
the go-i2pd API.

``` Go
package main

import (
	"time"

	i2pd "github.com/eyedeekay/go-i2pd/goi2pd"
)

func main() {
    // Calling i2pd will return a function which you must defer and close with your application
	closer := i2pd.InitI2PSAM()
    // It de-allocates the arguments used to initialize libi2pd
	defer closer()
    // Start the i2pd router
	i2pd.StartI2P()
    // Wait a little while
	time.Sleep(time.Hour)
    // Stop the i2pd router
	i2pd.StopI2P()
}
```
