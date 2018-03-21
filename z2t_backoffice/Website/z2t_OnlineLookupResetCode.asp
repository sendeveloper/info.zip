
<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%
  dim strColor
  dim PageHeading
  dim recordCount
  dim StateAbbr(100)
  dim StateName(100)

  PageHeading = "Online Look-up Reset Code"
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
  <script>
  </script>
  
  <style type="text/css">
  </style>

</head>

<body>

  <!--#include virtual="z2t_Backoffice/includes/BodyParts/header.inc"-->
  <tr><td>      
      <table width="90%" border="0" cellspacing="2" cellpadding="2" align="center" bgcolor="#FFFFFF" style="padding: 8px;">
        <tr valign="top">	
          <td>
		    The TrackingID Reset Code is used when the IP address for a prospect has used all of their free lookups (10 per day for a total of 50) 
			and gets an error message saying they need to call us. The code is the reverse of the 2 letter abbreviation of the month plus the 2 digit 
			day of the month. Often times the prospect will claim they’ve never used our site before and this may be true. IP addresses are frequently 
			reassigned, so this message may be generated because someone else using their IP address may have used all of the lookups.
			<br><br><br>
          </td>
        </tr>
	
        <tr valign="top">	
          <td align="Center" style="font-size: 12pt;">
            Today's TrackingID Reset Code: <b><%=DateCode%></b>
			<br><br>
          </td>
        </tr>
		
        <tr valign="top">	
          <td>
			Instruct the prospect to go to the lower right corner of any Zip2Tax web page and click on the underlined Sample TrackingID or Cookie ID 
			to access the Zip2Tax code popup. Enter the 4 digit code and click submit. This will allow the prospect to access 10 more free lookups.<br><br>

			Sample TrackingID: 2638605<br>
			Cookie ID: 4714651<br>
			IP Address: 72.43.236.2<br>
			JavaScript: Pass<br><br>

			This code will not work if the prospect has ever successfully logged into our web site. If they have unsuccessfully attempted to log in 
			to our web site, they may be able to reset the ability to perform free lookups by clearing the cookies from the browser (see individual 
			browser instructions on how to do so), trying a fresh browser session or using a different internet browser.<br><br>
			
			<b>If the problem remains unsolved, collect the following information and create a Comm100 ticket for follow-up:</b><br>
			-Cookie ID: found in the lower right corner of the Zip2Tax.com index page.<br>
			-IP address: right underneath the Cookie ID.<br>
			-Internet browser used: such as Firefox, Internet Explorer, Chrome, etc.<br><br>
			
			Ask for the prospect's name, email, phone for future sales follow-up.
          </td>
        </tr>
		
        
      </table>
    </td>
  </tr>
  <!--#include virtual="z2t_Backoffice/includes/BodyParts/footer.inc"-->
  </body>
</html>

<%
Function DateCode

    DateCode = Right(Day(Date), 1) & _
        Left(Right("00" & day(Date), 2),1) & _
        Right(Ucase(MonthName(Month(Date))), 1) & _
        Left(Ucase(MonthName(Month(Date))), 1)

End Function
%>
