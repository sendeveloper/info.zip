<%
' This File Contain all the Functions for NetDiag Admin panel
' ***********************************************************

' Paging Function start	 
'***********************

Function GetHitCountAndPageLinks(sHref, nTotalRecords, nRecordsPerPage, intPageCount, currentPage, sQueryString)
	Dim sReturnValue

	sReturnValue = vbCrLf _
		& "<table border=""0"" align=""center"" cellpadding=""0"" cellspacing=""0"" width=""100%"">" & vbCrLf _
		& "<tr>" & vbCrLf _
		& "<td align=""center""><font color=""C0C0C0""><b>" _
              & DisplayHitCount(nTotalRecords, nRecordsPerPage, intPageCount, currentPage) _
              & "</b></font><br></td>" & vbCrLf _
		& "</tr>" & vbCrLf

	If intPageCount > 1 Then
		sReturnValue = sReturnValue & "<tr>" & vbCrLf _
			& "<td>" & vbCrLf _
			& DisplayPageLinks(sHref, sQueryString, intPageCount, currentPage) & vbCrLf _
			& "</td>" & vbCrLf _
			& "</tr>" & vbCrLf
	End If

	sReturnValue = sReturnValue & "</table>" & vbCrLf

	GetHitCountAndPageLinks = sReturnValue
End Function


Function DisplayHitCount(nTotalRecords, nRecordsPerPage, intPageCount, currentPage)
	Dim sReturnValue

	If nTotalRecords = 0 Then
		sReturnValue = "No Results Found."
	Elseif nTotalRecords = 1 then
		sReturnValue = "1 Record Found."
	Else
		Dim nLowestDisplayed, nHighestDisplayed
		Call GetHighAndLowRecordsDisplayed(nTotalRecords, nRecordsPerPage, intPageCount, currentPage, nLowestDisplayed, nHighestDisplayed)

		If nLowestDisplayed = nHighestDisplayed Then
			sReturnValue = nTotalRecords & " Records Found -- Showing Result " & nLowestDisplayed
		Else
			sReturnValue = nTotalRecords & " Records Found -- Showing Results " & nLowestDisplayed & " to " & nHighestDisplayed
		End If
	End If

	DisplayHitCount = sReturnValue
End Function


Sub GetHighAndLowRecordsDisplayed(nTotalRecords, nRecordsPerPage, intPageCount, currentPage, nLowestDisplayed, nHighestDisplayed)
	nLowestDisplayed = currentPage * nRecordsPerPage + 1

	If currentPage >= intPageCount - 1 and currentPage = intPageCount - 1 Then		' The last page is displayed
		' The highest record displayed is the last record
		nHighestDisplayed = nTotalRecords
	Else
		nHighestDisplayed = (currentPage + 1) * nRecordsPerPage
	End If
End Sub


Function DisplayPageLinks(sHref, sQueryString, intPageCount, currentPage)
	If intPageCount = 1 Then
		DisplayPageLinks = ""
		Exit Function
	End If

	Dim sReturnValue

	sReturnValue = "<table border=""0"" cellpadding=""0"" cellspacing=""1"" WIDTH=""100%"">" & VbCrLf _
		& VbCrLf _
		& "<tr valign=""bottom"">" & VbCrLf _
		& "<td width=""25%"" nowrap=""nowrap"">" & VbCrLf

	If currentPage > 0 Then
		sReturnValue = sReturnValue & _
                "<a href=""" & sHref & "?page=" & currentPage - 1 & sQueryString & """ class=""listing"">" & _
                "&nbsp;&nbsp;&lt;&lt; Previous</a>&nbsp;&nbsp;&nbsp;<BR>" & vbCrLf
	Else
		sReturnValue = sReturnValue & "&nbsp;"	
	End If

	sReturnValue = sReturnValue & "</td>" & VbCrLf _
		& "<td align=""center"" valign=""middle"" nowrap=""nowrap"">" & VbCrLf _
		& "<font size=""-1"" color=""#666666"">" & VbCrLf

	Dim nLowPageLink, nHighPageLink, i

	' Make initial high/low calculations
	nLowPageLink = currentPage - 3
	nHighPageLink = currentPage + 3

	' If low is less than zero, increase both values
	If nLowPageLink < 0 Then
		nHighPageLink = nHighPageLink - nLowPageLink
		nLowPageLink = 0
	End If

	' If high is greater than total pages, decrease both values
	If nHighPageLink > intPageCount - 1 Then
		nLowPageLink = nLowPageLink - (nHighPageLink - intPageCount)
		nHighPageLink = intPageCount - 1
	End If

	' Ensure that the low value is not negative
	If nLowPageLink < 0 Then nLowPageLink = 0

	If nLowPageLink <> 0 Then
		' Display a link to the first page
		sReturnValue = sReturnValue & "<a href=""" & sHref & "?page=0" & sQueryString & """ class=""listing"">" & _
                "First . . .</a>" & vbCrLf
	End If
			
	For i = nLowPageLink To nHighPageLink
		If i = currentPage Then
			sReturnValue = sReturnValue & "<b>&nbsp;" & i + 1 & "&nbsp;</b>" & VbCrLf
		Else
			sReturnValue = sReturnValue & _
                  "&nbsp;<a href=""" & sHref & "?page=" & i & sQueryString & """ class=""listing"">" & _
                  i + 1 & "</a>&nbsp;" & vbCrLf
		End If
	Next

	If nHighPageLink <> intPageCount - 1 Then
		' Display a link to the last page
		sReturnValue = sReturnValue & _
            "<a href='" & sHref & "?page=" & intPageCount - 1 & sQueryString &  "' class='listing'>" & _
            ". . . Last</a> " & vbCrLf
	End If

	sReturnValue = sReturnValue & "</font>" & VbCrLf _
		& "</td>" & VbCrLf _
		& "<td align=""right"" width=""25%"" nowrap=""nowrap"">" & VbCrLf

	If currentPage < intPageCount - 1 Then
		sReturnValue = sReturnValue & _
            "&nbsp;&nbsp;&nbsp;" & _
            "<a href=""" & sHref & "?page=" & currentPage + 1 & sQueryString & """ class=""listing"">" & _
            "Next &gt;&gt;&nbsp;&nbsp;</a><br>" & vbCrLf
	Else
		sReturnValue = sReturnValue & "&nbsp;"	
	End If

	sReturnValue = sReturnValue & "</td>" & VbCrLf _
		& "</tr>" & VbCrLf _
		& VbCrLf _
		& "</table>" & VbCrLf

	DisplayPageLinks = sReturnValue
End Function

' Paging Function End 
'*********************
%>

