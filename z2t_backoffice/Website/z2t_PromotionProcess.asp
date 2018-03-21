
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
  dim strColor
  dim PageHeading
  dim recordCount
  dim StateAbbr(100)
  dim StateName(100)

  PageHeading = "Promotion Process"
  ColorTab = 6



  sqlText="z2t_Services_list"

  set RS=server.createObject("ADODB.Recordset")
  RS.open sqlText, connBackoffice, 3, 3, 4

%>

<html>
<head>
  <title><%=PageHeading%></title>

  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

  <script type="text/javascript" src="../includes/lib.js"></script>
   <script language='JavaScript'>

	function clickPopup(ID)
		{
		var URL = 'http://www.harvestamerican.info/ha_BackOffice/Company/DocumentMaintenance/ha_Document_Show.asp' +
			'?PhotoID=' + ID;
			PopupCenter(URL,'Daves Popup Test','593','450');
		}
		
  </script>
  
  <style type="text/css">
  </style>

</head>

<body>
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->
  
  <tr><td>
        <table width="95%" border="0" cellspacing="2" cellpadding="2" style="background-color: white;">

        <tr valign="top">	
          <td align="center">
			<a href="javascript:clickPopup(1122);">Promotion Process Diagram</a><br>
          </td>
        </tr>		

      </table>
</td></tr>
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/footer.inc"--></body>
</html>
