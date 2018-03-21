<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type='text/javascript' src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ajaxtransport-xdomainrequest/1.0.1/jquery.xdomainrequest.min.js"></script>
 
</head>

<body>

<button type="button" onclick="loadDoc()">Test Connection</button>
<script type = "text/javascript" src = "//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js" ></script>

<script>
function loadDoc() {
	$.ajax({
		url:"https://api.zip2tax.com/TaxRate-USA.json?username=jessie&password=jessie1&zip=90001",
		dataType: 'jsonp',
		success:function(response){
            if(response.z2tLookup.errorInfo.errorCode == 0) {
                console.log(response);
            }
		},
		error:function(){
			alert("Error");
		}      
});

}
</script>

</body>
</html>

