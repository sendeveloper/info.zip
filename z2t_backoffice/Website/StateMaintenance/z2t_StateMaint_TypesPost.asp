<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
	Response.buffer=true
	Dim SQL
	Dim strClass
	Dim apsClass
    Dim FormKey
    Dim Desc
	Dim apsDesc
	Dim Task
	Dim DeleteKey
	Dim apsDeleteKey
	
    
	
    If Request("class")="" or IsNull(Request("class")) Then
        Response.Redirect strBasePath & "z2t_login.asp"
	Else
		strClass = Request("class")
        apsClass = Replace(strClass, "'", "''")
    End If

    If Request("task")="" or IsNull(Request("task")) Then
        Response.Redirect strBasePath & "z2t_login.asp"
	Else
		Task = Request("task")
    End If

    If Task = "Delete" Then
		If Request("deleteKey")="" or IsNull(Request("deleteKey")) Then
			Response.Redirect strBasePath & "z2t_login.asp"
		Else
			DeleteKey = Request("deleteKey")
			apsDeleteKey = Replace(DeleteKey, "'", "''")
		End If
	End If
	
	'First update the existing rows
	For X = 1 To Request.Form.Count() 
		FormKey = Request.Form.Key(X)
		Desc  = Request.Form.Item(X)
		apsDesc = Replace(Desc, "'", "''")

		If FormKey <> "class" And FormKey <> "task" And FormKey <> "deleteKey" Then
			SQL = "z2t_Webpage_Types_UPDATE  '" & apsDesc  & "'  , 'StatePageVariables_" & apsClass & "', '" & FormKey    & "', '"& Session("z2t_UserName")   &"'"
'			response.Write(sql)
'			response.End()
			connPhilly01PublishTables.Execute SQL
		End If
	Next 

	'Perform Add/Update if requested
	If Task = "Add" Then
		SQL = "z2t_Webpage_Types_add 'StatePageVariables_" & apsClass & "', '"& Session("z2t_UserName")   &"'"
		connPhilly01PublishTables.Execute SQL
		response.redirect "z2t_StateMaint_TypesEdit.asp?Class=" & Server.URLEncode(Request("Class"))
	ElseIf Task = "Delete" Then
		SQL = "z2t_Webpage_Types_Delete  '"& Session("z2t_UserName")   &"','StatePageVariables_" & apsClass & "'," & apsDeleteKey & ""
		connPhilly01PublishTables.Execute SQL
		response.redirect "z2t_StateMaint_TypesEdit.asp?Class=" & Server.URLEncode(Request("Class"))
	End If
%>

<html>
<head>
    <title>Zip2Tax State Maintenance - Types Post</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
</html>

<%If Task = "Update" Then %>
	<script>
		window.opener.location.href = window.opener.location.href;
		window.close()
	</script>
<%End If%>
