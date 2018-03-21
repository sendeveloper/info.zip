<%
        Response.buffer=true
        Response.clear
%>

<!--#include file="includes/z2t_connection.asp"-->

<%

        Title = "Zip2Tax Display Name Edit"

        SQL="z2t_Subscription_read(" & Request("z2tID") & ")"
        rs.open SQL, connPublic, 3, 3, 4  'Barley2.z2t_WebPublic

        DebugData = 0
		eDisplayName = rs("DisplayName")
		eIsAdmin = rs("IsAdmin")
		
        rs.close

		If eIsAdmin > 0 Then
			'See if the Debug Edit window should be set
			p = instr(eDisplayName,"(Debug On)")
			If p Then
				DebugData = 1
				eDisplayName = Left(eDisplayName,p-2)
			End If
		End If
%>

<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
</head>


<body onLoad="SetScreen(550,450);">
  <form method="Post" action="z2t_DisplayNamePost.asp?z2tID=<%=Request("z2tID")%>&user=<%=Request("user")%>" name="frm">

	  <span class="popupHeading"><%=Title%></span>

<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>
	  
		<table width="80%" border="0" cellspacing="2" cellpadding="2" align="center">

			<tr><td>&nbsp;</td></tr>
			
			<tr>
				<td style="color: #999999;">
					This is the name that will be displayed for the customer after they log in to the website.
				</td>		 
			</tr>

			<tr><td>&nbsp;</td></tr>

			<tr>
				<td>
				<INPUT TYPE="Text" NAME="DisplayName"
					Value="<%=eDisplayName%>"
					Size="60">
				</td>		 
			</tr>
			
			<tr><td>&nbsp;</td></tr>
			
<%
	If eIsAdmin > 0 Then
%>

			<tr>
				<td style="color: #999999;">
					Administrators can have the debug data display at the bottom of each page on the website.
					You can set this function below.
				</td>		 
			</tr>
			
			<tr>
				<td align="center">
					<table border="0" cellspacing="2" cellpadding="2">
						<tr>
							<td align="right">
								Debug Data:
							</td>
							<td>
								<select name="DebugData">
<%
		If DebugData > 0 Then
%>
									<OPTION value="Y" selected="Selected">Yes</OPTION><OPTION value="N">No</OPTION>
<%
		Else
%>
									<OPTION value="Y">Yes</OPTION><OPTION value="N" selected="Selected">No</OPTION>
<%
		End If
%>
								</select>
							</td>
						</tr>
					</table>
				</td>		 
			</tr>

<%
	End If
%>
			
		</table>
			

    </td>
  </tr>
</table>

    <div class="center" style="margin-top: 2em;">
      <a href="javascript:document.frm.submit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:window.close();" class="buttons bo_Button80">Cancel</a>
    </div>


  </form>
</body>
</html>
