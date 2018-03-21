
<%
option explicit
Server.ScriptTimeout=2000
Response.Buffer = True


dim States(99)  
dim StatesCount
dim exportDirectory : exportDirectory= Request.QueryString("ExportDirectory")
dim TaxType: TaxType = Request.QueryString("TaxType")  '' Use or Sales
dim FormatType :FormatType = Request.QueryString("FormatType")  '' Basic Magento etc.
dim ExportType: ExportType=Request.QueryString("ExportType")  '' Individual or Entire or NY Clothing

dim RunThemAll: RunThemAll = Request.QueryString("RunThemAll")
dim pollProgress:pollProgress=Request.QueryString("Progress")
Dim rs  
Set rs=server.createObject("ADODB.Recordset")  
dim fso:    set fso = createobject("scripting.filesystemobject")

Dim countFiles
Dim UltracartFieldWidth(99)   

    UltracartFieldWidth(0) = 5  'ZIP
    UltracartFieldWidth(1) = 3  'FPIS
    UltracartFieldWidth(2) = 2  'ST
    UltracartFieldWidth(3) = 25 'County
    UltracartFieldWidth(4) = 28 'City
    UltracartFieldWidth(5) = 8  'ST_ST
    UltracartFieldWidth(6) = 8  'CO_ST
    UltracartFieldWidth(7) = 8  'CI_ST
    UltracartFieldWidth(8) = 8  'ST_UT
    UltracartFieldWidth(9) = 8  'CO_UT
    UltracartFieldWidth(10) = 8 'CI_UT

