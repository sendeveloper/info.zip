<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%
  PageHeading = "Research Links"
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
			window.open(URL,'','height=490, width=1600');
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
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/Header.inc"-->
					<table width="95%" align="center" border="0" cellspacing="2" cellpadding="2" style="background-color: white;">
					  <tr valign="top">
					  	<td style="font-size: 10pt;">
						
						
				
							
<br><span class="subHead">Tax Rate Look-Up Tools</span><br>
	<i>Links to available official look-up tools.</i><br>
			<a href="http://commerce.alaska.gov/cra/DCRAExternal/Query" target="_blank">AK - Alaska Tax Rate List</a><br>
			<a href="https://www.alabamainteractive.org/ador_taxrate_lookup/welcome.action" target="_blank">AL - Sales Tax Lookup</a><br>
			<a href="http://www.arkansas.gov/dfa/excise_tax_v2/st_zip.html" target="_blank">AR - Arkansas Local Tax Lookup Tools</a><br>
			<a href="https://www.aztaxes.gov/AddressLookup/Index" target="_blank">AZ - Arizona TP & Use Tax Rate Look Up</a><br>
			<a href="https://maps.gis.ca.gov/boe/TaxRates/" target="_blank">CA - Find a Sales and Use Tax Rate BOE</a><br>
			<a href="http://gis.atlantaga.gov/apps/most/index.php" target="_blank">GA - Georgia City of Atlanta MOST Address Verification</a><br>
			<a href="http://www.revenue.state.mn.us/businesses/sut/Pages/SalesTaxCalculator.aspx" target="_blank">MN - Minnesota Sales Tax Rate Calculator</a><br>
			<a href="https://dors.mo.gov/tax/strgis/input.jsp" target="_blank">MO - Missouri Sales Tax Information System</a><br>
			<a href="https://thefinder.tax.ohio.gov/StreamlineSalesTaxWeb/AddressLookup/LookupByAddress.aspx?taxType=Sales" target="_blank">OH - Ohio Tax Rate Lookup</a><br>
			<a href="https://mycpa.cpa.state.tx.us/atj/addresslookup.jsp" target="_blank">TX - Texas Tax Rate Locator</a><br>
			<a href="https://tap.tax.utah.gov/TaxExpress/_/#1" target="_blank">UT - Utah Tax Rate Look Up</a><br>
			<a href="https://webgis.dor.wa.gov/taxratelookup/SalesTax.aspx" target="_blank">WA - Washington Tax Rate Lookup Tool</a><br>

<br><span class="subHead">URLs for API Testing</span><br>
	<i>Casper09 Dev</i><br>
			<a href="http://casper09-api.zip2tax.com/TaxRate-USA.xml?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.xml</a>
			<a href="http://casper09-api.zip2tax.com/TaxRate-USA.web?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.web</a>
			<a href="http://casper09-api.zip2tax.com/TaxRate-USA.json?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.json</a><br><br>
	<i>Philly05 Staging</i><br>
			<a href="http://philly05-api.zip2tax.com/TaxRate-USA.xml?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.xml</a>
			<a href="http://philly05-api.zip2tax.com/TaxRate-USA.web?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.web</a>
			<a href="http://philly05-api.zip2tax.com/TaxRate-USA.json?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.json</a><br><br>
	<i>Philly02 Production</i><br>
			<a href="https://philly02-api.zip2tax.com/TaxRate-USA.xml?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.xml</a>
			<a href="https://philly02-api.zip2tax.com/TaxRate-USA.web?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.web</a>
			<a href="https://philly02-api.zip2tax.com/TaxRate-USA.json?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.json</a><br><br>
	<i>Philly04 Production</i><br>
			<a href="https://philly04-api.zip2tax.com/TaxRate-USA.xml?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.xml</a>
			<a href="https://philly04-api.zip2tax.com/TaxRate-USA.web?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.web</a>
			<a href="https://philly04-api.zip2tax.com/TaxRate-USA.json?&AddressLine1=911 Cornelia Street&City=Utica&State=NY&zip=13502&username=pinhead&password=pinwheel" target="_blank">.json</a><br><br>
	<i>Casper06 Production</i><br>
			<a href="https://casper06-api.zip2tax.com/TaxRate-USA.xml?&AddressLine1=20%20Main%20Street&City=Camden&State=NY&zip=13316&username=pinhead&password=pinwheel" target="_blank">.xml</a>
			<a href="https://casper06-api.zip2tax.com/TaxRate-USA.web?&AddressLine1=20%20Main%20Street&City=Camden&State=NY&zip=13316&username=pinhead&password=pinwheel" target="_blank">.web</a>
			<a href="https://casper06-api.zip2tax.com/TaxRate-USA.json?&AddressLine1=20%20Main%20Street&Cityt&City=Camden&State=NY&zip=13316&username=pinhead&password=pinwheel" target="_blank">.json</a><br><br>
	<i>Frank02 Production</i><br>
			<a href="https://frank02-api.zip2tax.com/TaxRate-USA.xml?&AddressLine1=20%20Main%20Street&Cityt&City=Camden&State=NY&zip=13316&username=pinhead&password=pinwheel" target="_blank">.xml</a>
			<a href="https://frank02-api.zip2tax.com/TaxRate-USA.web?&AddressLine1=20%20Main%20Street&Cityt&City=Camden&State=NY&zip=13316&username=pinhead&password=pinwheel" target="_blank">.web</a>
			<a href="https://frank02-api.zip2tax.com/TaxRate-USA.json?&AddressLine1=20%20Main%20Street&Cityt&City=Camden&State=NY&zip=13316&username=pinhead&password=pinwheel" target="_blank">.json</a><br>
			
			<br><a href="javascript:clickPopup(1421);" target="_blank">Test Data</a><br>
						</td>
				  </td>
                  <td>
					
					
						<td style="font-size: 10pt;">
						
	 
