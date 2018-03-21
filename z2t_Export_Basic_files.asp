
<%
Server.ScriptTimeout=2000
dim States(99)  
dim StatesCount
exportDirectory= Request("ExportDirectory")
TaxType = Request("TaxType")  '' Use or Sales
FormatType = Request("FormatType")  '' Basic Magento etc.
ExportType=Request("ExportType")  '' Individual or Entire or NY Clothing


Dim UltracartFieldWidth(99)   

Dim rs

   
Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")
connPhilly05.Open "driver=SQL Server;server=208.88.49.22,8543;uid=davewj2o;pwd=get2it;database=z2t_Export" '

dim fieldCount
Dim fieldName(99)  
dim TaxRate

Call GetStateList()

	if TaxType = "Sales" Then
		TaxRate= "SalesTaxRate"
		ReportingCode ="ReportingCode"
	else
		TaxRate="UseTaxRate"
		ReportingCode ="SalesTaxReportingCode"
	end if
	
 For iState = 1 to StatesCount
  if  len(trim(States(iState)) ) >0 Then
	dim file_being_created
	dim YearMonth 
	YearMonth = Request("cmbYearval") &"_"& Request("cmbMonthval") &"_"

	if TaxType = "Sales" Then
		file_being_created= exportDirectory &"\Basic\"& TaxType &"\z2t_Basic_"& YearMonth & States(iState) &".csv"
	else
		file_being_created= exportDirectory &"\Basic\"& TaxType &"\z2t_Basic_UseTax_"& YearMonth & States(iState) &".csv"
	end if
	
	
	Call 	OpenStoredProc(States(iState) )
	
	'Create File System Object
	set fso = createobject("scripting.filesystemobject")

	'create the file to write to
	Set act = fso.CreateTextFile(file_being_created, true)
	act.WriteLine(handleHeading)

	Do Until rs.EOF	
		' Write to the file
'		Act.Write("hello world")
'		act.Write(" Hello")
		for i = 0 to fieldCount
			act.Write(rs("""&fieldName(i)&"""))
		Next
	' act.WriteLine (rs("z2t_ID") & ","& rs("ZipCode") & ","& rs(TaxRate) & ", "& rs("Jurisdiction") &","& rs(ReportingCode) & "," &	rs("City") & ","&rs("PostOffice") & ", " & rs("State") &","& rs("County") & "," &  IIf(trim(rs("ShippingTaxable"))="",0, rs("ShippingTaxable")) & ","& rs("PrimaryRecord") )	
		rs.MoveNext	
	Loop
	act.close
   End If

Next

Public Function handleHeading()

    Dim h
    Dim i 

    'Write headings to file
    For i = 0 To fieldCount - 1
        Select Case FormatType
        Case "Magento", "Magento Enterprize"
            'Magento format needs quoted strings
            h = h & Chr(34) & fieldName(i) & Chr(34) & ","
        Case Else
            h = h & fieldName(i) & ","
        End Select
    Next 

    'End of line
    Select Case FormatType
    Case "Ultracart"' omits the heading
        h = ""
    Case Else
        'All others need to have the trailing comma removed
        If Len(h) > 0 Then
            h = Left(h, Len(h) - 1)
        End If
    End Select
        
    handleHeading = Trim(h)
        
End Function


Public Sub GetStateList()

    Dim i    : i = 0
    Dim SQL   
	Dim rsStates: Set rsStates=server.createObject("ADODB.Recordset")  
    Dim connPhilly05: Set connPhilly05=server.CreateObject("ADODB.Connection")

	 connPhilly05.Open "driver=SQL Server;server=208.88.49.22,8543;uid=davewj2o;pwd=get2it;database=z2t_Export" ' philly05   
    SQL = "SELECT DISTINCT([State]) as State FROM z2t_ZipCodes WHERE DeletedDate IS NULL ORDER BY [State]"
  
	rsStates.open SQL, connPhilly05
            StatesCount =0
    If Not rsStates.EOF Then
        Do While Not rsStates.EOF
            i = i + 1
            states(i) = rsStates("State")
			StatesCount = i
            rsStates.MoveNext
        Loop
    End If
    
    rsStates.Close
    Set rsStates = Nothing

End Sub

Function IIf(bClause, sTrue, sFalse)
    If CBool(bClause) Then
        IIf = sTrue
    Else 
        IIf = sFalse
    End If
End Function


Public Sub OpenStoredProc(stateName)

    Dim i
    Dim SQL
    
    If stateName = "NYClothing" Then
        SQL = "z2t_CustomerExport_NY_Clothing(" & CStr(FormatType) & ")"
    Else
        'Standard stored procedure name
        Select Case FormatType
        Case "Basic"
            SQL = "z2t_TableExport_Basic"
        Case "Full Breakout"
            SQL = "z2t_TableExport_FullBreakout"
        Case "Unique"
            SQL = "z2t_TableExport_UniqueZips"
        Case "Evolution"
            SQL = "z2t_TableExport_Evolution"
        Case "Magento"
            SQL = "z2t_TableExport_Magento"
        Case "Magento Enterprise"
            SQL = "z2t_TableExport_Magento_Enterprise"
        Case "Sedona"
            SQL = "z2t_TableExport_Sedona"
        Case "Ultracart"
            SQL = "z2t_TableExport_Ultracart"
        Case "Volusion"
            SQL = "z2t_TableExport_Volusion"
        End Select
        
        If stateName = "" Then
            SQL = SQL & "(" & CStr(IIf(TaxType="Sales", 1, 2)) & ",'')"
        Else
            SQL = SQL & "(" & CStr(IIf(TaxType="Sales", 1, 2)) & ",'" & stateName & "')"
        End If        
    End If
    
	
	
	Set rs=server.createObject("ADODB.Recordset")
 	'strSQL = "z2t_TableExport_Basic("&TaxType&",'"& States(iState) &"')"
 	rs.open SQL, connPhilly05, 3, 3, 4 
	
      
	If Not rs.EOF Then
        fieldCount = rs.Fields.Count
        For i = 0 To fieldCount - 1
            fieldName(i) = rs.Fields.Item(i).Name
        Next 
    End If

End Sub



Public Function handleFields()

    Dim s
    Dim i

        For i = 0 To fieldCount - 1
            Select Case FormatType
        Case "Magento", "Magento Enterprize"
                'Magento format needs quoted strings
                s = s & Chr(34) & Trim(rs.Fields.Item(i)) & Chr(34) & ","
            Case "Ultracart" ' needs fixed widths
                If i > 4 Then
                    'Special format for rate fields
                    If IsNull(rs.Fields.Item(i)) Then
                        s = s & "0.000000"
                    Else
                        s = s & Format(rs.Fields.Item(i), "0.000000")
                    End If
                Else
                    If IsNull(rs.Fields.Item(i)) Then
                        s = s & Space(UltracartFieldWidth(i))
                    Else
                        s = s & Trim(rs.Fields.Item(i)) & Space(UltracartFieldWidth(i) - Len(Trim(rs.Fields.Item(i))))
                    End If
                End If
            Case Else
                s = s & Trim(rs.Fields.Item(i)) & ","
            End Select
        Next 
        
    'End of line
    Select Case FormatType
    Case "Ultracart"' needs line feed
        'Oops, I guess the Print method of writing to the file already puts one in?
        s = s & vbCrLf
    Case Else
        'All others need to have the trailing comma removed
        s = Left(s, Len(s) - 1)
    End Select
        
    handleFields = s
        
End Function


ResponseText =FormatType &" "& TaxType & " File(s) has been created for "& ExportType &"."



response.write ResponseText 
%>
