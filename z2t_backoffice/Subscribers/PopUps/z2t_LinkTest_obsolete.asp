<!DOCTYPE html>

<!--#include virtual="z2t_BackOffice/includes/help/helpDiv.inc"-->

<%
	If isnull(Request("zip")) or Request("zip") = "" Then
		RequestZip = 82009
	Else
		RequestZip = Request("zip")
	End If
    
	AjaxLoadingGif = "'https://info.zip2tax.com/z2t_backoffice/subscribers/popups/includes/Loading.gif' alt='Loading'"

	PathURL = "https://info.zip2tax.com/z2t_Backoffice/subscribers/popups/Ajax/"

	Dim AjaxURL(21), ActionURL(21)
  
	AjaxURL(1) = PathURL & "z2t_DatabaseTest_Frank02_web.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd")
	AjaxURL(2) = PathURL & "z2t_DatabaseTest_Casper09_web.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd")
	AjaxURL(3) = "https://www.zip2tax.com/Link/Lookup_XML.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd")
	AjaxURL(4) = PathURL & "z2t_DatabaseTest_api.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd") & "&server=Casper09"  
	AjaxURL(5) = PathURL & "z2t_DatabaseTest_Philly01_mysql.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd")
	AjaxURL(6) = PathURL & "z2t_DatabaseTest_api.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd") & "&server=Philly02"
	AjaxURL(7) = PathURL & "z2t_DatabaseTest_api.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd") & "&server=Philly04"
	AjaxURL(8) = PathURL & "z2t_DatabaseTest_api.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd") & "&server=Casper06"
	AjaxURL(9) = PathURL & "z2t_DatabaseTest_Philly05_web.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd")
	AjaxURL(10) = PathURL & "z2t_DatabaseTest_Casper06_web.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd")
	AjaxURL(11) = PathURL & "z2t_DatabaseTest_api.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd") & "&server=Philly05"
	AjaxURL(12) = PathURL & "z2t_DatabaseTest_Philly03_web.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd")
	AjaxURL(13) = PathURL & "z2t_DatabaseTest_Philly01_link.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd")
	AjaxURL(14) = PathURL & "z2t_DatabaseTest_api.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd") & "&server=Frank02"

	'AjaxURL(15) = PathURL & "z2t_DatabaseTest_api.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd") & "&server=Frank03"
	'AjaxURL(17) = PathURL & "z2t_DatabaseTest_Frank03_web.asp?zip=" & RequestZip & "&usr=" & Request("Usr") & "&pwd=" & Request("Pwd")
	
	ActionURL(11) = "http://philly05.harvestamerican.net/TaxRate-USA.xml?username=davewj2o&password=get2it&zip=82009"
  
%>

