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
        .forminputs input
        {
            width: 15em;
        }
        .forminputs textarea
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
        #bugtracker
        {
            margin-top: -5em;
        }
    </style>
</head>
<body>
  <table style="width: 1200px; border: 0px; padding: 0" align="center">
    <!--#include virtual="/z2t_Backoffice/includes/heading.inc"-->
    <tr>
      <td>
        <table style="width: 100%; border: 0px; padding: 0; margin: 0" align="center">
          <tr>
            <td width="100%" align="left" height="10" class="divDeskTop">
            </td>
          </tr>
          <tr>
            <td style="width: 100%; height: 600px" align="left" class="divDeskMiddle">
              <form id="bugtracker" action="z2t_submit_address_bug.asp" method="post" target="foo" onsubmit="window.open('','foo','width=450,height=300,status=yes,resizable=yes,scrollbars=yes')">
                <%
                  Dim rs : set rs = server.createObject("ADODB.Recordset")

                  ' SQL connection string
	              connString = "driver=SQL Server; server=localhost; uid=davewj2o; pwd=get2it; database=z2t_BackOffice"

	              ' check for page
     	          If Request.QueryString("Page") = "" Then
		            currentPage = 1
	              Else
		            currentPage = CINT(Request.QueryString("Page")) ' convert Page request to an integer
	              End If

	              ' set connection object and Recordset
	              Set objConn = Server.CreateObject("ADODB.Connection")
	              Set rs = Server.CreateObject("ADODB.RecordSet")
	              objConn.Open connString

	         
                  ' SQL Query

                  If Not Request("ID") <> "" Then
                    Session("bMode") = "Add"
                    Set rs = Server.CreateObject("ADODB.Recordset")
                    rs.CursorLocation = 3

                    rs.Fields.Append "ID", 12
                    rs.Fields.Append "Status", 12
                    rs.Fields.Append "StreetAddress", 12
                    rs.Fields.Append "City", 12
                    rs.Fields.Append "State", 12
                    rs.Fields.Append "PostalCode", 12
                    rs.Fields.Append "Plus4", 12
                    rs.Fields.Append "County", 12
                    rs.Fields.Append "Latitude", 12
                    rs.Fields.Append "Longitude", 12
                    rs.Fields.Append "LocationMatch", 12
                    rs.Fields.Append "TotalRate", 12
                    rs.Fields.Append "StateRate", 12
                    rs.Fields.Append "CountyRate", 12
                    rs.Fields.Append "CityRate", 12
                    rs.Fields.Append "SpecialRate", 12
                    rs.Fields.Append "Z2TSTATE", 12
                    rs.Fields.Append "STATELOOKUPRESULT", 12
                    rs.Fields.Append "ZIPURL", 12
                    rs.Fields.Append "ZIPXMLRESULTPassFail", 12
                    rs.Fields.Append "ZIPXMLResult", 12
                    rs.Fields.Append "ZIPWebsiteResult", 12
                    rs.Fields.Append "ZIPWebsitePassFail", 12
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
                    rs.Fields("Status").Value = ""
                    rs.Fields("StreetAddress").Value = ""
                    rs.Fields("City").Value = ""
                    rs.Fields("State").Value = ""
                    rs.Fields("PostalCode").Value = ""
                    rs.Fields("Plus4").Value = ""
                    rs.Fields("County").Value = ""
                    rs.Fields("Latitude").Value = ""
                    rs.Fields("Longitude").Value = ""
                    rs.Fields("LocationMatch").Value = ""
                    rs.Fields("TotalRate").Value = ""
                    rs.Fields("StateRate").Value = ""
                    rs.Fields("CountyRate").Value = ""
                    rs.Fields("CityRate").Value = ""
                    rs.Fields("SpecialRate").Value = ""
                    rs.Fields("Z2TSTATE").Value = ""
                    rs.Fields("STATELOOKUPRESULT").Value = ""
                    rs.Fields("ZIPURL").Value = ""
                    rs.Fields("ZIPXMLRESULTPassFail").Value = ""
                    rs.Fields("ZIPXMLResult").Value = ""
                    rs.Fields("ZIPWebsiteResult").Value = ""
                    rs.Fields("ZIPWebsitePassFail").Value = ""
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
                    strSQL = "SELECT * FROM dbo.z2t_bugtracking_addresses WHERE ID = " & Request.QueryString("ID")
	                rs.open strSQL,objConn
                  End If

                  If rs.EOF Then
                    rs.Close
                    Set rs = Server.CreateObject("ADODB.Recordset")
                    rs.CursorLocation = 3
 
                    rs.Fields.Append "ID", 12
                    rs.Fields.Append "Status", 12
                    rs.Fields.Append "StreetAddress", 12
                    rs.Fields.Append "City", 12
                    rs.Fields.Append "State", 12
                    rs.Fields.Append "PostalCode", 12
                    rs.Fields.Append "Plus4", 12
                    rs.Fields.Append "County", 12
                    rs.Fields.Append "Latitude", 12
                    rs.Fields.Append "Longitude", 12
                    rs.Fields.Append "LocationMatch", 12
                    rs.Fields.Append "TotalRate", 12
                    rs.Fields.Append "StateRate", 12
                    rs.Fields.Append "CountyRate", 12
                    rs.Fields.Append "CityRate", 12
                    rs.Fields.Append "SpecialRate", 12
                    rs.Fields.Append "Z2TSTATE", 12
                    rs.Fields.Append "STATELOOKUPRESULT", 12
                    rs.Fields.Append "ZIPURL", 12
                    rs.Fields.Append "ZIPXMLRESULTPassFail", 12
                    rs.Fields.Append "ZIPXMLResult", 12
                    rs.Fields.Append "ZIPWebsiteResult", 12
                    rs.Fields.Append "ZIPWebsitePassFail", 12
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
                    rs.Fields("Status").Value = ""
                    rs.Fields("StreetAddress").Value = ""
                    rs.Fields("City").Value = ""
                    rs.Fields("State").Value = ""
                    rs.Fields("PostalCode").Value = ""
                    rs.Fields("Plus4").Value = ""
                    rs.Fields("County").Value = ""
                    rs.Fields("Latitude").Value = ""
                    rs.Fields("Longitude").Value = ""
                    rs.Fields("LocationMatch").Value = ""
                    rs.Fields("TotalRate").Value = ""
                    rs.Fields("StateRate").Value = ""
                    rs.Fields("CountyRate").Value = ""
                    rs.Fields("CityRate").Value = ""
                    rs.Fields("SpecialRate").Value = ""
                    rs.Fields("Z2TSTATE").Value = ""
                    rs.Fields("STATELOOKUPRESULT").Value = ""
                    rs.Fields("ZIPURL").Value = ""
                    rs.Fields("ZIPXMLRESULTPassFail").Value = ""
                    rs.Fields("ZIPXMLResult").Value = ""
                    rs.Fields("ZIPWebsiteResult").Value = ""
                    rs.Fields("ZIPWebsitePassFail").Value = ""
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
                <div class="forminputs" style="width: 40%; margin-left: 7em; float: left">
                  <div style="float: left; width: 100%; display: none">
                    <label style="width: 12em; height: 1.4em; float: left" for="txtID">Bug ID:</label>
                    <input id="txtID" name="ID" type="text" readonly style="float: right; width: 12em" value="<%=rs("ID")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtAddress" style="width: 12em; vertical-align: top; float: left; margin-top: .1em">Address:</label>
                    <input type="text" id="txtAddress" name="StreetAddress" style="float: right; width: 20em" value="<%=rs("StreetAddress")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtCity" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">City:</label><input id="txtCity" name="City" style="float: right; width: 20em" type="text" value="<%=rs("City")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtState" style="width: 12em; vertical-align: top; float: left; margin-top: .1em">State:</label><input type="text" id="txtState" name="State" style="float: right; width: 20em" value="<%=rs("State")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtZIPcode" style="width: 12em; vertical-align: top; float: left; margin-top: .1em">ZIP Code:</label><input type="text" id="txtZIPcode" name="PostalCode" style="float: right; width: 20em" value="<%=rs("PostalCode")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtPlus4" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">Plus4:</label><input id="txtPlus4" name="Plus4" type="text" style="float: right; width: 20em" value="<%=rs("Plus4")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtCounty" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">County:</label><input id="txtCounty" name="County" style="float: right; width: 20em" type="text" value="<%=rs("County")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtLatitude" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">Latitude:</label><input id="txtLatitude" name="Latitude" style="float: right; width: 20em" type="text" value="<%=rs("Latitude")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtLongitude" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">Longitude:</label><input id="txtLongitude" name="Longitude" type="text" style="float: right; width: 20em" value="<%=rs("Longitude")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtLocation" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">Location Match?:</label><input id="txtLocation" name="LocationMatch" type="text" style="float: right; width: 20em" value="<%=rs("LocationMatch")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtTotalRate" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">Total Rate:</label><input id="txtTotalRate" name="TotalRate" type="text" style="float: right; width: 20em" value="<%=rs("TotalRate")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtStateRate" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">State Rate:</label><input id="txtStateRate" name="StateRate" type="text" style="float: right; width: 20em" value="<%=rs("StateRate")%>" />
                  </div>
                  <div style="float: left; width: 100%">
                    <label for="txtCountyRate" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">County Rate:</label><input id="txtCountyRate" name="CountyRate" type="text" style="float: right; width: 20em" value="<%=rs("CountyRate")%>" />
