<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/DBConstants.inc"-->
<!--#include virtual="z2t_Backoffice/includes/DBFunctions.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%  


    if Request("retPage")="" OR isnull(Request("retPage")) then
        RetPage = "z2t_SpecialRules.asp"
	else
        RetPage = Request("retPage")
    end if

    if Request("action")="" OR isnull(Request("action")) then
        Response.Redirect RetPage
	else
        Action = Request("action")
    end if

	if Request("ID")="" OR isnull(Request("ID")) then
	    if Action = "Add" then
			NoteID = ""
		else
			Response.Redirect RetPage
		end if
	else
        NoteID = Request("ID")
    end if

	if Session("z2t_UserName") > "" then
		UserName = Session("z2t_UserName")
	else
		UserName = Session("z2t_login")
	end if

	Set cmd = Server.CreateObject("ADODB.Command")
	cmd.ActiveConnection = connBackoffice

    ErrMsg = ""
	
    If Action = "Edit" then
		cmd.CommandText = "z2t_SpecialRules_update"
		cmd.CommandType = adCmdStoredProc
		cmd.Parameters.Refresh	

		cmd.Parameters("@ID").value              = NoteID
		cmd.Parameters("@State").value           = Request("State")
		cmd.Parameters("@County").value          = Request("County")
		cmd.Parameters("@City").value            = Request("City")
		cmd.Parameters("@Zip").value             = Request("Zip")
		cmd.Parameters("@Category").value        = Request("Category")
		cmd.Parameters("@Note").value            = Request("Note")
		cmd.Parameters("@ShippingTaxable").value = Request("ShippingTaxable")
		cmd.Parameters("@EditedBy").value        = UserName

		cmd.Execute

		Set rsEdit = cmd.Execute
		ErrMsg = rsEdit("ErrMsg")

		rsEdit.close
		Set rsEdit = Nothing
    ElseIf Action = "Add" then
		cmd.CommandText = "z2t_SpecialRules_add"
		cmd.CommandType = adCmdStoredProc
		cmd.Parameters.Refresh	

		cmd.Parameters("@State").value     = Request("State")
		cmd.Parameters("@County").value    = Request("County")
		cmd.Parameters("@City").value      = Request("City")
		cmd.Parameters("@Zip").value       = Request("Zip")
		cmd.Parameters("@Category").value  = Request("Category")
		cmd.Parameters("@Note").value      = Request("Note")
		cmd.Parameters("@CreatedBy").value = UserName

		cmd.Execute
	ElseIf Action = "Delete" then
		cmd.CommandText = "z2t_SpecialRules_delete"
		cmd.CommandType = adCmdStoredProc
		cmd.Parameters.Refresh	

		cmd.Parameters("@ID").value       = NoteID
		cmd.Parameters("@DeletedBy").value = UserName

		cmd.Execute
	End If
	
	Set cmd = nothing

	If ErrMsg = "" Then
		Response.Redirect RetPage
	Else   
		PageHeading = "Special Rules"
		ColorTab = 1
%>
		<html>
		<head>
			<title>Zip2Tax.info - Special Rules</title>

			<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

			<link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">
			<link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />

			<script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
		</head>

		<body>
		<table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">

		  <!--#include virtual="z2t_Backoffice/includes/heading.inc"-->

		  <tr>
			<td width="100%" align="left" height="10" class="divDeskTop">
			</td>
		  </tr>
		  <tr>
			<td width="100%" align="center" class="divDeskMiddle">
				<b>An error occurred: <%=ErrMsg%></b>
			</td>
		  </tr>
		  <tr>
			<td width="100%" align="left" height="10" class="divDeskBottom">
			</td>
		  </tr>
		</table>
		</body>
		</html>
<%	End If  %>
