
<%

AllFormatType = false
path= Request("ExportDirectory") &"\"&Request("FormatType")&"\"&Request("TaxType")

	Dim fs, folder, c
	c = 0
	Set fs = CreateObject("Scripting.FileSystemObject")
if len(Request("FormatType")) > 1 then
		if fs.FolderExists(path) 	  then
		response.Write("Single~")
			Set folder = fs.GetFolder(path)
			For Each item In folder.Files
				If UCase(Right(item.Name, Len (ext))) = UCase(ext) Then 
						c=c+1
				End if
			Next
		countFiles = c
		end if 

else

		path= Request("ExportDirectory")	
	if fs.FolderExists(path) 	  then
		dim subFolderTaxType(2)
		subFolderTaxType(1) = "Sales"
		subFolderTaxType(2) = "Use"
		
		dim 	subFolderNameTaxType(2)	
		subFolderNameTaxType(1) = ""
		subFolderNameTaxType(2) = "_UseTax"
		
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
		
		ifRunThemAll = true
		countFiles = "Collective~" 

		for j = 1 to UBound(subFolders)
			for i= 1 to UBound(subFolderTaxType)
				c=0
				subPath= "\"&Subfolders(j)&"\"&subFolderTaxType(i)
				Path = path&SubPath
'	response.Write(path&vbcrlf)
'	response.End()

					Set folder = fs.GetFolder(path)
					For Each item In folder.Files
					
						If UCase(Right(item.Name, Len (ext))) = UCase(ext) Then 
							c=c+1
						End if
					Next
				countFiles=	countFiles & c &"~"
				path=Request("ExportDirectory")	
			next 
	
		next 
	
	
	
else

end if
end if
Response.Write(countFiles)
%>
