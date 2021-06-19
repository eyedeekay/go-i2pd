package main

import (
	//"flag"
	//"log"
	"time"
	//"os"

	"github.com/eyedeekay/go-i2pd/goi2pd"
)

func main() {
	i2pd.InitI2PSAM()
/*	if len(os.Args) > 0{ 
		i2pd.InitI2P(os.Args[1:], "go-i2pd")
	}else{
		i2pd.InitI2P([]string{""}, "go-i2pd")
	}*/
	i2pd.StartI2P()
	time.Sleep(time.Hour)
	i2pd.StopI2P()
}
