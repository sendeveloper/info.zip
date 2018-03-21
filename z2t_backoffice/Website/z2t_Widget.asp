
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->

<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->
<%
  PageHeading = "Desktop Application Widget"
  ColorTab = 6
%>

<html>
<head>
  <title>Zip2Tax.info - Zip2Tax Desktop Application Widget<%=PageHeading%></title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
  
  <script language='JavaScript'>

		function clickPopup(ID)
		{
		var URL = 'http://www.harvestamerican.info/ha_BackOffice/Company/DocumentMaintenance/ha_Document_Show.asp' +
			'?PhotoID=' + ID;
			PopupCenter(URL);
		}
		
  </script>


  
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
            <td width="100%" align="left" height="190" class="divDeskMiddle">
              <table width="100%" align="center" border="0" cellspacing="5" cellpadding="5">
				<tr valign="top">
				
				<table width="1150" align="center" border="0" cellspacing="2" cellpadding="2" style="background-color: white;">

						<tr valign="top">
							<td>
								<h3>Application Details</h3>
								<ul>
									<li>Webpage to download the Widget is <a href="http://www.zip2tax.com/Website/pagesTaxRates/z2t_widget.asp">HERE</a></li>
									<a href="javascript:clickPopup(1383);">Version History</a><br>
									<a href="javascript:clickPopup(1384);">Application Details</a><br>
									<a href="javascript:clickPopup(1385);">File Locations</a><br>
								</ul>
								
								
							</td>
						
						</tr>
						
						
						
					</table>

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
