<Script language='VbScript' runat='Server'>
 const adEmpty=0'No value
 const adSmallInt=2'A 2-byte signed integer.
 const adInteger=3'A 4-byte signed integer.
 const adSingle=4'A single-precision floating-point value.
 const adDouble=5'A double-precision floating-point value.
 const adCurrency=6'A currency value
 const adDate=7'"The number of days since December 30= 1899 + the fraction of a day."
 const adBSTR=8'A null-terminated character string.
 const adIDispatch=9'A pointer to an IDispatch interface on a COM object. Note: Currently not supported by ADO.
 const adError=10'A 32-bit error code
 const adBoolean=11'A boolean value.
 const adVariant=12'An Automation Variant. Note: Currently not supported by ADO.
 const adIUnknown=13'A pointer to an IUnknown interface on a COM object. Note: Currently not supported by ADO.
 const adDecimal=14'An exact numeric value with a fixed precision and scale.
 const adTinyInt=16'A 1-byte signed integer.
 const adUnsignedTinyInt=17'A 1-byte unsigned integer.
 const adUnsignedSmallInt=18'A 2-byte unsigned integer.
 const adUnsignedInt=19'A 4-byte unsigned integer.
 const adBigInt=20'An 8-byte signed integer.
 const adUnsignedBigInt=21'An 8-byte unsigned integer.
 const adFileTime=64'"The number of 100-nanosecond intervals since January 1=1601"
 const adGUID=72'A globally unique identifier (GUID)
 const adBinary=128'A binary value.
 const adChar=129'A string value.
 const adWChar=130'A null-terminated Unicode character string.
 const adNumeric=131'An exact numeric value with a fixed precision and scale.
 const adUserDefined=132'A user-defined variable.
 const adDBDate=133'A date value (yyyymmdd).
 const adDBTime=134'A time value (hhmmss).
 const adDBTimeStamp=135'A date/time stamp (yyyymmddhhmmss plus a fraction in billionths).
 const adChapter=136'A 4-byte chapter value that identifies rows in a child rowset
 const adPropVariant=138'An Automation PROPVARIANT.
 const adVarNumeric=139'A numeric value (Parameter object only).
 const adVarChar=200'A string value (Parameter object only).
 const adLongVarChar=201'A long string value.
 const adVarWChar=202'A null-terminated Unicode character string.
 const adLongVarWChar=203'A long null-terminated Unicode string value.
 const adVarBinary=204'A binary value (Parameter object only).
 const adLongVarBinary=205'A long binary value.
' const AdArray=0x2000'A flag value combined with another data type constant. Indicates an array of that other data type.

'---- CommandTypeEnum Values ----
 const adCmdStoredProc = &H0004

</Script>