package main 

import "fmt"


func main () {

	// VAR 
	var temperatue int= 9 ;
	name := "Quang" ;
	city := "Hanoi"

	// CONST
	const PI = 3.1415972 
	fPI := 3.1242

	// type of variable, common and popular
	var a [3]int 


	// CONVERTING TYPE
	var intergerPi int = int(fPI)

	// PRINT & PRINTF
	fmt.Printf("Hello %s , today the temperature in %s is %d " , name, city, temperatue)
	fmt.Println(PI)
	fmt.Printf("Here is the pi const %f \n", PI)
	fmt.Printf("Here is the fpi const %f \n", fPI)

	fmt.Print("CONVERTER float pi to Int pi: ")
	fmt.Println(intergerPi)

	fmt.Print("here is the array ")
	fmt.Println(a)


	// CONDITION
	var age int = 21 ;
	if reqAge := 18 ; reqAge < age {
		fmt.Println("Congrat, you are adult enough to watch ")
	}

	//FUCNTION
	fmt.Println("Welcome "+greetingMembers("Kaj", "Quang"))


	// POINTER TYPE
	// Declare an integer variable
    var num int = 42
    // Declare a pointer to an integer and assign the address of 'num' to it
    var ptr *int = &num
	fmt.Println(ptr)


	var firstName, _ = getName()
	fmt.Println("Hello "+firstName)

	//early return and GUARD (early return in condition met)  bit wise


	// Struct TEST 
	printMessage(message{ name: "Quang", phone:"12312412"})

	
}


func greetingMembers(name1 string, name2 string) string {
	return name1+","+name2
}

func sumInt(x, y int ) int {
	return x+y
}

func getName() (string , string) {
	return "Messi" ,"Lionel"
}

//struct 
type message struct {
	address string 
	phone string
	name string
}

func printMessage(m message) {
	fmt.Printf("Hello %v , your phone is %s, address %s \n", m.name, m.phone, m.address)
}