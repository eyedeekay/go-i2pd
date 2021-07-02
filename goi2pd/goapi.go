package i2pd

import (
	"github.com/eyedeekay/go-i2pd/i2pd/libi2pd_wrapper"
	"log"
	"os"
	"strings"
)

var argv string

func InitI2P(argp []string, name string) {
	if argp == nil {
		argp = []string{""}
	}
	args := append(os.Args[:1], argp...)
	argv = strings.Join(args, " ")
	log.Println(argv)
	api.C_InitI2P(len(args), argv, name)
}

func InitI2PSAM() {
	args := append(os.Args[:1], "--sam.enabled=1", "--sam.address=127.0.0.1", "--sam.port=7656") //"--datadir=go-i2pd-data"
	argv = strings.Join(args, " ")
	log.Println(argv)
	api.C_InitI2P(len(args), argv, "go-i2pd")
}

func StartI2P() {
	api.C_StartI2P()
}

func StopI2P() {
	api.C_StopI2P()
}
