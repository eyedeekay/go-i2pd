package i2pd

import (
	"strings"
	"os"
	"log"
	"github.com/eyedeekay/i2pd/libi2pd"
)

var argv string

func InitI2P(args []string, name string) {
	argv = strings.Join(os.Args, "")
	api.C_InitI2P(len(os.Args), argv, "go-i2pd")

//	api.C_StartI2P()

//	time.Sleep(time.Hour)

//	api.C_StopI2P()
}

func InitI2PSAM() {
	args := append(os.Args, "--datadir=_goi2pd", "--sam.enabled=1", "--sam.address=127.0.0.1", "--sam.port=7656") //"--datadir=go-i2pd-data"
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
