//Select form - https://developer.mozilla.org/en-US/docs/Web/API/Document/forms
// form name : AALimitFormv

// var form =  document.forms[0];
// document.forms["AALimitForm"]
// document.getElementsByName(AALimitForm);

var mform = document.AALimitForm ;
// document.AALimitForm

//loop through all input fields - https://stackoverflow.com/questions/19978600/how-to-loop-through-elements-of-forms-with-javascript
var elements = mform.elements;

//validate 1 - only special char ascii 
for (var i = 0, element; element = elements[i++];) {
    if (element.type === "text" && element.value != "") {
        const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
        if(specialChars.test(str) == false) {
            alert(false);
        } 

    }    
}

//saveAAlimit
function submit() {
    var mform = document.AALimitForm ;
// document.AALimitForm

    //loop through all input fields - https://stackoverflow.com/questions/19978600/how-to-loop-through-elements-of-forms-with-javascript
    var elements = mform.elements;

    const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
    //validate 1 - only special char ascii 
    for (var i = 0, element; element = elements[i++];) {
        if (element.type === "text" && element.value != "") {

            var str = element.value
            if(specialChars.test(str) == true) {
                alert('false invalidation ' + element.value + ' in field ' + element.name);
            } 

        }    
    }
    return ;
}

//test 1 field input
//gug7 99t7/$%^<
// const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|<>\?~]/;

var ele = document.getElementsByName('generalRemarks')[0] ;
console.log(ele.value)
console.log(specialChars.test(ele.value))
if (ele.name != '') console.log(ele.name)


// full test submit 
function saveAALimit() {
	var officerName = document.AALimitForm.officerName.value;
	document.AALimitForm.event.value = "<%=AALimitAction.EVENT_CREATE_AA_LIMIT%>";
	selectMultiListValues('selectedAdjustments');

	var mform = document.AALimitForm ;
// document.AALimitForm

	//loop through all input fields - https://stackoverflow.com/questions/19978600/how-to-loop-through-elements-of-forms-with-javascript
	var elements = mform.elements;

	//validate 1 - only special char ascii
	const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|<>\?~]/;
	//validate 1 - only special char ascii 
    //delete box error element
    var errorBox = document.getElementById("errorBox");
    if ( typeof(errorBox) != 'undefined' && errorBox != null )errorBox.parentNode.removeChild(errorBox);

    for (var i = 0; i< elements.length ; i++) {
		element = elements[i]
		if ( (element.type === "text"||element.type === "textarea") && element.value != "") {
            
            //create box error element
            errorBox = document.createElement('div');
            errorBox.setAttribute("id", "errorBox");
            errorBox.style.color = 'red';

			var str = element.value
			if(specialChars.test(str) == true) {
				console.log('false invalidation ' + element.value + ' in field ' + element.name);
                var message = document.createElement('span')
                message.innerText = 'false invalidation ' + element.value + ' in field ' + element.name ;
                document.insertBefore(message, errorBox.firstChild)
			}

		}
	}

	//gug7 99t7/$%^<
	// const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;
	var ele = document.getElementsByName('generalRemarks')[0] ;
	console.log(ele.value)
	console.log(specialChars.test(ele.value))
	if (ele.name != '') console.log(ele.name)


	return ;

	// document.AALimitForm.submit();
}


// NEARLY DONE 
function saveAALimit() {
	var officerName = document.AALimitForm.officerName.value;
	document.AALimitForm.event.value = "<%=AALimitAction.EVENT_CREATE_AA_LIMIT%>";
	selectMultiListValues('selectedAdjustments');

	var mform = document.AALimitForm ;
// document.AALimitForm

	//loop through all input fields - https://stackoverflow.com/questions/19978600/how-to-loop-through-elements-of-forms-with-javascript
	var elements = mform.elements;

//validate 1 - only special char ascii
	const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|<>\?~]/;
	//validate 1 - only special char ascii
	//delete box error element
	var errorBox = document.getElementById("errorBox");
	if ( typeof(errorBox) != 'undefined' && errorBox != null )errorBox.parentNode.removeChild(errorBox);
	//create box error element
	errorBox = document.createElement('div');
	errorBox.setAttribute("id", "errorBox");
	errorBox.style.color = 'red';
	errorBox.style.padding = '30px';
	errorBox.style.flex='column';
	var error = false;
	for (var i = 0; i< elements.length ; i++) {
		element = elements[i]
		if ( (element.type === "text"||element.type === "textarea") && element.value != "") {
			var str = element.value
			if(specialChars.test(str) == true) {
				console.log('false invalidation ' + element.value + ' in field ' + element.name);
				var message = document.createElement('p')
				message.style.fontWeight = 'bold'
				message.innerText = 'false invalidation ' + element.value + ' in field ' + element.name ;
				errorBox.insertBefore(message, errorBox.firstChild)
				error = true ;
			}

		}
	}
	mform.insertBefore(errorBox, mform.firstChild);
	if (error) return ;

	// document.AALimitForm.submit();
}

