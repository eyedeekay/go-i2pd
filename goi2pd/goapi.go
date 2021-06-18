package i2pd

import (
	"strings"
	"log"
	"github.com/eyedeekay/i2pd/libi2pd"
)

func InitI2P(argv []string, name string) {
	args := strings.Join(argv, " ")
	log.Println(args)
	api.C_InitI2P(len(argv), args, name)
}

func InitI2PSAM() {
	args := "--datadir=go-i2pd-data"
	api.C_InitI2P(1, args, "go-i2pd")
}

func StartI2P() {
	api.C_StartI2P()
}

func StopI2P() {
	api.C_StopI2P()
}