dim YearMonth : YearMonth = Split(ExportDirectory, "\")(3) &"_"& Split(Split(ExportDirectory, "\")(4)," - ")(0)&"_"
   
Dim connPhilly05
dim fieldCount
Dim fieldName(99)  
dim TaxRate

if RunThemAll = "True" then
	call RunThemAll_Export()
else
	if ExportType = "Individual States" Then 
		Call IndividualStatesExport()
	Elseif  ExportType = "NY Clothing" then
		Call NY_ClothingExport()
	Else
		call EntireUS_Export()
	End if
end if

'''''''''''''''''''' Basic Functions Start
Public Sub IndividualStatesExport()
Call GetStateList()
dim iState
 For iState = 1 to StatesCount
  if  len(trim(States(iState)) ) >0 Then
	' Create Files with specific names
	dim oFile
	if FormatType = "Ultracart" OR FormatType = "EpicorProphet21" then
		 oFile=exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_"&FormatType& _
			IIf(TaxType ="Use", "_UseTax","")&"_"& YearMonth & States(iState) &".txt"
	elseif FormatType = "Magento Enterprise" then
		 oFile=exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_MagentoEnterprise"& _
			IIf(TaxType ="Use", "_UseTax","")&"_"& YearMonth & States(iState) &".csv"
	else
		 oFile=exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_"&FormatType& _
			IIf(TaxType ="Use", "_UseTax","")&"_"& YearMonth & States(iState) &".csv"
	
	end if
	
	Call OpenStoredProc(States(iState) )	
	'create the file to write to
	dim act: Set act = fso.CreateTextFile(oFile, true)
	act.WriteLine(handleHeading)
	Do Until rs.EOF	
'		Session("CurrentProgress")=FormatType & " for " & TaxType & " " & rs.AbsolutePosition & " of " & rs.RecordCount
		act.WriteLine(WriteToFile(rs )) ' 1 for Individual States
		rs.MoveNext	   
	Loop
'	Session("CurrentProgress")="Done"
   End If
Next
	act.close
	rs.close
	Set rs = Nothing
	set act = Nothing
connPhilly05.close
Set connPhilly05=Nothing

	if Not RunThemAll then
		CountFiles = StatesCount
	else
		CountFiles = CountFiles + StatesCount
	end if

End Sub

public Sub NY_ClothingExport()
	' Create Files with specific names
	dim oFile: oFile  = exportDirectory &"\"&FormatType&"\Sales\z2t_"&FormatType&"_"& YearMonth & "NY_Clothing.csv"
	'	response.Write(oFile)
	Call OpenStoredProc("NYClothing" )	

	'create the file to write to
	dim act:Set act = fso.CreateTextFile(oFile, true)
	act.WriteLine(handleHeading)	

	Do Until rs.EOF	
		act.WriteLine(WriteToFile(rs )) ' 1 for Individual States
		rs.MoveNext	   
	Loop
	if Not RunThemAll then
		CountFiles = 1
	else
		CountFiles = CountFiles + 1
	end if
	act.close
	set act =Nothing
	rs.close
	Set rs = Nothing
	connPhilly05.close
	Set connPhilly05=Nothing

End Sub



Public Sub EntireUS_Export()
	dim SecondFileStarted
	
	dim oFile1 
	if FormatType = "Ultracart" OR FormatType = "EpicorProphet21" then
 		oFile1= exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_"&FormatType &IIf(TaxType ="Use", "_UseTax_","_")& YearMonth & "US_Part1.txt"
	elseif FormatType = "Magento Enterprise" then
 		oFile1= exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_MagentoEnterprise"&IIf(TaxType ="Use", "_UseTax_","_")& YearMonth & "US_Part1.csv"
	 else
		 oFile1= exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_"&FormatType &IIf(TaxType ="Use", "_UseTax_","_")& YearMonth & "US_Part1.csv"
	 end if
	dim act: Set act = fso.CreateTextFile(oFile1, true)
	if Not RunThemAll then
		CountFiles = 1
	else
		CountFiles = CountFiles + 1
	end if
  	'create the file to write to for entire US
	dim oFile	
	if FormatType = "Ultracart"  OR FormatType = "EpicorProphet21" then
 		 oFile= exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_"&FormatType &IIf(TaxType ="Use", "_UseTax_","_")& YearMonth & "US.txt"
	elseif FormatType = "Magento Enterprise" then
		 oFile= exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_MagentoEnterprise" &IIf(TaxType ="Use", "_UseTax_","_")& YearMonth & "US.csv"
	 else
		 oFile= exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_"&FormatType &IIf(TaxType ="Use", "_UseTax_","_")& YearMonth & "US.csv"
	 end if
    dim actEntireUS: Set actEntireUS = fso.CreateTextFile(oFile, true)

	CountFiles=CountFiles+1			
	Call OpenStoredProc("")
	act.WriteLine(handleHeading)	
	actEntireUS.WriteLine(handleHeading)
	Do Until rs.EOF	 

        If SecondFileStarted = False Then		
			dim z 
				'We need the name of the zip code field so we can know when we're half way
            Select Case FormatType
            Case "Evolution"
                z = CSng(rs.Fields("zip"))
			Case "FabChoice"
                z = CSng(rs.Fields("ZipCode"))
            Case "Magento", "Magento Enterprise"
                z = CSng(rs.Fields("Zip/Post Code"))
            Case "Sedona"
                z = CSng(rs.Fields("Zip Code"))
            Case "Ultracart"
                z = CSng(rs.Fields("Zip/Post Code"))
            Case "Volusion"
                z = CSng(rs.Fields("taxpostalcode"))
			Case "EpicorManage2000"
				z = left(rs.Fields(""),5)
			Case "EpicorProphet21"
				z = CSng(rs.Fields("ImportSetNumber"))
            Case Else
                z = CSng(rs.Fields("ZipCode"))
            End Select
 
            'We need the name of the zip code field so we can know when we're half way
            If z > 50000 Then
				act.close
				'Start the 2nd file
				SecondFileStarted = True
				dim oFile2
	if FormatType = "Ultracart" OR FormatType = "EpicorProphet21" then
 		 oFile2= exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_"&FormatType & _
			 IIf(TaxType ="Use", "_UseTax_","_")& YearMonth & "US_Part2.txt"
	elseif FormatType = "Magento Enterprise" then
 		 oFile2= exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_MagentoEnterprise" & _
			 IIf(TaxType ="Use", "_UseTax_","_")& YearMonth & "US_Part2.csv"
	 else
		 oFile2= exportDirectory &"\"&FormatType&"\"& TaxType &"\z2t_"&FormatType & _
			 IIf(TaxType ="Use", "_UseTax_","_")& YearMonth & "US_Part2.csv"
	 end if
				Set act = fso.CreateTextFile(oFile2, true)
       		 'Write headings to file
				act.WriteLine(handleHeading)
	if Not RunThemAll then
			CountFiles=CountFiles+1			
	else
		CountFiles = CountFiles + 1
	end if
	        End If
        End If
		actEntireUS.WriteLine(WriteToFile(rs )) ' 1 for Individual States
		act.WriteLine(WriteToFile(rs )) ' 1 for Individual States

     	rs.MoveNext
    Loop
	act.Close
	actEntireUS.Close
	set act=Nothing
	set actEntireUS=Nothing
	rs.close
	Set rs = Nothing
	connPhilly05.close
	Set connPhilly05=Nothing

End Sub 


Public Sub RunThemAll_Export()

	dim subFolderTaxType(2)
	subFolderTaxType(1) = "Sales"
	subFolderTaxType(2) = "Use"

	dim 	subFolders(12)
	subFolders(1) = "Basic"
	subFolders(2) = "FullBreakout"
	subFolders(3)=  "UniqueZips"
	subFolders(4)=  "EpicorManage2000"
	subFolders(5)=  "EpicorProphet21"
	subFolders(6)=  "Evolution"
	subFolders(7)=  "FabChoice"
	subFolders(8)=  "Magento"
	subFolders(9)=  "Magento Enterprise"
	subFolders(10)=  "Sedona"
	subFolders(11)= "Ultracart"
	subFolders(12)= "Volusion"
	
dim i
dim j
	for i = 1 to UBound(subFolderTaxType)
			TaxType=subfolderTaxType(i)		
	for j = 1 to UBound(subFolders)
		FormatType=Subfolders(j)
		if (i = 2 AND j = 4) Then 'Added since EpicorManage2000 doesn't have a use tax so it should just skip it. Jessie Shrauger 8/16/17
		Else
			if FormatType = "FullBreakout" Then
				call NY_ClothingExport()
			End if	
			call IndividualStatesExport()
		call EntireUS_Export()
		End if
		Next
	Next
End Sub
''''''''''''''' Basic Functions End

''''''''''' Help Functions Start
Public function WriteToFile( rs)
	' Write to the file
	dim i
	dim s
	for i = 0 to fieldCount-1			
		Select Case FormatType
			Case "Magento", "Magento Enterprise"	
				s=s&Chr(34)&rs(fieldName(i))&Chr(34)&","
			Case "Ultracart" ' needs fixed widths			
				If i > 4 Then
					'Special format for rate fields
					If IsNull(rs(fieldName(i))) Then
						s=s&"0.000000"&Space(1)
				Else
				'		FormatNumber(Expression[,NumDigAfterDec[,IncLeadingDig[,UseParForNegNum[,GroupDig]]]])
						s=s&FormatNumber(  rs(fieldName(i)), 6)&Space(1)	
				End If
				Else
					If IsNull(rs(fieldName(i))) Then
						s=s&Space(UltracartFieldWidth(i))
					Else
						s=s&Trim(rs(fieldName(i))) & Space(UltracartFieldWidth(i) - Len(Trim(rs(fieldName(i)))))
					End If
				End If
				
			Case "EpicorProphet21"
						s=s&rs(fieldName(i))&chr(9)

			Case Else
						s=s&rs(fieldName(i))&","	
		End Select 
	Next
	  'All others need to have the trailing comma removed
	s = Left(s, Len(s) - 1)
'			response.Write(s)    
	WriteToFile=s
End function

Public Function handleHeading()

    Dim h
    Dim i 

    'Write headings to file
    For i = 0 To fieldCount - 1
        Select Case FormatType
        Case "Magento", "Magento Enterprise"
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
	Case "EpicorProphet21"' omits the heading
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
    'Dim connPhilly05: 
	Set connPhilly05=server.CreateObject("ADODB.Connection")

	 connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_Export" ' philly05   
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
connPhilly05.close
Set connPhilly05=Nothing
End Sub
''''''''''''''''''''' Help Functions End


'''''''''''' System Support Functions Start
Public Function IIf(bClause, sTrue, sFalse)
    If CBool(bClause) Then
        IIf = sTrue
    Else 
        IIf = sFalse
    End If
End Function

Function FormatString(sVal, aArgs)
Dim i
    For i=0 To ubound(aArgs)
        sVal = Replace(sVal,"{" & CStr(i) & "}",aArgs(i))
    Next
    StringFormat = sVal
End Function

''''''''''''''''System Support Functions End


'''''''''''''''' DB Functions Start

Public Sub OpenStoredProc(stateName)

    Dim i
    Dim SQL

    If stateName = "NYClothing" Then
        SQL = "z2t_CustomerExport_NY_Clothing(1)"
    Else

        'Standard stored procedure name
        Select Case FormatType
        Case "Basic"
            SQL = "z2t_TableExport_Basic"
        Case "FullBreakout"
            SQL = "z2t_TableExport_FullBreakout"
        Case "UniqueZips"
            SQL = "z2t_TableExport_UniqueZips"
		Case "EpicorManage2000"
			SQL = "z2t_TableExport_Epicor_Manage2000"
		Case "EpicorProphet21"
			SQL = "z2t_TableExport_Epicor_Prophet21"
        Case "Evolution"
            SQL = "z2t_TableExport_Evolution"
		Case "FabChoice"
			SQL = "z2t_TableExport_FabChoice"
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
	Set connPhilly05=server.CreateObject("ADODB.Connection")
	 connPhilly05.Open "driver=SQL Server;server=127.0.0.1;uid=davewj2o;pwd=get2it;database=z2t_Export" ' philly05   

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
'''''''''''''''''' DB Functions End

dim ResponseText

if pollProgress ="true" Then
	 ResponseText =CountFiles &"  Files(s) have been created."
 end if
 
if RunThemAll Then
 ResponseText =CountFiles &"  Files(s) have been created."
Else
 ResponseText =CountFiles &" "& FormatType &" "& TaxType & " File(s) have been created for "& ExportType &"."'& "~"&FileCount
End If


Response.write ResponseText 
%>
