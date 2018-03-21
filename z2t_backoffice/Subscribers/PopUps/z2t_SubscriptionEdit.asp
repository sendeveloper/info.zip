<% 

''''' Changelog
'
' <2011-03-14 Mon nathan> Conformed default values for eStartDate and sExpirationDate to `mm/dd/yyyy' format.
' <2011-03-15 Tue dave> Added ajax functions
' <2011-03-22 Tue dave> Added button to auto generate a login and password
' <2012-01-16 Mon nathan> Make popup more mobile-friendly.
' <2012-02-06 Mon dave> Add database shutoff date field.
' <2012-08-06 Mon nathan> Add online login status for new Z2T/PinPoint product
' <2012-10-09 Tue dave> Use connections for the server that the data is located on to eliminate cross server requests
' <2013-08-01 Thr dave> Port over to Zip2Tax.info on Philly05
' <2013-11-14 Thr dave> Add lookup limit field
' <2014-06-12 Thr dave> Add Use Tax for Database Interface Subscribers

%>
<%
        Response.buffer=true
        Response.clear
        Dim strMessage
        Dim strMode
%>

<!--#include file="includes/z2t_connection.asp"-->
<!--#include virtual='z2t_BackOffice/includes/help/helpDiv.inc'-->

<%

    Dim eSubscriptionServiceLevel: eSubscriptionServiceLevel = 0
    Dim eSubscriptionPeriod: eSubscriptionPeriod = 0

	Dim z2tID
	
	'Shape the passed in variables
	If Request("z2tID")="" or isnull(Request("z2tID")) then
		z2tID = 0
	Else
		z2tID = Request("z2tID")
	End If
	
	If Request("HarvestID")="" or isnull(Request("HarvestID")) then
		If Session("HarvestID")="" or isnull(Session("HarvestID")) then
			Session("HarvestID") = 0
		End If
	Else
		Session("HarvestID") = Request("HarvestID")
	End If
	
	If Request("User")="" or isnull(Request("User")) then
	Else
		Session("User") = Request("User")
	End If
	
	'Set up the variables for the controls
    If z2tID=0 Then
		'Must be we're new here?
        Title = "Add Zip2Tax Product"

        SQL="z2t_Login_Password_read(" & cStr(Session("HarvestID")) & ")" 
        rs.open SQL,connPublic, 3, 3, 4

        if rs.eof then
            eLogin = ""
            ePassword = ""
        else
            eLogin = rs("Login")
            ePassword = rs("Password")
        end if

        rs.close

        eSubscriptionType = ""
        eAutoRenew = ""
		eLookupLimit = 1000
        eStartDate =      Right("00" & DatePart("m",Date()), 2) & "/" & _
                          Right("00" & DatePart("d", Date()), 2) & "/" & _
                          Right("0000" & DatePart("yyyy", Date()), 4)
        eExpirationDate = Right("00" & DatePart("m",Date()), 2) & "/" & _
                          Right("00" & DatePart("d", Date()), 2) & "/" & _
                          Right("0000" & DatePart("yyyy", Date()), 4)
        eSubscriptionType = ""
        eSubscriptionServicelevel = 0
        eSubscriptionPeriod = 0
		eShutOffDate = ""
        eDatabaseLinkSingleState = ""
        eStateString = ""
        eStateStringInitialTable = ""
        eEmailNotification1 = ""
        eEmailNotification2 = ""
        eEmailNotification3 = ""
        eTableType = ""
        eSpecialTableNYClothing = ""
        eNote = ""
    Else
        Title = "Zip2Tax Product Edit"

        SQL="z2t_Subscription_read(" & cStr(z2tID) & ")"
        rs.open SQL,connPublic, 3, 3, 4

        eLogin = rs("Login")
        ePassword = rs("Password")
        eSubscriptionType = rs("SubscriptionType")
        eSubscriptionServicelevel = rs("SubscriptionServiceLevel")
			If isNull(eSubscriptionServicelevel) Then eSubscriptionServicelevel = 0
        eSubscriptionPeriod = rs("SubscriptionPeriod")
			If isNull(eSubscriptionPeriod) Then eSubscriptionPeriod = 0
        eAutoRenew = rs("AutoRenew")
		eLookupLimit = rs("LookupLimit")
        eStartDate = rs("StartDate")
        eExpirationDate = rs("ExpirationDate")
        eShutOffDate = rs("ShutoffDate")
		eOriginalExpirationDate = rs("OriginalExpirationDate")
        eDatabaseLinkSingleState = rs("DatabaseLinkSingleState")
        eStateString = rs("StateString")
        eStateStringInitialTable = rs("StateStringInitialTable")
        eEmailNotification1 = rs("EmailNotification1")
        eEmailNotification2 = rs("EmailNotification2")
        eEmailNotification3 = rs("EmailNotification3")
        eTableType = rs("TableType")
        eSpecialTableNYClothing = rs("SpecialTableNYClothing")
        eNote = rs("Note")

        rs.close

        'Dim eOriginalExpirationDate
        SQL = "select OriginalExpirationDate " &_
              "from z2t_BackOffice.dbo.z2t_Subscriptions " &_
              "where z2t_AccountId = " & cStr(z2tID) & " " &_ 
              "and DeletedDate is null"
        'Response.Write(SQL)
        'rs.open SQL, connDallas, 2, 2, 1
        'If rs.eof Then
          'eOriginalExpirationDate = ""
        'Else
          'eOriginalExpirationDate = rs("OriginalExpirationDate")
        'End If
        'rs.close

        Select Case eSubscriptionType
          Case "online", "annual", "semi", "quart", "month","link"
            SQL = "z2t_WebPublic.dbo.z2t_LookupAddons_hasAddon(" + cStr(z2tID) + ", 2)"
            rs.open SQL, connPublic, 3, 3, 4
            If rs.eof Then
              eUseTax = "N"
            Else
              eUseTax = "Y"
            End If
            rs.close
          Case Else eUseTax = "T"
        End Select
    End If

    DateCaption = "<img src=""/z2t_BackOffice/includes/dates/cal.gif"" " & _
                  "width=""16"" height=""16"" border=""0"" alt=""Calendar""></a>" & _
                  "<span class=""small-text"" style=""margin-left: .5em"">[mm/dd/yyyy]</span>"
%>
<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
	
    <script language="JavaScript" src="/z2t_BackOffice/includes/dates/checkDate.js" type="text/javascript"></script>
    <script language="JavaScript" src="/z2t_BackOffice/includes/dates/ts_picker.js" type="text/javascript"></script>
    <script language="JavaScript" src="./includes/z2t_SubscriptionEditFunctions.js" type="text/javascript"></script>
    <script language="JavaScript" src="/z2t_BackOffice/includes/help/help.js"></script>

<script language="javascript" type = "text/javascript">

    var httpUnique = new XMLHttpRequest();
    var httpGenerate = new XMLHttpRequest();
    var subFolder = '<%=strPathIncludes%>dates/';
    var DateEntry = 'mm/dd/yyyy';
	var subTypeInitial = '';
	var stateStringInitial = '<%=eStateString&eStateStringInitialTable%>';

    var eLoginCount = 0;
    var ePasswordCount = 0;
    var HarvestID = <%=Session("HarvestID")%>;

    var focusLogin = '';
    var focusPassword = '';

    var monthName=new Array(12);
    monthName[0]='January';
    monthName[1]='February';
    monthName[2]='March';
    monthName[3]='April';
    monthName[4]='May';
    monthName[5]='June';
    monthName[6]='July';
    monthName[7]='August';
    monthName[8]='September';
    monthName[9]='October';
    monthName[10]='November';
    monthName[11]='December';

    function clickCancel()
        {
		if (subTypeInitial == 'Tab' && stateStringInitial == '')
			{
			alert('The subscription type is set to Tables but you have no States selected.');
			}
		else
			{
			window.close();
			}
		}
		
    function clickSubmit()
        {
        lostFocusLogin();
        lostFocusPassword();

        var s = document.getElementById('Login').value
        if (s == '')
            {
            alert('You must enter a Login');
            return;
            }

        var s = document.getElementById('Password').value
        if (s == '')
            {
            alert('You must enter a Password');
            return;
            }

        if (eLoginCount > 0)
            {
            //alert('You need to create a unique login before submitting');
			if (confirm('Do you wish to proceed even though the login is not unique?') == false)
				{
				return;
				}
            }        
        if (ePasswordCount > 0)
            {
            //alert('You need to create a unique password before submitting');
			if (confirm('Do you wish to proceed even though the password is not unique?') == false)
				{
				return;
				}
            }        

        document.frm.submit();
        }

    function clickCopyExpiration(event) {
      get("#OriginalExpirationDate").value = get("#ExpirationDate").value;
      get("#ExpirationDate").focus();
      get("#ExpirationDate").select();
      return;}
		
    function clickGenerate()
        {
        var aPage = "includes/z2t_Password_Create.asp" +
            "?id=" + HarvestID;

        httpGenerate.open("GET", aPage, true);
        httpGenerate.onreadystatechange = readGenerate;
        httpGenerate.send(null);
        }

    function readGenerate()
        {
        if (httpGenerate.readyState == 4) 
            {
            var r = httpGenerate.responseText.split(",");
            //alert(r[0] + '|' + r[1]);
            document.getElementById('Login').value = r[0];
            document.getElementById('Password').value = r[1];
			checkUnique();
            }
        }

    function displayUniques()
        {
        //alert(eLoginCount + ' ' + ePasswordCount);
        //alert(document.getElementById('Login').value);
        var s = document.getElementById('msgUL');
        if (document.getElementById('Login').value == '')
            {
            s.innerHTML = '';
            }
        else
            {
            if (eLoginCount > 0)
                {
                s.innerHTML = 'Login Not Unique';
                s.style.color = 'red';
                }
            else
                {
                s.innerHTML = 'Unique Login';
                s.style.color = 'black';
                }
            }

        var s = document.getElementById('msgUP');
        if (document.getElementById('Password').value == '')
            {
            s.innerHTML = '';
            }
        else
            {
            if (ePasswordCount > 0)
                {
                s.innerHTML = 'Password Not Unique';
                s.style.color = 'red';
                }
            else
                {
                s.innerHTML = 'Unique Password';
                s.style.color = 'black';
                }
            }
        }


    function formLoad(event) {
        SetScreen(850,800);
        setShading();
        setFirstMonth();
        setLastMonth();
		
        focusLogin = document.getElementById('Login').value + '';
        focusPassword = document.getElementById('Password').value + '';

        //Set-up unique messages
        //eLoginCount = '<%=eLoginCount%>';
        //ePasswordCount = '<%=ePasswordCount%>';
        document.getElementById('msgUL').style.fontWeight = 'bold';
        document.getElementById('msgUP').style.fontWeight = 'bold';
        checkUnique();
        displayUniques();
        get("#copy-expiry").style.left = px(get("#generate").offsetLeft - get("#copy-expiry").offsetLeft);		
		}

	function changedLookupLimitWeb()
		{
		document.getElementById('LookupLimitLink').value = document.getElementById('LookupLimitWeb').value;
		}

	function changedLookupLimitLink()
		{
		document.getElementById('LookupLimitWeb').value = document.getElementById('LookupLimitLink').value;
		}
		
	function checkUnique() 
        {
        var l = document.getElementById('Login').value;
        var p = document.getElementById('Password').value;

        if (l != '')
            {
            if (l.length < 4)
                {
                alert('Login must be at least 4 characters long!');
                document.getElementById('Login').focus();
                return;
                }
            }

        if (p != '')
            {
            if (p.length < 4)
                {
                alert('Password must be at least 4 characters long!');
                document.getElementById('Password').focus();
                return;
                }
            }

        if (l != '' || p != '')
            {
                {
                var aPage = "includes/z2t_CheckUniqueLoginPassword.asp" +
                    "?id=" + HarvestID +
                    "&l=" + escape(l) +
                    "&p=" + escape(p)

                httpUnique.open("GET", aPage, true);
                httpUnique.onreadystatechange = readUnique;
                httpUnique.send(null);
                }
            }
        }

        function readUnique()
            {
            if (httpUnique.readyState == 4) 
                {
                var r = httpUnique.responseText.split(",");
                //alert(r[0] + '|' + r[1]);
                eLoginCount = r[0];
                ePasswordCount = r[1];
                //alert(eLoginCount + ' ' + ePasswordCount);
                displayUniques();
                }
            }


    function gotFocusLogin()
        {
        focusLogin = document.getElementById('Login').value;
        }

    function gotFocusPassword()
        {
        focusPassword = document.getElementById('Password').value;
        }

    function lostFocusLogin()
        {
        if (focusLogin != document.getElementById('Login').value)
            {
            checkUnique(); 
            }
        if (document.getElementById('Login').value == '')
            {
            document.getElementById('msgUL').innerHTML = '';
            }
        }

    function lostFocusPassword()
        {
        if (focusPassword != document.getElementById('Password').value)
            {
            checkUnique(); 
            }
        if (document.getElementById('Password').value == '')
            {
            document.getElementById('msgUP').innerHTML = '';
            }
        }

    function setFirstMonth()
        {
        var startDate = document.getElementById('StartDate');
        if (isDate(startDate.value) == true)
            {
            var sDate = new Date(startDate.value);
            document.getElementById('firstTable').innerHTML = monthName[sDate.getMonth()] + ' ' + sDate.getFullYear();
            }
        else
            {
            document.getElementById('firstTable').innerHTML = '';
            }
        }

    function setLastMonth()
        {
        var expirationDate = document.getElementById('ExpirationDate');
        if (isDate(expirationDate.value) == true)
            {
            var sDate = new Date(expirationDate.value);
            document.getElementById('lastTable').innerHTML = monthName[sDate.getMonth()] + ' ' + sDate.getFullYear();
            }
        else
            {
            document.getElementById('lastTable').innerHTML = '';
            }
        }

    function setShading()
        {
        var t1 = document.getElementById('t1');
        var t2 = document.getElementById('t2');
        var t3 = document.getElementById('t3');

        var i = document.forms[0].SubscriptionType.selectedIndex;
        var s = document.forms[0].SubscriptionType.options[i].text;
        var subType = s.match(/(...)/);
        subType = subType ? subType[1] : "";
        t1.style.display = ((subType == 'Onl') || (subType == 'Web')) ? 'block' : 'none';
        t2.style.display = (subType == 'Dat') ? 'block' : 'none';
        t3.style.display = (subType == 'Tab') ? 'block' : 'none';
		
		if (subType == 'Tab')
			{
			document.getElementById('buttonsNext').style.display='block';
			document.getElementById('buttonsSubmit').style.display='none';
			}
		else
			{
			document.getElementById('buttonsNext').style.display='none';
			document.getElementById('buttonsSubmit').style.display='block';
			}
			
		if (subTypeInitial == '')
			{
			subTypeInitial = subType;
			}
        }

</script>


<style type="text/css">

div.subDetails
        {
        margin-top: 2em;
        margin-left: auto;
        margin-right: auto;
        padding: .5em;
        min-width: 20em;
        max-width: 100%;
        text-align: left;
        border: 2px solid black;
        display: inline-block;
        }

span.small-text
        {
        font-size: 10px;
        }

span.comment
        {
        color: #999999;
        overflow: hidden;
        white-space: normal;
        display: inline-block;
        width: 40%;
        margin-left: 3em;
        margin-right: 2em;
        text-align: left;
        }

label.field 
        {
        display: inline-block; 
        width: 25%;
        font-size: 9pt;
        font-weight: bold;
        text-align: right; 
        margin-left: 1em;
        }

.subDetails label.field
        {
        margin-left: 5%;
        }

.subDetails label.field
        {
        width: 20%;
        }

.subDetails span.non-comment
        {
        margin-left: auto;
        margin-right: .5em;
        width: 90%;
        display: inline-block;
        text-align: left;
        } 

input.field, select.field 
        {
        width: 35%;
        }

input.ynfield, select.ynfield 
        {
        width: 4em;
        }

input.email
        {
        display: inline-block; 
		width: 12em; 
		text-align: left;
        }

input.field, select.field, span.date
        {
        display: inline-block; 
        width: 15em;
        text-align: left;
        }

      
input.date 
       {
       display: inline-block; 
       width: 6em;
       }
   
	   
</style>

</head>


<body onLoad="formLoad()";>
  <form method="Post" action="z2t_SubscriptionPost.asp?z2tID=<%=cStr(z2tID)%>&HarvestID=<%=cStr(Session("HarvestID"))%>" name="frm">
	<span class="popupHeading"><%=Title%></span>
    <strong style="color: #000066"><%=strMessage%></strong><br>

    <label class="field" for="Login">Login</label>
  	  <span style="width: 50%; display: inline-block;">
		<input class="field" type="Text" name="Login" id="Login" value="<%=eLogin%>"
          onfocus="gotFocusLogin();"
          onblur="lostFocusLogin();">
		<span id="msgUL" name="msgUL" class="small-text"></span>
	  </span>
      <a href="Javascript:clickGenerate();" class="bo_Button100"
        title="Generate a new login and password based on the customer's name"
        style="display: inline-block;"
        id="generate">
        Generate New</a>
	<br>
    
    <label class="field" for="Password">Password</label>
    <input class="field" type="Text" name="Password" id="Password" value="<%=ePassword%>" size="20"
           onfocus="gotFocusPassword();"
           onblur="lostFocusPassword();">
    <span id="msgUP" name="msgUP" class="small-text"></span><br>

    <label class="field" for="SubscriptionType">Subscription Type</label>
    <select class="field" id="SubscriptionType" name="SubscriptionType" onchange="setShading();">
<%
    strSQL = "util_HTML_option_list('z2t_types', 'class', 'z2tLoginStatus', " & _
        "'value', 'description', 'sequence', '', '" & eSubscriptionType & "')"

    rs.open strSQL, connPhilly05, 3, 3, 4

    If not rs.eof Then
        While not rs.eof
          Response.Write chr(9) & rs("Result") & vbCrLf
          rs.movenext
        Wend
    End If

    rs.close
%>
    </select><br>

	
    <label class="field" for="SubscriptionServiceLevel">Subscription Level</label>
	<select class="field" id="SubscriptionServiceLevel" name="SubscriptionServiceLevel">
<%

	strSQL = "util_HTML_option_list('z2t_types', 'class', 'SubscriptionServiceLevel', " &_ 
		"'value', 'description', 'sequence', '', '" & cStr(eSubscriptionServiceLevel) & "')"

    rs.open strSQL, connPhilly05, 3, 3, 4
	
    If not rs.eof Then
        While not rs.eof
          Response.Write chr(9) & rs("Result") & vbCrLf
          rs.movenext
        Wend
    End If

    rs.close
  
%>
    </select><br>

    <label class="field" for="SubscriptionPeriod">Subscription Period</label>
    <select class="field" id="SubscriptionPeriod" name="SubscriptionPeriod">
<%
	strSQL = "util_HTML_option_list('z2t_types', 'class', 'SubscriptionPeriod', " &_ 
		"'value', 'description', 'sequence', '', '" & cStr(eSubscriptionPeriod) & "')"

    rs.open strSQL, connPhilly05, 3, 3, 4

    If not rs.eof Then
        While not rs.eof
          Response.Write chr(9) & rs("Result") & vbCrLf
          rs.movenext
        Wend
    End If

    rs.close
%>
    </select><br>

    <label class="field" for="AutoRenew">Automatic Renewal</label>
    <select class="ynfield" name="AutoRenew">
<%
    strSQL = "util_HTML_option_list('z2t_types', 'class', 'BlankYesNo', " & _
        "'value', 'description', 'sequence', '', '" & eAutoRenew & "')"

    rs.open strSQL, connPhilly05, 3, 3, 4

    If not rs.eof Then
        While not rs.eof
          Response.Write chr(9) & rs("Result") & vbCrLf
          rs.movenext
        Wend
    End If

    rs.close
%>
    </select><br>
    
    <label class="field" for="StartDate">Start Date</label>
    <input class="field date" type="text" name="StartDate" id="StartDate"
           size="10" Value = "<%=eStartDate%>"
           onblur="setFirstMonth();">
    <a href="javascript:show_calendar('document.frm.StartDate', document.frm.StartDate.value);">
      <%=DateCaption%></a><br>

    <label class="field" for="ExpirationDate">Expiration Date</label>
    <input class="field date" type="text" name="ExpirationDate" id="ExpirationDate"
           size="10" value="<%=eExpirationDate%>"
           onblur="setLastMonth();">
    <a href="javascript:show_calendar('document.frm.ExpirationDate', document.frm.ExpirationDate.value);">
      <%=DateCaption%></a><br>


    <label class="field" for="OriginalExpirationDate">Original Expiration Date</label>
	<span style="width: 50%; display: inline-block;">
		<input class="field date" type="text" name="OriginalExpirationDate" id="OriginalExpirationDate"
          size="10" value="<%=eOriginalExpirationDate%>"
          onblur="setLastMonth();">
		<a href="javascript:show_calendar('document.frm.OriginalExpirationDate', document.frm.ExpirationDate.value);">
		  <%=DateCaption%></a>
		<a href="javascript:help(2)"><%=HelpImage%></a>
	</span>
    <a href="Javascript:clickCopyExpiration();" class="bo_Button100"
       title='Copy the "Expiration Date" into the "Original Expiration Date"'
	   style="display: inline-block;"
       id="copy-expiry">
      Same as Exp.</a>


    <!-- Start Web Subscriber -------------------------------------------------- -->
    <div class="subDetails" id="t1" name="t1">
      <span class="subHead">Web Subscriber</span><br>


	  <!--Add On Use Tax-->
      <span class="non-comment" style="width: 100%; display: inline-block;">
        <label class="field" for="UseTax">Add on Use Tax</label>
        <select class="ynfield" name="UseTax">
<%
    strSQL = "util_HTML_option_list('z2t_types', 'class', 'BlankYesNo', " & _
        "'value', 'description', 'sequence', '', '" & eUseTax & "')"

    rs.open strSQL, connPhilly05, 3, 3, 4

    If not rs.eof Then
        While not rs.eof
          Response.Write rs("Result")
          rs.movenext
        Wend
    End If

    rs.close
%>
        </select>
	  </span>

	  <!--Lookup Limit-->
      <span class="non-comment" style="width: 100%; display: inline-block; margin-top: 10px;">
        <label class="field" for="LookupLimitBox"><br>Monthly Lookup Limit</label>
        <span class="date" name="LookupLimitBox">
          <input type="text" name="LookupLimitWeb" id="LookupLimitWeb" onChange="changedLookupLimitWeb();"
                 value="<%=eLookupLimit%>" size="10">
		  <span class="small-text" style="margin-left: .5em">[numbers only]</span>
		</span>
		<span class="comment small-text" style="margin-top: 10px;">
		  (This limit does not shut off a customer.  It is only used for our reporting.)
		</span>
      </span>
				
    </div>


    <!-- Start Database Link -------------------------------------------------- -->
    <div class="subDetails" ID="t2" Name="t2">
      <span class="subHead">Database Link</span><br>

      <span class="non-comment" style="width: 100%; display: inline-block; ">
        <label class="field" for="DatabaseLinkSingleState">State(s)</label>
        <select class="field" name="DatabaseLinkSingleState">
<%
    strSQL = "util_HTML_option_list('z2t_types', 'class', 'States', " & _
        "'value', 'description', 'sequence', '', '" & eDatabaseLinkSingleState & "')"

    rs.open strSQL, connPhilly05, 3, 3, 4

    If not rs.eof Then
        While not rs.eof
          Response.Write chr(9) & rs("Result") & vbCrLf
          rs.movenext
        Wend
    End If

    rs.close
%>
        </select>
		<span class="comment small-text">(Either a Single State or ALL)<br></span>
      </span>
      

      <span class="non-comment" style="width: 100%; display: inline-block; margin-top: 10px;">
        <label class="field" for="ShutOffDateBox"><br>Shutoff Date</label>
        <span class="date" name="ShutOffDateBox">
          <input class="field date" type="text" name="ShutOffDate" id="ShutOffDate"
                 value="<%=eShutOffDate%>"
                 onblur="setLastMonth();">
          <a href="javascript:show_calendar('document.frm.ShutOffDate', document.frm.ShutOffDate.value);">
            <%=DateCaption%></a></span>
		<span class="comment small-text" style="margin-top: 10px;">
		  (A date here, earlier than today, will shut the customer off regardless of the expiration date)
		</span>
      </span>
      
	  <!--Add On Use Tax-->
      <span class="non-comment" style="width: 100%; display: inline-block; margin-top: 10px;">
        <label class="field" for="UseTax1">Add on Use Tax</label>
        <select class="ynfield" name="UseTax1">
<%
    strSQL = "util_HTML_option_list('z2t_types', 'class', 'BlankYesNo', " & _
        "'value', 'description', 'sequence', '', '" & eUseTax & "')"

    rs.open strSQL, connPhilly05, 3, 3, 4

    If not rs.eof Then
        While not rs.eof
          Response.Write rs("Result")
          rs.movenext
        Wend
    End If

    rs.close
%>
        </select>
	  </span>
	  
	  <!--Lookup Limit-->
      <span class="non-comment" style="width: 100%; display: inline-block; margin-top: 10px;">
        <label class="field" for="LookupLimitBox"><br>Monthly Lookup Limit</label>
        <span class="date" name="LookupLimitBox">
          <input type="text" name="LookupLimitLink" id="LookupLimitLink" onChange="changedLookupLimitLink();"
                 value="<%=eLookupLimit%>" size="10">
		  <span class="small-text" style="margin-left: .5em">[numbers only]</span>
		</span>
		<span class="comment small-text" style="margin-top: 10px;">
		  (This limit does not shut off a customer.  It is only used for our reporting.)
		</span>
      </span>
	  
    </div>


    <!-- Start Table Purchase -------------------------------------------------- -->
    <div class="subDetails" ID="t3" Name="t3">
      <span class="subHead">Table Purchase</span><br>

      <span class="non-comment">
        <label class="field" for="firstTable">First Table</label>
        <span id="firstTable" class="small-text"></span>
      </span><br>

      <span class="non-comment">
        <label class="field" for="lastTable">Last Table</label>
        <span id="lastTable" class="small-text"></span>
      </span><br>

      <span class="non-comment">
        <label class="field" for="StateString">State List</label>
        <strong><%=eStateStringInitialTable%></strong>
      </span><br>

      <span class="non-comment">
        <label class="field" for="EmailNotification1">E-mail Notification 1</label>
        <input class="field email" type="Text" name="EmailNotification1" id="EmailNotification1" value="<%=eEmailNotification1%>" size="35">
      </span><br>

      <span class="non-comment">
        <label class="field" for="EmailNotification2">E-mail Notification 2</label>
        <input class="field email" type="Text" name="EmailNotification2" id="EmailNotification2" value="<%=eEmailNotification2%>" size="35">
      </span><br>

      <span class="non-comment">
        <label class="field" for="EmailNotification3">E-mail Notification 3</label>
        <input class="field email" type="Text" name="EmailNotification3" id="EmailNotification3" value="<%=eEmailNotification3%>" size="35">
      </span><br>

      <span class="non-comment">
        <label class="field" for="TableType">Table Type</label>
        <select class="field" name="TableType" style="width: 20em;">
<%
    strSQL = "util_HTML_option_list('z2t_types', 'class', 'TableType', " & _
        "'value', 'description', 'sequence', '', '" & eTableType & "')"

    rs.open strSQL, connPhilly05, 3, 3, 4

    If not rs.eof Then
        While not rs.eof
          Response.Write chr(9) & rs("Result") & vbCrLf
          rs.movenext
        Wend
    End If

    rs.close
%>
        </select>
      </span><br>

      <span class="non-comment">
        <label class="field" for="SpecialTableNYClothing">NY Clothing</label>
        <select class="ynfield" name="SpecialTableNYClothing">
<%

    strSQL = "util_HTML_option_list('z2t_types', 'class', 'NoYes', " & _
        "'value', 'description', 'sequence', '', '" & eSpecialTableNYClothing & "')"

    rs.open strSQL, connPhilly05, 3, 3, 4

    If not rs.eof Then
        While not rs.eof
          Response.Write chr(9) & rs("Result") & vbCrLf
          rs.movenext
        Wend
    End If

    rs.close
%>
        </select>
      </span><br>
    </div>

    <!-- Notes -->
    <div style="margin-top: 2em;">
      <span class="subHead" for="Note" style="margin-left: 0em;">Note</span>
	  <span style="">
		<input type="Text" name="Note" id="Note" value="<%=eNote%>" style="margin-left: 2em; display: inline-block; width: 90%;">
		<a href='javascript:help(1)'><%=HelpImage%></a>
	  </span>
	</div>
	
    <!-- Buttons -->
    <div ID="buttonsSubmit" Name="buttonsSubmit" class="center" style="margin-top: 2em; display: none;">
      <a href="javascript:clickSubmit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:clickCancel();" class="buttons bo_Button80">Cancel</a>
    </div>

    <div ID="buttonsNext" Name="buttonsNext" class="center" style="margin-top: 2em; display: none;">
      <a href="javascript:clickSubmit();" class="buttons bo_Button80">Next</a>
      <a href="javascript:clickCancel();" class="buttons bo_Button80">Cancel</a>
    </div>
    
  </form>

</body>
</html>
