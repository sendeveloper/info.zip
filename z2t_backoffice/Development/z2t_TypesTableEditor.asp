<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
  PageHeading = "Types Table Editor"
  ColorTab = 1
%>

<!DOCTYPE html>
<html>
  <head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_Backoffice.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

  <script language='JavaScript'>
		
	function clickEdit(Class)
		{
		var URL = 'PopUps/z2t_TypesClass_Edit.asp' +
			'?Class=' + Class;
		openPopUp(URL);
		}
				
  </script>

  </head>
  
<body>
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->        <%
			Dim connPhilly01: Set connPhilly01=server.CreateObject("ADODB.Connection")
			Dim rs: Set rs=server.createObject("ADODB.Recordset")
			connPhilly01.Open "driver=SQL Server;server=208.88.49.18,8143;uid=davewj2o;pwd=get2it;database=z2t_PublishedTables" ' philly01
            strSQL = "z2t_Types_list"
            rs.open strSQL, connPhilly01, 3, 3, 4

			If Not rs.EOF Then
        %>
               
                    <table width="98.5%" border="0" cellspacing="2" cellpadding="2">
		               <tr>
                        <td colspan="5">
					      <table width="98.5%" border="0" cellspacing="0" cellpadding="0">
					        <tr>
					          <td align="left" style="font-weight: bold;">
                                Here you can view and edit entries in the z2t_Types table.  Proceed with caution when editing as a change here can effect many processes.
						      </td>
					        </tr>
					      </table>
				        </td>
                      </tr>
				
								
                      <tr bgcolor="#990000">
                        <th width="30%">
                          Class
                        </th>
                        <th width="40%">
                          Purpose
                        </th>
                        <th width="10%">
                          Count
                        </th>
                        <th width="10%">
                          Last Edited
                        </th>
                        <th width="10%">&nbsp;
				          
                        </th>

                      </tr>
					</table>
					
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
				      <tr>
				        <td width="100%">
      				  
		      			<div style="height: 500px; overflow-y: scroll;">
				          <table width="100%" border="0" cellspacing="2" cellpadding="2">
					
							  
		<%
			Do While not rs.eof
		%>
							  <tr bgcolor="#FFFFFF">
								<td width="30%" align="left">
								  <%=rs("Class")%>
								</td>
								<td width="40%">
								  <%=rs("Purpose")%>
								</td>
								<td width="10%" align="right">
								  <%=rs("CountClass")%>
								</td>
								<td width="10%" align="center">
								  <%=rs("LastEditedDate")%>
								</td>
								<td width="10%" align="center">
								  <a href="javascript:clickEdit('<%=rs("Class")%>');" class="button30">View</a>
								</td>
							  </tr>
        <%
              rs.MoveNext
            Loop
        %>
		
						  </table>
						</div>
					    </td>
					  </tr>	  
				
			        </table>
			      </td>
		        </tr>
		  
		        <tr>
				  <td align="left" vAlign="bottom">
		            Be sure to 
			        <a href="javascript:openPopUp('http://www.harvestamerican.info/ha_backoffice/Servers/TableDistribution/z2t_Types/TableDistribution_z2t_Types.asp');">
					distribute the z2t_Types table</a>
					after editing.
			      </td>
				</tr>
				
					
        <%
            End If
			rs.Close
		%>
		
				<!--#include virtual="/z2t_Backoffice/includes/BodyParts/footer.inc"-->
</body>
</html>

<%
  Function DisplayNumber(n)
	If isnull(n) Then
		DisplayNumber = ""
	Else
        DisplayNumber = FormatNumber(n,0)
	End If
  End Function
%>


