<%response.buffer=true%>

<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->

<%
    dim strColor
    dim PageHeading
    dim recordCount
    dim StateAbbr(100)
    dim StateName(100)

    PageHeading = "State Maintenance"
	ColorTab = 4

    '----- Be sure secure path is used -----
    If LCase(Request.ServerVariables("HTTPS")) <> "on" Then
        response.redirect "https://www.zip2tax.info" & Request.ServerVariables("PATH_INFO")
    End If

    If session("z2t_loggedin")<>"True" Or isNULL(session("z2t_loggedin")) _
    Or session("z2t_status")<>"admin"  Or isNULL(session("z2t_status")) Then
        Response.Redirect strBasePath & "z2t_login.asp"
    End If

    SQL="SELECT * " & _
	    "FROM z2t_Webpage_Duplication_States " & _
        "ORDER BY StateFullName"

    set RS=server.createObject("ADODB.Recordset")
    RS.open SQL, connBackoffice, 2, 3

    if not RS.EOF then
		do while not rs.eof
			recordCount = recordCount + 1
			StateAbbr(recordCount) = rs("State")
			if rs("State") = "DC" and rs("StateFullName") = "Columbia"  then
				StateName(recordCount) = "District of Columbia"
			else
				StateName(recordCount) = rs("StateFullName")
			end if
			rs.MoveNext
		loop
    end if
		
	rs.close
    set rs = nothing
%>

<html>
<head>
    <title>Zip2Tax State Maintenance</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />

	<script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

	<style type="text/css">
		td
			{
			font-size: 12pt;
			}
	</style>

</head>

<body>

<table width="1200" border="0" cellspacing="0" cellpadding="0" align="left">

  <!--#include virtual="z2t_Backoffice/includes/heading.inc"-->

  <tr>
	<td width="100%" align="left" height="10" class="divDeskTop">
	</td>
  </tr>
  
  <tr>
	<td width="100%" align= "left" height="500" class="divDeskMiddle" style="padding-left: 50px;">

	  <table width="1000" border="0" cellspacing="5" cellpadding="5">
		<tr valign="top">
		  <td>
		    Use this page to edit the variables used on the Zip2Tax state web pages. 
		  </td>
		</tr>


			<tr>
				<td>
					<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
				<%
					For row = 1 to 13
				%>
			
						<tr>
				<%
						For col = 0 to 3
							sName = StateName(row + (col * 13))
							sAbbr = StateAbbr(row + (col * 13))
				%>
							<td width="22%" bgColor="White">
				<%
							If sName = "" Then
								Response.write "&nbsp;"
							Else
				%>
							  <table width="100%" border="0" cellspacing="0" cellpadding="0">
							    <tr>
								  <td align="left">
									  <a href="javascript:window.open('z2t_StateMaintEdit.asp?State=<%=sAbbr%>',
										'','scrollbars=yes,fullscreen=no,resizable=no, 
										height=630,width=750,left=100,top=30');void(0)">
											<FONT Size="2"><%=sName%></FONT>
									  </a>
								  </td>
								  <td align="right">
									  <a href="javascript:window.open('z2t_StateMaintEdit.asp?State=<%=sAbbr%>',
										'','scrollbars=yes,fullscreen=no,resizable=no, 
										height=630,width=750,left=100,top=30');void(0)" class="buttonEdit"
										Title="Edit Variables for <%=sName%>">Edit</a>
									  <a href="http://www.Zip2Tax.com/state/<%=replace(replace(sName,"District of ", "")," ","-")%>-state-rates/index.html"
										target="_StateEdit"
									    class="buttonEdit"
										Title="View Finished Page for <%=sName%>">View</a>
								  </td>
								</tr>
							  </table>
							</td>

				<%
							End If
							If col <> 3 then
								Response.write "<td width='3%'>&nbsp;</td>"
							End If
						Next
				%>
						</tr>
				<%
					Next
				%>
					</table>
				</td>
			</tr>

		<tr valign="top">
		  <td>
			The template for the state pages is located at
			<a href="http://zip2tax.com/includes/templates/state-template.asp" target="_template">
			http://zip2tax.com/includes/templates/state-template.asp</a><br><br>
			
			This template is duplicated after the variables are merged in and you can see the results of each
			state by clicking on the view button to the right of each state name.
		  </td>
		</tr>
			
      </table>
	</td>
  </tr>
  <tr>
	<td width="100%" align="left" height="10" class="divDeskBottom">
	</td>
  </tr>
</table>

</body>
</html>
