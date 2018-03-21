<!--#include virtual="/z2t_Backoffice/includes/Config.asp"-->
<!--#include virtual="/z2t_Backoffice/includes/z2t_BackofficeConnection.asp"-->
<!--#include virtual="z2t_Backoffice/includes/z2t_PageStart.inc"-->

<%  
    '----- Be sure secure path is used -----
    if LCase(Request.ServerVariables("HTTPS")) <> "on" then
        response.redirect "https://www.zip2tax.info" & Request.ServerVariables("PATH_INFO")
    end if
	
    PageHeading = "Home - Free Lookup Reset"
	ColorTab = 0

    IF session("z2t_loggedin")<>"True" OR isNULL(session("z2t_loggedin")) _
	OR session("z2t_status")<>"admin"  OR isNULL(session("z2t_status")) THEN
        Response.Redirect strBasePath & "z2t_login.asp"
    END IF
%>

<html>
<head>
    <title>Zip2Tax.info - Free Lookup Reset</title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link rel="stylesheet" href="<%=strPathIncludes%>z2t_backoffice.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="<%=strPathIncludes%>menu/dropdowntabfiles/ddcolortabs.css" />

	<script type="text/javascript" src="<%=strPathIncludes%>menu/dropdowntabfiles/dropdowntabs.js"></script>

	<style type="text/css">
		td
			{
			font-size: 12pt;
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
          <td width="100%" align="left" height="500" class="divDeskMiddle" style="padding-left: 50px;">
		    <table width="1000" border="0" cellspacing="5" cellpadding="5">
			  <tr valign="top">
			    <td colspan="2">
				  When a prospect complains that they have not used all of their free lookups 
				  but they are getting an error message saying they have used them all:
				</td>
			  </tr>
			  
			  <tr valign="top">
			    <td>
				  <table width="500" border="0" cellspacing="5" cellpadding="5">

					  <tr>
						<td>
						  <b>Possible solutions:</b>
						  <ol>
							<li>Have them try a fresh browser session.</li>
							<li>Have them try a different Internet browser.</li>
							<li>Have them clear out their cookies (Firefox: Tools / Options. / 
							  Privacy / remove individual cookies / Zip2Tax.com / Remove Cookies)</li>
						  </ol>
						</td>
					  </tr>
					  
					  <tr>
						<td>
						<b>If this doesn't solve the problem, get the following information:</b>
						  <ol>
							<li>Cookie ID: found in the lower right corner of the Zip2Tax.com index page</li>
							<li>IP address: right underneath the Cookie ID.</li>
							<li>What internet browser are they using? (Firefox, Internet Explorer, etc.)</li>
							<li>What Internet service provider? (Comcast, DirecTV, etc.)</li>
							<li>Try to get prospect's name, email, phone for future sales follow-up</li>
							<li>Put this information in a Comm 100 ticket, assign it to Lucinda.</li>
						  </ol>
						</td>
					  </tr>
					  
					</table>
				</td>

			    <td>
				  <table width="500" border="0" cellspacing="5" cellpadding="5">

					  <tr>
						<td>
						<b>Solution:</b>
						  <ol>
							<li>Instruct customer to go to the lower right hand corner of any Zip2tax page.</li>
							<li>Have the prospect click on Tracking ID or Cookie ID and enter the code shown below.</li>
							<li>Click Submit</li>
							<li>Tell them they now can perform 10 additional lookups. 
							  Ask them to do one now to confirm it is working.</li>
						  </ol>
						</td>
					  </tr>

						<tr>
							<td>
								<table width="350" align="center" border="0" cellspacing="0" cellpadding="10" style="border: 1px solid black;">
								  <tr>
									  <td align="center" style="font-size: 14px;">
										<span style="font-weight: bold;">
										  Today's Free Lookup Reset Code: &nbsp; <%=DateCode%>
										</span> 
									  </td>
								  </tr>
								</table>
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