<br><span class="subHead">Local Jurisdiction Research</span><br>
	<i>Links to available local jurisdiction information.</i><br>
	
			<a href="http://www.azdor.gov/Business/TransactionPrivilegeTax/NonProgramCities.aspx" target="_blank">Arizona TPT Non-Program Cities</a><br>
			<a href="http://modelcitytaxcode.az.gov/changes/S_changes.htm" target="_blank">Arizona Model City Tax Code Changes</a><br>
			<a href="https://dola.colorado.gov/lgis/municipalities.jsf" target="_blank">Colorado Active Municipalities</a><br>
			<a href="http://www.colorado.gov/government/government/special-districts.html" target="_blank">Colorado Special Districts</a><br>
			<a href="http://www.cityofdonnelly.org/Ordinance198.pdf" target="_blank">Donnelly, ID - 1%</a><br>
			<a href="http://www.sterlingcodifiers.com/codebook/index.php?book_id=1044" target="_blank">Driggs, ID - 0.50%</a><br>
			<a href="http://www.haileycityhall.org/codes_plans/municipalCode/Title%205%20%20Business%20Licenses%20and%20Regulations.pdf" target="_blank">Hailey, ID - 0%</a><br>
			<a href="http://sterlingcodifiers.com/codebook/index.php?book_id=344&section_id=786183" target="_blank">Ketchum, ID - 2%</a><br>
			<a href="http://sterlingcodifiers.com/codebook/index.php?book_id=660&section_id=433410" target="_blank">Lava Hot Springs, ID - 2%</a><br>
			<a href="http://sterlingcodifiers.com/codebook/index.php?book_id=497&section_id=744265" target="_blank">McCall, ID - 1%</a><br>
			<a href="http://sterlingcodifiers.com/codebook/index.php?book_id=464&section_id=681229" target="_blank">Ponderay, ID - 0%</a><br>
			<a href="http://www.rigginsidaho.org/ordinance/ord174.html" target="_blank">Riggins, ID - 0%</a><br>
			<a href="http://www.cityofsalmon.com/index.asp?Type=B_BASIC&SEC={F34773B8-1A53-43B5-AB44-27D795FC45A6}" target="_blank">Salmon, ID - 0%</a><br>
			<a href="http://sterlingcodifiers.com/codebook/index.php?book_id=437&section_id=155041" target="_blank">Sandpoint, ID - 1%</a><br>
			<a href="http://www.stanley.id.gov/pb/wp_300bbf9b/wp_300bbf9b.html" target="_blank">Stanley, ID - 2.5%</a><br>
			<a href="http://sterlingcodifiers.com/codebook/index.php?book_id=545&section_id=930642" target="_blank">Sun Valley, ID - 3%</a><br>
			<a href="http://www.victorcityidaho.com/sites/default/files/Title%203%20Chapter%201C.pdf" target="_blank">Victor, ID - 0.50%</a><br><br>
	
	
