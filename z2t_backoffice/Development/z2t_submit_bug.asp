<!DOCTYPE html>
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/sql-dev.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->
<%
  Response.Buffer = true
  Dim rs

  If conn is nothing then
    Response.Write("<span>A connection does not exist.</span>")
  End If

  PageHeading = "Address Bug Tracking"
  ColorTab = 1
%>
<html>
<head>
    <title>Harvest American Backoffice - Employees</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link href="<%=strPathIncludes%>ha_Backoffice.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <%
    Set rs = server.createobject("ADODB.Recordset")

    If Session("bMode")="Add" Then
        Response.Write "Adding "
        ' declare SQL string
        Dim strSQL: strSQL = "SELECT MAX(ID) AS MaxID FROM z2t_bugtracking"
        
        'open record set
        rs.Open strSQL, connBackoffice, 2, 3
        
        ' set the primary key based on the last record added
        If rs("MaxID") <> "" Then
            Session("BID") = rs("MaxID") + 1
        Else
            Session("BID") = 1
        End If
        Response.Write Session("BID")
        ' close recordset
        rs.Close

        strSQL = "SELECT * FROM z2t_bugtracking"

        ' reopen recordset with a new SQL string
        rs.Open strSQL, conn, 2, 3
        
        ' add new record
        rs.AddNew
        rs("ID") = Session("BID")
        rs("CreatedBy") = Session("Login")
        rs("CreatedDate") = Now
        rs.Update
        ' close recordset
        rs.close
    End If

    ' set Session
    Session("ID") = Request("ID")
    Response.Write(Session("ID"))
    ' set SQL string
    strSQL = "SELECT * FROM dbo.z2t_bugtracking WHERE ID = " & Session("ID")

    Response.Write(strSQL)
    ' open recordset
    rs.Open strSQL, connBackoffice, 2, 3
    ' set fields

    rs("BriefDescription") = Request("BriefDescription")
    rs("Success") = Request("SuccessFail")
    rs("Notes") = Request("Notes")
    rs("Variables") = Request("Variables")
    rs("DataTested") = Request("URL")
    rs("Results") = Request("Results")
    rs("TestTarget") = Request("TestTarget")
    rs("ErrorsThrown") = Request("ErrorsThrown")

    If Not Request("AssignedTo") = "" Then
      rs("AssignedTo") = Request("AssignedTo")
      rs("AssignedDate") = Request("AssignedDate")
    End If

    If Not Request("AssignedBy") = "" Then
      rs("AssignedBy") = Request("AssignedBy")
      rs("AssignedByDate") = Request("AssignedByDate")
    End If

    If Not Request("ClosedBy") = "" Then
      rs("ClosedBy") = Request("ClosedBy")
      rs("ClosedDate") = Request("ClosedDate")
    End If

    rs("EditedBy") = Session("Login")
    rs("EditedDate") = Now
    
    ' update recordset and close
    rs.Update
    rs.Close
    
    %>
    <script type="text/javascript">
        window.opener.location.href = window.opener.location.href;
        window.close();
    </script>
</body>
</html>
