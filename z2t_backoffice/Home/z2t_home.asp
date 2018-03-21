<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
  PageHeading = "Home"
  ColorTab = 0
%>

<html>
<head>

  <title>Zip2Tax.info - Home</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" >
  
  <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css" />
  <link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />
  
  <script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>
</head>
 <style type="text/css">

    button.disabled {background-color: darkgrey; color: lightgrey;}
  </style>
<body>
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/header.inc"-->
      <table width="100%" border="0" cellspacing="5" cellpadding="5">

          <tr>
            <td width="100%" align="left"  style="padding-top:100px">
            
              <table width="350" align="center" border="0" cellspacing="0" cellpadding="0" style="border: 1px solid black;">
                <tr>
                  <td align="center" style="font-size: 12px;">
                    <span style="font-weight: bold; color: red;">
                      Warning:
                    </span> 
                    <span style="font-weight: bold;">
                      These facilities are solely for the use of authorized employees
                      or agents of the organization and affiliates.  Unauthorized use is 
                      prohibited and subject to international criminal and civil penalties.  
                      Individuals using this computer system are subject to having all of
                      their activities on this system monitored and recorded by systems personnel.
                    </span> 
                  </td>
                </tr>
              </table>
              <br />
              <div style="width: 100%; text-align: center; display: inline-block;">
                  <!-- Badge sample code from <2012-10-18 Thu> -->
                  <a href="http://www.zip2tax.com"> <img src="<%=strPathImages%>0001.png" alt="Sales and use tax rates certified by Zip2Tax.com" title="Sales and use tax rates certified by Zip2Tax.com"></a> 
              </div>
            </td>
          </tr>
       </table>   
<!--#include virtual="/z2t_Backoffice/includes/BodyParts/Footer.inc"-->
</body>
</html>
