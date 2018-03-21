<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%
  PageHeading = "Tax Research Overview"
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
	
	span.subHeadSml
		{
		font-size:		12pt;
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
						
<span class="subHead">ZIP, ZIP+4 and Postal Code Update</span><br>
	<i>During the first week of each month.</i><br>
		
		<a href="javascript:clickPopup(1363);">Update ZIP and Postal Codes</a>&nbsp&nbsp <a href="javascript:clickPopup(1365);">Flowchart</a><br>
		<a  href="javascript:clickPopup(1362);">Update ZIP+4 Codes</a>&nbsp&nbsp <a href="javascript:clickPopup(1372);">Flowchart</a><br>
		<a href="javascript:clickPopup(1166);">Tax Data Update</a>&nbsp&nbsp <a href="javascript:clickPopup(1366);">Flowchart</a><br><br>
	
<span class="subHead">Research/Editing</span><br>
	<i>During the second and third weeks of each month</i><br>
	
		<a href="http://legacy.zip2tax.com/Backoffice/z2t_StateList.asp">Research USA, Canada, US Possessions</a><br>
		<a href="https://www.zip2tax.info/z2t_Backoffice/Research/z2t_TaxData.asp">Tax Data Edit</a> &nbsp&nbsp <a href="javascript:clickPopup(1367);">Flowchart</a><br>
		<a href="javascript:clickPopup(1166);">Tax Data Update</a> &nbsp&nbsp <a href="javascript:clickPopup(1366);">Flowchart</a><br>
		<a href="https://www.zip2tax.info/z2t_Backoffice/Research/z2t_IntegrityChecks.asp">Integrity Check</a><br>
		<a href="https://www.zip2tax.info/z2t_Backoffice/Research/z2t_IntegrityChecks.asp">Table Differences</a><br>
		Check one single state, US and NY Clothing for each version Sales and Use<br><br>

<span class="subHead">State Page Maintenance<br></span>
	<i>During the second and third weeks of each month.</i><br>
	
		<a href="https://www.zip2tax.info/z2t_Backoffice/Website/StateMaintenance/z2t_StateMaint.asp">State Maintenance</a><br>
		<a href="https://www.zip2tax.info/z2t_Backoffice/Website/StateMaintenance/z2t_StateMaint_Types.asp">State Maintenance Types</a><br>
		Updater notifies Page Duplication Manager of updates ready for Casper09.<br>
		<a href="javascript:clickPopup(1369);">Casper09 Duplication Steps</a><br>
		Manager notify tester for viewing on dev.<br>
		Tester notifies Page Duplication Manager of updates ready for staging.<br>
		<a href="javascript:clickPopup(1370);">Staging Duplication Steps</a><br>
		Manager notify tester for viewing on staging.<br>


						</td>
					  </tr>
					</table>
				  </td>
                  <td>
					<table width="550" align="center" border="0" cellspacing="2" cellpadding="2" style="background-color: white;">
					  <tr valign="top">
						<td style="font-size: 10pt;">
					


<span class="subHead">CSV Table Release Day<br></span>
	<i>The Last Monday of each month.</i><br>
	
		<a href="javascript:clickPopup(1165);">Table Release</a><br>
		<a href="https://www.zip2tax.info/z2t_Backoffice/Processes/z2t_EffectiveDateEditor.asp">Effective Date Editor</a><br>
		Test table downloads from My Account<br>
		Notify manager of table release<br>
		<a href="javascript:clickPopup(1272);">FTP US Full Breakout Table to Yahoo</a><br><br>

<span class="subHead">First of Month Day</span></a><br>
	<i>First day of each month.</i><br>
		<a href="javascript:clickPopup(1273);">First of Month Update: Legacy</a><br>
		<a href="javascript:clickPopup(1274);">First of Month Update: PinPoint</a><br>
		<a href="javascript:clickPopup(1293);">First of Month Update: MySQL</a><br>
		<a href="javascript:PopupCenter('https://www.zip2tax.info/z2t_Backoffice/Processes/PopUps/z2t_MySQL.asp','Daves Popup Test','900','500')"> First of Month Update: MySQL Pop Up</a><br><br>

<span class="subHead">z2t_ZipCodes Database Table Monthly Archiving</span></a><br>
	<i>After First of Month Day, during first week of each month prior to ZIP Code Update.</i><br>
		<a href="javascript:clickPopup(1376);">z2t_ZipCodes Monthly Archiving Steps</a><br><br>

<span class="subHead">State Page Promotion to Production</span></a><br>
	<i>First day of each month.</i><br>
		Tester notifies manager of updates ready for production.<br>
		<a href="javascript:clickPopup(1371);">Production Duplication Steps</a><br>
		Manager notifies tester of updates in production for viewing.<br>

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
