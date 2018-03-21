<%
        Response.buffer=true
        Response.clear
%>

<!--#include file="includes/z2t_connection.asp"-->

<%

        Title = "Zip2Tax Product Renewal Effort"

        SQL="z2t_Subscription_read(" & Request("z2tID") & ")"
        rs.open SQL,connPublic, 3, 3, 4  'Barley2.z2t_WebPublic

        eDisplayName = rs("DisplayName")

        rs.close

%>
<!DOCTYPE html>
<html>
<head>
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	

</head>


<body onLoad="SetScreen(700,450);">
  <form method="Post" action="z2t_RenewalPost.asp?z2tID=<%=Request("z2tID")%>" name="frm">

	<span class="popupHeading"><%=Title%></span>

    <strong style="color: #000066"><%=strMessage%></strong><br>


    <!-- Start Notes -->
    <div>
		<div class="notes">
			<label class="subHead" for="Note">Note</label>
			<span style="padding-left: 20px;">
				<input class="field note" type="Text" name="Note" id="Note" value="<%=eNote%>" size="90">
			</span>
		</div>
		
		<br><br>
		I don't remember what this edit pop-up was supposed to be for.<br>
		Can anybody refresh my memory?<br>
		Dave
		<br><br>
    </div>
      
    <div class="center" style="margin-top: 2em;">
      <a href="javascript:clickSubmit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:window.close();" class="buttons bo_Button80">Cancel</a>
    </div>
	
  </form>
</body>
</html>
