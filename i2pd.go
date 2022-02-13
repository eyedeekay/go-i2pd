package main

import (
	//"flag"
	//"log"

	"time"

	i2pd "github.com/eyedeekay/go-i2pd/goi2pd"
)

func main() {
	closer := i2pd.InitI2PSAM()
	defer closer()
	i2pd.StartI2P()
	time.Sleep(time.Hour)
	i2pd.StopI2P()
}
