<!DOCTYPE html>

<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/DBConstants.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/DBFunctions.asp"-->
<%         
  PageHeading = "Bug Tracking"
  ColorTab = 1
%>
<html>
<head>
  <title>Zip2Tax.info - Home</title>
  
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  <style type="text/css">
    #forminputs label
    {
        width: 10em;
    }
    #forminputs input
    {
        width: 15em;
    }
    #forminputs textarea
    {
        width: 15em;
    }
    .button
    {
        background-color: #990000;
        border-color: #E0E0E0 black black #E0E0E0;
        border-style: solid;
        border-width: 1px;
        color: #FFFFFF;
        display: block;
        font-family: Verdana,Arial,Helvetica,sans-serif;
        font-size: 9px;
        font-weight: bold;
        padding: 2px 4px;
        text-align: center;
        vertical-align: middle;
        text-decoration: none;
        width: 10em !important;
        height: 1em !important;
    }
    div#nav a
    {
      color: White;
      font-weight: bold;   
    }
  </style>
</head>

<body>
  <table style="width:1200px; border:0; padding:0" align="center">

  <!--#include virtual="/z2t_Backoffice/includes/heading.inc"-->

    <tr>
      <td>
        <table style="width:100%; border:0; margin:0; padding:0" align="center" class="content">
          <tr>
            <td width="100%" align="left" height="10" class="divDeskTop">
            </td>
          </tr>
          <tr>
            <td width="1200" align="left" height="600" class="divDeskMiddle">
              <div style="margin: 0 auto; width: 900">
                <div style="margin: 2em auto 5em; width: 100%; font-size: 1em; font-style: normal; line-height: normal; font-weight: bold; font-variant: normal; text-transform: none;">
                  <select id="selSort" name="selSort" style="width: 10em; float: right; margin-right: 9em" onchange="window.location='<%request.servervariables("URL")%>?BugStatus=' + this.value">
                    <% 
                      Dim rs, rsDDL, strSQL

                      set rsDDL = server.createObject("ADODB.Recordset")
                      set conn = server.CreateObject("ADODB.Connection")  

                      strSQL = "SELECT * FROM dbo.z2t_Types WHERE Class = 'BugStatus'"
                      rsDDL.Open strSQL,connBackoffice

                      If Not rsDDL.EOF Then
                        While Not rsDDL.EOF
                          If Request("BugStatus") = rsDDL("Value") Then
                            Response.Write("<OPTION value='" & rsDDL("Value") & "' selected='selected'>" & rsDDL("Description") & "</OPTION>")
                          Else
                            Response.Write("<OPTION value='" & rsDDL("Value") & "'>" & rsDDL("Description") & "</OPTION>")
                          End If
                          rsDDL.MoveNext
                        WEnd
                      End If

                      rsDDL.Close
                    %>
                  </select>
                  <br style="clear:both;"/><br />
                  <% 
                    Dim sqlSort, sqlPageSize, rsCount, query

                    query = ""
    
                    set rs = server.createObject("ADODB.Recordset")

	                ' set number of records per page
	                recordsPerPage = 15

	                ' check for page
	                If Request.QueryString("Page") = "" Then
		              currentPage = 1
	                Else
		              currentPage = Request("Page") + 1 ' convert Page request to an integer
                      
	                End If

	                ' SQL Query
	                strSQL = "SELECT * FROM dbo.z2t_bugtracking WHERE DeletedDate IS NULL"

                    If Not Request("BugStatus") = "" And Not Request("BugStatus") = "All" Then
                      strSQL = strSQL & " AND Success ='" & Request("BugStatus") & "'"
                      query = query & "&BugStatus=" & Request.QueryString("BugStatus")
                    End If

	                rs.CursorType = 3
                    rs.CursorLocation = 3 ' adUseClient
                    rs.LockType = 3
	                rs.open strSQL, connBackoffice

	                rs.PageSize = recordsPerPage
                    rsCount = rs.RecordCount
	                numOfPages = rs.PageCount

                    Dim count

                    'Do While Not rs.EOF
                    '  count = count + 1
                    'Loop
	
	                ' set current page
	                'If 1 > currentPage Then currentPage = 1
	                'If currentPage > numOfPages Then currentPage = numOfPages
		            rs.AbsolutePage = currentPage
                  %>
                  <table style="width: 80%; margin: 0 auto;">
                    <thead>
                      <tr style="text-align: left; width: 100%; margin-left: .5em; background-color: #990000; color: white; font-weight: bold; font-family: Arial, Helvetica, sans-serif;">
                        <th style="text-align: center; width: 540; vertical-align: top;">Error Type</th>
                        <th style="text-align: center; width: 150; vertical-align: top;">Date</th>
                        <th style="text-align: center; width: 100; vertical-align: top;">Status</th>
                        <th style="text-align: center; width: 104; vertical-align: top;">Options</th>
                      </tr>
                    </thead>
                    <tfoot id="nav" style="text-align: left; width: 100%; vertical-align: top; 
                                           margin-left: .5em; background-color: #990000; color: white; font-weight: bold;                                  font-family: Arial, Helvetica, sans-serif; text-align: center">
                      <tr>
                        <th colspan="4">
                      <%
                        ' page navigation
                        Response.Write GetHitCountAndPageLinks(Request.ServerVariables("URL"), rsCount, recordsPerPage, numOfPages, currentPage - 1, query)
                      %>
                        </th>
                      </tr>
                    </tfoot>
                    <tbody>
                      <%  
                        'loop through the table to obtain records
                        Do While rs.AbsolutePage = currentPage And Not rs.EOF
                      %>
                        <tr style="text-align: left; width: 100%; vertical-align: middle; margin-left: .5em; background-color: white">
                          <td style="text-align: left; width: 538; height: 2em; vertical-align: middle; background-color: white; border: 1px solid black"><span style="margin-left: 1em"><%=rs("BriefDescription")%></span></td>
                          <td style="text-align: center; width: 150; height: 2em; vertical-align: middle; background-color: white; border: 1px solid black"><%response.write(rs("CreatedDate") & "&nbsp;")%></td>
                          <td style="text-align: center; width: 100; height: 2em; vertical-align: middle; background-color: white; border: 1px solid black"><%response.write(rs("Success") & "&nbsp;")%></td>
                          <td style="text-align: center; width: 104; height: 2em; vertical-align: middle; background-color: white; border: 1px solid black">
                            <span class="noPrint"><a style="font-size: 1em; text-decoration: none; font-weight: bold" href="z2t_add_bug.asp?id=<%=rs("ID")%>">Edit</a></span></td>
                        </tr>
                      <%
                        ' move to the next record
                        rs.MoveNext
                        Loop
  
                        ' close the recordset and connection object then clean out
                        rs.close
                        Set rs = Nothing
                        
                        ' set line break
                        'Response.Write("<br>")
                         Response.Write("<tr></tr>")
                    %>
                    </tbody>
                  </table>
                </div>
              </div>
              <div class="noPrint" style="margin: 0 auto; width: 20%"><a class="button" href="javascript:void(0)" onclick="window.print()">Print</a></div>
              <br /><br /><br />
            </td>
          </tr>
        </table>
        <!--#include virtual="/z2t_Backoffice/includes/z2t_PageTail.inc"-->
      </td>
    </tr>
  </table>
</body>
</html>