<html>
<head>
  <title>Zip2Tax.com Database Link Test</title>

  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <link href="includes/BackOfficePopup.css" type="text/css" rel="stylesheet" />

  <script type="text/javaScript" src="/z2t_BackOffice/includes/help/help.js"></script>
  <script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
  
  <style type="text/css">
    td.databaseHead
    {
      text-align: center;
      font-size: 12pt;
      font-weight: bold;
      border-bottom: 1px solid #000000;
      padding-top: 25px;
    }
	
    td.subHead1
    {
      text-align: center;
      font-size: 10pt;
      font-weight: bold;
      color: #C0C0C0;
    }

    td.subHead2
    {
      text-align: center;
      font-size: 10pt;
      border-bottom: 1px solid #C0C0C0;
      color: #C0C0C0;
    }
	
    .error {color: red; font-weight: bold; font-style: italic;}
  </style>

  <script type="text/javascript">
  
    var ServerID = 0;
    var nextServer = 0;
    var ajaxURL = ['', 
						'<%=AjaxURL(1)%>', '<%=AjaxURL(2)%>', '<%=AjaxURL(3)%>', '<%=AjaxURL(4)%>', '<%=AjaxURL(5)%>', 
						'<%=AjaxURL(6)%>', '<%=AjaxURL(7)%>', '<%=AjaxURL(8)%>', '<%=AjaxURL(9)%>', '<%=AjaxURL(10)%>', 
						'<%=AjaxURL(11)%>',  '<%=AjaxURL(12)%>', '<%=AjaxURL(13)%>', '<%=AjaxURL(14)%>'];
    var serverSequence = [12, 10, 1, 9, 2, 13, 3, 5, 6, 7,8, 14, 4, 11];

	
    function linkToError(title, message) {
      return function showError(e) {
        var parent = e.parentNode
        parent.innerHTML = "<span class=\"error\">" + title + "</span>";
        parent.style.cursor = "pointer";
        parent.childNodes[0].style.cursor = "pointer";
        parent.addEventListener("click", function(e){alert(title + ":\n\n" + message);}, false);}}

    window.onerror = function(message, file, line) {
      [].slice.call(document.querySelectorAll(".loading")).forEach(linkToError("js error", [file,line,message].join(" : ")));}

    var debug = alert;

    // Return boolean value of whether OBJ is undefined.
    // If ALTERNATIVE is supplied, return OBJ when defined; defaulting to ALTERNATIVE.
    function undef(obj, /*optional*/ alternative) {
      var altform = !(typeof(alternative) == "undefined")
      var isUndefined = (typeof(obj) == "undefined");
      return altform ? (isUndefined ? alternative : obj) : isUndefined;}


    // -- "make XHR / AJAX easy" -- e.g., xhr(URL, SUCCESS_FUNCTION, ERROR_FUNCTION).get();
    function xhrDefaultError(body) {
      switch (this.status) {
      case 0:
        alert("Unreachable URL\n\n" + this.url);
        return;
        break;
      default:
        var errorText;
        alert("XHR error:\n\n" + body);
        return;
        break;}
      return;}
    
    
    function xhrChange(state) {
      try {
        var states = {0: "uninitialized", 1: "loading", 2: "loaded", 3: "interactive", 4: "complete"};
        var status = {0: "unreachable", 404: "not found", 200: "success", 500: "server error"};
    
        switch (this.readyState) {
        case 4:
          //debug("State: " + this.readyState +  " Status: " + this.status + " / " + this.responseText);
          //inlinePopUp(node("div", [], node("h1", [], text(this.status.toString())), text((this.status == 200) ? this.responseText : this.responseText)));
          switch (this.status) {
          case 200:
    	      this.fn.call(this, this.responseText, this.responseXML, this.timer);
            break;
          default:
            this.abort();
            this.error.call(this, this.responseText, this.responseXML, this.timer);
            return;
            break;}
          break;
        default:
          //debug("State: " + this.readyState + " Status: " + this.status + " / " + this.responseText);
          //inlinePopUp(node("div", [], text("Error: " + this.status.toString() + " / " + this.responseText)));
          break;}
        return;
      } catch(error) {debug(error); return;}}
    
    function xhrDefaultFn(body) {
      var element = document.createElement("textarea");
      document.body.appendChild(element);
      element.style.width = "100%";
      element.innerHTML = body;
      return;}
    
    
    // Use FN for callback; store any data in the object returned from the call to XHR
    function xhr(url, /*optional*/ fn, error, timeout, timeoutfn) {

      var http = new XMLHttpRequest();
        http.get = function xhrGet(/*optional*/ asynchronous) {
          http.open("GET", url, undef(asynchronous, true));
          //http.onabort = timeoutfn;
          http.timer = setTimeout(function(){http.abort(); timeoutfn();}, timeout ? timeout : 8000);
        http.send()
        return http;};
    
        http.post = function xhrPost(params, /*optional*/ asynchronous) {
        http.open("POST", url, undef(asynchronous, true));
          //http.abort = timeoutfn;
        http.timer = setTimeout(function(){http.abort(); timeoutfn();}, timeout ? timeout : 8000);
        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        http.setRequestHeader("Content-length", params.length);
        http.setRequestHeader("Connection", "close");
        http.send(params);
        return http;}
    
      http.onreadystatechange = xhrChange;
      http.fn = undef(fn, xhrDefaultFn);
      http.error = undef(error, xhrDefaultError);
      http.url = url;
      //http.send(null); // allow caller to send post data or store ancillay data in the http request obect
      return http;}
      // -- end of "make XHR / AJAX easy"


    function formLoad()
        {
        SetScreen(1300, 1050);
        runTest();
        }

	function pressEnter() 
		{
		if (event.keyCode == 13)
			{
	
				clickSubmit();
			}
		}
		
    function runTest(id)
        {
        id = id ? id : nextServer++;
		
        if (!serverSequence[id]) 
			{
			return;
			}
			
			ServerID = serverSequence[id];		
			//alert(ServerID);
				(function(placeId) 
					{
					var place = placeId
					return function() 
					{

					var successFn = function(ignore, r, timer) 
						{
						clearTimeout(timer);
						getUpdateResponse(ignore, r, place);
						};

					var errorFn = function(r, ignore, timer) 
						{
						clearTimeout(timer);
						errorfn(r, ignore, place);
						};

					var timeoutFn = function(ignore, ignore2, timer) 
						{
						clearTimeout(timer);
						linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + place)[0].firstChild);
						}

					var http = xhr(ajaxURL[ServerID], successFn, errorFn, 5000, timeoutFn);
					errorFn.timer = http.timer;
					successFn = http.timer;
					http.get();
					return http;
					}
				})
			(serverSequence[id])();
        }

    function getUpdateResponse(ignore, r, ServerID)
		{
		if (!r) 
			{
				return errorfn(ignore, r, ServerID);
			}
		if (r.querySelectorAll("error_code")[0] && r.querySelectorAll("error_code")[0].nodeValue && (["", "0"].indexOf(r.querySelectorAll("error_code")[0].nodeValue) = -1))
			{
				return errorfn(ignore, r, ServerID);
			}
		if (r.querySelectorAll("error_message")[0] && r.querySelectorAll("error_message")[0].firstChild.nodeValue && (["", "No Errors"].indexOf(r.querySelectorAll("error_message")[0].firstChild.nodeValue) < 0)) 
			{
				return errorfn(ignore, r, ServerID);
			}
		document.querySelectorAll("#city" + ServerID)[0].innerHTML = "";
    
		function set(key, /* optional */ tag) 
			{
			var element = document.querySelectorAll("#" + key + ServerID.toString())[0];
			if (!element) {return};
			element.innerHTML = r.querySelectorAll(tag ? tag : key)[0].firstChild ? r.querySelectorAll(tag ? tag : key)[0].firstChild.nodeValue : "";
			}
			
		[["zip"], ["rate"], ["city"], ["county"], ["state"], ["shipping", "shippingtaxable"], ["server"]]
		.forEach(function(e) {set.apply(null, e);});
		
		runTest();
		}

    function errorfn(r, ignore, ServerID) 
        {
        var element = document.querySelectorAll("#city" + ServerID)[0];
        if (r && r.length > 0) {
          linkToError("ajax error", r.toString())(element.firstChild);}
        else if (!element.marked) {
          // For some reason http://www.zip2tax.info/z2t_Backoffice/subscribers/popups/Ajax/z2t_DatabaseTest_Barley2.asp fails silently, returning a blank page when the password is not specified.
          element.innerHTML = "<span class=\"error\">ajax error: no details.</span>";}
        runTest();
        }

	function clickSubmit()
        {
			
        var URL = 'z2t_LinkTest.asp?zip=' + document.frm.zip.value +'&usr=<%=Request("usr")%>' +'&pwd=<%=Request("pwd")%>&v=1.1';
        window.location = URL;
        }

  </script>

