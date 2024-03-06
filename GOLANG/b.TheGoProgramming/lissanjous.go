// write a function fibonaci() that returns a function (a closure) that returns an int
// fibonaci() returns a function that returns an int
// The returned function returns the next fibonaci number each time it is called
// The first two numbers are 0 and 1
// The next number is the sum of the last two numbers
// The sequence starts: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...
// The function fibonaci() should be able to return the next number in the sequence each time it is called
// You should use a recursive function to implement fibonaci()
// The function should be a closure
// The function should return a function that returns an int
// The function should take no arguments
// The function should return the next fibonaci number each time it is called
// The first two numbers are 0 and 1

//write a fibonaci function in go lang
package main

import "fmt"

func fibonaci() func() int {
	a, b := 0, 1
	return func() int {
		a, b = b, a+b
		return a
	}
}

func main() {
	f := fibonaci()
	for i := 0; i < 10; i++ {
		fmt.Println(f())
			}


			