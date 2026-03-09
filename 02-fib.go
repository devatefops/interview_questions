package main

import (
	"fmt"
)
////////////////////////////////////////
func fib(index int) int {
	if index <= 1 {
		return index
	}
	a, b := 0, 1
	for i := 2; i <= index; i++ {
		a, b = b, a+b
	}
	return b
}
//////////////////////////////////////////////


func main() {	
fmt.Println(fib(3))

}