</head>

<body onload="formLoad();">

<table width="1150" border="0" cellspacing="0" cellpadding="0" align="center">
  <form method="post" action="z2t_LinkTest.asp" name="frm">

  <tr>
    <td>
      <table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr>
          <td class="popupHeading">
            Zip2Tax.com Service Test
          </td>
        </tr>
	  </table>
	</td>
  </tr>
	  
  <tr>
    <td>	  
      <table border="0" cellspacing="2" cellpadding="2">
	
		<tr>
		  <td align="left">
			ZIP Code
			<input type="Text" name="zip" value="<%=RequestZip%>" size="10" onkeydown="pressEnter();"/>
			<input type="hidden" value="<%=request("usr")%>" name ="usr">
			<input type="hidden" value="<%=request("pwd")%>" name ="pwd">
		  </td>
		  <td align="left">
			<a href="javascript:clickSubmit();" class="bo_Button80">Go</a>
		  </td>
		</tr>

	  </table>
	</td>
  </tr>
  	
  <tr>
    <td>	  
	
    <table width="100%" border="0" cellspacing="2" cellpadding="2">
      <tr valign="top">
        <td colspan="7" class="databaseHead">
          Legacy - Microsoft SQL Server Database
        </td>
      </tr>

      <tr valign="top">
	    <%=DisplayTestBlockHead%>
	    <%=DisplayTestBlock (12,"Philly03", "Website", 13)%>
   	    <%=DisplayTestBlock (10,"Casper06", "Website", 14)%>
	    <%=DisplayTestBlock (1, "Frank02", "Website", 15)%>
	    <!--%'=DisplayTestBlock (17,"Frank03", "Website", 9)%-->
	    <%=DisplayTestBlock (9, "Philly05", "Website (Staging)", 17)%>
	    <%=DisplayTestBlock (2, "Casper09", "Website (dev)", 18)%>
        <td width="14%">&nbsp;</td>
      </tr>
	</table>
	  
    <table width="100%" border="0" cellspacing="2" cellpadding="2">
      <tr valign="top">
        <td colspan="3" class="databaseHead">
          Legacy - Microsoft SQL Server Database
        </td>
		<td>&nbsp;</td>
		<td colspan="3" class="databaseHead">
		  Legacy - MySQL Database
		</td>
      </tr>
	  
      <tr valign="top">
	    <%=DisplayTestBlockHead%>
	    <%=DisplayTestBlock (13,"Philly01", "LinkAPI", 12)%>
	    <%=DisplayTestBlock (3, "Various", "Req Var", 5)%>
        <td width="14%">&nbsp;</td>
        <td width="14%">&nbsp;</td>
	    <%=DisplayTestBlock (5, "Philly01", "Link", 7)%>
        <td width="14%">&nbsp;</td>
      </tr>
    </table>

	

    <table width="100%" border="0" cellspacing="2" cellpadding="2">
      <tr valign="top">
            <td colspan="7" class="databaseHead">
              API
            </td>
          </tr>

      <tr valign="top">
	    <%=DisplayTestBlockHead%>
	    <%=DisplayTestBlock (6, "Philly02", "API", 8)%>
	    <%=DisplayTestBlock (7, "Philly04", "API", 9)%>
	    <%=DisplayTestBlock (8, "Casper06", "API", 10)%>'
   	    <%=DisplayTestBlock (14, "Frank02", "API", 19)%>		
   		<%=DisplayTestBlock (4, "Casper09", "API (dev)", 22)%>
	    <%=DisplayTestBlock (11, "Philly05", "API (Staging)", 21)%>		
        <td width="14%">&nbsp;</td>
      </tr>
    </table>


        <table width="100%" border="0" cellspacing="5" cellpadding="5">
      <tr>
        <td align="center">
        <br>
                <a href="javascript:close();" class="bo_Button100">Ok</a>
        </td>
      </tr>
        </table>

    </td>
  </tr>
  </form>
