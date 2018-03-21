<%
        Response.buffer=true
        Response.clear

        Title = "Edit Wine Note for "

		Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
		Dim rs: Set rs=server.createObject("ADODB.Recordset")
		Dim eWineNote
			
		connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_UpdateRates" ' philly05
        strSQL = "z2t_StateInfo_Alcohal_read('" & request("state") & "',2)"
		
        rs.open strSQL, connPhilly05, 3, 3, 4

		If not rs.eof Then
			eWineNote = rs("Note")			
			Title = Title + rs("StateName")
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
    .WineNote
		{
		width: 60em;
    	height: 13em;
    	resize: none;
		}
		
	
  </style>
</head>


<body onLoad="SetScreen(900,500);">
  <form method="Post" action="z2t_StateInformationWineNote_post.asp" name="frm">

	 <span class="popupHeading"><%=Title%></span>
        
	 <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
				<tr><td>&nbsp;</td></tr>	
            	<tr>
				<td style="color: #999999;" colspan="2">
					This indicates notes regarding sales tax on wine.
				</td>		 
			</tr>	
            <tr><td>&nbsp;</td></tr>
			<tr>
			  <td width="55%" align="left">
              <textarea cols="1" rows="1" id="WineNote" name="WineNote" class="WineNote"><%=eWineNote%>
              </textarea>
         	  </td>
			</tr>
						
			
						
	</table>

    <div class="center" style="margin-top: 2em;">
      <a href="javascript:document.frm.submit();" class="buttons bo_Button80">Submit</a>
      <a href="javascript:window.close();" class="buttons bo_Button80">Cancel</a>
    </div>


	<input type="hidden" id="State" name="State" value='<%=Request("State")%>'>
       
	<input type='hidden' id='orderBy' name='orderBy' value='<%=trim(request("orderBy"))%>' />
	<input type='hidden' id='ascDesc' name='ascDesc' value='<%=trim(request("ascDesc"))%>' />
	<input type='hidden' id='filterbyval' name='filterbyval' value='<%=trim(request("filterbyval"))%>'  />
   	<input type="hidden" id="pageviewtype" name="pageviewtype" value='<%=trim(Request("pageviewtype"))%>'>
  </form>
  
  
  
  <span class="popupCredit"><%=CreditLine(eCreatedBy, eCreatedDate, eEditedBy, eEditedDate)%></span>
  
  
</body>
</html>
