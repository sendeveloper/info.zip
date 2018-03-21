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

	function clickPopup(ID)
		{
		var URL = 'http://www.harvestamerican.info/ha_BackOffice/Company/DocumentMaintenance/ha_Document_Show.asp' +
			'?PhotoID=' + ID;
			PopupCenter(URL,'Daves Popup Test','900','500');
		}
		
  </script>

  <style type="text/css">
  
	a
		{
		font-size:		10pt;
		}
		
	span.subHead
		{
		font-size:		14pt;
		font-weight:	bold;
		}
		
  </style>
  
</head>

<body>
  <table width="1200" border="0" cellspacing="0" cellpadding="0" align="center">

  <!--#include virtual="/z2t_Backoffice/includes/heading.inc"-->

    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
          <tr>
            <td width="100%" align="left" height="10" class="divDeskTop">
            </td>
          </tr>
          <tr>
            <td width="100%" align="left" height="400" class="divDeskMiddle">
              <table width="100%" align="center" border="0" cellspacing="5" cellpadding="5">
				<tr valign="top">
                  <td>
					<table width="550" align="center" border="0" cellspacing="2" cellpadding="2" style="background-color: white;">
					  <tr valign="top">
						<td style="font-size: 10pt;">
						
<span class="subHead">Zip Code Update</span><br>
<i>During the first week of each month.</i></br>
<a href="javascript:clickPopup(1162);">Import Zip Codes</a></br>
<a href="javascript:clickPopup(1166);">Tax Data Update</a></br>

 
<br></br><span class="subHead">Research/Editing</span><br>
<i>During the second and third weeks of each month</i><br>
<a href="http://legacy.zip2tax.com/Backoffice/z2t_StateList.asp">Research USA, Canada, US Possessions</a><br>
<i>(update links on state worksheet page with my spreadsheet)</i><br>
<a href="https://www.zip2tax.info/z2t_Backoffice/Research/z2t_TaxData.asp">Tax Data Edit</a><br>
<a href="javascript:clickPopup(1166);">Tax Data Update</a><br>
<a href="https://www.zip2tax.info/z2t_Backoffice/Research/z2t_IntegrityChecks.asp">Integrity Check</a><br>
<a href="https://www.zip2tax.info/z2t_Backoffice/Research/z2t_IntegrityChecks.asp">Table Differences</a><br>
Check one single state, US and NY Clothing for each version Sales and Use</br>


						</td>
					  </tr>
					</table>
				  </td>
                  <td>
					<table width="550" align="center" border="0" cellspacing="2" cellpadding="2" style="background-color: white;">
					  <tr valign="top">
						<td style="font-size: 10pt;">

<span class="subHead">Deployment of API</br></span>
<!--<i>The Last Monday of each month.</i><br>-->
<a href="javascript:clickPopup(1209);">API Version Control</a><br>
<a href="javascript:clickPopup(1208);">Deployment Guidelines</a><br>
<!--<a href="https://www.zip2tax.info/z2t_Backoffice/Processes/z2t_EffectiveDateEditor.asp">Effective Date Editor</a><br>
Test table downloads from My Account<br>
Notify manager of table release<br>
FTP Yahoo<br><br>-->
<br><br>

<span class="subHead">First of Month Day</span></a><br>
<i>First day of each month.</i><br>
<a href="javascript:clickPopup(1163);">First of Month Update</a><br><br></br>


						</td>
					  </tr>
					</table>
				  
                  </td>
                </tr>
              </table>
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
