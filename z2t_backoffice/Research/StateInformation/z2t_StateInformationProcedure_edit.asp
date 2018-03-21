<%
        Response.buffer=true
        Response.clear

        Title = "Edit Procedure for "

		Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
		Dim rs: Set rs=server.createObject("ADODB.Recordset")
		Dim eProcedure
		DIM eEditedBy
		DIM eEditedDate
		
		connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates" ' philly05
        strSQL = "z2t_StateInfo_Research_read('" & request("state") & "')"
		
        rs.open strSQL, connPhilly05, 3, 3, 4

		If not rs.eof Then
		'response.Write(rs("ResearchProcedure")	)
		'response.End()
			eProcedure = rs("ResearchProcedure")			
			eEditedBy  = rs("EditedBy")
			eEditedDate = rs("EditedDate")
			eCreatedBy	= ""
			eCreatedDate = ""			
			Title = Title + request("state")
		End If
		
        rs.close

%>

<!DOCTYPE html>
<html>
<head>
	<!--#include virtual="/z2t_Backoffice/includes/z2t_FunctionsMisc.inc"-->
    <title><%=Title%></title>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

    <link href="/z2t_BackOffice/includes/BackOfficePopup.css" type="text/css" rel="stylesheet">
	<script type="text/javascript" src="/z2t_Backoffice/includes/z2t_Backoffice_functions.js"></script>	
    
    <style type="text/css">   
    .Procedure
		{
		width: 60em;
    	height: 33em;
    	resize: none;
		}
		
	
  </style>
</head>


<body onLoad="SetScreen(900,700);">
  <form method="Post" action="z2t_StateInformationProcedure_post.asp" name="frm">

	 <span class="popupHeading"><%=Title%></span>
        
	 <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
			<tr><td>&nbsp;</td></tr>		
			<tr>
			  <td width="55%" align="left">
              <textarea cols="1" rows="1" id="Procedure" name="Procedure" class="Procedure"><%=eProcedure%>
              </textarea>
         	  </td>
			</tr>
						
			
						
	</table>

    <div class="center" style="margin-top: 2em;">
      <a href="javascript:document.frm.submit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:window.close();" class="buttons bo_Button80">Cancel</a>
    </div>


	<input type="hidden" id="State" name="State" value='<%=Request("State")%>'>
  </form>
  
  
  
  <span class="popupCredit"><%=CreditLine(eCreatedBy, eCreatedDate, eEditedBy, eEditedDate)%></span>
  
  
</body>
</html>
