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
        
    function runTest()
    {
        var ServerID;
        var http = [];
            
        var successFn0 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[0]);
        };

        var errorFn0 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[0]);
        };

        var timeoutFn0 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[0])[0].firstChild);
        }

        var successFn1 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[1]);
        };

        var errorFn1 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[1]);
        };

        var timeoutFn1 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[1])[0].firstChild);
        }

        var successFn2 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[2]);
        };

        var errorFn2 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[2]);
        };

        var timeoutFn2 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[2])[0].firstChild);
        }

        var successFn3 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[3]);
        };

        var errorFn3 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[3]);
        };

        var timeoutFn3 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[3])[0].firstChild);
        }

        var successFn4 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[4]);
        };

        var errorFn4 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[4]);
        };

        var timeoutFn4 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[4])[0].firstChild);
        }

        var successFn5 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[5]);
        };

        var errorFn5 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[5]);
        };

        var timeoutFn5 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[5])[0].firstChild);
        }

        var successFn6 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[6]);
        };

        var errorFn6 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[6]);
        };

        var timeoutFn6 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[6])[0].firstChild);
        }

        var successFn7 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[7]);
        };

        var errorFn7 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[7]);
        };

        var timeoutFn7 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[7])[0].firstChild);
        }

        var successFn8 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[8]);
        };

        var errorFn8 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[8]);
        };

        var timeoutFn8 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[8])[0].firstChild);
        }

        var successFn9 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[9]);
        };

        var errorFn9 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[9]);
        };

        var timeoutFn9 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[9])[0].firstChild);
        }

        var successFn10 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[10]);
        };

        var errorFn10 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[10]);
        };

        var timeoutFn10 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[10])[0].firstChild);
        }

        var successFn11 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[11]);
        };

        var errorFn11 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[11]);
        };

        var timeoutFn11 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[11])[0].firstChild);
        }

        var successFn12 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[12]);
        };

        var errorFn12 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[12]);
        };

        var timeoutFn12 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[12])[0].firstChild);
        }

        var successFn13 = function(ignore, r, timer) 
        {
            clearTimeout(timer);
            getUpdateResponse(ignore, r, serverSequence[13]);
        };

        var errorFn13 = function(r, ignore, timer) 
            {
            clearTimeout(timer);
            errorfn(r, ignore, serverSequence[13]);
        };

        var timeoutFn13 = function(ignore, ignore2, timer) 
        {
            clearTimeout(timer);
            linkToError("ajax timeout", "Timed out with no response.")(document.querySelectorAll("#city" + serverSequence[13])[0].firstChild);
        }

        ServerID = serverSequence[0];
        http[0] = xhr(ajaxURL[ServerID], successFn0, errorFn0, 15000, timeoutFn0);
        errorFn0.timer = http.timer;
        successFn0 = http.timer;
        http[0].get();

        ServerID = serverSequence[1];
        http[1] = xhr(ajaxURL[ServerID], successFn1, errorFn1, 15000, timeoutFn1);
        errorFn1.timer = http.timer;
        successFn1 = http.timer;
        http[1].get();

        ServerID = serverSequence[2];
        http[2] = xhr(ajaxURL[ServerID], successFn2, errorFn2, 15000, timeoutFn2);
        errorFn2.timer = http.timer;
        successFn2 = http.timer;
        http[2].get();

        ServerID = serverSequence[3];
        http[3] = xhr(ajaxURL[ServerID], successFn3, errorFn3, 15000, timeoutFn3);
        errorFn3.timer = http.timer;
        successFn3 = http.timer;
        http[3].get();

        ServerID = serverSequence[4];
        http[4] = xhr(ajaxURL[ServerID], successFn4, errorFn4, 15000, timeoutFn4);
        errorFn4.timer = http.timer;
        successFn4 = http.timer;
        http[4].get();

        ServerID = serverSequence[5];
        http[5] = xhr(ajaxURL[ServerID], successFn5, errorFn5, 15000, timeoutFn5);
        errorFn5.timer = http.timer;
        successFn5 = http.timer;
        http[5].get();

        ServerID = serverSequence[6];
        http[6] = xhr(ajaxURL[ServerID], successFn6, errorFn6, 15000, timeoutFn6);
        errorFn6.timer = http.timer;
        successFn6 = http.timer;
        http[6].get();

        ServerID = serverSequence[7];
        http[7] = xhr(ajaxURL[ServerID], successFn7, errorFn7, 15000, timeoutFn7);
        errorFn7.timer = http.timer;
        successFn7 = http.timer;
        http[7].get();

        ServerID = serverSequence[8];
        http[8] = xhr(ajaxURL[ServerID], successFn8, errorFn8, 15000, timeoutFn8);
        errorFn8.timer = http.timer;
        successFn8 = http.timer;
        http[8].get();

        ServerID = serverSequence[9];
        http[9] = xhr(ajaxURL[ServerID], successFn9, errorFn9, 15000, timeoutFn9);
        errorFn9.timer = http.timer;
        successFn9 = http.timer;
        http[9].get();

        ServerID = serverSequence[10];
        http[10] = xhr(ajaxURL[ServerID], successFn10, errorFn10, 15000, timeoutFn10);
        errorFn10.timer = http.timer;
        successFn10 = http.timer;
        http[10].get();

        ServerID = serverSequence[11];
        http[11] = xhr(ajaxURL[ServerID], successFn11, errorFn11, 15000, timeoutFn11);
        errorFn11.timer = http.timer;
        successFn11 = http.timer;
        http[11].get();

        ServerID = serverSequence[12];
        http[12] = xhr(ajaxURL[ServerID], successFn12, errorFn12, 15000, timeoutFn12);
        errorFn12.timer = http.timer;
        successFn12 = http.timer;
        http[12].get();

        ServerID = serverSequence[13];
        http[13] = xhr(ajaxURL[ServerID], successFn13, errorFn13, 15000, timeoutFn13);
        errorFn13.timer = http.timer;
        successFn13 = http.timer;
        http[13].get();
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
        
        // runTest();
        }

    function errorfn(r, ignore, ServerID) 
        {
        var element = document.querySelectorAll("#city" + ServerID)[0];
        if (r && r.length > 0) {
          linkToError("ajax error", r.toString())(element.firstChild);}
        else if (!element.marked) {
          // For some reason http://www.zip2tax.info/z2t_Backoffice/subscribers/popups/Ajax/z2t_DatabaseTest_Barley2.asp fails silently, returning a blank page when the password is not specified.
          element.innerHTML = "<span class=\"error\">ajax error: no details.</span>";}
        // runTest();
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
        s = s & "        " & Purpose & vbCrLf
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
