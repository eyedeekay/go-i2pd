package main

import (
	//"flag"
	//"log"
	"os"

	"github.com/eyedeekay/go-i2pd/goi2pd"
)

func main() {
	i2pd.InitI2P(os.Args[1:], "go-i2pd")
	i2pd.StartI2P()
}