</div>
<div style="float: left; width: 100%">
<label for="txtCityRate" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">City Rate:</label>
<input id="txtCityRate" name="CityRate" type="text" style="float: right; width: 20em" value="<%=rs("CityRate")%>" />
</div>
<div style="float: left; width: 100%">
<label for="txtSpecialRate" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">Special Rate:</label>
<input id="txtSpecialRate" name="SpecialRate" type="text" style="float: right; width: 20em" value="<%=rs("SpecialRate")%>" />
</div>
<div style="float: left; width: 100%">
<label for="txtZ2TSTATE" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">Z2T=STATE?:</label>
<textarea id="txtZ2TSTATE" name="Z2TSTATE" style="float: right; width: 20em; height: 5em; resize: none" rows="1" cols="1"><%=rs("Z2TSTATE")%></textarea>
</div>
</div>
<div class="forminputs" style="width: 40%; margin-right: 7em; float: right">
                                <div style="float: left; width: 100%">
                                    <label for="txtStateLookupResult" style="width: 12em; height: 1.4em; float: left;
                                        margin-top: .1em">
                                        State Look-up Result:</label>
                                    <textarea id="txtStateLookupResult" name="StateLookupResult" style="float: right;
                                        width: 20em; height: 5em; resize: none" rows="1" cols="1"><%=rs("STATELOOKUPRESULT")%></textarea>
                                </div>
                                <div style="float: left; width: 100%">
                                    <label for="txtZipURL" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">
                                        Zip URL:</label>
                                    <input id="txtZipURL" name="ZipURL" type="text" style="float: right; width: 20em"
                                        value="<%=rs("ZIPURL")%>" />
                                </div>
                                <div style="float: left; width: 100%">
                                    <label for="txtZipXmlResultPassFail" style="width: 12em; height: 1.4em; float: left;
                                        margin-top: .1em">
                                        Zip Xml Result Pass/Fail:</label>
                                    <input id="txtZipXmlResultPassFail" name="ZipXmlResultPassFail" type="text" style="float: right;
                                        width: 20em" value="<%=rs("ZIPXMLRESULTPassFail")%>" />
                                </div>
                                <div style="float: left; width: 100%">
                                    <label for="txtZipXmlResult" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">
                                        Zip Xml Result:</label>
                                    <textarea id="txtZipXmlResult" name="ZipXmlResult" style="float: right; width: 20em;
                                        height: 5em; resize: none" rows="1" cols="1"><%=rs("ZIPXMLResult")%></textarea>
                                </div>
                                <div style="float: left; width: 100%">
                                    <label for="txtZipWebResult" style="width: 12em; height: 1.4em; float: left; margin-top: .1em">
                                        Zip Website Result:</label>
                                    <input id="txtZipWebResult" name="ZipWebsiteResult" type="text" style="float: right;
                                        width: 20em" value="<%=rs("ZIPWebsiteResult")%>" />
                                </div>
                                <div style="float: left; width: 100%">
                                    <label for="txtZipWebsitePassFail" style="width: 12em; height: 1.4em; float: left;
                                        margin-top: .1em">
                                        Zip Website Pass/Fail:</label>
                                    <input id="txtZipWebsitePassFail" name="ZipWebsitePassFail" type="text" style="float: right;
                                        width: 20em" value="<%=rs("ZIPWebsitePassFail")%>" />
                                </div>
                                <br />
                                <div style="clear: both">
                                    &nbsp;</div>
                            <div style="width: 9em; vertical-align: top; float: left">
                                &nbsp;</div>
                            <div style="width: 10em; vertical-align: top; float: left; text-align: left">
                                Who?</div>
                            <div style="width: 10em; vertical-align: top; float: left; text-align: center">
                                When?</div>
                            <div style="clear: both">
                            </div>
                            <div style="width: 9em; vertical-align: top; float: left;">
                                Created:</div>
                            <input id="txtCreatedBy" name="CreatedBy" style="float: left; width: 11.75em" type="text"
                                value="<%=rs.Fields("CreatedBy")%>" readonly /><input id="txtCreatedDate"
                                    name="CreatedDate" style="float: left; width: 11em" type="text" value="<%=rs.Fields("CreatedDate")%>"
                                    readonly="readonly" />
                            <div style="width: 9em; vertical-align: top; float: left">
                                Assigned To:</div>
                            <select id="selAssigned" name="AssignedTo" style="width: 12.25em; float: left;">
                                <option value="">(Select A User)</option>
                                <%
                      Dim un, connHA
                      Set connHA = Server.CreateObject("ADODB.Connection")
					  ' Commented By Humair: 2 Sep 2016, Not sure which its trying to connect but its resulting in error
                      'connHA.Open "driver=SQL Server; server=66.119.55.118,7043; uid=davewj2o; pwd=get2it; database=ha_BackOffice"
					   connHA.Open "driver=SQL Server; server=66.119.50.230,7043; uid=davewj2o; pwd=get2it; database=ha_BackOffice"' Casper10
                      Set rs2 = Server.CreateObject("ADODB.Recordset")
                      rs2.Open "ha_Employee_Names_List 1 , 1 , 1 , 1", connHA, 1, 3

                      Do While Not rs2.EOF
                        un = rs2("FirstName") & " " & left(rs2("LastName"), 1) & "."
                                %>
                                <option value="<%=rs2("EmpID")%>" <%=iif(rs.Fields("AssignedTo") = rs2("EmpID"), "selected=""selected""", "")%>>
                                    <%=un%>
                                </option>
                                <%
                        
                        rs2.MoveNext
                      Loop

                                %>
                            </select>
                            <input id="txtAssignedDate" name="AssignedDate" style="float: left; width: 11em"
                                type="text" value="<%=rs.Fields("AssignedDate")%>" readonly /><br />
                            <div style="width: 9em; vertical-align: top; float: left">
                                Assigned By:</div>
                            <select id="selAssignedBy" name="AssignedBy" style="width: 12.25em; float: left;">
                                <option value="">(Select A User)</option>
                                <%
                      rs2.MoveFirst

                      Do While Not rs2.EOF
                        un = rs2("FirstName") & " " & left(rs2("LastName"), 1) & "."
                                %>
                                <option value="<%=rs2("EmpID")%>" <%=iif(rs.Fields("AssignedTo") = rs2("EmpID"), "selected=""selected""", "")%>>
                                    <%=un%>
                                </option>
                                <%
                        
                        rs2.MoveNext
                      Loop
                                %>
                            </select>
                            <input id="txtAssignedByDate" name="AssignedByDate" style="float: left; width: 11em"
                                type="text" value="<%=rs.Fields("AssignedByDate")%>" readonly /><br />
                            <div style="width: 9em; vertical-align: top; float: left">
                                Closed By:</div>
                            <select id="selClosed" name="ClosedBy" style="float: left; width: 12.25em">
                                <option value="">(Select A User)</option>
                                <%
                      rs2.MoveFirst

                      Do While Not rs2.EOF
                        un = rs2("FirstName") & " " & left(rs2("LastName"), 1) & "."
                                %>
                                <option value="<%=rs2("EmpID")%>" <%=iif(rs.Fields("AssignedTo") = rs2("EmpID"), "selected=""selected""", "")%>>
                                    <%=un%>
                                </option>
                                <%
                        
                        rs2.MoveNext
                      Loop

                      rs2.Close
                                %>
                            </select>
                            <input id="txtClosedDate" name="ClosedDate" style="float: left; width: 11em" type="text"
                                value="<%=rs.Fields("ClosedDate")%>" readonly /><br />
                            <% rs.Close %><br />
                            <input type="reset" value="Undo Changes" class="button" style="float: right; margin-left: 2em;
                                margin-top: 2em" />
                            <input type="submit" value="Submit" class="button" style="float: right; margin-left: 0px;
                                margin-top: 2em" />
                            </div>
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%" align="left" height="10" class="divDeskBottom">
                        </td>
                    </tr>
                </table>
                <!--#include virtual="/z2t_Backoffice/includes/z2t_PageTail.inc"-->
            </td>
        </tr>
    </table>
</body>
</html>
