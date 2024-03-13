package main

import (
	"encoding/base64"
	"fmt"
	"io"
	"io/ioutil"
	// "net/smtp"
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

	jobTitle := "barisra"

	// Read the image file
	imagePath := "image/celebration.png"
	imageBytes, err := ioutil.ReadFile(imagePath)
	if err != nil {
		fmt.Println("Error reading image file:", err)
		return
	}

	// Encode the image as base64
	imageBase64 := base64.StdEncoding.EncodeToString(imageBytes)

	// Embed the image in the HTML

	HTML := fmt.Sprintf(`<html>
	<head>
		<style>
		.image-container {
			width: 150px;
			height: 150px;
			overflow: hidden;
			border-radius: 50%%;
			border: 2px solid black;
			margin: auto;
			position: relative;
		}
		.image-container img {
			display: block;
			max-width: 100%%;
			height: auto;
			position: absolute;
			top: 50%%;
			left: 50%%;
			transform: translate(-50%%, -50%%);
	}
			body {
				background-color: lightgray;
			}
			.content-container {
				background-color: white;
				margin: 30px auto;
				padding: 20px;
				max-width: 600px;
				border: 1px solid black;
				text-align: center;
			}
		</style>
	</head>
	<body>
		<div class="image-container">
			<img src="data:image/png;base64,%s" alt="Description of image">
		</div>
		<div class="content-container">
			<h2>All Submitted</h2>
			<p>Thank you for your interest in %s at %s</p>
			<p>We have received your application and will be in touch with any updates</p>
			<p>All the best,</p>
		</div>
	</body>
</html>`, imageBase64, jobTitle, "business Name")

	// fmt.Println(HTML)
	// Write the HTML to a file
    err = ioutil.WriteFile("output.html", []byte(HTML), 0644)
    if err != nil {
        fmt.Println("Error writing to file:", err)
        return
    }

    fmt.Println("HTML written to output.html")

	// Decode the base64 string to bytes
    imageBytes, err = base64.StdEncoding.DecodeString(imageBase64)
    if err != nil {
        fmt.Println(err)
    }

    // Write the bytes to a file
    err = ioutil.WriteFile("outputBack.png", imageBytes, 0644)
    if err != nil {
		fmt.Println(err)
    }

    fmt.Println("Image saved to outputBack.png")
	 
	// Choose auth method and set it up
	// err = godotenv.Load()
	// if err != nil {
    //     fmt.Println("Error loading .env file")
    //     return
    // }

	// password := os.Getenv("EMAIL_PASSWORD")
	// password := ""
	// auth := smtp.PlainAuth("", "Printinstorevn@gmail.com", password, "smtp.gmail.com")

	// fmt.Println(password)
	// Here we do it all: connect to our server, set up a message and send it

	// to := []string{"hle@deputy.com", "lethehoanghai@gmail.com"}
    // // Sending email.
    // err = smtp.SendMail("smtp.gmail.com:587", auth, "", to, []byte("Subject: Job Application\nMIME-version: 1.0;\nContent-Type: text/html; charset=\"UTF-8\";\n\n"+HTML))
    // if err != nil {
    //     fmt.Println("Error sending email:", err)
    //     return
    // }

    // fmt.Println("Email sent successfully!")
}

