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

// encode and decode string utf8 
function encode_utf8(s) {
    return unescape(encodeURIComponent(s));
  }
  
  function decode_utf8(s) {
    return decodeURIComponent(escape(s));
  }

var input = "Hello Wor ascas â ơ o ô ơ $#@%!&*&<>T3t"
console.log(String.fromCharCode(parseInt(input, 8)))
console.log(String.fromCharCode(parseInt(input,16))) 

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
            // var hexStr = element.value.hexEncode()
			var hexStr = encodeURI(element.value)
			console.log(hexStr)
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


// all specious string
var speciousStr = "1	202207210022499345	202207210005737947	Quyền sử dụng đất tại thôn Chiết Bi, xã Thủy Tân, thị xã Hương Thủy, tỉnh Thừa Thiên Huế; Thửa đất số: 236-1; Tờ bản đồ số: 06; Diện tích: 540,5 m2 (Bằng chữ: Năm trăm bốn mươi phẩy năm mét vuông). Hình thức sử dụng: Riêng: 540,5 m2; Chung: không m2. Mục đích sử dụng: Đất ở 400,0 m2; Đất trồng cây lâu năm 140,5 m2. Thời hạn sử dụng: Đất ở: Lâu dài; Đất trông cây lâu năm: 50 năm kể từ ngày ký. Nguồn gốc sử dụng: Công nhận QSDĐ như giao đất không thu tiền sử dụng đất. Ghi chú: Thửa đất có 129,6 m2 nằm trong lộ giới đường Võ Xuân Lâm. Các loại giấy tờ chứng minh quyền sử dụng tài sản: Giấy chứng nhận quyền sử dụng đất quyền sở hữu nhà ở và tài sản khác gắn liền với đất số BH 722706 do Ủy ban nhân dân thị xã Hương Thủy, Tỉnh Thừa Thiên Huế cấp ngày 04/05/2013. Số vào sổ cấp GCN: CH00022		Chiết Bị, Thủy Tân, Hương Thủy, TT Huế	202207210022499345	0	tuantn5	7/21/2022 01:54:39 PM	tuantn5	7/21/2022 01:54:39 PM	PT202107270019772213	10031	100010	153571			VN		0	VND	1800000000										462	12/31/2049	O	-1		46231-LOS-1002-BH722706-1401544446							VND		1	0				VND		I	137206				N	1002												CMS		N		N					20210728018249224	0	Quyền sử dụng đất tại thôn Chiết Bi, xã Thủy Tân, thị xã Hương Thủy, tỉnh Thừa Thiên Huế; Thửa đất số: 236-1; Tờ bản đồ số: 06; Diện tích: 540,5 m2 (Bằng chữ: Năm trăm bốn mươi phẩy năm mét vuông). Hình thức sử dụng: Riêng: 540,5 m2; Chung: không m2. Mục đích sử dụng: Đất ở 400,0 m2; Đất trồng cây lâu năm 140,5 m2. Thời hạn sử dụng: Đất ở: Lâu dài; Đất trông cây lâu năm: 50 năm kể từ ngày ký. Nguồn gốc sử dụng: Công nhận QSDĐ như giao đất không thu tiền sử dụng đất. Ghi chú: Thửa đất có 129,6 m2 nằm trong lộ giới đường Võ Xuân Lâm. Các loại giấy tờ chứng minh quyền sử dụng tài sản: Giấy chứng nhận quyền sử dụng đất quyền sở hữu nhà ở và tài sản khác gắn liền với đất số BH 722706 do Ủy ban nhân dân thị xã Hương Thủy, Tỉnh Thừa Thiên Huế cấp ngày 04/05/2013. Số vào sổ cấp GCN: CH00022	202207210022498469	N	4143181	46231-LOS-1002-BH722706-1401544446	1022445394	2490952978		75	Theo tờ trình		1023863092								202207210022497468	1	tuantn5	7/21/2022 01:54:39 PM	tuantn5	7/21/2022 01:54:39 PM	202207210005737947	202207210022499345	Y " +
"3	202207210022499407	202207210005737947	CL387700		Phú Bài, Hương Thủy, Thừa Thiên Huế	202207210022499407	1	tuantn5	7/21/2022 01:58:32 PM	tuantn5	7/21/2022 01:58:32 PM	PT202207210022499407	10031	100010	153571			VN			VND	1742000000												O	-1		202207210022499407							VND			0				VND			137206					1002												CMS		N		N					0	0	CL387700	0			46231-LOS-1002-1401544446-CL387700 	1022445572	2490952978	162249	73.68	Theo tờ trình		1023863092								202207210022497530	0	tuantn5	7/21/2022 01:58:32 PM	tuantn5	7/21/2022 01:58:32 PM	202207210005737947	202207210022499407	N" +
"2	202207210022499346	202207210005737947	462-LOS-1401544446-1002-CG 325459		Phường Thủy Châu, thị xã Hương Thủy	202207210022499346	0	tuantn5	7/21/2022 01:54:39 PM	tuantn5	7/21/2022 01:54:39 PM	PT202105200019217115	10031	100010	153571			VN		0	VND	752000000										462	12/31/2049		-1		462-LOS-1401544446-1002-CG 325459									1	0				VND		I	137206				N	1002														N		N					20210521017812076	0	462-LOS-1401544446-1002-CG 325459	20210722009158	N	4084769	462-LOS-1401544446-1002-CG 325459	1022445394	2490952978		73.14			1023863092								202207210022497469	1	tuantn5	7/21/2022 01:54:39 PM	tuantn5	7/21/2022 01:54:39 PM	202207210005737947	202207210022499346	Y "+
"1	202207210022499345	202207210005737947	202207210022499345			1		12	7/21/2021	7/21/2022	I	BH 722706		06	236-1			100	540.5	1	0	F 	0					0														M 			Chiết Bị, Thủy Tân, Hương Thủy, TT Huế	N	N	N			N															TTH			007	U		Y						Y		10											0						001		3						001							1023490719	1772516501				202207210022660688	0	tuantn5	7/21/2022 01:54:38 PM	tuantn5	7/21/2022 01:54:38 PM	202207210022499345	202107270001285351	 	1022445457							20210728036964661	N		202107270001285351	0	SML	7/27/2021 09:03:33 PM	SML	7/27/2021 09:03:33 PM	3020067271	164224	191660153	VN	CA TINH TT HUE	6/2/2020				VN						VN					1022777005		45173	I	LE DINH THE	LE DINH THE				Y		20210203065951	137206																																					20130816346984	1022446496	1028		N	N	L	N								N		I205-480															1022445776	1023863092					191660153	164224	202207210022499345	0	tuantn5	7/21/2022 01:54:39 PM	tuantn5	7/21/2022 01:54:39 PM	PT202107270019772213	10031	100010	153571			VN		0	VND	1800000000										462	12/31/2049	O	-1		46231-LOS-1002-BH722706-1401544446							VND		1	0				VND		I	137206				N	1002												CMS		N		N					20210728018249224	0	Quyền sử dụng đất tại thôn Chiết Bi, xã Thủy Tân, thị xã Hương Thủy, tỉnh Thừa Thiên Huế; Thửa đất số: 236-1; Tờ bản đồ số: 06; Diện tích: 540,5 m2 (Bằng chữ: Năm trăm bốn mươi phẩy năm mét vuông). Hình thức sử dụng: Riêng: 540,5 m2; Chung: không m2. Mục đích sử dụng: Đất ở 400,0 m2; Đất trồng cây lâu năm 140,5 m2. Thời hạn sử dụng: Đất ở: Lâu dài; Đất trông cây lâu năm: 50 năm kể từ ngày ký. Nguồn gốc sử dụng: Công nhận QSDĐ như giao đất không thu tiền sử dụng đất. Ghi chú: Thửa đất có 129,6 m2 nằm trong lộ giới đường Võ Xuân Lâm. Các loại giấy tờ chứng minh quyền sử dụng tài sản: Giấy chứng nhận quyền sử dụng đất quyền sở hữu nhà ở và tài sản khác gắn liền với đất số BH 722706 do Ủy ban nhân dân thị xã Hương Thủy, Tỉnh Thừa Thiên Huế cấp ngày 04/05/2013. Số vào sổ cấp GCN: CH00022	202207210022498469	N	4143181	46231-LOS-1002-BH722706-1401544446	1022445394	2490952978		75	Theo tờ trình		1023863092								202207210022497468	1	tuantn5	7/21/2022 01:54:39 PM	tuantn5	7/21/2022 01:54:39 PM	202207210005737947	202207210022499345	Y"+
"2	202207210022499346	202207210005737947	202207210022499346			0		-1			O	325459	CG						108	1	0	F 	0					0	1																Phường Thủy Châu, thị xã Hương Thủy	N	N	N																	41111 	TTH			007	C										10		Không có dự án									0																	N	N								202207210022660689	0	tuantn5	7/21/2022 01:54:38 PM	tuantn5	7/21/2022 01:54:38 PM	202207210022499346	201509180000391513	 	1022445457							20150918008912338	N		201509180000391513	8	SML	9/18/2015 01:27:17 PM	DUNGNV17	7/20/2022 05:05:52 PM	1401544446	164224	191725785	VN	CA TT HUE	2/18/2011				VN						VN					1022777005		45173	I	NGUYEN THI LAM	NGUYEN THI LAM				Y		20210203065951	137206																													Y								20130816346984	11668	1028		N	N	L	N								N		I206-255															1022445776	1023863100			1726917	201509290000035454	191725785	164224	202207210022499346	0	tuantn5	7/21/2022 01:54:39 PM	tuantn5	7/21/2022 01:54:39 PM	PT202105200019217115	10031	100010	153571			VN		0	VND	752000000										462	12/31/2049		-1		462-LOS-1401544446-1002-CG 325459									1	0				VND		I	137206				N	1002														N		N					20210521017812076	0	462-LOS-1401544446-1002-CG 325459	20210722009158	N	4084769	462-LOS-1401544446-1002-CG 325459	1022445394	2490952978		73.14			1023863092								202207210022497469	1	tuantn5	7/21/2022 01:54:39 PM	tuantn5	7/21/2022 01:54:39 PM	202207210005737947	202207210022499346	Y"+
"3	202207210022499407	202207210005737947	202207210022499407			1		12	7/8/2022	7/8/2023	I	CL387700		11	425			0	82.1	1	0	F 	0					0	1													M 			Phú Bài, Hương Thủy, Thừa Thiên Huế	N	N	N			N 															TTH			007	C		N						Y													0						001		1													1023490719	1772516501				202207210022660750	0	tuantn5	7/21/2022 01:57:16 PM	tuantn5	7/21/2022 01:57:16 PM	202207210022499407	201509180000391513	 	1022445457							0	N		201509180000391513	8	SML	9/18/2015 01:27:17 PM	DUNGNV17	7/20/2022 05:05:52 PM	1401544446	164224	191725785	VN	CA TT HUE	2/18/2011				VN						VN					1022777005		45173	I	NGUYEN THI LAM	NGUYEN THI LAM				Y		20210203065951	137206																													Y								20130816346984	11668	1028		N	N	L	N								N		I206-255															1022445776	1023863100			1726917	201509290000035454	191725785	164224	202207210022499407	1	tuantn5	7/21/2022 01:58:32 PM	tuantn5	7/21/2022 01:58:32 PM	PT202207210022499407	10031	100010	153571			VN			VND	1742000000												O	-1		202207210022499407							VND			0				VND			137206					1002												CMS		N		N					0	0	CL387700	0			46231-LOS-1002-1401544446-CL387700 	1022445572	2490952978	162249	73.68	Theo tờ trình		1023863092								202207210022497530	0	tuantn5	7/21/2022 01:58:32 PM	tuantn5	7/21/2022 01:58:32 PM	202207210005737947	202207210022499407	N"+
"1	202207210042192902	0	tuantn5	7/21/2022 01:54:38 PM	tuantn5	7/21/2022 01:54:38 PM	VND	7/21/2021	NHCT462	1800000000	0		12	3	202207210022499345		-1						NHCT462		82070			S		20210728018249224	20210728050986523	1800000000	0		0	1023490780 "+
"2	202207210042192903	0	tuantn5	7/21/2022 01:54:38 PM	tuantn5	7/21/2022 01:54:38 PM	VND	7/21/2021		1800000000	1800000000		12	3	202207210022499345		-1						462-CN NAM THUA THIEN HUE-NHTMCP CONG THUONG VN		82070			M		20210728018249224	20210730051062309	1800000000	0		0	1023490780 " +
"3	202207210042192904	0	tuantn5	7/21/2022 01:54:38 PM	tuantn5	7/21/2022 01:54:38 PM	VND	5/17/2021		752000000			12	3	202207210022499346		-1											S		20210521017812076	20210728051017694				0	" +
"4	202207210042192905	0	tuantn5	7/21/2022 01:54:38 PM	tuantn5	7/21/2022 01:54:38 PM	VND	5/17/2021		752000000	0		12	3	202207210022499346		-1								82070			S		20210521017812076	20210521049440282	752000000			0	1023490780" +
"5	202207210042192906	0	tuantn5	7/21/2022 01:54:38 PM	tuantn5	7/21/2022 01:54:38 PM	VND	5/17/2021		752000000	752000000		12	3	202207210022499346		-1						462-CN NAM THUA THIEN HUE-NHTMCP CONG THUONG VN					M		20210521017812076	20210722050881419	752000000	0		0	1023490780+" +
"6	202207210042193032	0	tuantn5	7/21/2022 01:58:10 PM	tuantn5	7/21/2022 01:58:10 PM	VND	7/8/2022	NHCT462	1742000000			0		202207210022499407		-1						NHCT462		82070			S		0	-999999999	1562000000	180000000			1023490780"
