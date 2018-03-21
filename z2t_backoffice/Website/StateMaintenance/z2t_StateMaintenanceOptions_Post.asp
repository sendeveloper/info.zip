<!--#include virtual="z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
	Response.buffer=true
	Dim rs
	Dim SQL
	Dim strState
	
	If Request("State")=" " or isnull(Request("State")) then
        Response.Redirect strBasePath & "z2t_login.asp"
	Else
		strState = Request("State")
	End If

	Dim Field(12)
	Dim FieldCnt
	Dim FieldSub
	Dim FieldName

	FieldCnt = 12
	
	Field(1) = "Jurisdictions"
	Field(2) = "UseTaxBase"
	Field(3) = "Shipping"
	Field(4) = "Origin"
	Field(5) = "Source"
	Field(6) = "Clothing"
	Field(7) = "NexusDef"
	Field(8) = "Nexus"
	Field(9) = "Finance"
	Field(10) = "Installation"
	Field(11) = "Contact"
	Field(12) = "Holiday"

	Set rs = server.createObject("ADODB.Recordset")

	SQL = "SELECT * FROM z2t_StateInfo_Website " & _
		  "WHERE [State] = '" & strState & "'"
'Response.Write(SQL)                       
if 1=2 then 
	SQL = "Update z2t_StateInfo_Website Set EditedBy = '"& Session("z2t_UserName") &"', EditedDate = '"& Now() &"', "
	'Get each field that was posted to this page, and update the matching field on the database
	For FieldSub = 1 to FieldCnt
		FieldName = Field(FieldSub)
		
		If Request(FieldName) = "" or IsNull(Request(FieldName)) Then
			rs(FieldName) = Null
		elseif FieldSub=FieldCnt then
			SQL =SQL &	FieldName &"="& Request.Form(FieldName)&" "			
		Else
			SQL =SQL &	FieldName &"="& Request.Form(FieldName)&", "
		End If
		
	Next
	SQL=SQL&		  "WHERE [State] = '" & strState & "'"

	rs.execute(SQL)

'	Response.Write(SQL)
'	Response.End()	

	end if



	rs.Open SQL, connPhilly01PublishTables, 1, 3	
	'Get each field that was posted to this page, and update the matching field on the database
	For FieldSub = 1 to FieldCnt
		FieldName = Field(FieldSub)
		
		If Request(FieldName) = "" or IsNull(Request(FieldName)) Then
			rs(FieldName) = Null
		Else
			rs(FieldName) = Request.Form(FieldName)
		End If
		
	Next

	rs("EditedBy") = Session("z2t_UserName")
	rs("EditedDate") = Now()

		For x = 0 To rs.Fields.Count - 1 
            value = value & Trim(rs.Fields(x).Name) & " - " & Trim(rs.Fields(x).Value) & ",  " 

         Next 

	rs.Update 					 
	rs.Close




%>

<html>
<head>
    <title>Zip2Tax State Maintenance Post</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">

</head>

<script>
    window.opener.location.href = window.opener.location.href;
    window.close()
</script>

</html>
