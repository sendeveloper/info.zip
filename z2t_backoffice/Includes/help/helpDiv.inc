<%
	HelpImage = "<img src='/z2t_BackOffice/includes/help/questionmark.gif' border='0' height='14' width='10' alt='Help'>"

	

%>

<style type="text/css">
.helpDiv
{
    width: 200px;
    height: 200px;
    position: fixed !important;
    top: 50%;
    left: 50%;
    margin-left: -100px;
    margin-top: -100px;
}

	a.editHelpButton 
		{
		font-weight: bold; font-size: 9px; 
		font-family: Verdana, Arial, Helvetica, sans-serif;	
		padding: 4px 8px; 
		border-top: 1px solid #E0E0E0;
		border-right: 1px solid black; 
		border-bottom: 1px solid black;
		border-left: 1px solid #E0E0E0; 
		background-color: #3380CC;
		color: #FFFFFF;
		display: block;
		text-align: center; 
		width: 60px;
		text-transform: uppercase;
		text-decoration: none;
		}

	a.editHelpButton:hover {border-color: black white white black; color: #FFFFFF;}
	
</style>

  <div id="helpDiv" class="helpDiv">
    <table width='100%' height='100%' border="2" cellspacing="2" cellpadding="2" bordercolor='black'
      background='/z2t_BackOffice/includes/help/HelpBackground.jpg'>
      <tr valign='top'>
        <td>

			<table width='100%' height='100%' border='0' cellspacing='0' cellpadding='0')
			  <tr valign='top'>
				<td>

				  <table width='100%' height='30' border='0' cellspacing='2' cellpadding='2'>
					<tr valign='top'>
					  <td align='center'>
						<font size='3'>
						  <b><span id='helpTitle'>Topic Goes Here</span></b>
						</font>
					  </td>
					</tr>
					<tr>
					  <td align='center'>
						<hr>
					  </td>
					</tr>
				  </table>

				</td>
			  </tr>
			  <tr valign='top'>
				<td>

				  <table width='100%' border='0' cellspacing='2' cellpadding='2'>
					<tr valign='top'>
					  <td width='100%'>
						<span id='helpBody'>
						  This is where the help text will go.
						</span>
					  </td>
					</tr>
					<tr valign='top'>
					  <td height='100%'>
						&nbsp;
					  </td>
					</tr>
				  </table>

				</td>
			  </tr>
			  <tr valign='bottom'>
				<td>

				  <table width='100%' height='30' border='0' cellspacing='2' cellpadding='2'>
					<tr valign='bottom'>
					  <td width='100%'>&nbsp;</td>
					  <td><a href='javascript:clickHelpOk();' class='editHelpButton'>Ok</a></td>
					</tr>
				  </table>

				</td>
			  </tr>
			</table>

        </td>
      </tr>
    </table>
  </div>
