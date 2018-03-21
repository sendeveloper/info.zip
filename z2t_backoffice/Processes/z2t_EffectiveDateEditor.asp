<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_PageStart.inc"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->

<%
  PageHeading = "Effective Date Editor"
  ColorTab = 2
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

	function clickAdd()
		{
		var URL = 'PopUps/z2t_TableHistoryAdd.asp';
		openPopUp(URL);
		}
		
	function clickEdit(ID)
		{
		var URL = 'PopUps/z2t_TableHistoryEdit.asp' +
			'?ID=' + ID;
		openPopUp(URL);
		}
		
	function clickEditTypes()
		{
		var URL = 'PopUps/z2t_TypesDatesEdit.asp';
		openPopUp(URL);
		}		
		
  </script

  ></head>
  
<body>
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->	  
        <%

			Dim rs: Set rs=server.createObject("ADODB.Recordset")
            strSQL = "z2t_Types_Dates_list"
            rs.open strSQL, connPhilly01Maintenance, 3, 3, 4

			If Not rs.EOF Then
        %>
              <table width="1100" border="0" cellspacing="2" cellpadding="2" style="margin-left: 2em;">
                <tr>
                  <td width="640">
                    <table width="600" border="0" cellspacing="2" cellpadding="2">
                      <tr>
                        <td colspan="3">
					      <table width="100%" border="0" cellspacing="0" cellpadding="0">
					        <tr>
					          <td align="left" style="font-weight: bold;">
                                Current Zip2Tax System Dates - Stored in the z2t_Types Table
						      </td>
				              <td align="right">
				                <a href="javascript:clickEditTypes();" class="button40">Edit</a>
                              </td>
					        </tr>
					      </table>
				        </td>
                      </tr>
				
								
                      <tr bgcolor="#990000">
                        <th width="25%">
                          Name
                        </th>
                        <th width="25%">
                          Date
                        </th>
                        <th width="50%">
                          Purpose
                        </th>
                      </tr>
							  
		<%
			Do While not rs.eof
		%>
                      <tr bgcolor="#FFFFFF">
		                <td align="left">
                          <%=rs("dteName")%>
                        </td>
		                <td align="center">
                          <%=rs("dteDate")%>
                        </td>
		                <td align="left">
                          <%=rs("dtePurpose")%>
                        </td>
                      </tr>
        <%
              rs.MoveNext
            Loop
        %>
				
			        </table>
			      </td>
			      <td align="left" vAlign="bottom">
		            Be sure to 
			        <a href="javascript:openPopUp('http://www.harvestamerican.info/ha_backoffice/Servers/TableDistribution/z2t_Types/TableDistribution_z2t_Types.asp');">
					distribute the z2t_Types table</a>
					after editing.
			      </td>
		        </tr>
		     <tr><td>&nbsp;</td></tr>
			    <tr><td>&nbsp;</td></tr>
		  
		<tr>
		  <td>
					
        <%
            End If
			rs.Close
			
            strSQL = "z2t_TableEffectiveDateHistory_read"
            rs.open strSQL, connPhilly01Maintenance, 3, 3, 4

			If Not rs.EOF Then
		%>
                    <table width="600" border="0" cellspacing="2" cellpadding="2">
                      <tr>
                        <td colspan="5">
					      <table width="100%" border="0" cellspacing="0" cellpadding="0">
					        <tr>
					          <td align="left" style="font-weight: bold;">
                                Zip2Tax Table History - Stored in the z2t_EffeciveDates Table
						      </td>
				              <td align="right">
				                <a href="javascript:clickAdd();" class="button40">Add</a>
                              </td>
					        </tr>
					      </table>
				        </td>
                      </tr>				
				
                      <tr bgcolor="#990000">
                        <th width="15%">
                          Year
                        </th>
                        <th width="15%">
                          Month
                        </th>
                        <th width="30%">
                          Effective Date
                        </th>
                        <th width="30%">
                          Release Date
                        </th>
                        <th width="10%">&nbsp;
                          
                        </th>
                      </tr>
			      </table>
				
		          <table width="616" border="0" cellspacing="0" cellpadding="0">
				      <tr>
				        <td width="640" colspan="5">
      				  
		      			<div style="height: 200px; overflow-y: scroll;">
				          <table width="100%" border="0" cellspacing="2" cellpadding="2">


		<%
			Do While not rs.eof
		%>
                            <tr bgcolor="#FFFFFF">
		                      <td width="15%" align="center">
                                <%=rs("Year")%>
                              </td>
		                      <td width="15%" align="center">
                                <%=rs("Month")%>
                              </td>
		                      <td width="30%" align="center">
                                <%=rs("EffectiveDate")%>
                              </td>
		                      <td width="30%" align="center">
                                <%=rs("ReleaseDate")%>
                              </td>
		                      <td width="10%" align="center">
				                <a href="javascript:clickEdit(<%=rs("ID")%>);" class="button30">Edit</a>
                              </td>
                            </tr>
        <%
              rs.MoveNext
            Loop
            End If
			rs.Close
        %>
            			  </table>
					    </div>
				        </td>
				      </tr>
				
			        </table>
			  
			      </td>
				  
			      <td align="left" vAlign="bottom">
		            Be sure to
			        <a href="javascript:openPopUp('http://www.harvestamerican.info/ha_backoffice/Servers/TableDistribution/z2t_EffectiveDates/TableDistribution_z2t_EffectiveDates.asp');">
					distribute the z2t_EffectiveDates table</a>
					after editing.
			      </td>

			 
				  
		        </tr>
		        <tr><td>&nbsp;</td></tr>
			  </table>
			  
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