<span class="subHead">Canada Tax & Postal Code Research</span><br>
	<i>Links to available Canadian information.</i><br>
			<a href="http://www.cra-arc.gc.ca/tx/bsnss/tpcs/gst-tps/rts-eng.html" target="_blank">Canada Revenue Agency</a><br>
			<a href="http://www2.gov.bc.ca/gov/content/taxes/sales-taxes/pst" target="_blank">British Columbia - PST 7%</a><br>
			<a href="http://www.fin.gov.on.ca/en/rates/index.html" target="_blank">Ontario Ministry of Finance - HST 13%</a><br>
			<a href="http://www.revenuquebec.ca/en/entreprises/taxes/tpstvhtvq/reglesdebase/default.aspx" target="_blank">Revenu Quebec - QST 9.975%</a><br>
			<a href="http://www.saskatchewan.ca/business/taxes-licensing-and-reporting/provincial-taxes-policies-and-bulletins/provincial-sales-tax" target="_blank">Government of Saskatchewan - PST 6%</a><br>
		
						</td>
									  
                  </td>
				   <td>
									
						<td style="font-size: 10pt;">
						
<br><span class="subHead">Boundary Data Research</span><br>
	<i>Links to available boundary data.</i><br>
			<a href="http://streamlinedsalestax.org/ratesandboundry/" target="_blank">SSUTA - Rate and Boundary Index</a><br>
	<i>For AR, GA, IA, IN, KS, KY, MN, NC, ND, NE, NV, <br>
		OH, OK, SD, TN, UT, VT, WA, WI, WV, WY.</i><br>
			<a href="https://data.colorado.gov/browse" target="_blank">CO - Information Marketplace</a><br>
			<a href="http://opendata.dc.gov/" target="_blank">DC - Open Data</a><br>
			<a href="http://tax.illinois.gov/Publications/Sales/" target="_blank">IL - state</a><br>
			<a href="http://www.dornc.com/taxes/sales/boundary_database.html" target="_blank">NC - state</a><br>
			<a href="http://www.co.travis.tx.us/fire_marshal/contact.asp" target="_blank">TX - Travis County</a><br>
			<a href="http://www.mcad-tx.org/html/mcad__info.html" target="_blank">TX - Montgomery County</a><br>
			<a href="http://pdata.hcad.org/GIS/index.html" target="_blank">TX - Harris County</a><br>
			<a href="http://gis.utah.gov/data/economy/taxingareas/" target="_blank">UT - state</a><br><br>
			<a href="http://www.census.gov/geo/maps-data/data/tiger-line.html" target="_blank">TIGER/Line Shapefiles</a>&nbsp&nbsp<a href="http://www.census.gov/geo/reference/ansi.html" target="_blank">ANSI Codes</a><br>
			<a href="http://www2.census.gov/geo/pdfs/maps-data/data/tiger/tgrshp2015/TGRSHP2015_TechDoc.pdf" target="_blank">Technical Documentation</a><br>
			<i>To access a large number of files the best option is use<br>
			an FTP client software to connect to the Census Bureau FTP site.<br>
			The host name must be ftp2.census.gov.<br>
			Use anonymous for the user name and password. <br>
			Then, navigate to the GEO, then TIGER folders.</i><br><br>
			

<span class="subHead">Geocoding Technical Information</span><br>
	<i>Links to solutions and other information about geocoding.</i><br>
			<a href="https://developers.google.com/maps/documentation/geocoding/#Results" target="_blank">Geocoding API - Google</a><br>
			<a href="https://msdn.microsoft.com/en-us/library/ff701733.aspx" target="_blank">Geocoding API - Bing</a><br><br>

<span class="subHead">Address, ZIP & Postal Code Verification</span><br>
	<i>Get standardized address or list of cities by ZIP, verify postal codes.</i><br>
			<a href="https://tools.usps.com/go/ZipLookupAction_input" target="_blank">Address & ZIP Verification - USPS</a><br>
			<a href="http://www.canadapost.ca/cpo/mc/default.jsf?LOCALE=en" target="_blank"> Postal Code Verification - Canada</a><br><br>
			
<span class="subHead">Mapping Tools</span><br>
	<i>Links to location and boundary mapping sites.</i><br>
			<a href="http://zipmaps.net/" target="_blank">zipmaps.net</a><br>
	
						</td>
					  </tr>
					  </tr>
					  <td colspan="3"> 
						<p id="demo"></p>
							<script>  
								document.getElementById("demo").innerHTML = Date();
							</script>
						<td>
					</table>
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
</body>
</html>