function saveAALimit() {
	var officerName = document.AALimitForm.officerName.value;
	document.AALimitForm.event.value = "<%=AALimitAction.EVENT_CREATE_AA_LIMIT%>";
	selectMultiListValues('selectedAdjustments');

	var mform = document.AALimitForm ;
	var elements = mform.elements;

	const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|<>\?~]/;
	var errorBox = document.getElementById("errorBox");
	if ( typeof(errorBox) != 'undefined' && errorBox != null )errorBox.parentNode.removeChild(errorBox);
	errorBox = document.createElement('div');
	errorBox.setAttribute("id", "errorBox");
	errorBox.style.color = 'red';
	errorBox.style.padding = '30px';
	errorBox.style.flex='column';
	var error = false;
	for (var i = 0; i< elements.length ; i++) {
		element = elements[i]
		if ( (element.type === "text"||element.type === "textarea") && element.value != "") {
			var str = element.value
			if(specialChars.test(str) == true) {
				console.log('false invalidation ' + element.value + ' in field ' + element.name);
				var message = document.createElement('p')
				message.style.fontWeight = 'bold'
				message.innerText = 'false invalidation ' + element.value + ' in field ' + element.name ;
				errorBox.insertBefore(message, errorBox.firstChild)
				error = true ;
			}

		}
	}
	mform.insertBefore(errorBox, mform.firstChild);
	if (error) return ;

	document.AALimitForm.submit();
}


// validate 2 - with hex
// https://stackoverflow.com/questions/21647928/javascript-unicode-string-to-hex
// http://blog.lesc.se/2009/03/escape-illegal-characters-with-jaxb-xml.html
// static {
    // final String escapeString = "\u0000\u0001\u0002\u0003\u0004\u0005" +
    //     "\u0006\u0007\u0008\u000B\u000C\u000E\u000F\u0010\u0011\u0012" +
    //     "\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001A\u001B\u001C" +
    //     "\u001D\u001E\u001F\uFFFE\uFFFF";

//     illegalChars = new HashSet<Character>();
//     for (int i = 0; i < escapeString.length(); i++) {
//         illegalChars.add(escapeString.charAt(i));
//     }
// }

// public EscapingXMLStreamWriter(XMLStreamWriter writer) {

//     if (null == writer) {
//         throw new IllegalArgumentException("null");
//     } else {
//         this.writer = writer;
//     }
// }

// private boolean isIllegal(char c) {
//     return illegalChars.contains(c);
// }

// String.prototype.hexDecode = function(){
//     var j;
//     var hexes = this.match(/.{1,4}/g) || [];
//     var back = "";
//     for(j = 0; j<hexes.length; j++) {
//         back += String.fromCharCode(parseInt(hexes[j], 16));
//     }

//     return back;
// }

String.prototype.hexEncode = function(){
    var hex, i;

    var result = "";
    for (i=0; i<this.length; i++) {
        hex = this.charCodeAt(i).toString(16);
        result += ("000"+hex).slice(-4);
    }
    console.log(result);
    return result
}

var escapeString = "\u0000 \u0001 \u0002 \u0003 \u0004 \u0005 " +
"\u0006 \u0007 \u0008 \u000B \u000C \u000E \u000F \u0010 \u0011 \u0012 " +
"\u0013 \u0014 \u0015 \u0016 \u0017 \u0018 \u0019 \u001A \u001B \u001C " +
"\u001D \u001E \u001F \uFFFE \uFFFF";

var escapeStringArray = escapeString.split(" ");
// var replaceString = '\uFFFD';
// var mySet = {}
// for (var i = 0; i < escapeStringArray.length; i++) {
//     illegalChars.add(escapeStringArray.charAt(i));
// }

function isIllegal(hexStr) {
    for (var i = 0; i < escapeStringArray.length; i++) {
        if (hexStr.contains(escapeStringArray[i])) return true;
    }
    return false;
}

// var str = "\u6f22\u5b57"; // "\u6f22\u5b57" === "漢字"
// alert(str.hexEncode().hexDecode());

function saveAALimit() {
	var officerName = document.AALimitForm.officerName.value;
	document.AALimitForm.event.value = "<%=AALimitAction.EVENT_CREATE_AA_LIMIT%>";
	selectMultiListValues('selectedAdjustments');

	var mform = document.AALimitForm ;
	var elements = mform.elements;

	//create and remove Error box message
	const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|<>\?~]/;
	var errorBox = document.getElementById("errorBox");
	if ( typeof(errorBox) != 'undefined' && errorBox != null )errorBox.parentNode.removeChild(errorBox);
	errorBox = document.createElement('div');
	errorBox.setAttribute("id", "errorBox");
	errorBox.style.color = 'red';
	errorBox.style.padding = '30px';
	errorBox.style.flex='column';
	var error = false;

	//validate and add message to error box
	for (var i = 0; i< elements.length ; i++) {
		element = elements[i]
		if ( (element.type === "text"||element.type === "textarea") && element.value != "") {
			var hexStr = element.value.hexEncode()

			if(isIllegal(hexStr)) {
				console.log('false invalidation ' + element.value + ' in field ' + element.name);
				var message = document.createElement('p')
				message.style.fontWeight = 'bold'
				message.innerText = 'false invalidation ' + element.value + ' in field ' + element.name ;
				errorBox.insertBefore(message, errorBox.firstChild)
				error = true ;
			}
		}
	}
	mform.insertBefore(errorBox, mform.firstChild);
	if (error) return ;

	document.AALimitForm.submit();
}