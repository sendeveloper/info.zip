<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
  PageHeading = "Zip2Tax Data Maintenance"
  ColorTab = 2
  box = "&#9744;&nbsp;&nbsp;"
  star = "&#9733;&nbsp;"
  indent = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
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
			window.open(URL,'','height=900, width=900');
		}
		

		
  </script>

  <style type="text/css">
  
	a
		{
		font-size:		10pt;
		}
		
	span.subHead
		{
		font-size:		12pt;
		font-weight:	bold;
		//background-color: maroon;
	    color: maroon;
		//padding-right: 2px;
	    //padding-left: 2px;
		//padding-bottom: 1px;
	    //padding-top: 1px;
		border-bottom: 2px solid maroon;
		display: inline-block;
		margin-bottom: 5px;
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
					<table width="95%" align="center" border="0" cellspacing="2" cellpadding="2" style="background-color: white; border-collapse:collapse">
					  <tr valign="top" style="border:none">
						<td style="font-size: 10pt; width: 48%;">
						
							<span class="subHead">z2t_ZipCodes Database Table Monthly Archiving</span></a><br>
							<i>After First of Month Day, during first week of each month prior to ZIP Code Update.</i><br>
							<%=box%><a href="javascript:clickPopup(1376);">z2t_ZipCodes Monthly Archiving Steps</a><br><br>
						
							<span class="subHead">ZIP, ZIP+4 and Postal Code Update</span><br>
							<i>During the first week of each month.</i><br>
		
		<%=box%><a href="javascript:clickPopup(1389);">Update ZIP and Postal Codes</a>&nbsp;&nbsp; <a href="javascript:clickPopup(1390);">Flowchart</a>&nbsp;&nbsp; <a href="javascript:clickPopup(1391);">Flowchart</a><br>
		<%=box%><a  href="javascript:clickPopup(1615);">Update ZIP+4 Codes</a>&nbsp;&nbsp; <a href="javascript:clickPopup(1615);">Flowchart</a><br>
		<%=indent%><%=star%><i>If lapse in monthly updates, refresh Zip4 database in place of update procedures.</i><br>
		<%=indent%><%=box%><a href="javascript:clickPopup(1521);">Refresh Zip4 Database</a><br>
		<%=box%><a href="javascript:clickPopup(1166);">U.S. Tax Data Update</a>&nbsp;&nbsp; <a href="javascript:clickPopup(1366);">Flowchart</a><br>
		<%=box%><a href="javascript:clickPopup(1395);">Canada Tax Data Update</a>&nbsp;&nbsp; <a href="javascript:clickPopup(1394);">Flowchart</a><br>
		<%=box%><a href="javascript:clickPopup(1446);">Zip Code Boundary Data</a><br><br>
	
<span class="subHead">Research/Editing</span><br>
	<i>During the second and third weeks of each month</i><br>
	
		<%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Research/StateInformation/z2t_StateInformation.asp"target="_blank">Research USA and US Possessions</a><br>
		<%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Processes/z2t_ResearchLinks.asp"target="_blank">Research US Specific Local Jurisdictions and Canada</a><br>
		<%=indent%><%=star%><i>Close to end of month, prior to table release:</i><br>
		<%=indent%><%=box%><i>Web search "tax effective month date, year".</i><br> 
		<%=indent%><%=box%><i>Check tax blogs for rate changes.</i><br>
		<%=box%><a href="javascript:clickPopup(1379);">Import Data to SQL</a> &nbsp;&nbsp; <a href="javascript:clickPopup(1379);">Merge Imported Data with z2t_TaxData</a><br>
		<%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Research/z2t_TaxData.asp"target="_blank">U.S. Tax Data Edit</a> &nbsp;&nbsp; <a href="javascript:clickPopup(1367);">Flowchart</a><br>
		<%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Research/z2t_IntegrityChecks.asp"target="_blank">Integrity Check</a><br>
		<%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Research/z2t_IntegrityChecks.asp"target="_blank">Table Differences</a><br>
		<%=box%>Run Philly05 C:\Zip2Tax\Export\UpperLower Conversion on<br>
		<%=indent%><%=indent%>z2t_UpdateZipCodes.dbo.z2t_ZipCodes County field.<br>
		<%=box%>Remove blank citystname records from z2t_UpdateZipCodes.dbo.z2t_ZipCodes.<br>
		<%=box%>Remove duplicates from z2t_UpdateZipCodes.dbo.z2t_ZipCodes.<br>
		<%=box%><a href="javascript:clickPopup(1166);">U.S. Tax Data Update</a> &nbsp;&nbsp; <a href="javascript:clickPopup(1366);">Flowchart</a><br>
		<%=box%><a href="javascript:clickPopup(1430);">Update Zip4 SpecialDistrict db tables</a><br>
		<%=box%><a href="javascript:clickPopup(1396);">Canada Tax Data Edit</a>&nbsp;&nbsp; <a href="javascript:clickPopup(1397);">Flowchart</a><br>
		<%=box%><i>Remove duplicates from z2t_Canada.dbo.z2t_Canada_PostalCodes.</i><br>
		<%=box%><a href="javascript:clickPopup(1395);">Canada Tax Data Update</a>&nbsp;&nbsp; <a href="javascript:clickPopup(1394);">Flowchart</a><br>
		<%=box%>Check one single state, US and NY Clothing for each version<br>
		<%=box%>Check Canada<br><br>
		
						
                  </td>
        
                  <td style="font-size: 10pt;border-left: solid 1px #f00; width:4%;"></td>
					
					
						<td style="font-size: 10pt;  width: 48%;">
					
<span class="subHead">CSV Table Release Day<br></span>
	<i>The Last Monday of each month.</i><br>
	
		<%=box%><a href="javascript:clickPopup(1165);">Table Release</a><br>
		<%=box%><a href="javascript:clickPopup(1504);">Manually prepare Canada csv.zip</a><br>
		<%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Processes/z2t_EffectiveDateEditor.asp"target="_blank">Effective Date Editor</a><br>
		<%=star%>Copy current month folder to C:\Zip2Tax\Export:<br>
		<%=indent%><%=box%><i>Philly03</i>
		<%=indent%><%=box%><i>Casper06</i>
		<%=indent%><%=box%><i>Frank01</i>
		<%=indent%><%=box%><a href="https://harvestamerican.app.box.com/folder/0"target="_blank">Box.com</a><br>
		<%=box%>Test table downloads from My Account<br>
		<%=box%>Notify marketing, sales and customer service of table release<br>
		<%=box%>ZIP code and rate change summaries to marketing.<br>
		<%=star%>When data revisions are necessary prior to first of month:<br>
		<%=indent%><%=box%><a href="javascript:clickPopup(1519);">Re-release Tables</a><br><br>
					
<span class="subHead">First of Month Day</span></a><br>
	<i>First day of each month.</i><br>
		<%=star%>First of Month Updates:<br>
		<%=indent%><i>SEE THESE <a href="javascript:clickPopup(1622);"><i>NOTES</i></a> BEFORE BEGINNING THE UPDATE PROCESS!!</i><br>
		<%=indent%><%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Processes/Distribution/z2t_BasicTable_distribute.asp" target="_blank"><i>Basic</i></a>
		<!--#<%=indent%><%=box%><a href="http://www.harvestamerican.info/ha_backoffice/Servers/TableDistribution/z2t_ZipCodes/TableDistribution_z2t_ZipCodes.asp" target="_blank"><i>Basic</i></a>-->
		<%=indent%><a href="javascript:clickPopup(1578);"><i>Documentation</i></a><br>
		<%=indent%><%=box%><a href="http://www.harvestamerican.info/ha_BackOffice/Servers/TableDistribution/ha_TableDistribution.asp" target="_blank"><i>SpotOn</i></a>
		<%=indent%><%=box%><a href="javascript:clickPopup(1567);"><i>Documentation</i></a><br>
		<%=indent%><a href="javascript:clickPopup(1430);"><i>Special Districts</i></a>&nbsp&nbsp<%=indent%><%=box%><a href="javascript:clickPopup(1611);"><i>SpecialDistrictSC</i></a>
		&nbsp&nbsp<%=indent%><%=box%><a href="javascript:clickPopup(1595);"><i>SpecialDistrictUT</i></a><br>
		<%=indent%><%=box%><a href="javascript:clickPopup(1580);"><i>MySQL</i></a><br>
		
		<!--This MySQL PopUp isn't functional right now.<a href="javascript:PopupCenter('http://info.zip2tax.com/z2t_Backoffice/Processes/PopUps/z2t_MySQL.asp','Daves Popup Test','900','500')"> First of Month Update: MySQL Pop Up</a>-->
		<%=star%>Test all services for successful updates:<br>
		<%=indent%><a href="https://harvestamerican.box.com/s/z92vno9kr678lc7vdypfg04ukmn41ku2"target="_blank"><i>SALES & USE TAX INFO SUMMARY</i></a><br> 
		<%=indent%><%=box%><i>Basic Online Look-up</i> 
		<%=indent%><%=box%><i>Spot-On Online Look-up</i> 
		<%=indent%><%=box%><i>API via URLs</i> <br>
		<%=indent%><%=box%><i>Passing Request Variables</i> 
		<%=indent%><%=box%><a href="https://info.zip2tax.com/z2t_Backoffice/subscribers/popups/z2t_LinkTest.asp?usr=pinhead&pwd=pinwheel"target="_blank"><i>Database Links</i></a> 
		<%=indent%><%=box%><i>MySQL</i><br><br>
		
<span class="subHead">State Page Maintenance<br></span>
	<i>During the second and third weeks of each month.</i><br>
	
		<%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Website/StateMaintenance/z2t_StateMaint.asp"target="_blank">State Maintenance</a>&nbsp;&nbsp; 
		<%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Website/StateMaintenance/z2t_StateMaint_Types.asp"target="_blank">State Maintenance Types</a><br>
		<%=box%><a href="javascript:clickPopup(1369);">Development Duplication Steps</a>&nbsp&nbsp
		<%=box%><a href="javascript:clickPopup(1370);">Staging Duplication Steps</a><br><br>
				
<span class="subHead">The States and Provinces You Do Business In page</span></a><br>
	<i>After First of Month Day, during first week of each month.</i><br>
		<%=box%><a href="http://info.zip2tax.com/z2t_Backoffice/Website/z2t_What-State-Do-You-Do-Business-In.asp"target="_blank">What States and Provinces Do You Do Business In?</a><br><br>

<span class="subHead">State Page Promotion to Production</span></a><br>
	<i>First day of each month.</i><br>
		<%=box%><a href="javascript:clickPopup(1371);">Production Duplication Steps</a><br><br>

						</td>
					  </tr>
					  <td colspan="3"> 
						<span class="subHead">Researching Date __ /__ /____</span><br>
						<span id="demo"></span>
							<script>  
								document.getElementById("demo").innerHTML = Date(); 
							</script>
						<td>
					  </tr>
					</table>
                    
                    
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"--></body>
</html>
