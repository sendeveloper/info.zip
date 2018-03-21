<!DOCTYPE html>
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/sql-dev.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/lib.asp"-->
<%
  PageHeading = "Address Bug Tracking"
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
        #forminputs input
        {
            width: 15em;
        }
        #forminputs textarea
        {
            width: 15.4em;
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
            text-decoration: none;
            width: 10em !important;
        }
    </style>
</head>
<body>
  <table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">

  <!--#include virtual="/z2t_Backoffice/includes/heading.inc"-->
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="content">
          <tr>
            <td width="100%" align="left" height="10" class="divDeskTop">
            </td>
          </tr>
          <tr>
            <td width="100%" align="left" height="200" class="divDeskMiddle" style="vertical-align:	top">
              <form id="bugtracker" action="z2t_submit_bug.asp" method="post" target="foo" onsubmit="window.open('','foo','width=450,height=300,status=yes,resizable=yes,scrollbars=yes')">
                <%
                  Dim rs : set rs = server.createObject("ADODB.Recordset")

	               ' check for page
	               If Request.QueryString("Page") = "" Then
  		             currentPage = 1
	               Else
 		             currentPage = CINT(Request.QueryString("Page")) ' convert Page request to an integer
	               End If

	               ' set Recordset
	               Set rs = Server.CreateObject("ADODB.RecordSet")

	         
                   ' SQL Query

                   If Not Request("ID") <> "" Then
                     Session("bMode") = "Add"
                     Set rs = Server.CreateObject("ADODB.Recordset")
                     rs.CursorLocation = 3

                     rs.Fields.Append "ID", 12
                     rs.Fields.Append "BriefDescription", 12
                     rs.Fields.Append "Success", 12
                     rs.Fields.Append "Notes", 12
                     rs.Fields.Append "Variables", 12
                     rs.Fields.Append "DataTested", 12
                     rs.Fields.Append "Results", 12
                     rs.Fields.Append "TestTarget", 12
                     rs.Fields.Append "ErrorsThrown", 12
                     rs.Fields.Append "CreatedBy", 12
                     rs.Fields.Append "CreatedDate", 12
                     rs.Fields.Append "AssignedTo", 12
                     rs.Fields.Append "AssignedDate", 12
                     rs.Fields.Append "AssignedBy", 12
                     rs.Fields.Append "AssignedByDate", 12
                     rs.Fields.Append "ClosedBy", 12
                     rs.Fields.Append "ClosedDate", 12
                     rs.Open

                     rs.AddNew
                     rs.Fields("ID").Value = 0
                     rs.Fields("BriefDescription").Value = ""
                     rs.Fields("Success").Value = ""
                     rs.Fields("Notes").Value = ""
                     rs.Fields("Variables").Value = ""
                     rs.Fields("DataTested").Value = ""
                     rs.Fields("Results").Value = ""
                     rs.Fields("TestTarget").Value = ""
                     rs.Fields("ErrorsThrown").Value = ""
                     rs.Fields("CreatedBy").Value = ""
                     rs.Fields("CreatedDate").Value = ""
                     rs.Fields("AssignedTo").Value = ""
                     rs.Fields("AssignedDate").Value = ""
                     rs.Fields("AssignedBy").Value = ""
                     rs.Fields("AssignedByDate").Value = ""
                     rs.Fields("ClosedBy").Value = ""
                     rs.Fields("ClosedDate").Value = ""
                     rs.Update
                
                   Else
                     Session("bMode") = "Edit"
                     strSQL = "SELECT * FROM dbo.z2t_bugtracking WHERE ID = " & Request.QueryString("ID")
	                 rs.open strSQL,connBackoffice
                   End If

                   If rs.EOF Then
                     rs.Close
                     Set rs = Server.CreateObject("ADODB.Recordset")
                     rs.CursorLocation = 3

                     rs.Fields.Append "ID", 12
                     rs.Fields.Append "BriefDescription", 12
                     rs.Fields.Append "Success", 12
                     rs.Fields.Append "Notes", 12
                     rs.Fields.Append "Variables", 12
                     rs.Fields.Append "DataTested", 12
                     rs.Fields.Append "Results", 12
                     rs.Fields.Append "TestTarget", 12
                     rs.Fields.Append "ErrorsThrown", 12
                     rs.Fields.Append "CreatedBy", 12
                     rs.Fields.Append "CreatedDate", 12
                     rs.Fields.Append "AssignedTo", 12
                     rs.Fields.Append "AssignedDate", 12
                     rs.Fields.Append "AssignedBy", 12
                     rs.Fields.Append "AssignedByDate", 12
                     rs.Fields.Append "ClosedBy", 12
                     rs.Fields.Append "ClosedDate", 12
                     rs.Open

                     rs.AddNew
                     rs.Fields("ID").Value = 0
                     rs.Fields("BriefDescription").Value = ""
                     rs.Fields("Success").Value = ""
                     rs.Fields("Notes").Value = ""
                     rs.Fields("Variables").Value = ""
                     rs.Fields("DataTested").Value = ""
                     rs.Fields("Results").Value = ""
                     rs.Fields("TestTarget").Value = ""
                     rs.Fields("ErrorsThrown").Value = ""
                     rs.Fields("CreatedBy").Value = ""
                     rs.Fields("CreatedDate").Value = ""
                     rs.Fields("AssignedTo").Value = ""
                     rs.Fields("AssignedDate").Value = ""
                     rs.Fields("AssignedBy").Value = ""
                     rs.Fields("AssignedByDate").Value = ""
                     rs.Fields("ClosedBy").Value = ""
                     rs.Fields("ClosedDate").Value = ""
                     rs.Update
                   End If

                %>
                <div id="forminputs" style="width: 40%; margin: 0 0 5em 5em; float: left">
                	<div style="float: left; width: 100%; display: none">
	                  <label style="width: 10em; height: 1.4em; float: left" for="txtID;float: left">Bug ID:</label>
                      <input id="txtID" name="ID" type="text" readonly style="float: right" value="<%=rs.Fields("ID")%>" />
    	            </div>
          		      <div style="float: left; width: 100%">
                    	  <label for="selErrorCode" style="width: 10em; vertical-align: top; float: left">Error Code:</label>


                          <select id="selErrorCode" name="BriefDescription" style="float: right; width: 15em">
                            <%
                              Dim strSQL2, rs2, objConn2, connString2
        
                              strSQL2 = "SELECT * FROM dbo.z2t_Types_repl WHERE Class = 'ErrorType'"
                              set rs2 = Server.CreateObject("ADODB.RecordSet")
                              Response.Write(strSQL2)
                              rs2.open strSQL2, connBackoffice
        
                              If not rs2.eof Then
                                While not rs2.eof
                                  If rs2("Value") = rs.Fields("BriefDescription") Then
                                    Response.Write "<OPTION value='" & rs2("Value") & "' selected='selected'>" & rs2("Value") & "</OPTION>"
                                  Else
                                    Response.Write "<OPTION value='" & rs2("Value") & "'>" & rs2("Value") & "</OPTION>"
                                  End If
                                  rs2.MoveNext
                                Wend
                              End If
        
                              rs2.Close
							  
                            %>
                          </select>

                        </div>
                        <div style="float: left; width: 100%">
	                      <label for="selStatus" style="width: 10em; height: 1.4em; float: left">Status:</label>

                          <select id="selStatus" name="SuccessFail" style="width: 15em;float: right">
							<%
                              strSQL2 = "SELECT * FROM dbo.z2t_Types_repl WHERE Class = 'BugStatus'"
                              set rs2 = Server.CreateObject("ADODB.RecordSet")
                              Response.Write(strSQL2)
                              rs2.open strSQL2, connBackoffice
        
                              If not rs2.eof Then
                                While not rs2.eof
                                  If rs2("Value") = rs.Fields("Success") Then
                                    Response.Write "<OPTION value='" & rs2("Value") & "' selected='selected'>" & rs2("Value") & "</OPTION>"
                                  Else
                                    Response.Write "<OPTION value='" & rs2("Value") & "'>" & rs2("Value") & "</OPTION>"
                                  End If
                                  rs2.MoveNext
                                Wend
                              End If
        
                              rs2.Close
                            %>
	                        </select>

    	                </div>
    		            <div style="float: left; width: 100%">
	    	              <label for="txtNotes" style="width: 10em; height: 5.3em; vertical-align: top; float: left">Notes:</label>
            		      <textarea id="txtNotes" name="Notes" cols="1" rows="4" style="float: right"><%=rs.Fields("Notes")%></textarea>
		                </div>
                        <div style="float: left; width: 100%">
                          <label for="txtVariables" style="width: 10em; height: 5.3em; vertical-align: top; float: left">Variables:</label>
                          <textarea id="txtVariables" name="Variables" cols="1" rows="4" style="float: right"><%=rs.Fields("Variables")%></textarea>
                        </div>
                        <div style="float: left; width: 100%">
                          <label for="txtDataInput" style="width: 10em; height: 1.4em; float: left">URL:</label>
                          <input id="txtDataInput" name="URL" type="text" style="float: right" value="<%=rs.Fields("DataTested")%>" />
                        </div>
                        <div style="float: left; width: 100%">
                          <label for="txtResults" style="width: 10em; height: 1.4em; float: left">Results:</label>
                          <input id="txtResults" name="Results" style="float: right" type="text" value="<%=rs.Fields("Results")%>" />
                        </div>
                         <div style="float: left; width: 100%">
	                      <label for="selTestTarget" style="width: 10em; height: 1.4em; float: left">Test Target:</label>
    	                  <select id="selTestTarget" name="TestTarget" style="float: right; width: 15em">
							<% 
                              strSQL2 = "SELECT * FROM dbo.z2t_Types_repl WHERE Class = 'BugTesting'"
                              set rs2 = Server.CreateObject("ADODB.RecordSet")
                              Response.Write(strSQL2)
                              rs2.open strSQL2, connBackoffice
                               
                              If not rs2.eof Then
                                While not rs2.eof
                                  If rs2("Value") = rs.Fields("TestTarget") Then
                                    Response.Write "<OPTION value='" & rs2("Value") & "' selected='selected'>" & rs2("Value") & "</OPTION>"
                                  Else
                                    Response.Write "<OPTION value='" & rs2("Value") & "'>" & rs2("Value") & "</OPTION>"
                                  End If
                                  rs2.MoveNext
                                Wend
                              End If
        
                              rs2.Close
                            %>
                          </select>
                        </div>
                        <div style="float: left; width: 100%">
                          <label for="txtErrors" style="width: 10em; height: 1.4em; float: left">Errors Thrown:</label>
                          <input id="txtErrors" name="ErrorsThrown" type="text" style="float: right" value="<%=rs.Fields("ErrorsThrown")%>" />
                        </div>
                </div>
                <div style="width: 40%; float: right; margin: 0 5em 5em 0">
                
                  <div style="width: 10em; vertical-align: top; float: left">&nbsp;</div>
                  <div style="width: 10em; vertical-align: top; float: left; text-align: center">Who?</div>
                  <div style="width: 10em; vertical-align: top; float: left; text-align: center">When?</div>
                  <div style="clear: both"></div>
                  <div style="width: 10em; vertical-align: top; float: left;">Created:</div>
                  <input id="txtCreatedBy" name="CreatedBy" style="float: left; width: 11.75em" type="text" value="<%=rs.Fields("CreatedBy")%>" readonly />
                  <input id="txtCreatedDate" name="CreatedDate" style="float: left; width: 11em" type="text" value="<%=rs.Fields("CreatedDate")%>" readonly />
                  <div style="width: 10em; vertical-align: top; float: left">Assigned To:</div>

                  <select id="selAssigned" name="AssignedTo" style="width: 11.75em; float: left;">
                    <option value="">(Select A User)</option>
                    <%
                      Dim un, connHA
                      Set connHA = Server.CreateObject("ADODB.Connection")
                      connHA.Open "driver=SQL Server;server=66.119.55.118,7043;uid=davewj2o;pwd=get2it;database=ha_BackOffice"
                      Set rs2 = Server.CreateObject("ADODB.Recordset")
                      rs2.Open "ha_Employee_Names_List 1 , 1 , 1 , 1", connHA, 1, 3

                      Do While Not rs2.EOF
                        un = rs2("FirstName") & " " & left(rs2("LastName"), 1) & "."
                        %>
                        <option value="<%=rs2("EmpID")%>" <%=iif(rs.Fields("AssignedTo") = rs2("EmpID"), "selected=""selected""", "")%>><%=un%> </option>
                        <%
                        
                        rs2.MoveNext
                      Loop

                    %>
                  </select>

                  <input id="txtAssignedDate" name="AssignedDate" style="float: left; width: 11em" type="text" value="<%=rs.Fields("AssignedDate")%>" readonly />
                  <br />
                  <div style="width: 10em; vertical-align: top; float: left">Assigned By:</div>

                	  <select id="selAssignedBy" name="AssignedBy" style="width: 9.8em; float: left; width: 11.75em">
                    <option value="">(Select A User)</option>
                    <%
                      rs2.MoveFirst

                      Do While Not rs2.EOF
                        un = rs2("FirstName") & " " & left(rs2("LastName"), 1) & "."
                        %>
                        <option value="<%=rs2("EmpID")%>" <%=iif(rs("AssignedBy") = rs2("EmpID"), "selected=""selected""", "")%>><%=un%> </option>
                        <%
                        
                        rs2.MoveNext
                      Loop
                    %>
                  </select>

                  <input id="txtAssignedByDate" name="AssignedByDate" style="float: left; width: 11em" type="text" value="<%=rs.Fields("AssignedByDate")%>" readonly /><br />
                  <div style="width: 10em; vertical-align: top; float: left">Closed By:</div>
                              
                  <select id="selClosed" name="ClosedBy" style="float: left; width: 11.75em">
                    <option value="">(Select A User)</option>
                    <%
                      rs2.MoveFirst

                      Do While Not rs2.EOF
                        un = rs2("FirstName") & " " & left(rs2("LastName"), 1) & "."
                        %>
                        <option value="<%=rs2("EmpID")%>" <%=iif(rs("ClosedBy") = rs2("EmpID"), "selected=""selected""", "")%>><%=un%> </option>
                        <%
                        
                        rs2.MoveNext
                      Loop

                      rs2.Close
                    %>
                  </select>

                  
                  <input id="txtClosedDate" name="ClosedDate" style="float: left; width: 11em" type="text" value="<%=rs.Fields("ClosedDate")%>" readonly /><br />
                  <% rs.Close %>
                  <input type="reset" value="Undo Changes" class="button" style="float: right; margin-right: 6.5em; margin-left: 2em; margin-top: 2em" />
                  <input type="submit" value="Submit" class="button" style="float: right; margin-top: 2em" />
                </div>
      <%if 1= 2 then%>                                              	                            <%end if%>
              </form>
            </td>
          </tr>
          <tr>
            <td width="100%" align="left" height="10" class="divDeskBottom">
            </td>
          </tr>
        </table>    
      </td>
    </tr>
  </table>
  <!--#include virtual="/z2t_Backoffice/includes/z2t_PageTail.inc"-->
</body>
</html>
