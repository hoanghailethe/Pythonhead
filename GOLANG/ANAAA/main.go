package main

import ( 
    "fmt"
    "io"
    "os"
) 

func main() {
	fmt.Print("Hello World")
	fmt.Println("Welcome to the booking application")

	var conferenceName = "Go Conference"
	const conferenceTickets = 50

	fmt.Println("Welcome", conferenceName)

	fmt.Println(conferenceName)

	fmt.Println("conferenceName TEST 2")
	// Declaring some const variables
	const name, dept = "GeeksforGeeks", "CS"

	// Calling Sprintf() function
	s := fmt.Sprintf("%s is ( border-radius: 50%%; border-radius: 50%%; ) a %s Portal. \n", name, dept)

	// Calling WriteString() function to write the
	// contents of the string "s" to "os.Stdout"
	io.WriteString(os.Stdout, s)
	fmt.Print(s)
}


