<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<!--#include virtual="/z2t_Backoffice/includes/config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
	
<html>
<head>
    <title>Zip2Tax.info | Back Office Login</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css" rel="stylesheet">
    
    <script type="text/javascript" language="javascript">
function keyPress(field, e)
    {
    var key;

    if (e)
        key = e.which;
    else if (!(window.event == null))
        key = window.event.keyCode;
    else
        return true;

    // Enter key hit
    if (key == 13) 
        {
        key = 0;
        switch (field) {
          case 'lname':
            {
            document.getElementById('pass').focus();
            return false;
            }
          case 'pass':
            {
            document.getElementById("login").submit()
            return false;
            }}
        }
    return true;
}

window.onload = function() {document.getElementById("lname").focus()}
    </script>
</head>
<body>
	<form method="get" action="/z2t_Backoffice/z2t_login.asp" name="frm" id="login">
	<input name="ReturnPage" type="hidden" value="<%=Request("ReturnPage")%>"></input>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td style="margin-top: 60px;">

				<table width="600" border="0" cellspacing="5" cellpadding="5" align="center">
				  <tr><td>&nbsp;</td></tr>
				  <tr><td>&nbsp;</td></tr>
				  <tr>
					<td align="center" style="font-size: 14pt; font-weight: bold; color: white;">
					  <img src="<%=strPathImages%>z2t-icon.png" vAlign="middle" alt='Zip2Tax Logo'>
					  Zip2Tax Backoffice
					</td>
				  </tr>
				</table>	

<%
	ReturnPage = Request("ReturnPage")
	If ReturnPage = "" Then ReturnPage = "/z2t_BackOffice/Home/z2t_Home.asp"

	'Protect against injection attacks
	LoginID = left(Request("lname"), 20)
	Password = left(Request("pass"), 20)
	
	If LoginID = "" then
		strMessage = "Please Sign In"
	ElseIf Password = "" then
		strMessage = "You must enter a password"
	Else
		'SQL="select * from z2t_accounts " & _
		'"where login='" & LoginID & "'" & _
		'" and password='" & Password & "'" & _
		'" order by case status when 'admin' then 0 else 1 end, status"   'Sort "admin" status first
    'Response.Write(SQL): Response.End
		'set RS=server.createObject("ADODB.Recordset")
		'RS.open SQL,connPublic,2,3
	
	
		
			sql = "z2t_Login('" & LoginID & "', '" & Password & "','"& Request.servervariables("REMOTE_ADDR") & "','',0)"
			'response.Write(sql)
			'response.End()
			rs.open sql, connBackoffice, 3, 3, 4
	
If rs.EOF then
			Session("z2t_status") = "Incorrect"
			Session("z2t_AccountID") = ""
			Session("z2t_loggedin") = ""
			Session("z2t_UserName") = ""
			Session("z2t_login") = ""
			Session("z2t_ShortName") = ""
			Session("usrPass") = "" 
			strMessage = "Login Incorrect.  Please try again."
	Else

	
'			Session("z2t_status") = "admin"  ''"davewj2o","get2it"''rs("LoginStatus")
'			Session("z2t_AccountID") =  1 ''rs("AccountID")
'			Session("z2t_loggedin") = "True"
'			Session("z2t_UserName") = "davewj2o"''LoginID
'			Session("z2t_login") = "davewj2o"''LoginID
'			Session("z2t_ShortName") = "Dave"''rs("ShortName")
			
				'Session("z2t_status") = rs("Status")
				Session("z2t_status") = rs("Z2t_Status")
				Session("z2t_AccountID") = rs("HarvestID")
				Session("z2t_loggedin") = "True"
				Session("z2t_UserName") = LoginID
				Session("z2t_login") = LoginID
				Session("z2t_ShortName") = rs("UserName")
				Session("usrPass") = Password
			
		End If		    

		 rs.close
		set rs = nothing
	End If

	'If Session("z2t_loggedin")="True" then
    If UCASE(Session("z2t_LoggedIn"))="TRUE" _
		And UCASE(Session("z2t_Status"))="ADMIN" Then
		If instr(Request.ServerVariables("PATH_INFO"), "z2t_login.asp") Then
			'I think we started with the login page so send me home
	''		ReturnPage = "https://www.zip2tax.info/z2t_Backoffice/Home/z2t_Home.asp"
ReturnPage = "http://info.zip2tax.com/z2t_Backoffice/home/z2t_Home.asp"
	
		Else
			'Send me to the page I was on prior to login
			ReturnPage = "https://info.zip2tax.com" & Request.ServerVariables("PATH_INFO")
		End If

		'Response.Write "<span style='color: #FFFFFF; font-size: 12pt;'>"
		'Response.Write "ReturnPage: [" & Request("ReturnPage") & "] - " & ReturnPage & "<br>"
		'response.write Session("z2t_status") & "<br>"
		'response.write Session("z2t_UserName") & "<br>"
		'response.write Session("z2t_loggedin") & "<br>"
		'response.write Session("z2t_accountid") & "<br>"
		'Response.Write "</span>"
		'Response.End
		
		Response.redirect ReturnPage
	End If		
	%>

				<table width="600" border="0" cellspacing="5" cellpadding="5" align="center">
					<tr><td>&nbsp;</td></tr>
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td colspan="2" align="center" class="white">
							<span id="LoginMessage">
								<b><%=strMessage%></b>
							</span>
						</td>		 
					</tr>

					<tr>
						<td width="40%" align="right" class="white">
						<b>User Name:</b>
						</td>
						<td width="60%" align="left">
						<input type="text" name="lname" id="lname" onkeydown='javascript:keyPress(this.id.toString(), event); void(0);'></input>
						</td>		 
					</tr>

					<tr>
						<td align="right" class="white">
						<b>Password:</b>
						</td>
						<td align="left">
						<input type="password" name="pass" id="pass" onkeydown='javascript:keyPress(this.id.toString(), event); void(0);'></input>
						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>
					<tr><td colspan="2" style="font-size: 10pt; color: white;">
						This is your administrator's account set in the Number-it Backoffice under a Zip2Tax Subscription
					</td></tr>
					<tr><td>&nbsp;</td></tr>

				</table>

				<table width="100%" border="0" cellspacing="5" cellpadding="0">
					<tr>
						<td align="right">
							<a href="javascript:document.frm.submit()" class="buttonGray">Submit</a>
						</td>
						<td align="left">
							<a href="javascript:void(window.location = '<%=Request.ServerVariables("HTTP_REFERER")%>');" class="buttonGray">Cancel</a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	</form>
</body>
</html>