</table>

</body>
</html>

<%
	Function DisplayTestBlockHead
		s = "<td width='16%'>" & vbCrLf
        s = s & "  <table width='100%' border='0' cellspacing='2' cellpadding='2'>" & vbCrLf
        s = s & "    <tr><td class='subHead1'>Server</td></tr>" & vbCrLf
        s = s & "    <tr><td class='subHead2'>Purpose</td></tr>" & vbCrLf
        s = s & "    <tr><td align='right'>ZIP Code:</td></tr>" & vbCrLf
        s = s & "    <tr><td align='right'>Sales Tax Rate:</td></tr>" & vbCrLf
        s = s & "    <tr><td align='right'>Post Office City/State:</td></tr>" & vbCrLf
        s = s & "    <tr><td align='right'>County:</td></tr>" & vbCrLf
        s = s & "    <tr><td align='right'>Shipping Taxable:</td></tr>" & vbCrLf
        s = s & "    <tr><td align='right'>Server:</td></tr>" & vbCrLf
        s = s & "  </table>" & vbCrLf
        s = s & "</td>" & vbCrLf

		DisplayTestBlockHead = s
	End Function

	Function DisplayTestBlock (TestID, ServerName, Purpose, HelpID)
	
		s = "<td width='14%'>" & vbCrLf
        s = s & "  <table width='100%' border='0' cellspacing='2' cellpadding='2' align='center'>" & vbCrLf
        s = s & "    <tr>" & vbCrLf
        s = s & "      <td class='subHead1'>" & ServerName & vbCrLf
        s = s & "        <a href='javascript:help(" & HelpID & ");'>" & HelpImage & "</a>" & vbCrLf
        s = s & "        <a href='" & AjaxURL(TestID) & "' Target='AjaxURL' style='font-size: 8pt; color: #000000;'>URL</a>" & vbCrLf
        s = s & "      </td>" & vbCrLf
        s = s & "    </tr>" & vbCrLf
        s = s & "    <tr>" & vbCrLf
        s = s & "      <td class='subHead2'>" & vbCrLf
		s = s & "	     " & Purpose & vbCrLf
        s = s & "      </td>" & vbCrLf
        s = s & "    </tr>" & vbCrLf
        s = s & "    <tr><td align='center' id='zip" & TestID & "'>&nbsp;</td></tr>" & vbCrLf
        s = s & "    <tr><td align='center' id='rate" & TestID & "'>&nbsp;</td></tr>" & vbCrLf
        s = s & "    <tr><td align='center'>"
		s = s & "      <span id='city" & TestID & "'><img class='loading' src=" & AjaxLoadingGif & " /></span>"
		s = s & "      <span id='state" & TestID & "'></span>"
		s = s & "    </td></tr>" & vbCrLf
        s = s & "    <tr><td align='center' id='county" & TestID & "'>&nbsp;</td></tr>" & vbCrLf
        s = s & "    <tr><td align='center' id='shipping" & TestID & "'>&nbsp;</td></tr>" & vbCrLf
        s = s & "    <tr><td align='center' id='server" & TestID & "'>&nbsp;</td></tr>" & vbCrLf
		

		If TestID = 17 or TestID = 15 Then
			s = s & "    <tr><td align='center' class = 'error'>fake data</td></tr>" & vbCrLf
		End If

        s = s & "  </table>" & vbCrLf
        s = s & "</td>" & vbCrLf
		
		DisplayTestBlock = s
		
	End Function
	
%>
