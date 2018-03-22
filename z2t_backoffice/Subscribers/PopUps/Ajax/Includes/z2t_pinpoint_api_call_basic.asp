<%


' Called by Request variables

'
' Lookup Class object
'
Class CLookupResults

    Public ZipInput
    Public SalesRate
    Public IsShippingTaxable
    Public DisplayCity
    Public County
    Public State
    Public objXML
   
   'Perform the XML request and store XML response
    Public Function ApiCall(UserName,Password,ZipCode)    
            apiurl = pathLookupAPI & "/TaxRate-USA.xml?username=" &Username& "&password=" &Password& "&zip=" &zipCode
            Set objXML = Server.CreateObject("Microsoft.XMLDOM")
            objXML.setProperty "ServerHTTPRequest", True
            objXML.async =  False
            objXML.Load(apiurl)
    End Function


    Public Function ErrorCode
            apiStatusCode = objXML.parseError.ErrorCode
            If(apiStatusCode = 0) Then
            Set xmlDoc = objXML.documentElement  
            ErrorCode = xmlDoc.getElementsByTagName("errorCode")(0).text
            Else
            ErrorCode = 3
            End If
    End Function


    Public Sub SetBasicLookupData()

            Set xmlDoc = objXML.documentElement
            addressIndex  =  0
            'Get address List
            Set NodeList = xmlDoc.getElementsByTagName("addressInfo")
            Set addressList = xmlDoc.getElementsByTagName("address")(addressIndex)

            'Lookup the city using the individual address Component
            DisplayCity  = addressList.getElementsByTagName("place")(0).text 
            'Get the other attributes including County, State
            stringCounty =  addressList.getElementsByTagName("authorityName")(1).text
            County = Mid(stringCounty,11)
            stringState =  addressList.getElementsByTagName("authorityName")(0).text
            State = Mid(stringState,10)

            'Get the total salesTaxRate
            Set salesTaxSection = addressList.getElementsByTagName("salesTax")(0)
            totalSalesRate = salesTaxSection.getElementsByTagName("taxRate")(0).text 
            SalesRate = TrimDecimal(totalSalesRate)

            IsShippingTaxable = 0
            Dim noteDetail
            Set noteDetail = addressList.getElementsByTagName("notes/noteDetail/note")
            noteDetailLength = noteDetail.length
 
            For notesDetailIncrementor = 0 to noteDetailLength-1
            CompShippingTaxable = StrComp("Shipping charges are taxable",noteDetail(notesDetailIncrementor).Text)
                    If CompShippingTaxable = 0 Then
                            IsShippingTaxable = 1
                    End If
            Next
              
    End Sub

    Public Function TrimDecimal(rate)
            trimDecimal = rate
            While Right(trimDecimal,1) = "0" AND trimDecimal <> ""
            trimDecimal = Left(trimDecimal,Len(trimDecimal)-1)
            Wend  

            If Right(trimDecimal,1) = "." AND trimDecimal <> "" Then
            trimDecimal = Left(trimDecimal,Len(trimDecimal)-1)
            End If 
        
    End Function
        

End Class

%>