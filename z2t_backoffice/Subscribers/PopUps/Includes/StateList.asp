<%
' `StateList.asp'  <2011-03-17 Thu nathan>  The States (and DC) manually grovelled from `barley2.zip2tax.dbo.z2t_StateInfo'
'
'                                           Format: ID, State Abbreviation, State Name, JurType1 (State/District for DC)
'                                           Sorted alphabetically by State Name
Dim States(51,4)

States(0,0) = 5
States(0,1) = "AK"
States(0,2) = "Alaska"
States(0,3) = "State"

States(1,0) = 4
States(1,1) = "AL"
States(1,2) = "Alabama"
States(1,3) = "State"

States(2,0) = 7
States(2,1) = "AR"
States(2,2) = "Arkansas"
States(2,3) = "State"

States(3,0) = 6
States(3,1) = "AZ"
States(3,2) = "Arizona"
States(3,3) = "State"

States(4,0) = 8
States(4,1) = "CA"
States(4,2) = "California"
States(4,3) = "State"

States(5,0) = 9
States(5,1) = "CO"
States(5,2) = "Colorado"
States(5,3) = "State"

States(6,0) = 10
States(6,1) = "CT"
States(6,2) = "Connecticut"
States(6,3) = "State"

States(7,0) = 12
States(7,1) = "DC"
States(7,2) = "Columbia"
States(7,3) = "District"

States(8,0) = 11
States(8,1) = "DE"
States(8,2) = "Delaware"
States(8,3) = "State"

States(9,0) = 13
States(9,1) = "FL"
States(9,2) = "Florida"
States(9,3) = "State"

States(10,0) = 14
States(10,1) = "GA"
States(10,2) = "Georgia"
States(10,3) = "State"

States(11,0) = 16
States(11,1) = "HI"
States(11,2) = "Hawaii"
States(11,3) = "State"

States(12,0) = 20
States(12,1) = "IA"
States(12,2) = "Iowa"
States(12,3) = "State"

States(13,0) = 17
States(13,1) = "ID"
States(13,2) = "Idaho"
States(13,3) = "State"

States(14,0) = 18
States(14,1) = "IL"
States(14,2) = "Illinois"
States(14,3) = "State"

States(15,0) = 19
States(15,1) = "IN"
States(15,2) = "Indiana"
States(15,3) = "State"

States(16,0) = 21
States(16,1) = "KS"
States(16,2) = "Kansas"
States(16,3) = "State"

States(17,0) = 22
States(17,1) = "KY"
States(17,2) = "Kentucky"
States(17,3) = "State"

States(18,0) = 23
States(18,1) = "LA"
States(18,2) = "Louisiana"
States(18,3) = "State"

States(19,0) = 26
States(19,1) = "MA"
States(19,2) = "Massachusetts"
States(19,3) = "State"

States(20,0) = 25
States(20,1) = "MD"
States(20,2) = "Maryland"
States(20,3) = "State"

States(21,0) = 24
States(21,1) = "ME"
States(21,2) = "Maine"
States(21,3) = "State"

States(22,0) = 28
States(22,1) = "MI"
States(22,2) = "Michigan"
States(22,3) = "State"

States(23,0) = 29
States(23,1) = "MN"
States(23,2) = "Minnesota"
States(23,3) = "State"

States(24,0) = 31
States(24,1) = "MO"
States(24,2) = "Missouri"
States(24,3) = "State"

States(25,0) = 30
States(25,1) = "MS"
States(25,2) = "Mississippi"
States(25,3) = "State"

States(26,0) = 32
States(26,1) = "MT"
States(26,2) = "Montana"
States(26,3) = "State"

States(27,0) = 38
States(27,1) = "NC"
States(27,2) = "North Carolina"
States(27,3) = "State"

States(28,0) = 39
States(28,1) = "ND"
States(28,2) = "North Dakota"
States(28,3) = "State"

States(29,0) = 33
States(29,1) = "NE"
States(29,2) = "Nebraska"
States(29,3) = "State"

States(30,0) = 35
States(30,1) = "NH"
States(30,2) = "New Hampshire"
States(30,3) = "State"

States(31,0) = 36
States(31,1) = "NJ"
States(31,2) = "New Jersey"
States(31,3) = "State"

States(32,0) = 37
States(32,1) = "NM"
States(32,2) = "New Mexico"
States(32,3) = "State"

States(33,0) = 34
States(33,1) = "NV"
States(33,2) = "Nevada"
States(33,3) = "State"

States(34,0) = 1
States(34,1) = "NY"
States(34,2) = "New York"
States(34,3) = "State"

States(35,0) = 2
States(35,1) = "OH"
States(35,2) = "Ohio"
States(35,3) = "State"

States(36,0) = 41
States(36,1) = "OK"
States(36,2) = "Oklahoma"
States(36,3) = "State"

States(37,0) = 42
States(37,1) = "OR"
States(37,2) = "Oregon"
States(37,3) = "State"

States(38,0) = 3
States(38,1) = "PA"
States(38,2) = "Pennsylvania"
States(38,3) = "State"

States(39,0) = 44
States(39,1) = "RI"
States(39,2) = "Rhode Island"
States(39,3) = "State"

States(40,0) = 45
States(40,1) = "SC"
States(40,2) = "South Carolina"
States(40,3) = "State"

States(41,0) = 46
States(41,1) = "SD"
States(41,2) = "South Dakota"
States(41,3) = "State"

States(42,0) = 47
States(42,1) = "TN"
States(42,2) = "Tennessee"
States(42,3) = "State"

States(43,0) = 48
States(43,1) = "TX"
States(43,2) = "Texas"
States(43,3) = "State"

States(44,0) = 49
States(44,1) = "UT"
States(44,2) = "Utah"
States(44,3) = "State"

States(45,0) = 63
States(45,1) = "VA"
States(45,2) = "Virginia"
States(45,3) = "State"

States(46,0) = 50
States(46,1) = "VT"
States(46,2) = "Vermont"
States(46,3) = "State"

States(47,0) = 53
States(47,1) = "WA"
States(47,2) = "Washington"
States(47,3) = "State"

States(48,0) = 55
States(48,1) = "WI"
States(48,2) = "Wisconsin"
States(48,3) = "State"

States(49,0) = 54
States(49,1) = "WV"
States(49,2) = "West Virginia"
States(49,3) = "State"

States(50,0) = 56
States(50,1) = "WY"
States(50,2) = "Wyoming"
States(50,3) = "State"
%>
