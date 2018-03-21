<%
                  
dim subFolders(99)               
dim subFolderNameTaxType(99)   
dim subFolderTaxType(99)        
dim fs                
dim BaseDir                  
dim createdirectory
dim exportDirectory 
dim BaseFolders
dim ifFileCreated
dim ifAlreadyExist
dim checkstatusclick
dim YearMonth 
dim CompletePath 
dim SubFolder
dim SubFolderType

YearMonth = Request("cmbYearval") &"_"& Request("cmbMonthval") &"_"

subFolderTaxType(1) = "Sales"
subFolderTaxType(2) = "Use"

subFolderNameTaxType(1) = ""
subFolderNameTaxType(2) = "_UseTax"

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

ifFileCreated=false
ifAlreadyExist=false
exportDirectory= Request("txtExportDirectory")
BaseDir = exportDirectory
BaseFolders= split(BaseDir,"\")

set filesys=CreateObject("Scripting.FileSystemObject")
		
createdirectory = request("createdirectory")  	
checkstatusclick= request("checkstatusclick")
ifAlreadyExist = filesys.FolderExists(exportDirectory) 	  
CompletePath = BaseFolders(0)

If Not ifAlreadyExist and len(createdirectory) =1   then     
	for i=1 to Ubound(BaseFolders)  
		SubFolder=""
		SubFolderType=""
		CompletePath=CompletePath &"\"&BaseFolders(i)	
		If  Not filesys.FolderExists(CompletePath) Then 
		   filesys.CreateFolder (CompletePath)		
		End if	
	Next	
	For j=1 to Ubound(SubFolders )			' Basic, Magento, Ultracart etc.
		SubFolder = CompletePath &"\"& SubFolders(j)
		If  Not filesys.FolderExists(SubFolder ) Then 
			filesys.CreateFolder (SubFolder)				
			For k = 1 to Ubound(SubFolderTaxType)    ' Use Tax and Sale Tax
				SubFolderType = SubFolder &"\"& SubFolderTaxType(k)
				If  Not filesys.FolderExists(SubFolderType ) Then 
					filesys.CreateFolder (SubFolderType)														
				End if
			Next
		end if
	Next			
ifFileCreated=true
End If

cmbYearval = request("cmbYearval")
cmbMonthval = request("cmbMonthval")

If Not ifAlreadyExist and len(createdirectory) <1 Then
		response.Write("ask~"&cmbMonthval&"~"&cmbYearval) 	  
Elseif ifAlreadyExist and checkstatusclick=0 Then
	response.Write("DoNothing")
Elseif ifAlreadyExist and checkstatusclick=1 Then
	response.Write("Directory already exist.~"&cmbMonthval&"~"&cmbYearval)
Elseif not ifAlreadyExist and len(createdirectory) =1 and ifFileCreated Then
    response.Write("Base directory created.~"&cmbMonthval&"~"&cmbYearval)  
End If


%>