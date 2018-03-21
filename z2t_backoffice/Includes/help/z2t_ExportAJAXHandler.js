
var FileCount=0;
var responseDiv="";

var fileCountSpan = "";



// AJAX Handler
function XHConn()
{
  openModal();

  var xmlhttp, bComplete = false;
  try { xmlhttp = new ActiveXObject("Msxml2.XMLHTTP"); }
  catch (e) { try { xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); }
  catch (e) { try { xmlhttp = new XMLHttpRequest(); }
  catch (e) { xmlhttp = false; }}}
  if (!xmlhttp) return null;
  this.connect = function(sURL, sMethod, sVars, fnDone)
  {
	  
    if (!xmlhttp) return false;
    bComplete = false;
    sMethod = sMethod.toUpperCase();
    try {
      if (sMethod == "GET")
      {
        xmlhttp.open(sMethod, sURL+"?"+sVars, true);
        sVars = "";
      }
      else
      {
        xmlhttp.open(sMethod, sURL, true);
        xmlhttp.setRequestHeader("Method", "POST "+sURL+" HTTP/1.1");
        xmlhttp.setRequestHeader("Content-Type",
          "application/x-www-form-urlencoded");
      }
      xmlhttp.onreadystatechange = function(){
        if (xmlhttp.readyState == 4 && !bComplete)
        {
          bComplete = true;
          fnDone(xmlhttp);	
		  closeModal();
        }};
      xmlhttp.send(sVars);
    }
    catch(z) { return false; }
    return true;
  };
  return this;
}


var doAJAXCall = function (PageURL, ReqType, PostStr, FunctionName) {

	
	// create the new object for doing the XMLHTTP Request
	var myConn = new XHConn();

	// check if the browser supports it
	if (myConn)	{
	    
	    // XMLHTTPRequest is supported by the browser, continue with the request
	    myConn.connect('' + PageURL + '', '' + ReqType + '', '' + PostStr + '', FunctionName);    
	} 
	else {
	    // Not support by this browser, alert the user
	    alert("XMLHTTP not available. Try a newer/better browser, this application will not work!");   
	}

}



var CallAjaxPage = function (URL, AjaxResponseDiv) {

    // build up the post string when passing variables to the server side page
    var PostStr = "";

  responseDiv = AjaxResponseDiv;


    doAJAXCall(URL, 'POST', '', EmbedMessageResponse);
	  
}

var CallAjaxPage = function (URL, AjaxResponseDiv) {
    // build up the post string when passing variables to the server side page
    var PostStr = "";
	responseDiv = AjaxResponseDiv;
    doAJAXCall(URL, 'POST', '', EmbedMessageResponse);
}
var CallAjaxPageForFileCount = function (URL, AjaxResponseDiv) {
    // build up the post string when passing variables to the server side page
    var PostStr = "";
	fileCountSpan = AjaxResponseDiv;
    doAJAXCall(URL, 'POST', '', EmbedMessageResponseForFileCount);
}




function showMessageResponse(oXML) { 
    // get the response text, into a variable
    var response = oXML.responseText;
	alert(response);
};

   function EmbedMessageResponse (oXML) {
        // get the response text, into a variable
        var response = oXML.responseText;
        // update the Div to show the result from the server
		if(response.indexOf("~") >0 )
			responseDiv.innerHTML = response.substring( response.indexOf("~")+1,response.length);
		else 
			responseDiv.innerHTML = response;

   }

	 function EmbedMessageResponseForFileCount (oXML) {
        // get the response text, into a variable
        var response = oXML.responseText;
        // update the Div to show the result from the server
		
	if(response.split('~')[0] != "Collective")
	{	
		fileCountSpan.innerHTML = response.split('~')[1];
	}
	else	
	{
		fileCountSpan.innerHTML = response;
		ShowCounts(response);
		
	 }
  }
	
	
function createbasicdir(oXML) { 
    
    // get the response text, into a variable
    var response = oXML.responseText;
    
    // update the Div to show the result from the server
	
	//alert(response);
};

function showConfirmBox (oXML) { 
    
    // get the response text, into a variable
    var response = oXML.responseText;
    
    // update the Div to show the result from the server
	//InStr(txt,"'ask'")
	//if (response.indexOf("ask") > -1){
		
		 var s = window.location.href
			 var URLVal=s.substring(0, s.indexOf('?'));

			 if (URLVal.length==0)
			 	URLVal = window.location.href
				
				 var res = response.split("~");
				
				
	if (res[0]=='ask'){
		//alert(response);
	
		yesno = confirm('Base Directory Does not Exist, Do you want to create it');
	
			if (yesno)
			{
				if(res.length > 1){
					 window.location.href =URLVal+'?createdirectory=1&cmbMonthval='+res[1]+'&cmbYearval='+res[2];
					
					}
				else
				{ 
					window.location.href =URLVal+'?createdirectory=1';	
		 			
				}
				
			}
		//else
		//alert(response);
	}else if (response!='DoNothing'){
		
			
		if(res.length > 1){
		 window.location.href =URLVal+'?cmbMonthval='+res[1]+'&cmbYearval='+res[2];
		 alert(res[0]);
		}
		else
		{
		 window.location.href =URLVal;
		 alert(response);
		}
		 	
	}
	
};

function openModal() {
        document.getElementById('modal').style.display = 'block';
        document.getElementById('fade').style.display = 'block';
	
(function(){
    // do some stuff
    setTimeout(	document.getElementById('modal-content').innerHTML = ShowStatus(), 100);
})();

}
function ShowStatus(){
	
	return "Status message";
	
	}

function closeModal() {
    document.getElementById('modal').style.display = 'none';
    document.getElementById('fade').style.display = 'none';
	
}
        
function ShowCounts(fileCount){
	
			var arrFormatTypeSpans = ["spnBasicFileCountSales", "spnBasicFileCountUse", "spnFullBreakoutFileCountSales","spnFullBreakoutFileCountUse", "spnUniqueZipsFileCountSales","spnUniqueZipsFileCountUse","spnEvolutionFileCountSales","spnEvolutionFileCountUse","spnMagentoFileCountSales","spnMagentoFileCountUse","spnMagentoEnterpriseFileCountSales","spnMagentoEnterpriseFileCountUse","spnSedonaFileCountSales","spnSedonaFileCountUse",	"spnUltracartFileCountSales","spnUltracartFileCountUse","spnVolusionFileCountSales","spnVolusionFileCountUse"];
		var	arrFileCount=	fileCount.split("~");
		for (i = 1; i<arrFileCount.length-1;i++){
				 document.getElementById(arrFormatTypeSpans[i-1]).innerHTML= arrFileCount[i];
			
			}				
	}

