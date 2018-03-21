<%

	ifAlreadyExist=false
	exportDirectory= Request("txtExportDirectory")
	set filesys=CreateObject("Scripting.FileSystemObject")
	ifAlreadyExist = filesys.FolderExists(exportDirectory) 	  

	response.Write(ifAlreadyExist)
	
%>