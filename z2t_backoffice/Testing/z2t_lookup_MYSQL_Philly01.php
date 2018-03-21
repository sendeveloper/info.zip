<?php

$php_zip = $_GET['zCode'];
$php_name = $_GET['uName'];
$php_pwd = $_GET['pwd'];


$strServer = "Philly01.HarvestAmerican.net:3306";
$strDBUsername = "swati";
$strDBPassword = "s1Intern";
$strDatabase = "zip2tax";


//Open the connection
$conn = mysql_connect($strServer, $strDBUsername, $strDBPassword) 
    or die("Failed to connect to MySQL server on $strServer ". mysql_error());

//Open the Database
mysql_select_db($strDatabase, $conn)
    or die("Could not open database $strDatabase");


//Set-up query variables
$strZipCode = $php_zip;  //sample zip code must be between 90001 and 90999
$strUserName = $php_name;
$strUserPassword = $php_pwd;


//Execute
$result = mysql_query( "CALL zip2tax.z2t_lookup('" . $strZipCode . "','" . $strUserName . "', '" . $strUserPassword . "')" )
    or die( mysql_error() );


//Read the result
while($row = mysql_fetch_array($result, MYSQL_ASSOC))
    {
    echo "Zip Code: " . $row['Zip_Code'] . "<br>";
    echo "Sales Tax Rate: " . $row['Sales_Tax_Rate'] . "<br>";
    echo "Post Office City: " . $row['Post_Office_City'] . "<br>";
    echo "County: " . $row['County'] . "<br>";
    echo "State: " . $row['State'] . "<br>";
    echo "Shipping Taxable: " . $row['Shipping_Taxable'] . "<br>";
    }


mysql_free_result($result);

//Close the Database
mysql_close($conn);


?>
