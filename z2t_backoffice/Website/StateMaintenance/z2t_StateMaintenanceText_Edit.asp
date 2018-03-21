<!--#include virtual="z2t_Backoffice/includes/functions.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<%
    Response.buffer=true
    Response.clear

    If Request("State")="" or IsNull(Request("State")) Then
		Close
	Else
		strState = Request("State")
    End If


	Dim rs: Set rs=server.createObject("ADODB.Recordset")

	SQL="z2t_StatePageMaintenanceTitles_read('" & strState & "')"
		
	rs.open SQL, connPhilly01PublishTables, 3, 3, 4
	
	If not rs.eof Then
		eLinkURL1 			= rs("LinkURL1")
		eLinkURL2 			= rs("LinkURL2")
		eLinkURL3 			= rs("LinkURL3")
		eLinkURL4 			= rs("LinkURL4")
		eLinkName1 			= rs("LinkName1")
		eLinkName2 			= rs("LinkName2")
		eLinkName3 			= rs("LinkName3")
		eLinkName4 			= rs("LinkName4")
		
		Title = "State Page Maintenance Text - " & rs("StateFullName") & "(" & strState & ")"
	End If
	
    rs.close
%>

<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="/z2t_Backoffice/includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
    <script language="JavaScript" type="text/javascript" src="/z2t_BackOffice/includes/dates/checkDate.js"></script>
    <script language="JavaScript" type="text/javascript" src="/z2t_BackOffice/includes/dates/ts_picker.js"></script>
	<script language="JavaScript" type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
</head>


<body onLoad="SetScreen(1100,700);">
  <form method="Post" action="z2t_StateMaintenanceText_Post.asp?State=<%=strState%>" name="frm">

	  <span class="popupHeading"><%=Title%></span>

		<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">

			<tr><td>&nbsp;</td></tr>
			
			<tr>
				<td style="color: #888888; font-weight: bold; font-size: 10pt; padding-bottom: 10px;" colspan="2">
					These are links that can be added to the individual state page.
				</td>		 
			</tr>
			
			<tr>
			  <td align="right">
			    Link URL 1:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="110" name="LinkURL1" id="LinkURL1"
                  value="<%=eLinkURL1%>">
			  </td>
			</tr>
			
			
			<tr>
			  <td align="right">
			    Link Name 1:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="110" name="LinkName1" id="LinkName1"
                  value="<%=eLinkName1%>">
			  </td>
			</tr>
			
			<tr>
			  <td align="right">
			    Link URL 2:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="110" name="LinkURL2" id="LinkURL2"
                  value="<%=eLinkURL2%>">
			  </td>
			</tr>
			
			<tr>
			  <td align="right">
			    Link Name 2:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="110" name="LinkName2" id="LinkName2"
                  value="<%=eLinkName2%>">
			  </td>
			</tr>
			
			
			<tr>
			  <td align="right">
			    Link URL 3:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="110" name="LinkURL3" id="LinkURL3"
                  value="<%=eLinkURL3%>">
			  </td>
			</tr>
			
			<tr>
			  <td align="right">
			    Link Name 3:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="110" name="LinkName3" id="LinkName3"
                  value="<%=eLinkName3%>">
			  </td>
			</tr>

			
			<tr>
			  <td align="right">
			    Link URL 4:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="110" name="LinkURL4" id="LinkURL4"
                  value="<%=eLinkURL4%>">
			  </td>
			</tr>
			
			<tr>
			  <td align="right">
			    Link Name 4:
			  </td>
			  <td align="left">
				<input class="field date" type="text" size="110" name="LinkName4" id="LinkName4"
                  value="<%=eLinkName4%>">
			  </td>
			</tr>
			
			<tr><td>&nbsp;</td></tr>
						
		</table>

    <div class="center" style="margin-top: 2em;">
      <a href="javascript:document.frm.submit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:window.close();" class="buttons bo_Button80">Cancel</a>
    </div>


  </form>
</body>
</html>
