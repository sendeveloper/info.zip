<table width="100%" cellspacing="2">
  <tr>
	<td>
		<hr/>
		 <table class="dvGray" width="100%">                                                        
		  <tr>
			<td colspan="3" class="dvHeading">Import files</td>
		  </tr>
		  <tr>
			<td style="text-align:right" width="15%">Month:	</td>
			<td style="text-align:left" width="8%">
			<%
		   
			Dim MonthsArr(11)
			MonthsArr(0) = "01 - January"
			MonthsArr(1) = "02 - February"
			MonthsArr(2) = "03 - March"
			MonthsArr(3) = "04 - April"
			MonthsArr(4) = "05 - May"
			MonthsArr(5) = "06 - June"
			MonthsArr(6) = "07 - July"
			MonthsArr(7) = "08 - August"
			MonthsArr(8) = "09 - September"
			MonthsArr(9) = "10 - October"
			MonthsArr(10) = "11 - November"
			MonthsArr(11) = "12 - December"
		 
			Dim i,StrValue            
			%>
			<select name="cmbMonth" id="cmbMonth">
		 
			<%
			
			SelectedMonth= request("cmbMonthval")
			If len(SelectedMonth) < 1 Then 
				SelectedMonth=Trim(Month(date))
			End If
				 For i = 0 To Ubound(MonthsArr)
				%>
			<option value="<%=MonthsArr(i)%>"
			<%If Trim(Split(MonthsArr(i), " - ")(0)) = SelectedMonth _ 
			  Then Response.Write("Selected") End If%>>
				<%=MonthsArr(i) %>
			</option>
			<% Next %>
			</optgroup>
			</select> 
			</td>
			<td  style="text-align:right" width="10%">Year:</td>
			<td  style="text-align:left" width="80px">
			<%
			Dim StartYear,TillYear,StrCheck,SelectedYear
			StartYear = 2008
			TillYear = Year(Date())+1
			StrCheck = ""
			
			SelectedYear= request("cmbYearval")
			If len(SelectedYear) < 1 Then 
				SelectedYear=Trim(year(date))
			End If
			'response.Write(SelectedYear)
			%>
			
			<select name="cmbYear" id="cmbYear">
	   
			<%
			For Yrs = StartYear To TillYear
				If StrCheck <> Yrs Then
			%>
			<option label="<%=Yrs %>" 
					<%If Yrs = cint(SelectedYear) Then 
						Response.Write("Selected") 
					End If%>>
				<%=Yrs%>
			<%
			End if
			StrCheck = Yrs
			Next
			%>
			</option>
		   </td>
		   <td style="text-align:left" >
			<input type="button" 
					name="cmdCheckStatus" 
					id="cmdCheckStatus"
					style="width:150px;" 
					title="Check Status" 
					alt="Check Status" 
					value="Check Status" 
					onclick="javascript:CheckFileStatus(1);"/>
		   </td>
		  </tr>
		  <tr>
			<td width="15%" style="text-align:right">Database Table Name: </td>
			<td><span id="spnfilename"></span></td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td width="15%" style="text-align:right">Record:</td>
			<td><span id="spnlRecordCount"></span> </td>
			<td>&nbsp;</td>
		  </tr>
		 </table>
	</td></tr>
	<tr>
		<td>       
			<table class="dvGray" width="100%">
			<tr>
				<td colspan="2"  class="dvHeading">Export files</td>
			</tr>
			<tr>
				<td style="text-align:right" width="15%">Export Directory:	</td>
				<td style="text-align:left" >                                                     
				  <input type="text" name="txtExportDirectory" id="txtExportDirectory" style="width: 500;" />
				</td>
			</tr>
			</table>
			<hr/>								
		</td>
	</tr>
</table>