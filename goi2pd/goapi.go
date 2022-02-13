package i2pd

import (
	"os"

	api "github.com/eyedeekay/go-i2pd/i2pd/libi2pd_wrapper"
)

// #cgo CFLAGS: -I${SRCDIR}/../i2pd/libi2pd_wrapper
// #cgo CXXFLAGS: -I${SRCDIR}/../i18n -I${SRCDIR}/../libi2pd_client -I${SRCDIR}/../libi2pd -g -Wall -Wextra -Wno-unused-parameter -pedantic -Wno-psabi -fPIC -D__AES__ -maes
// #cgo LDFLAGS: -L${SRCDIR}/../ -l:./i2pd/libi2pdclient.a -l:./i2pd/libi2pdwrapper.a -l:./i2pd/libi2pd.a -l:./i2pd/libi2pdlang.a -latomic -lcrypto -lssl -lz -lboost_system -lboost_date_time -lboost_filesystem -lboost_program_options -lpthread -lstdc++
//
// #include <stdlib.h>
// #include "../i2pd/libi2pd_wrapper/capi.h"
//
// static void *AllocArgv(int argc) {
//     return malloc(sizeof(char *) * argc);
// }
//
// static void ArgvSet(void *argv, int i, char *arg) {
//     ((char **) argv)[i] = arg;
// }
//
// static void FreeArgv(int argc, void *argv) {
//     for (int i = 0; i < argc; ++i) {
//         free(((char **) argv)[i]);
//     }
//     free(argv);
// }
//
// static void CallInit(int argc, void *argv) {
//     C_InitI2P(argc, (char *) argv, "go-i2pd");
// }
import "C"

var argv string

// InitI2P initializes the i2pd library. Pass the arguments to i2pd in a slice of strings argp, and the name of the application in appname.
// func InitI2P(args []string, name string) {
func InitI2P(args []string, name string) func() {
	argv := C.AllocArgv(C.int(len(os.Args)))
	for i, arg := range os.Args {
		C.ArgvSet(argv, C.int(i), C.CString(arg))
	}
	//defer
	C.CallInit(C.int(len(os.Args)), argv)
	return func() {
		C.FreeArgv(C.int(len(os.Args)), argv)
	}
	//os.Exit(int(C.callMain(C.int(len(os.Args)), argv)))
}

// InitI2PSAM is a helper function to initialize the i2pd library with SAM on-by-default
func InitI2PSAM() func() {
	return InitI2P(defaults, "go-i2pd")
}

var dir, err = os.Getwd()

var defaults = []string{
	"--datadir=" + dir,
	"--httpproxy.enabled=1",
	"--httpproxy.address=127.0.0.1",
	"--httpproxy.port=4444",
	"--sam.enabled=1",
	"--sam.address=127.0.0.1",
	"--sam.port=7656",
	"--i2pcontrol.enabled=1",
	"--i2pcontrol.address=127.0.0.1",
	"--i2pcontrol.port=7657",
}

// NewI2P creates an I2P router which starts 1) an HTTP Proxy on localhost:4444
// 2) a SAM bridge on localhost:7656, and 3) an i2pcontrol API on localhost:7657.
func NewI2P() func() {
	return InitI2P(defaults, "go-i2pd")
}

// StartI2P starts the i2pd router.
func StartI2P() {
	api.C_StartI2P()
}

// StopI2P stops the i2pd router.
func StopI2P() {
	api.C_StopI2P()
}
