<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%
  PageHeading = "API Overview"
  ColorTab = 2
%>

<html>
<head>
  <title>Zip2Tax.info - <%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
   
  <script language='JavaScript'>

	function clickPopupImage(ID)
		{
		var URL = 'http://www.harvestamerican.info/ha_BackOffice/Company/DocumentMaintenance/ha_Document_Show.asp' +
			'?PhotoID=' + ID;
			PopupCenter(URL,'Daves Popup Test','900','500');
		}
		
    function clickPopup(n)
		{
		  var URL = '/z2t_backoffice/Processes/Overview/' + n + '.asp'
		  openPopUp(URL);
		}		
		
  </script>

  <style type="text/css">
  	
	a
		{
		font-size:		12px;
		}
		
	span.subHead
		{
		font-size:		14pt;
		font-weight:	bold;
		}
		
	span.subHeadSml
		{
		font-size:		12pt;
		font-weight:	bold;
		}		
  </style>
  
</head>

<body>
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->			
						<table width="95%" align="center" border="0" cellspacing="2" cellpadding="2" style="background-color: white;">

						<tr valign="top">
							<td  style="font-size: 12pt;">
								<span class="subHead">Deployment of API</br></span>
                                <!--<i>The Last Monday of each month.</i><br>-->
                                <a href="javascript:clickPopupImage(1209);">API Version Control</a><br>
                                <a href="javascript:clickPopupImage(1208);">Deployment Guidelines</a><br>
                                <!--<a href="https://www.zip2tax.info/z2t_Backoffice/Processes/z2t_EffectiveDateEditor.asp">Effective Date Editor</a><br>
                                Test table downloads from My Account<br>
                                Notify manager of table release<br>
                                FTP Yahoo<br><br>-->
                                <br><br>
                                
                                <span class="subHead">Misc Z2T Docs</span><br>
                                <a href="javascript:clickPopupImage(1349);">Generate Sec Key - CyberSource SA</a><br>
                            </td>
                            <td  style="font-size: 12pt;">
                                                        <span class="subHead">Direct Connect</span></a><br>
                                <a href="javascript:clickPopupImage(1593);">MySQL How to Connect and Test Lookups on Philly01</a><br><br>
                                
                                <a href="javascript:clickPopup('DirectConnect/z2t_DirectConnect_MySQL_Lookup');">MySQL Direct Connect Flowchart</a><br>
                                <a href="javascript:clickPopup('DirectConnect/z2t_DirectConnect_MySQL_Objects');">MySQL Direct Connect Objects</a><br><br>
                                
                                <a href="javascript:clickPopup('DirectConnect/z2t_DirectConnect_MSSQL_Lookup');">MSSQL Direct Connect Flowchart</a><br>
                            </td>
                            
                            <td  style="font-size: 12pt;">
                                                        <span class="subHead">Rate Look-Up Flowcharts</span></a><br>
                                <a href="javascript:clickPopupImage(1416);">5 digit ZIP code</a><br>
                                <a href="javascript:clickPopupImage(1415);">ZIP+4</a><br>
                                <a href="javascript:clickPopupImage(1414);">Address</a><br>
                                <a href="javascript:clickPopupImage(1417);">Get Special District Details</a><br>
                                <a href="javascript:clickPopupImage(1418);">SpotOn API</a><br>
                                <a href="javascript:clickPopupImage(1419);">Address Enhancement</a><br>
                                <a href="javascript:clickPopupImage(1420);">Get Latitude and Longitude for Maps</a><br>
							</td>
						</tr>
						
						
						
					</table>
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
</body>
</html>
