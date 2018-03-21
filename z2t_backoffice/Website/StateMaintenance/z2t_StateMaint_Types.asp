<%response.buffer=true%>

<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%


	Dim PageHeading
	Dim CurrClass
	Dim NewClass
	Dim Description
	Dim DescDisplay
	
    PageHeading = "State Maintenance - Types"
	ColorTab = 6
%>
	
<html>
<head>

    <title>Zip2Tax State Maintenance - Types</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />

	<script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

	<script language='JavaScript'>
		function clickEdit(c)
			{
			var URL = 'z2t_StateMaint_TypesEdit.asp?Class=' + c;
			window.open(URL,'','scrollbars=yes,fullscreen=no,resizable=no,height=630,width=750,left=100,top=30');
			}
	</script>
	
	<style>
	    td {font-size: 12pt;}
		th {font-size: 13 px; background-color: #990000}
	</style>
	
</head>

<body>

	<!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->

      <table width="100%" border="0" cellspacing="5" cellpadding="5">
        <tr valign="top">
          <td style="font-size:12pt">
                        The wording in the option choices you are given to choose from on the State Maintenance page can edited here. 
                        <br>
                        Editing here writes changes to the z2t_Types table. Once complete you must distribute the z2t_Types table for the changes to take effect.
          </td>
        </tr>
	
	
        <tr>
          <td colspan="3">
            <table width="60%" border="0" cellspacing="2" cellpadding="2" align="left">
            <tr>
            <%
			ifHomePages="false"
			tdHeading = "State Pages"

			for i= 0 to 1
				' if 	ifHomePages = "true" then 
					response.Write("<td valign='top' style='width:45%'>"		)
					' end if
					
			
			%>

			<table width="100%" border="0" cellspacing="2" cellpadding="2" align="left" >
                <tr>
                    <th> <%=tdHeading%>  </th>
                </tr>
                <%
					set rs=Server.CreateObject("ADODB.Recordset")
					SQL = "z2t_StatePageMaintenanceTypes_read ('"&ifHomePages&"')"
					rs.open SQL, connPhilly01PublishTables, 2, 3
					
					while not rs.EOF
						CurrClass = split(rs("Class"),"_")(1)
                %>

                <tr>  
                <td width="100%" bgColor="White">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td align="left" style="font-size:12px;">
					   <b><%=CurrClass%></b>
                      </td>
                      <td align="right">
						<a href="javascript:clickEdit('<%=Server.URLEncode(CurrClass)%>');" class='button20' title='Edit this category'>
							Edit
						</a>
                      </td>
                    </tr>
                  </table>
                </td>    
              </tr>
              

				<%
             
          rs.MoveNext
		wend

		rs.Close
				tdHeading = "Home Page"
				ifHomePages ="true"
' if ifHomePages = "true" then 
response.Write("</table>")
response.Write("</td><td style='width:10%'>&nbsp;</td>")
'end if
		Next 
                %>
            </tr>    
		    </table>        
          </td>
        </tr>
        
      </table>


 <!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
</body>
</html>
