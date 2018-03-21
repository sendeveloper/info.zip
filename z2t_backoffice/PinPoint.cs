//// Zip2Tax/Pinpoint API
////
//// Created: <2012-08-15 Wed nathan>
//// Descripion: An IIS HTTP handler that takes request variables,
////             returning XML/JSON results of a tax-rate-lookup.
////
//// Modified: <2013-01-21 Mon nathan>
//// Description: merged 4 types of handlers to refactor common code
////
//// Modified: <2013-06-14 Fri Pramoth>
//// Added Connection.Close on certain connections that are not closed, providing load capability.
////
//// Modified: <2013-06-14 Fri Pramoth>
//// Parse Google responses only for Pinpoint requests
////
//// Modified: <2013-08-23 Fri Pramoth>
//// Prioritized locality over Admin_area_Level_3
////
//// Modified: <2013-09-09 Wed nathan>
//// Description: Added pathway for data-source tags.
////
////
//// Modified: <2013-09-11 Wed nathan>
//// Description: Match specials with community ID. (They were duplicated for each extra community.)

//// Modified: <6/2/2014 Swati>
//// Description: Chnages mentioned in Version sheet

//// Modified: <6/12/2014 Swati>
//// Description:  Changed data to be sent to "data2" column in logactivity method

//// Modified: <6/19/2014 Swati>
//// Description: Changes to retreive Error message from types table instead of hard coding

//// Modified: <6/20/2014 Swati>
//// Description: Changes to add single state functionality for database interface
////
//// Modified: <2014-08-21 Thurs Kanchan
//// Description: Added  code for empty address table
////
//// Modified: <2014-08-28 Thurs Kanchan
//// Description: Added - to trimchar ,final address(line 617), parse method


using System;
using System.Collections;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.Linq;
using System.Xml.XPath;
using System.ServiceModel.Web;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Net;
using System.Diagnostics;
using System.Text.RegularExpressions;
using System.Linq;
using System.Reflection;

public delegate dynamic g(params dynamic[] args);

/// <summary>
///   Zip2Tax/Pinpoint API
/// </summary>
public class PinPointHandler : IHttpHandler
{
    //adding version number starting from 2ND June 2014, please update as in accordance with excel sheet.
    public static string version= "1.0.5";

    // Connection string for transactions
    public static string defaultConnectionString = "Initial Catalog=z2t_Zip4;Data Source=localhost;User ID=z2t_PinPoint_User;Password=get2PinPoint";
    //public static string defaultConnectionString = "Initial Catalog=z2t_Zip4;Data Source=philly05.harvestamerican.net,8543;User ID=z2t_PinPoint_User;Password=get2PinPoint";

    public PinPointHandler() { }

    static dynamic response = StreamWriter.Null; // *** for debug on local dev machine only ***
    static dynamic stdout = StreamWriter.Null; // *** for debug on local dev machine only ***

    private XslCompiledTransform xsl = new XslCompiledTransform();


    private String rawify(dynamic[] args)
    {
        var xml = args[0];
        var xsltArgs = args[1];
        return xml;
    }

    private String webify(dynamic[] args)
    {
        var xml = args[0];
        var xsltArgs = args[1];
        dynamic output = new StringWriter();
        //output.Write(webXSLT(xsltArgs)); // debug: show xslt transform
        xsl.Load(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(webXSLT(xsltArgs)))));
        //xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(webXSLT(xsltArgs)))), null, output);
        xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(xml))), null, output);
        return output.ToString();
    }

    private String xmlify(dynamic[] args)
    {
        var xml = args[0];
        var xsltArgs = args[1];
        dynamic output = new StringWriter();
        xsl.Load(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(xmlXSLT(xsltArgs)))));
        //xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(xmlXSLT(xsltArgs)))), null, output);
        xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(xml))), null, output);
        return output.ToString();
    }

    private String jsonify(dynamic[] args)
    {
        var xml = args[0];
        var xsltArgs = args[1];
        dynamic output = new StringWriter();
        xsl.Load(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(jsonXSLT(xsltArgs)))));
        //xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(jsonXSLT(xsltArgs)))), null, output);
        xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(xml))), null, output);
        return output.ToString();
    }


    private string widgetify(dynamic[] args)
    {
        var xml = args[0];
        var xsltArgs = args[1];
        dynamic output = new StringWriter();
        xsl.Load(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(webXSLT(xsltArgs)))));
        //xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(jsonXSLT(xsltArgs)))), null, output);
        xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(xml))), null, output);
        return output.ToString();

    }

    private string widgetLoginfy(dynamic[] args)
    {
        var xml = args[0];
        var xsltArgs = args[1];
        dynamic output = new StringWriter();
        xsl.Load(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(webXSLT(xsltArgs)))));
        //xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(jsonXSLT(xsltArgs)))), null, output);
        xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(xml))), null, output);
        return output.ToString();
    }

    private string webxmlify(dynamic[] args)
    {
        var xml = args[0];
        var xsltArgs = args[1];
        dynamic output = new StringWriter();
        xsl.Load(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(webXmlXSLT(xsltArgs)))));
        //xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(xmlXSLT(xsltArgs)))), null, output);
        xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(xml))), null, output);
        return output.ToString();

    }

    public void ProcessRequest(HttpContext context)
    {
/*
              try
*/
        {
            // This handler is called whenever a file ending in
            // .json/.xml/.web/.raw is requested. A file with that extension
            // does not need to exist.


            HttpResponse Response = context.Response;
            //Changes SM - May'2014 - adding change to record start timestamp
            Stopwatch stopWatch = new Stopwatch();
            stopWatch.Start();
            String timeStampStart = GetTimestamp(DateTime.Now);


            //response = context.Response; // *** for debug on local dev machine only ***
            //stdout = context.Response.Output; // *** for debug on local dev machine only ***
            Response.ContentType = "text/plain";

            dynamic ContentType = new Dictionary<dynamic, dynamic>(){
              {"web", new Dictionary<dynamic, dynamic>(){{"content-type", "application/json"}, {"transform", new g(webify)}, {"subscription-type", 3}}},
              {"json", new Dictionary<dynamic, dynamic>(){{"content-type", "application/json"}, {"transform", new g(jsonify)}, {"subscription-type", 4}}},
              {"xml",  new Dictionary<dynamic, dynamic>(){{"content-type", "application/xml"}, {"transform", new g(xmlify)}, {"subscription-type", 4}}},
              {"raw",  new Dictionary<dynamic, dynamic>(){{"content-type", "application/xml"}, {"transform", new g(rawify)}, {"subscription-type", 4}}},
              {"widget", new Dictionary<dynamic,dynamic>(){{"content-type","application/json"},{"transform",new g(widgetify)},{"subscription-type",3}}},
              {"widgetlogin", new Dictionary<dynamic,dynamic>() {{"content-type","application/json"},{"transform",new g(widgetLoginfy)},{"subscription-type",3}}},
              {"webxml",new Dictionary<dynamic,dynamic>() {{"content-type","application/xml"},{"transform", new g(webxmlify)},{"subscription-type",3}}}};

            g fn;
            ContentType = ContentType[context.Request.ServerVariables["URL"].Split(new String[] { "." }, StringSplitOptions.None).Last()];
            Response.ContentType = ContentType["content-type"];
            fn = ContentType["transform"];

            // select ContentType based on URL extension
            //    Response.ContentType = ContentType[context.Request.ServerVariables["URL"].Split(new String[]{"."}, StringSplitOptions.None).Last()]["content-type"];

            string queryString = context.Request.ServerVariables["QUERY_STRING"];
            NameValueCollection Request = HttpUtility.ParseQueryString(queryString);
            Func<string, string> request = delegate(string name) { return (Request[name] ?? ""); };

            string connectionString = defaultConnectionString;

            //geocodeService(new Object[] { request("addressLine1"), request("addressLine2"), request("city"), request("state"), request("zip") });

            string[] subscriptionServiceLevels = { "None", "ZIP", "Zip+4", "PinPoint" };
            string subscriptionServiceLevel = "Unchecked";
            string addressResolution = "None";
            string user = request("username");
            SqlDataAdapter adapter;
            DataSet ds = new DataSet();
            ds.DataSetName = "z2tLookup";
            SqlCommand sql;
            SqlConnection connection = new SqlConnection(connectionString);
            List<String> warnings = new List<String>();

            List<String> fallbacks = new List<String>();
            List<String> urgentMessages = new List<String>();
            List<String> passiveMessages = new List<String>();
            List<String> strings = new List<String>(); //new string[101].ToList()
            strings.Add("Success");
            strings.Add("Incorrect ZIP");
            strings.Add("Incorrect State as per ZIP provided");
            strings.Add("Incorrect City as per ZIP and State provided");
            strings.Add("City Alias is provided by user");
            strings.Add("Blank I/P Received");
            strings.Add("Address Not Found");
            strings.Add("Expired Account");
            strings.Add("Invalid Credentials");
            strings.Add("Invalid ZIP+4");
            strings.Add("Address found, but tax jurisdiction boundaries could not be matched");
            for (int count = strings.Count; count < 500; count++)
            { // i don't know how many; so i guessed 500 predefined errors
                strings.Add("Error #" + count.ToString());
            }
            strings.Add("Login Failed");


            int loginError = strings.Count - 1;
            int errorCode = 0;
            String errorMessage = strings[0];
            String passiveMessage;
            String urgentMessage;
            int expiry = 0;
            String geocodeLatitude = "NA", geocodeLongitude = "NA";
            String geoCoderName = "GeocoderAsNA";
            // bool passiveMessageSet; // used to pass in passive Message for special address correction systems

/* // obsolete <2013-09-04 Wed nathan>
            //// source data tag
            String lsad = "Locality";
            String addressSource = "i";
            String placeSource = "i";
            String countySource = "i";
            String stateSource = "i";
            String zipCodeSource = "i";
*/

            // fallback: login
            string zipString = request("zip"); //== "" ? finalZIP : request("zip"));
            string[] zipParts = zipString.Split(new char[] { '-' });
            string zipBase = (zipParts.Length > 0) ? zipParts[0] : "";
            string zip4 = (zipParts.Length > 1) ? zipParts[1] : "";
            int zip=00000;
            if (CheckZipIsNumeric(zipBase) && CheckZipIsNumeric(zip4))
                zip = Convert.ToInt32(((zipBase.Length == 5) && ((zip4.Length == 4) || (zip4.Length == 0)) && (zipParts.Length < 3)) ? zipBase : "-1");
            if ((user == "sample") && (request("password") == "password"))
            { // no zip?  don't know if it's in sample range yet.
                if ((zipString == "") || ((zip > 90000) && (zip < 91000)))
                {
                    warnings.Insert(warnings.Count, "Testing with free trial");
                    subscriptionServiceLevel = "PinPoint";
                }
                else
                {
                    errorCode = 55;
                    //errorMessage = "Valid sample ZIP codes must fall in the range 90001 - 90999";
                    errorMessage = getErrorMessage(errorCode);

                    warnings.Insert(warnings.Count, "Trial Lookup: " + errorMessage);
                    if (zip == -1)
                    {
                        warnings.Insert(warnings.Count, "Trial Lookup: The ZIP code " + zipString + " is invalid ");
                    }
                    else
                    {
                        warnings.Insert(warnings.Count, "Trial Lookup: The ZIP code " + zipString + " is out of range");
                    }
                    subscriptionServiceLevel = "None";
                    addressResolution = "None";
                }
                connection.Close();
            }
            else
            {
                connection.Close();
                connection = new SqlConnection(connectionString);
                connection.Open();
                sql = new SqlCommand("z2t_Login_API", connection);

                sql.CommandType = CommandType.StoredProcedure;

                // using (sql.Parameters) {}
                // - function to add
                sql.Parameters.Add(new SqlParameter("@userName", SqlDbType.NVarChar, -1));
                sql.Parameters["@userName"].Value = user;

                sql.Parameters.Add(new SqlParameter("@password", SqlDbType.NVarChar, -1));
                sql.Parameters["@password"].Value = request("password");

                sql.Parameters.Add(new SqlParameter("@subscriptionType", SqlDbType.Int));
                sql.Parameters["@subscriptionType"].Value = ContentType["subscription-type"];

                sql.Parameters.Add(new SqlParameter("@expirationDays", SqlDbType.Int)).Direction = ParameterDirection.Output;
                sql.Parameters["@expirationDays"].Value = DBNull.Value;

                sql.Parameters.Add(new SqlParameter("@subscriptionLevel", SqlDbType.Int)).Direction = ParameterDirection.Output;
                sql.Parameters["@subscriptionLevel"].Value = DBNull.Value;

                sql.Parameters.Add(new SqlParameter("@errorCode", SqlDbType.Int)).Direction = ParameterDirection.Output;
                sql.Parameters["@errorCode"].Value = DBNull.Value;

                sql.Parameters.Add(new SqlParameter("@errorMessage", SqlDbType.NVarChar, -1)).Direction = ParameterDirection.Output;
                sql.Parameters["@errorMessage"].Value = DBNull.Value;


                //foreach (SqlParameter e in sql.Parameters) {Response.Write(e.ParameterName + ": " + e.Value + " <" + e.DbType + ">\n");}
                adapter = new SqlDataAdapter(sql);
                adapter.Fill(ds);
                //foreach (SqlParameter e in sql.Parameters) {Response.Write(e.ParameterName + ": " + e.Value + " <" + e.DbType + ">\n");}

                expiry = Convert.ToInt32((sql.Parameters["@expirationDays"].Value as int?) ?? 0);

                //Response.Write("Convert.ToInt32(sql.Parameters["@expirationDays"].Value.ToString()) + " days\n");
                //Response.Write("subscription service level: " + Convert.ToString(sql.Parameters["@subscriptionLevel"].Value) + "\n");
                //Response.Write("error code: " + Convert.ToString(sql.Parameters["@errorCode"].Value) + "\n");
                //Response.Write("error message: " + sql.Parameters["@errorMessage"].Value + "\n");
                //Response.End();

                connection.Close();

                errorCode = (sql.Parameters["@errorCode"].Value as int?) ?? 0;
                errorMessage = ((errorCode >= 0) ? strings[errorCode] : null) ?? ("Error #" + errorCode);
                //warnings.Insert(warnings.Count, errorCode);
                if ((errorCode > 0) && !((user == "sample") && (request("password") == "password")))
                {
                    warnings.Insert(warnings.Count, "Login: " + strings[loginError] + " (" + user + " @ level " + sql.Parameters["@subscriptionLevel"].Value.ToString() + ")");
                    subscriptionServiceLevel = "None";
                }
                else
                {
                    warnings.Insert(warnings.Count, "Login: " + strings[0] + " (" + user + " @ level " + sql.Parameters["@subscriptionLevel"].Value.ToString() + ")");
                    subscriptionServiceLevel = subscriptionServiceLevels[Convert.ToInt32(((sql.Parameters["@subscriptionLevel"].Value as int?) ?? 0).ToString())];
                
                    if(4 == ContentType["subscription-type"])
                    {
                        connection = new SqlConnection(connectionString);
                        connection.Open();
                        sql = new SqlCommand("z2t_SingleState_Lookup", connection);

                        sql.CommandType = CommandType.StoredProcedure;

                        // using (sql.Parameters) {}
                        // - function to add
                        sql.Parameters.Add(new SqlParameter("@userName", SqlDbType.NVarChar, -1));
                        sql.Parameters["@userName"].Value = user;

                        sql.Parameters.Add(new SqlParameter("@password", SqlDbType.NVarChar, -1));
                        sql.Parameters["@password"].Value = request("password");

                        if(request("state").Length > 0)
                        {
                            sql.Parameters.Add(new SqlParameter("@state", SqlDbType.NVarChar, -1));
                            sql.Parameters["@state"].Value = request("state");
                        }
                        else
                        {
                            sql.Parameters.Add(new SqlParameter("@state", SqlDbType.NVarChar, -1));
                            sql.Parameters["@state"].Value = DBNull.Value;
                        }

                        if(request("zip").Length > 0)
                        {
                            sql.Parameters.Add(new SqlParameter("@zip", SqlDbType.NVarChar, -1));
                            sql.Parameters["@zip"].Value = zipBase;
                        }
                        else
                        {
                            sql.Parameters.Add(new SqlParameter("@zip", SqlDbType.NVarChar, -1));
                            sql.Parameters["@zip"].Value = DBNull.Value;
                        }

                         if(request("city").Length > 0)
                        {
                            sql.Parameters.Add(new SqlParameter("@city", SqlDbType.NVarChar, -1));
                            sql.Parameters["@city"].Value = request("city");
                        }
                        else
                        {
                            sql.Parameters.Add(new SqlParameter("@city", SqlDbType.NVarChar, -1));
                            sql.Parameters["@city"].Value = DBNull.Value;
                        }

                        sql.Parameters.Add(new SqlParameter("@errorCode", SqlDbType.Int)).Direction = ParameterDirection.Output;
                        sql.Parameters["@errorCode"].Value = DBNull.Value;

                        sql.Parameters.Add(new SqlParameter("@errorMessage", SqlDbType.NVarChar, -1)).Direction = ParameterDirection.Output;
                        sql.Parameters["@errorMessage"].Value = DBNull.Value;


                        //foreach (SqlParameter e in sql.Parameters) {Response.Write(e.ParameterName + ": " + e.Value + " <" + e.DbType + ">\n");}
                        adapter = new SqlDataAdapter(sql);
                        adapter.Fill(ds);

                        connection.Close();

                        errorCode = (sql.Parameters["@errorCode"].Value as int?) ?? 0;
                        errorMessage = sql.Parameters["@errorMessage"].Value.ToString();
                        //warnings.Insert(warnings.Count, errorCode);
                        if ((errorCode > 0))
                        {
                            warnings.Insert(warnings.Count, errorMessage);
                            subscriptionServiceLevel = "None";
                        }
                     }
                
                }
            }


            if (!(CheckZipIsNumeric(zipBase) && CheckZipIsNumeric(zip4))) subscriptionServiceLevel = "Unchecked";

            if ((subscriptionServiceLevel == "PinPoint"))
            {
                if (((request("addressLine1").Length > 0) &&
                    (request("city").Length > 0) &&
                    (request("state").Length > 0)) ||
                    ((request("addressLine1").Length > 0) &&
                    (request("zip").Length > 0)))
                {

                    // Final city name that would be passed to Stored Procedure
                    string finalCity = request("city"), finalZIP = request("zip"), finalAddressLine = request("addressLine1");
                    string finalState = request("state");

                    // Lookup Services for Google
                    string lookupAddress = request("addressLine1");
                    if (request("addressLine2") != null) { lookupAddress += request("addressLine2"); }
                    lookupAddress = (request("state") == "") ? lookupAddress += " " + request("zip") : lookupAddress += ", " + request("city") + ", " + request("state") + " " + request("zip");
                    WebRequest ajax = WebRequest.Create("http://maps.googleapis.com/maps/api/geocode/xml?address=" + lookupAddress + "&sensor=false");
                    ajax.Method = "get";

                    // Get the status code to see if Google is alive
                    var googleResponseData = (HttpWebResponse)ajax.GetResponse();
                    string googleStatusCode = googleResponseData.StatusCode.ToString();
                    if (googleStatusCode == "OK")
                    {
                        XPathNavigator geo = (new XPathDocument(((HttpWebResponse)ajax.GetResponse()).GetResponseStream())).CreateNavigator();
                        string innerXML = geo.InnerXml;
                        XElement xelement = XElement.Parse(innerXML);
                        string resolveStatus = xelement.Descendants("status").ElementAt(0).Value;
                        if (resolveStatus == "OK")
                        {
                            geoCoderName = "GeocoderAsGoogle";
                            XPathNodeIterator i = geo.Select("//lat");
                            i.MoveNext();

                            geocodeLatitude = i.Current.Value;
                            i = geo.Select("//lng");
                            i.MoveNext();
                            geocodeLongitude = i.Current.Value;

                            i = geo.Select("//address_component/long_name[../type[text() = 'locality']]");
                            i.MoveNext();
                            finalCity = (i.Count > 0) ? i.Current.Value : "";
                            // placeSource = (i.Count > 0) ? "g" : placeSource; // obsolete <2013-09-04 Wed nathan>

                            i = geo.Select("//address_component/short_name[../type[text() = 'administrative_area_level_1']]");
                            i.MoveNext();
                            string geocodeState = (i.Count > 0) ? i.Current.Value : "";
                            finalState = geocodeState; // when user just enters address and zipcode
                            // stateSource = "g";  // obsolete <2013-09-04 Wed nathan

                            if (finalCity == "")
                            {
                                // placeSource = "g";  // obsolete <2013-09-04 Wed nathan
                                i = geo.Select("//address_component/long_name[../type[text() = 'administrative_area_level_3']]");
                                i.MoveNext();
                                finalCity = (i.Count > 0) ? i.Current.Value : "";
                            }

                            if (finalCity == "") {
                              // placeSource = "i";  // obsolete <2013-09-04 Wed nathan
                              finalCity = request("city");
                            }

                            i = geo.Select("//address_component/short_name[../type[text() = 'route']]");
                            i.MoveNext();
                            string googleRoute = (i.Count > 0) ? i.Current.Value : ""; // to perform address correction on address(route)

                            i = geo.Select("//address_component/short_name[../type[text() = 'street_number']]");
                            i.MoveNext();
                            string googleStreetNo = (i.Count > 0) ? i.Current.Value : ""; // to validate the street number entered, if street nu not found, use user input

                            i = geo.Select("//address_component[./type[text() = 'postal_code']]/long_name");
                            i.MoveNext();
                            string googleZIP = (i.Count > 0) ? i.Current.Value : "";  // to get the zipcode when user enters address,city and state
                            finalZIP = googleZIP;
                            // zipCodeSource = "g";  // obsolete <2013-09-04 Wed nathan

                            string getStreetNo = "";
                            if (request("city") == "" && request("state") == "") // when Google comes back with a different zip for the same address
                            {
                                if (googleZIP == request("zip"))
                                {
                                    if (googleRoute != "")
                                    {
                                      // addressSource = "g";  // obsolete <2013-09-04 Wed nathan
                                        getStreetNo = Regex.Match(finalAddressLine, @"\d+").Value;
                                        finalAddressLine = getStreetNo + "" + googleRoute;
                                    }
                                }
                                else
                                {
                                    // zipCodeSource = "i";  // obsolete <2013-09-04 Wed nathan
                                    finalZIP = request("zip");

                                }
                            }

                            // Overwrite the user given address
                            if (googleRoute != "" && googleStreetNo != "") // Get address and street number from Google
                            {
                                // addressSource = "g";  // obsolete <2013-09-04 Wed nathan
                                finalAddressLine = googleStreetNo + " " + googleRoute;}
                            else if (googleRoute != "" && googleStreetNo == "") // If user street name is wrong but street number as expected by user
                            {
                                // addressSource = "g";  // obsolete <2013-09-04 Wed nathan
                                getStreetNo = Regex.Match(finalAddressLine, @"\d+").Value;
                                finalAddressLine = getStreetNo + " " + googleRoute;
                            }

                        }
                        else
                        {
                            // Lookup Services for Bing
                            string bingQueryString = "";
                            char[] trimChar = { '.', '*', '%', '!', '~', '@', '#','-' };// Added by Kanchan : Added - to trimchar
                            string bingState = request("state");
                            if (bingState != "")
                                bingQueryString = "/" + bingState.Trim(trimChar);
                            string bingzip = request("zip");
                            if (bingzip != "")
                                bingQueryString += "/" + bingzip.Trim(trimChar);
                            string bingCity = request("city");
                            if (bingCity != "")
                                bingQueryString += "/" + bingCity.Trim(trimChar);
                            string bingAddress = request("addressLine1");
                            // Trim special characters in Bing Address
                            if (bingAddress != "")
                                bingQueryString += "/" + bingAddress.Trim(trimChar);

                            // Place bing request for geocoding

                            string webRequestString = "http://dev.virtualearth.net/REST/v1/Locations/US" + bingQueryString + "?o=xml&key=AiFCxobALkHZa1FGO3_5bM6b0-NAdqxpaKVMi5U4OSK51O8B724TEFVLQJc4_1TQ#";
                            HttpWebRequest bingReq = (HttpWebRequest)WebRequest.Create(webRequestString) as HttpWebRequest;
                            // Get Bing Responses for Geocoding
                            HttpWebResponse bingResponse = bingReq.GetResponse() as HttpWebResponse;
                            // Process elements of Bing Response
                            XmlDocument xmlDoc = new XmlDocument();
                            xmlDoc.Load(bingResponse.GetResponseStream());
                            XmlNamespaceManager nsmgr = new XmlNamespaceManager(xmlDoc.NameTable);
                            nsmgr.AddNamespace("rest", "http://schemas.microsoft.com/search/local/ws/rest/v1");
                            XmlNodeList readStatus = xmlDoc.SelectNodes("//rest:StatusCode", nsmgr);
                            string bingStatusCode = "0";
                            foreach (XmlNode status in readStatus)
                            {
                                bingStatusCode = status.InnerText;
                            }
                            if (bingStatusCode == "200")
                            {

                                geoCoderName = " GeocoderAsBing";
                                XmlNodeList locationElements = xmlDoc.SelectNodes("//rest:Point", nsmgr);
                                XmlNodeList latitudePoint, longitudePoint;
                                string latitudeText, longitudeText;
                                foreach (XmlNode location in locationElements)
                                {
                                    latitudePoint = location.SelectNodes("//rest:Latitude", nsmgr);
                                    latitudeText = latitudePoint[0].InnerText;
                                    geocodeLatitude = latitudeText;
                                    longitudePoint = location.SelectNodes("//rest:Longitude", nsmgr);
                                    longitudeText = longitudePoint[0].InnerText;
                                    geocodeLongitude = longitudeText;
                                }
                                XmlNodeList addressElements = xmlDoc.SelectNodes("//rest:Address", nsmgr);
                                XmlNodeList localityList, zipCodeList, stateCodeList;
                                string localityValue, zipCodeValue;
                                foreach (XmlNode addressNode in addressElements)
                                {
                                    localityList = addressNode.SelectNodes("//rest:Locality", nsmgr);

                                    if (localityList.Count > 0)
                                    {
                                        // placeSource = "b";  // obsolete <2013-09-04 Wed nathan
                                        localityValue = localityList[0].InnerText;
                                        finalCity = localityValue;
                                    }
                                    zipCodeList = addressNode.SelectNodes("//rest:PostalCode", nsmgr);
                                    if (zipCodeList.Count > 0)
                                    {
                                        // zipCodeSource = "b";  // obsolete <2013-09-04 Wed nathan
                                        zipCodeValue = zipCodeList[0].InnerText;
                                        finalZIP = zipCodeValue;
                                    }
                                    stateCodeList = addressNode.SelectNodes("//rest:AdminDistrict", nsmgr);
                                    if (stateCodeList.Count > 0)
                                    {
                                        // stateSource = "b";  // obsolete <2013-09-04 Wed nathan
                                        finalState = stateCodeList[0].InnerText;
                                    }

                                }
                            }
                        }
                    }
                     string finalAddressLine2 = request("addressLine2"); // Kanchan : final address and parse method
                    finalAddressLine = parseSpecialCharacters(finalAddressLine);
                    finalAddressLine2 = parseSpecialCharacters(finalAddressLine2);

                    ds = new DataSet();
                    // fallback: use pinpoint
                    //  connection.Close();
                    connection = new SqlConnection(connectionString);
                    connection.Open();
                    sql = new SqlCommand("z2t_Pinpoint_Lookup", connection);

                    sql.CommandType = CommandType.StoredProcedure;

                    // using (sql.Parameters) {}
                    // - function to add
                    sql.Parameters.Add(new SqlParameter("@addressLine1", SqlDbType.NVarChar, -1));
                    sql.Parameters["@addressLine1"].Value = finalAddressLine;

                    sql.Parameters.Add(new SqlParameter("@addressLine2", SqlDbType.NVarChar, -1));
                    sql.Parameters["@addressLine2"].Value = finalAddressLine2;// Kanchan : final address and parse method

                    sql.Parameters.Add(new SqlParameter("@city", SqlDbType.NVarChar, -1));
                    sql.Parameters["@city"].Value = finalCity; //request("city")

                    sql.Parameters.Add(new SqlParameter("@state", SqlDbType.NVarChar, -1));
                    sql.Parameters["@state"].Value = finalState; // request("state");

                    sql.Parameters.Add(new SqlParameter("@zip", SqlDbType.NVarChar, -1));
                    sql.Parameters["@zip"].Value = finalZIP;

                    sql.Parameters.Add(new SqlParameter("@latitude", SqlDbType.Float));
                    sql.Parameters["@latitude"].Value = geocodeLatitude;

                    sql.Parameters.Add(new SqlParameter("@longitude", SqlDbType.Float));
                    sql.Parameters["@longitude"].Value = geocodeLongitude;

                    sql.Parameters.Add(new SqlParameter("@googleCity", SqlDbType.NVarChar, -1));
                    sql.Parameters["@googleCity"].Value = finalCity;

                    sql.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, -1));
                    sql.Parameters["@username"].Value = user;

                    sql.Parameters.Add(new SqlParameter("@errorCode", SqlDbType.Int)).Direction = ParameterDirection.Output;
                    sql.Parameters["@errorCode"].Value = DBNull.Value;

                    sql.Parameters.Add(new SqlParameter("@severity", SqlDbType.Int)).Direction = ParameterDirection.Output;
                    sql.Parameters["@severity"].Value = DBNull.Value;

                    sql.Parameters.Add(new SqlParameter("@errorMessage", SqlDbType.NVarChar, -1)).Direction = ParameterDirection.Output;
                    sql.Parameters["@errorMessage"].Value = DBNull.Value;


                    adapter = new SqlDataAdapter(sql);
                    // match element tag names to Steve's API

                    ITableMapping address = adapter.TableMappings.Add("Table", "address");
                    ITableMapping salestax = adapter.TableMappings.Add("Table1", "salesTax");
                    ITableMapping salestaxspecials = adapter.TableMappings.Add("Table2", "salesTaxSpecials");
                    ITableMapping usetax = adapter.TableMappings.Add("Table3", "useTax");
                    ITableMapping usetaxspecials = adapter.TableMappings.Add("Table4", "useTaxSpecials");
                    ITableMapping notes = adapter.TableMappings.Add("Table5", "note");

                    address.ColumnMappings.Add("ZipCode", "zipCode");
                    address.ColumnMappings.Add("AddressLine1", "addressLine1");
                    address.ColumnMappings.Add("AddressLine2", "addressLine2");
                    address.ColumnMappings.Add("City", "place");
                    address.ColumnMappings.Add("CountyName", "county");
                    address.ColumnMappings.Add("CountyFIPS", "countyFIPS");
                    address.ColumnMappings.Add("State", "state");
                    address.ColumnMappings.Add("StateSource", "stateSource");
                    address.ColumnMappings.Add("CountySource", "countySource");
                    address.ColumnMappings.Add("PlaceSource", "placeSource");
                    address.ColumnMappings.Add("AddressSource", "addressSource");
                    address.ColumnMappings.Add("ZipCodeSource", "zipCodeSource");
                    address.ColumnMappings.Add("LSAD", "lsad");

                    salestax.ColumnMappings.Add("SalesTaxRate", "taxRateTotal");
                    //salestax.ColumnMappings.Add("Shipping_Taxable", "isShippingTaxable"); // obsolete? <2013-03-16 Sat>
                    salestax.ColumnMappings.Add("SalesTaxRateState", "taxRateState");
                    salestax.ColumnMappings.Add("SalesTaxRateCounty", "taxRateCounty");
                    salestax.ColumnMappings.Add("SalesTaxRateCity", "taxRateCity");
                    salestax.ColumnMappings.Add("SalesTaxJurState", "authorityNameState");
                    salestax.ColumnMappings.Add("SalesTaxJurCounty", "authorityNameCounty");
                    salestax.ColumnMappings.Add("SalesTaxJurCity", "authorityNameCity");

                    salestaxspecials.ColumnMappings.Add("SpecialSalesTaxRate", "taxRateSpecial");
                    salestaxspecials.ColumnMappings.Add("SpecialDistrictName", "authorityNameSpecial");

                    usetax.ColumnMappings.Add("UseTaxRate", "taxRateTotal");
                    //usetax.ColumnMappings.Add("Shipping_Taxable", "isShippingTaxable");
                    usetax.ColumnMappings.Add("UseTaxRateState", "taxRateState");
                    usetax.ColumnMappings.Add("UseTaxRateCounty", "taxRateCounty");
                    usetax.ColumnMappings.Add("UseTaxRateCity", "taxRateCity");
                    //usetax.ColumnMappings.Add("UseTaxRateSpecial", "taxRateSpecial"); // obsolete? <2013-03-16 Sat>
                    usetax.ColumnMappings.Add("UseTaxJurState", "authorityNameState");
                    usetax.ColumnMappings.Add("UseTaxJurCounty", "authorityNameCounty");
                    usetax.ColumnMappings.Add("UseTaxJurCity", "authorityNameCity");
                    //usetax.ColumnMappings.Add("UseTaxJurSpecial", "authorityNameSpecial"); // obsolete? <2013-03-16 Sat>

                    usetaxspecials.ColumnMappings.Add("SpecialUseTaxRate", "taxRateSpecial");
                    usetaxspecials.ColumnMappings.Add("SpecialDistrictName", "authorityNameSpecial");

                    notes.ColumnMappings.Add("Jurisdiction", "jurisdiction");
                    notes.ColumnMappings.Add("Category", "category");
                    notes.ColumnMappings.Add("Note", "note");

                    ds.DataSetName = "z2tLookup";

                    adapter.Fill(ds);

                    connection.Close(); // added for load capability

                    errorCode = Convert.ToInt32(sql.Parameters["@errorCode"].Value.ToString());
                    errorMessage = ((errorCode < strings.Count) && (errorCode >= 0)) ? strings[errorCode] : ("Error #" + errorCode);

                    if (errorCode == 0)
                    {
                        if (user == "sample")
                        {
                            foreach (DataRow row in ds.Tables["address"].Rows)
                            {
                                string zs = (row["zipCode"].ToString() ?? "");
                                string[] zp = zs.Split(new char[] { '-' });
                                string zb = (zp.Length > 0) ? zp[0] : "";
                                string z4 = (zp.Length > 1) ? zp[1] : "";
                                int z = Convert.ToInt32(((zb.Length == 5) && ((z4.Length == 4) || (z4.Length == 0)) && (zp.Length < 3)) ? zb : "-1");
                                if ((z < 90001) || (z > 90999))
                                {
                                    row.Delete();
                                    /* should filter out sample blocks */
                                }
                            };


                            ds.Tables["address"].AcceptChanges();

                            if (ds.Tables["address"].Rows.Count == 0)
                            {
                                errorCode = 56;
                                //errorMessage = "Valid sample ZIP codes must fall in the range 90001 - 90999 (PinPoint resolution)";
                                errorMessage = getErrorMessage(errorCode);
                                ds.Tables["address"].Rows.Clear();
                                ds.Tables["note"].Rows.Clear();
                                warnings.Insert(warnings.Count, "Trial Lookup: " + errorMessage);
                                string addressString = request("addressLine1") + "/" + request("addressLine2") + "/" + request("city") + ", " + request("state") + " " + zipString;
                                warnings.Insert(warnings.Count, "Trial Lookup: The Address (" + addressString + ") is out of range");
                                subscriptionServiceLevel = "None";
                                addressResolution = "None";
                            }
                            else if (ds.Tables["salesTax"].Rows.Count == 0)
                            {
                                warnings.Insert(warnings.Count, "PinPoint Lookup: " + strings[10]);
                                zipString = ds.Tables["address"].Rows[0]["zipCode"].ToString();
                                subscriptionServiceLevel = "Zip+4";
                            }
                            else
                            {
                                warnings.Insert(warnings.Count, "PinPoint Lookup: " + strings[0]);
                                addressResolution = "PinPoint";
                            }

                        }
                        else if (ds.Tables["salesTax"].Rows.Count == 0)
                        {
                            warnings.Insert(warnings.Count, "PinPoint Lookup: " + strings[10]);
                            zipString = ds.Tables["address"].Rows[0]["zipCode"].ToString();
                            subscriptionServiceLevel = "Zip+4";
                        }
                            else if ((ds.Tables["address"].Rows.Count == 0))  // Added by kanchan :Added  code for empty address table
                        {
                            warnings.Insert(warnings.Count, "PinPoint Lookup: " + strings[6]);
                            zipString = request("zip");
                            if (request("zip") == "")
                                zipString = finalZIP;
                            subscriptionServiceLevel = "Zip+4";
                        }
                        else
                        {
                            warnings.Insert(warnings.Count, "PinPoint Lookup: " + strings[0]);
                            addressResolution = "PinPoint";
                        }
                    }
                    else
                    {
                        if (ds.Tables["address"].Rows.Count == 0)
                        {
                            zipString = request("zip");
                            if (request("zip") == "")
                                zipString = finalZIP;
                            warnings.Insert(warnings.Count, "PinPoint Lookup: " + errorMessage);
                            subscriptionServiceLevel = "Zip+4";
                            fallbacks.Insert(fallbacks.Count, "PinPoint");
                        }
                        else if (ds.Tables["address"].Columns.Contains("salesTax") && ds.Tables["salesTax"].Rows.Count == 0)
                        {
                            warnings.Insert(warnings.Count, "PinPoint Lookup: " + errorMessage);
                            // zipString = ds.Tables["address"].Rows[0]["zipCode"].ToString();
                            zipString = request("zip");
                            if (request("zip") == "")
                            {
                                zipString = finalZIP;
                            }
                            subscriptionServiceLevel = "Zip+4";
                            fallbacks.Insert(fallbacks.Count, "PinPoint");
                        }
                        else
                        {
                            zipString = request("zip");
                            if (request("zip") == "")
                            {
                                zipString = finalZIP;
                            }
                            warnings.Insert(warnings.Count, "PinPoint Lookup: " + errorMessage);
                            subscriptionServiceLevel = "Zip+4";
                            fallbacks.Insert(fallbacks.Count, "PinPoint");

                        }
                        ds.Clear();
                    }
                }
                else
                {
                    errorCode = 111;
                    dynamic hasAddressLine1 = (request("addressLine1") == "");
                    dynamic hasCity = (request("city") == "");
                    dynamic hasState = (request("state") == "");
                    dynamic hasAny = (hasAddressLine1 || hasCity || hasState);
                    //errorMessage = "Insufficient input to specify a tax jurisdiction" +
                    errorMessage = getErrorMessage(errorCode);
                    errorMessage = errorMessage +
                      (hasAny ? " (" : "") +
                      (hasAddressLine1 ? request("addressLine1") : "") +
                      ((hasAddressLine1 && hasCity) ? ", " : "") +
                      (hasCity ? request("city") : "") +
                      (((hasAddressLine1 || hasCity) && hasState) ? ", " : "") +
                      (hasState ? request("state") : "") +
                      (hasAny ? ")" : "");
                    warnings.Insert(warnings.Count, "PinPoint Lookup: " + errorMessage);
                    fallbacks.Insert(fallbacks.Count, "PinPoint");
                    subscriptionServiceLevel = "Zip+4";
                }
            }


            if ((subscriptionServiceLevel == "Zip+4"))
            {
                if (zipString.Length == 10)
                {
                    // fallback: use Zip+4
                    // connection.Close();
                    connection = new SqlConnection(connectionString);
                    connection.Open();


                    sql = new SqlCommand("z2t_Zip4_lookup", connection);
                    sql.CommandType = CommandType.StoredProcedure;

                    // using (sql.Parameters) {}
                    // - function to add

                    sql.Parameters.Add(new SqlParameter("@zip4", SqlDbType.NVarChar, -1));
                    sql.Parameters["@zip4"].Value = zipString;

                    sql.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, -1));
                    sql.Parameters["@username"].Value = user;

                    sql.Parameters.Add(new SqlParameter("@errorCode", SqlDbType.Int)).Direction = ParameterDirection.Output;
                    sql.Parameters["@errorCode"].Value = DBNull.Value;

                    sql.Parameters.Add(new SqlParameter("@severity", SqlDbType.Int)).Direction = ParameterDirection.Output;
                    sql.Parameters["@severity"].Value = DBNull.Value;

                    sql.Parameters.Add(new SqlParameter("@errorMessage", SqlDbType.NVarChar, -1)).Direction = ParameterDirection.Output;
                    sql.Parameters["@errorMessage"].Value = DBNull.Value;

                    adapter = new SqlDataAdapter(sql);

                    ITableMapping address = adapter.TableMappings.Add("Table", "address");
                    ITableMapping salestax = adapter.TableMappings.Add("Table1", "salesTax");
                    ITableMapping salestaxspecials = adapter.TableMappings.Add("Table2", "salesTaxSpecials");
                    ITableMapping usetax = adapter.TableMappings.Add("Table3", "useTax");
                    ITableMapping usetaxspecials = adapter.TableMappings.Add("Table4", "useTaxSpecials");
                    ITableMapping notes = adapter.TableMappings.Add("Table5", "note");

                    address.ColumnMappings.Add("ZipCode", "zipCode");
                    address.ColumnMappings.Add("AddressLine1", "addressLine1");
                    address.ColumnMappings.Add("AddressLine2", "addressLine2");
                    address.ColumnMappings.Add("City", "place");
                    address.ColumnMappings.Add("CountyName", "county");
                    address.ColumnMappings.Add("CountyFIPS", "countyFIPS");
                    address.ColumnMappings.Add("State", "state");
                    address.ColumnMappings.Add("StateSource", "stateSource");
                    address.ColumnMappings.Add("CountySource", "countySource");
                    address.ColumnMappings.Add("PlaceSource", "placeSource");
                    address.ColumnMappings.Add("ZipCodeSource", "zipCodeSource");
                    address.ColumnMappings.Add("AddressSource", "addressSource");
                    address.ColumnMappings.Add("LSAD", "lsad");


                    salestax.ColumnMappings.Add("SalesTaxRate", "taxRateTotal");
                   // salestax.ColumnMappings.Add("Shipping_Taxable", "isShippingTaxable"); // obsolete? <2013-03-16 Sat>
                    salestax.ColumnMappings.Add("SalesTaxRateState", "taxRateState");
                    salestax.ColumnMappings.Add("SalesTaxRateCounty", "taxRateCounty");
                    salestax.ColumnMappings.Add("SalesTaxRateCity", "taxRateCity");
                    salestax.ColumnMappings.Add("SalesTaxJurState", "authorityNameState");
                    salestax.ColumnMappings.Add("SalesTaxJurCounty", "authorityNameCounty");
                    salestax.ColumnMappings.Add("SalesTaxJurCity", "authorityNameCity");

                    salestaxspecials.ColumnMappings.Add("SpecialSalesTaxRate", "taxRateSpecial");
                    salestaxspecials.ColumnMappings.Add("SpecialDistrictName", "authorityNameSpecial");

                    usetax.ColumnMappings.Add("UseTaxRate", "taxRateTotal");
                   // usetax.ColumnMappings.Add("Shipping_Taxable", "isShippingTaxable"); // obsolete? <2013-03-16 Sat>
                    usetax.ColumnMappings.Add("UseTaxRateState", "taxRateState");
                    usetax.ColumnMappings.Add("UseTaxRateCounty", "taxRateCounty");
                    usetax.ColumnMappings.Add("UseTaxRateCity", "taxRateCity");
                    //usetax.ColumnMappings.Add("UseTaxRateSpecial", "taxRateSpecial"); // obsolete? <2013-03-16 Sat>
                    usetax.ColumnMappings.Add("UseTaxJurState", "authorityNameState");
                    usetax.ColumnMappings.Add("UseTaxJurCounty", "authorityNameCounty");
                    usetax.ColumnMappings.Add("UseTaxJurCity", "authorityNameCity");
                    //usetax.ColumnMappings.Add("UseTaxJurSpecial", "authorityNameSpecial"); // obsolete? <2013-03-16 Sat>

                    usetaxspecials.ColumnMappings.Add("SpecialUseTaxRate", "taxRateSpecial");
                    usetaxspecials.ColumnMappings.Add("SpecialDistrictName", "authorityNameSpecial");

                    notes.ColumnMappings.Add("Jurisdiction", "jurisdiction");
                    notes.ColumnMappings.Add("Category", "category");
                    notes.ColumnMappings.Add("Note", "note");

                    ds.DataSetName = "z2tLookup";

                    adapter.Fill(ds);

                    connection.Close(); // added for load capability
                    errorCode = Convert.ToInt32(sql.Parameters["@errorCode"].Value.ToString());
                    errorMessage = (errorCode < strings.Count) ? strings[errorCode] : ("Error #" + errorCode);
                    if (errorCode == 0)
                    {
                        warnings.Insert(warnings.Count, "Zip+4 Lookup: " + strings[0]);
                        addressResolution = "ZIP+4";
                        if (geocodeLatitude == "NA" || geocodeLongitude == "NA")
                        {
                            Tuple<string, string> latLong = getLatLongZip4(zipString);
                            geocodeLatitude = latLong.Item1;
                            geocodeLongitude = latLong.Item2;
                            geoCoderName = "zip_Standard";
                        }
                    }
                    else
                    {
                        zipString = (zipString.Length > 5) ? zipString.Substring(0, 5) : zipString;
                        warnings.Insert(warnings.Count, "Zip+4 Lookup: " + errorMessage);
                        subscriptionServiceLevel = "ZIP";
                        fallbacks.Insert(fallbacks.Count, "Zip+4");
                        ds.Clear();
                    }
                }
                else
                {
                    errorCode = 112;
                    //errorMessage = "Insufficient input to specify a tax jurisdiction" + (zipString == "" ? "" : " (" + zipString + ")");                 
                    errorMessage = getErrorMessage(errorCode) + (zipString == "" ? "" : " (" + zipString + ")");
                    warnings.Insert(warnings.Count, "Zip+4 Lookup: " + errorMessage);
                    fallbacks.Insert(fallbacks.Count, "Zip+4");
                    subscriptionServiceLevel = "ZIP";
                }
            }


            if (subscriptionServiceLevel == "ZIP")
            {
                if ((zipString.Length == 5) ||
                (zipString.Length == 10))
                {
                    // fallback: use ZIP
                    // connection.Close();
                    connection = new SqlConnection(connectionString);
                    connection.Open();
                    sql = new SqlCommand("z2t_Basic_Lookup", connection);
                    sql.CommandType = CommandType.StoredProcedure;

                    // using (sql.Parameters) {}
                    // - function to add

                    sql.Parameters.Add(new SqlParameter("@zip", SqlDbType.NVarChar, -1));
                    sql.Parameters["@zip"].Value = zipString.Substring(0, 5);

                    sql.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, -1));
                    sql.Parameters["@username"].Value = user;

                    sql.Parameters.Add(new SqlParameter("@errorCode", SqlDbType.Int)).Direction = ParameterDirection.Output;
                    sql.Parameters["@errorCode"].Value = DBNull.Value;

                    sql.Parameters.Add(new SqlParameter("@severity", SqlDbType.Int)).Direction = ParameterDirection.Output;
                    sql.Parameters["@severity"].Value = DBNull.Value;

                    sql.Parameters.Add(new SqlParameter("@errorMessage", SqlDbType.NVarChar, -1)).Direction = ParameterDirection.Output;
                    sql.Parameters["@errorMessage"].Value = DBNull.Value;

                    //sql.Parameters.Add(new SqlParameter("@retval", SqlDbType.Int)).Direction = ParameterDirection.ReturnValue;

                    adapter = new SqlDataAdapter(sql);

                    ITableMapping address = adapter.TableMappings.Add("Table", "address");
                    ITableMapping salestax = adapter.TableMappings.Add("Table1", "salesTax");
                    ITableMapping salestaxspecials = adapter.TableMappings.Add("Table2", "salesTaxSpecials");
                    ITableMapping usetax = adapter.TableMappings.Add("Table3", "useTax");
                    ITableMapping usetaxspecials = adapter.TableMappings.Add("Table4", "useTaxSpecials");
                    ITableMapping notes = adapter.TableMappings.Add("Table5", "note");

                    //address.ColumnMappings.Add("ZipCode", "zipCode");
                    address.ColumnMappings.Add("ZipCode", "zipCode");
                    address.ColumnMappings.Add("AddressLine1", "addressLine1");
                    address.ColumnMappings.Add("AddressLine2", "addressLine2");
                    address.ColumnMappings.Add("City", "place");
                    address.ColumnMappings.Add("CountyName", "county");
                    address.ColumnMappings.Add("CountyFIPS", "countyFIPS");
                    address.ColumnMappings.Add("State", "state");
                    address.ColumnMappings.Add("StateSource", "stateSource");
                    address.ColumnMappings.Add("CountySource", "countySource");
                    address.ColumnMappings.Add("PlaceSource", "placeSource");
                    address.ColumnMappings.Add("ZipCodeSource", "zipCodeSource");
                    address.ColumnMappings.Add("AddressSource", "addressSource");
                    address.ColumnMappings.Add("LSAD", "lsad");

                    salestax.ColumnMappings.Add("SalesTaxRate", "taxRateTotal");
                    //salestax.ColumnMappings.Add("Shipping_Taxable", "isShippingTaxable"); // obsolete? <2013-03-16 Sat>
                    salestax.ColumnMappings.Add("SalesTaxRateState", "taxRateState");
                    salestax.ColumnMappings.Add("SalesTaxRateCounty", "taxRateCounty");
                    salestax.ColumnMappings.Add("SalesTaxRateCity", "taxRateCity");
                    salestax.ColumnMappings.Add("SalesTaxJurState", "authorityNameState");
                    salestax.ColumnMappings.Add("SalesTaxJurCounty", "authorityNameCounty");
                    salestax.ColumnMappings.Add("SalesTaxJurCity", "authorityNameCity");

                    salestaxspecials.ColumnMappings.Add("SpecialSalesTaxRate", "taxRateSpecial");
                    salestaxspecials.ColumnMappings.Add("SpecialDistrictName", "authorityNameSpecial");

                    usetax.ColumnMappings.Add("UseTaxRate", "taxRateTotal");
                   // usetax.ColumnMappings.Add("Shipping_Taxable", "isShippingTaxable"); // obsolete? <2013-03-16 Sat>
                    usetax.ColumnMappings.Add("UseTaxRateState", "taxRateState");
                    usetax.ColumnMappings.Add("UseTaxRateCounty", "taxRateCounty");
                    usetax.ColumnMappings.Add("UseTaxRateCity", "taxRateCity");
                    //usetax.ColumnMappings.Add("UseTaxRateSpecial", "taxRateSpecial"); // obsolete? <2013-03-16 Sat>
                    usetax.ColumnMappings.Add("UseTaxJurState", "authorityNameState");
                    usetax.ColumnMappings.Add("UseTaxJurCounty", "authorityNameCounty");
                    usetax.ColumnMappings.Add("UseTaxJurCity", "authorityNameCity");
                    //usetax.ColumnMappings.Add("UseTaxJurSpecial", "authorityNameSpecial"); // obsolete? <2013-03-16 Sat>

                    usetaxspecials.ColumnMappings.Add("SpecialUseTaxRate", "taxRateSpecial");
                    usetaxspecials.ColumnMappings.Add("SpecialDistrictName", "authorityNameSpecial");

                    notes.ColumnMappings.Add("Jurisdiction", "jurisdiction");
                    notes.ColumnMappings.Add("Category", "category");
                    notes.ColumnMappings.Add("Note", "note");

                    ds.DataSetName = "z2tLookup";
                    adapter.Fill(ds);

                    connection.Close(); // added for load capability


                    errorCode = Convert.ToInt32(sql.Parameters["@errorCode"].Value.ToString());
                    //errorCode = (errorCode < 0) ? Math.Abs(Convert.ToInt32(sql.Parameters["@errorCode"].Value.ToString())) : 0;
                    errorMessage = (errorCode < strings.Count) ? strings[errorCode] : ("Error #" + errorCode);
                    if (errorCode == 0)
                    {
                        addressResolution = "ZIP code";
                        warnings.Insert(warnings.Count, "ZIP Lookup: " + strings[0]);
                        if (geocodeLatitude == "NA" || geocodeLongitude == "NA")
                        {
                            Tuple<string, string> latLong = getLatLongZip(zipString);
                            geocodeLatitude = latLong.Item1;
                            geocodeLongitude = latLong.Item2;
                            geoCoderName = "zip_Standard";
                        }
                    }
                    else
                    {
                        warnings.Insert(warnings.Count, "ZIP Lookup: " + errorMessage);
                        subscriptionServiceLevel = "None";
                    }
                }
                else
                {
                    errorCode = 113;
                    errorMessage = "Insufficient input to specify a tax jurisdiction" + " (" + zipString + ")";
                    warnings.Insert(warnings.Count, "ZIP Lookup: " + errorMessage);
                }
            }

            if (subscriptionServiceLevel == "Unchecked")
            {
                errorCode = 100;
                errorMessage = "Invalid ZIP code " + ((request("zip") == "") ? "" : ("(" + request("zip") + ")"));
                warnings.Insert(warnings.Count, "Input: " + errorMessage);
                subscriptionServiceLevel = "None";
                addressResolution = "None";
            }

            //}}}
            //}
            //Execute your command


            // restrict sample data
            //if ds.

            // hierarchize dataset

            // jsonify accumulated warnings
            if (expiry <= 0)
            {
                urgentMessages.Insert(urgentMessages.Count, "Your subscription has expired.");
                passiveMessages.Insert(passiveMessages.Count, "Your subscription has expired.");
            }
            else if (expiry == 1)
            {
                urgentMessages.Insert(urgentMessages.Count, "Your subscription will expire tomorrow.");
                passiveMessages.Insert(passiveMessages.Count, "Your subscription will expire tomorrow.");
            }
            else if (expiry < 10)
            {
                urgentMessages.Insert(urgentMessages.Count, "Your subscription will expire in " + expiry.ToString() + " days.");
                passiveMessages.Insert(passiveMessages.Count, "Your subscription will expire in " + expiry.ToString() + " days.");
            }
            else if (expiry < 31) { passiveMessages.Insert(passiveMessages.Count, "Your subscription will expire in " + expiry.ToString() + " days."); }

            bool plurality = (fallbacks.Count == 1);
            if (fallbacks.Count > 0)
            {
                passiveMessages.Insert(passiveMessages.Count, String.Join(" &amp; ", fallbacks) + " " + (plurality ? "lookup was" : "lookups were") + " not possible with the inputs you entered." + ((addressResolution == "None") ? "" : " Using " + addressResolution + " level lookup as best alternative."));
            }

            bool useTax = true;
            string delimiter = "";
            string jsonWarnings = "";
            warnings.ForEach(delegate(String e)
            {
                jsonWarnings += delimiter + (@"{""warning"": """ + e.Trim() + @"""}");
                delimiter = ",\n      ";
            });
            string xmlWarnings = "";
            warnings.ForEach(delegate(String e)
            {
                xmlWarnings += (@"<xsl:element name='warning'><xsl:text>" + e.Trim() + @"</xsl:text></xsl:element>");
            });

            urgentMessage = "{\"message\": \"" + String.Join("\"},\n      {\"message\": \"", urgentMessages) + "\"}";
            passiveMessage = "{\"message\": \"" + String.Join("\"},\n      {\"message\": \"", passiveMessages) + "\"}";

            //    StringWriter xml; =
            //xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(ds.GetXml()))), null, xml = new StringWriter());
            ////    xsl.Load(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes())));
            //////    xsl.Transform(XmlReader.Create(new MemoryStream(Encoding.UTF8.GetBytes(ds.GetXml()))), null, xml = new StringWriter());
            //xsl.Transform(XmlReader.Create(xml), null, xml = new StringWriter());
            //Response.Write(xml.ToString());

            //Changes SM - May'14 - change to record ending timestamp
            stopWatch.Stop();
            TimeSpan timeSpan = stopWatch.Elapsed;
            string elapsedTime = String.Format("{0:00}:{1:00}.{2:00}",  timeSpan.Minutes, timeSpan.Seconds,   timeSpan.Milliseconds / 10);

            String timeStampEnd = GetTimestamp(DateTime.Now);
           
			
			string query = @"select @@ServerName as dual";
			
			SqlCommand sqlCommand = new SqlCommand(query, connection);
			connection.Open();
            SqlDataAdapter dbad = new SqlDataAdapter(sqlCommand);
			//sqlCommand.CommandType = sqlCommandType;
			
			DataTable dt3=new DataTable();
            dbad.Fill(dt3);
			string tmp_name = "";
			using (SqlDataReader reader = sqlCommand.ExecuteReader())
			{
				while (reader.Read())
				{
					tmp_name = Convert.ToString(reader["dual"]);
				}
			}
			connection.Close();
         

            Response.Write(fn(ds.GetXml(), new Dictionary<dynamic, dynamic>(){
              // xsltArgs
              {"errorCode", errorCode},
              {"errorMessage", errorMessage},
              {"elapsedTime",elapsedTime},
              {"startTime",timeStampStart},
              {"endTime",timeStampEnd},
              {"localhost",tmp_name},
              {"version",version},
              {"jsonWarnings", jsonWarnings},
              {"xmlWarnings", xmlWarnings},
              {"passiveMessage", passiveMessage},
              {"urgentMessage", urgentMessage},
              {"addressResolution", addressResolution},
              {"latitude", geocodeLatitude},
              {"longitude", geocodeLongitude},
              {"useTax", useTax},
              {"subscriptionServiceLevel", subscriptionServiceLevel}

/*  // obsolete <2013-09-04 Wed nathan
              ,
              {"placeSource", placeSource},
              {"stateSource", stateSource},
              {"countySource", countySource},
              {"addressSource", addressSource},
              {"zipCodeSource", zipCodeSource}
*/
              }));

            string executionType = context.Request.CurrentExecutionFilePathExtension;
            char[] trimType = { '.' };
            string stripExecutionType = executionType.Trim(trimType);

            string tmp_addressLogString = "";
             if(request("addressLine1").Length > 0)
             {
                 tmp_addressLogString = tmp_addressLogString + "<Address: " + request("addressLine1");

                 if(request("addressLine2").Length > 0)
                 {
                     tmp_addressLogString = tmp_addressLogString +  " " + request("addressLine2") + ">";
                 }
                 else
                 {
                     tmp_addressLogString = tmp_addressLogString + ">";
                 }
             }

             

             if(request("city").Length > 0)
             {
                 tmp_addressLogString = tmp_addressLogString +  "<City: " + request("city") + ">";
             }

             if(request("state").Length > 0)
             {
                 tmp_addressLogString = tmp_addressLogString +  "<State: " + request("state") + ">";
             }

             if(zipString.Length > 0)
             {
                 tmp_addressLogString = tmp_addressLogString +  "<Zip: " + zipString + ">";
             }

             tmp_addressLogString = tmp_addressLogString + "<ElapsedTime: " + elapsedTime + ">";

            //Response.Write(ds.GetXml()); // debug
            LogActivity(user, errorCode + ": " + errorMessage, stripExecutionType, tmp_addressLogString, context.Request.ServerVariables["URL"], context.Request.ServerVariables["HTTP_REFERER"] ?? "", context.Request.ServerVariables["REMOTE_ADDR"], geoCoderName, addressResolution, errorCode);

        }
/*
        catch (Exception e)
        {
            //Show the exception in the format whatever the user has requested
            HttpResponse Response = context.Response;
            Response.Clear();
            Response.ContentType = "text/plain";

            // Get stack trace for the exception with source file information
            var st = new StackTrace(e, true);
            string exceptionInfo = st.ToString();
            // Get the top stack frame
            var frame = st.GetFrame(0);
            // Get the line number from the stack frame
            var line = frame.GetFileLineNumber();

            sendEmail(new Object[] { context.Request.ServerVariables["REMOTE_ADDR"], HttpContext.Current.Request.Url.AbsoluteUri });

            string contentType = context.Request.ServerVariables["URL"].Split(new String[] { "." }, StringSplitOptions.None).Last();
            if (contentType.Equals("xml") || contentType.Equals("raw"))
            {
                Response.ContentType = "application/xml";
                Response.Write("<z2tLookup><errorCode>500</errorCode><errorInfo>Internal Error</errorInfo></z2tLookup>");
            }
            else if (contentType.Equals("json"))
            {
                Response.ContentType = "application/json";
                Response.Write("{ \"z2tLookup\": { \"errorCode\":\"500\",\"errorInfo\": \"Internal Error\" } }");
            }
            else if (contentType.Equals("web"))
            {
                Response.ContentType = "application/json";
                Response.Write("{\"z2tLookup\": {\"errorInfo\": {\"errorCode\":\"500\",\"passiveMessages\": { \"message\": \"" + e.Message + "\" }, \"urgentMessages\": { \"message\": \"" + e.Message + "\" }}}}");
            }
            else if (contentType.Equals("webxml"))
            {
                Response.ContentType = "application/xml";
                Response.Write("<z2tLookup><errorCode>500</errorCode><errorInfo>Internal Error</errorInfo><passiveMessage>" + e.Message + "</passiveMessage><exceptionInfo>" + exceptionInfo + "</exceptionInfo></z2tLookup>");
            }
            else if (contentType.Equals("widget"))
            {
                Response.ContentType = "application/json";
                Response.Write("{\"z2tLookup\": {\"errorInfo\": {\"errorCode\":\"500\",\"passiveMessages\": { \"message\": \"" + e.Message + "\" }, \"urgentMessages\": { \"message\": \"" + e.Message + "\" }}}}");
            }
            else if (contentType.Equals("widgetlogin"))
            {
                Response.ContentType = "application/json";
                Response.Write("{\"z2tLookup\": {\"errorInfo\": {\"errorCode\":\"500\",\"passiveMessages\": { \"message\": \"" + e.Message + "\" }, \"urgentMessages\": { \"message\": \"" + e.Message + "\" }}}}");
            }

        }
*/
    }

    //CheckZipIsNumeric returns false if any element of string type variable passed is not in 0-9
    bool CheckZipIsNumeric(string inputZip)
    {
        foreach (char element in inputZip)
        {
            if (element < '0' || element > '9')
                return false;
        }

        return true;
    }

        private string parseSpecialCharacters(string addressline) // Kanchan : final address and parse method
    {
        StringBuilder finaladdressline = new StringBuilder();
        foreach (char each_Character in addressline)
        {
            if (Char.IsLetterOrDigit(each_Character) || each_Character==' ')
            { finaladdressline.Append(each_Character); }
        }

        return finaladdressline.ToString();
    }
    //returns NA when unable to connect to sql else returns value of latitude and longitude from table z2t_zipstandard using SP z2t_ZipStandard_Lookup
    private Tuple<string, string> getLatLongZip(string zipString)
    {
        zipString = (zipString.Length > 5) ? zipString.Substring(0, 5) : zipString;
        string ConnectionString = "Initial Catalog=z2t_Zip4;Data Source=localhost;User ID=z2t_PinPoint_User;Password=get2PinPoint";
        using (SqlConnection sqlconn = new SqlConnection(ConnectionString))
        {
            sqlconn.Open();
            using (SqlCommand command = new SqlCommand("z2t_ZipStandard_Lookup", sqlconn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@zipinput", SqlDbType.Int));
                command.Parameters["@zipinput"].Value = Convert.ToInt32(zipString);


                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string Latitude = Convert.ToString(reader["Latitude"]);
                        string Longitude = Convert.ToString(reader["Longitude"]);
                        return new Tuple<string, string>(Latitude, Longitude);
                    }
                }
            }
            sqlconn.Close();
        }
        return new Tuple<string, string>("NA", "NA");
    }



    //returns NA when unable to connect to sql else returns value of to/fromlatitude and to/fromlongitude using SP z2t_Zip4G_Lookup and takes average of the same.
    private Tuple<string, string> getLatLongZip4(string zipString)
    {
       string ConnectionString = "Initial Catalog=z2t_Zip4;Data Source=localhost;User ID=z2t_PinPoint_User;Password=get2PinPoint";
        using (SqlConnection sqlconn = new SqlConnection(ConnectionString))
        {
            string[] splitZip = zipString.Split('-');
            sqlconn.Open();
            using (SqlCommand command = new SqlCommand("z2t_Zip4G_Lookup", sqlconn))
            {

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@zipInput", SqlDbType.NVarChar));
                command.Parameters["@zipinput"].Value = splitZip[0];
                command.Parameters.Add(new SqlParameter("@zip4Input", SqlDbType.NVarChar));
                command.Parameters["@zip4input"].Value = splitZip[1];
                using (SqlDataReader reader = command.ExecuteReader())
                    while (reader.Read())
                    {
                        //Changes SM - May'14 - chnaging FromLatitude -> toLatitude, as of now it was only taking avg of fromlatitude
                        //List<double> latitudes = new List<double> { Convert.ToDouble(reader["FromLatitude"]), Convert.ToDouble(reader["FromLatitude"]) };
                        List<double> latitudes = new List<double> { Convert.ToDouble(reader["FromLatitude"]), Convert.ToDouble(reader["ToLatitude"]) };
                        List<double> longitudes = new List<double> { Convert.ToDouble(reader["FromLongitude"]), Convert.ToDouble(reader["ToLongitude"]) };
                        string latitudeAverage = latitudes.Average().ToString();
                        string longitudeAverage = latitudes.Average().ToString();
                        if ((latitudes.Average() == 0.0) || (longitudes.Average() == 0.0))
                        {
                            Tuple<string, string> latLong = getLatLongZip(zipString);
                            return new Tuple<string, string>(latLong.Item1, latLong.Item2);
                        }
                        else
                            return new Tuple<string, string>(latitudes.Average().ToString(), longitudes.Average().ToString());
                    }
            }

        }
        return new Tuple<string, string>("NA", "NA");
    }




    //sends email regarding any error, as of may 2014 the call is commented
    private bool sendEmail(Object[] args)
    {
        SqlConnection conn = null;
        string emailConnectionString = "Initial Catalog= ha_prod; Data Source=barley1.harvestamerican.net;User ID=davewj2o;Password=get2it";
        DateTime eastern = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(DateTime.UtcNow, "Eastern Standard Time");
        string bodyMessage = "Hi Guys," + System.Environment.NewLine + System.Environment.NewLine + "Our system  " + System.Net.Dns.GetHostName() + "  has experienced a technical difficulty in processing the request " + args[1] + "  from our client with IP address " + args[0] + "  at " + eastern + " EST";
        conn = new SqlConnection(emailConnectionString);
        conn.Open();
        SqlCommand cmd = new SqlCommand("ha_prod.dbo.util_SendMail", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@From", "info@zip2tax.com"));
        cmd.Parameters.Add(new SqlParameter("@To", "angel@harvestamerican.com"));
        cmd.Parameters.Add(new SqlParameter("@CC", "nathan@harvestamerican.com"));
        cmd.Parameters.Add(new SqlParameter("@Subject", "Pinpoint-API technical difficulty at " + System.Net.Dns.GetHostName()));
        cmd.Parameters.Add(new SqlParameter("@Body", bodyMessage));
        var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
        returnParameter.Direction = ParameterDirection.ReturnValue;
/* // sendmail is disabled for <2013-09-03 Tue nathan> testing
        cmd.ExecuteNonQuery();
*/
        var emailStatus = returnParameter.Value;
        conn.Close();
        return true;
    }

    /* sql(query, parameter...) allows using SqlParameter objects, without the horrible syntax. */

    static private CommandType sqlCommandType = CommandType.StoredProcedure; //CommandType.Text; //CommandType.TableDirect

    //this method queries the given SP with argument list passed in args 
    private DataSet sqlAt(String query, Object[] args, String connectionString = null)
    {
        SqlConnection connection = new SqlConnection((connectionString == null) ? defaultConnectionString : connectionString);
        SqlCommand sqlCommand = new SqlCommand(query, connection);
        connection.Open();
        sqlCommand.CommandType = sqlCommandType;
        List<List<Object>> pairs = new List<List<Object>>();
        for (int name = 0, value = 1; value < args.Length; name += 2, value += 2)
        {
            pairs.Add(new List<Object> { args[name], args[value] });
        }
        pairs.ForEach(delegate(List<Object> e)
        {
            sqlCommand.Parameters.Add(new SqlParameter("@" + e[0], e[1]));
        });
        DataSet ds = Fill(sqlCommand);
        connection.Close();
        return ds;
    }


    //this method a has call to sqlat function
    private DataSet sql(String query, params Object[] args)
    {
        return sqlAt(query, args);
    }


    private DataSet Fill(SqlCommand sql)
    {
        DataSet ds = new DataSet();
        new SqlDataAdapter(sql).Fill(ds);
        return ds;
    }

    /* end sql */


    private void LogActivity(String user, String error, String contenttype, String addressLogString, String url, String referrer, String ip, String geocoderName, String addressResolution, int errorCode)
    {
        string hostName = System.Net.Dns.GetHostName();
        dynamic method = new Dictionary<dynamic, dynamic>(){
          {"web", new Dictionary<dynamic, dynamic>(){{"type", 4}, {"device", "Web"}, {"interface", "Online"}}},
          {"json", new Dictionary<dynamic, dynamic>(){{"type", 4}, {"device", "Link"}, {"interface", "Database Interface"}}},
          {"xml",  new Dictionary<dynamic, dynamic>(){{"type", 4}, {"device", "Link"}, {"interface", "Database Interface"}}},
          {"raw",  new Dictionary<dynamic, dynamic>(){{"type", 30}, {"device", "Test"}, {"interface", "Raw"}}},
          {"widget", new Dictionary<dynamic,dynamic>(){{"type", 4}, {"device", "Widget"}, {"interface", "Widget"}}},
          {"widgetlogin", new Dictionary<dynamic, dynamic>(){{"type", 2}, {"device", "Widget"},{"interface", "Widget"}}},
          {"webxml", new Dictionary<dynamic, dynamic>(){{"type", 4}, {"device", "Web"}, {"interface", "Online"}}}};

        sqlAt("z2t_Zip4.dbo.z2t_log_API", new Object[]{
          "user", user,
          "type", 4,
          "activityType", addressResolution,
          "data1", error,
          "data2", addressLogString,
          "pageurl", url,
          "refurl", referrer,
          "searchengine", "",
          "searchtype", "",
          "searchkeywords", "",
          "sessionid", "", //context.Session.SessionID
          "cookieid", "", //context.Session["CookieID"]
          "remotehost", "",
          "nameserver", hostName,
          "namedatabase", "z2t_Zip4",
          "nameinterface", method[contenttype]["interface"] ?? "Unknown",
          "namedevice", (url == "/TaxRate-USA.xml") ? "Request" : method[contenttype]["device"],
          "nameservice", addressResolution,
          "errorcode", Convert.ToString(errorCode),
          "createdbyip", ip,
          "createdby", "api:" + geocoderName},
          defaultConnectionString);
        return;
    }





    public String webXSLT(Dictionary<dynamic, dynamic> xsltArgs)
    {
        return
      @"<?xml version='1.0' encoding='iso-8859-1' ?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
<xsl:output method='text' media-type='text/plain' omit-xml-declaration='yes' doctype-public='text/plain' doctype-system='text/plain'/>
<xsl:strip-space elements='*'/>
<xsl:preserve-space elements='xsl:text'/>
  <xsl:template match='/z2tLookup'>
   <xsl:text>{""z2tLookup"": {
  ""errorInfo"": {
    ""errorCode"": """ + xsltArgs["errorCode"] + @""",
    ""errorMessage"": """ + xsltArgs["errorMessage"] + @""",
    ""elapsedTime"": """ + xsltArgs["elapsedTime"] + @""",
    ""startTime"": """ + xsltArgs["startTime"] + @""",
    ""endTime"": """ + xsltArgs["endTime"] + @""",
    ""ServerName"": """ + xsltArgs["localhost"] + @""",
    ""Version"": """ + xsltArgs["version"] + @""",
    ""warnings"": [
      " + xsltArgs["jsonWarnings"] + @"],
    ""passiveMessages"": [
      " + xsltArgs["passiveMessage"] + @"],
    ""urgentMessages"": [
      " + xsltArgs["urgentMessage"] + @"]},
  ""addressInfo"": {
    ""addressResolution"": """ + xsltArgs["addressResolution"] + @""",
    ""addresses"": [</xsl:text>
    <xsl:apply-templates select='address'/><xsl:text>]}}}</xsl:text>
  </xsl:template>

  <xsl:template match='warning'>
    <xsl:element name='{name()}'>
        <xsl:value-of select='normalize-space(.)'/>
    </xsl:element>
  </xsl:template>

  <xsl:template match='address'><xsl:variable name='id' select='ID'/><xsl:choose><xsl:when test='position() &gt; 1'><xsl:text>,</xsl:text></xsl:when></xsl:choose><xsl:text>
      {""address"": {
        ""addressSource"": ""</xsl:text><xsl:value-of select='addressSource'/><xsl:text>"",</xsl:text>
        <xsl:apply-templates select='zipCode|addressLine1|addressLine2|place|county|state'/><xsl:text>,
        ""lsad"": ""</xsl:text><xsl:value-of select='lsad'/><xsl:text>"",
        ""Latitude"": """ + xsltArgs["latitude"] + @""",
        ""Longitude"": """ + xsltArgs["longitude"] + @"""</xsl:text>
    <xsl:apply-templates select='//salesTax[ID=$id]|//useTax[ID=$id]'/><xsl:text>,
        ""notes"": [</xsl:text>
       <xsl:apply-templates select='/z2tLookup/note[ID=$id]'/><xsl:text>]}}</xsl:text>
  </xsl:template>

  <xsl:template match='salesTax|useTax'><xsl:variable name='id' select='ID'/><xsl:variable name='taxtype' select='name()'/><xsl:text>,
        ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": {
          ""rateInfo"": {</xsl:text>
         <xsl:apply-templates select='isShippingTaxable|taxRateTotal'/>
   <xsl:text>          ""rateDetails"": [</xsl:text><xsl:apply-templates select=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))]""/><xsl:choose><xsl:when test=""boolean(./*[starts-with(name(), 'taxRate')]) and boolean(/z2tLookup/*[name() = concat($taxtype, 'Specials')]/*[starts-with(name(), 'taxRate')][ID=$id])""><xsl:text>,</xsl:text></xsl:when></xsl:choose>
   <xsl:apply-templates select='//salesTaxSpecials[starts-with(name(), $taxtype)]|//useTaxSpecials[starts-with(name(), $taxtype)]'><xsl:with-param name='id-special' select='$id'/></xsl:apply-templates><xsl:text>]}}</xsl:text>
  </xsl:template>

  <xsl:template match='z2tLookup/note'><xsl:choose><xsl:when test='position() &gt; 1'><xsl:text>,</xsl:text></xsl:when></xsl:choose><xsl:text>
          {""noteDetail"": {</xsl:text>
        <xsl:for-each select='./jurisdiction|./category|./note'><xsl:text>
            ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
        </xsl:for-each>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <xsl:template match='z2tLookup/note'><xsl:choose><xsl:when test='position() &gt; 1'><xsl:text>,</xsl:text></xsl:when></xsl:choose><xsl:text>
          {""noteDetail"": {</xsl:text>
        <xsl:for-each select='./jurisdiction|./category|./note'><xsl:text>
            ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
        </xsl:for-each>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <xsl:template match='salesTaxSpecials|useTaxSpecials'><xsl:param name='id-special'/><xsl:variable name='id' select='ID'/><xsl:apply-templates select=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))][$id-special=$id]""><xsl:with-param name='id-special' select='$id-special'/></xsl:apply-templates>
    <!--  <xsl:choose><xsl:when test='position() != last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>  (obsolete 2013-09-12 Thu)-->
  </xsl:template>


  <xsl:template match='zipCode'><xsl:text>
        ""</xsl:text><xsl:value-of select='name()'/>Source<xsl:text>"": ""</xsl:text><xsl:value-of select='../zipCodeSource'/><xsl:text>"",
        ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
  </xsl:template>

  <xsl:template match='addressLine1|addressLine2'><xsl:text>
        ""</xsl:text><xsl:value-of select='name()'/>Source<xsl:text>"": ""</xsl:text><xsl:value-of select='../addressSource'/><xsl:text>"",
        ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
  </xsl:template>

  <xsl:template match='place'><xsl:text>
        ""</xsl:text><xsl:value-of select='name()'/>Source<xsl:text>"": ""</xsl:text><xsl:value-of select='../placeSource'/><xsl:text>"",
        ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
  </xsl:template>

  <xsl:template match='county'><xsl:text>
        ""</xsl:text><xsl:value-of select='name()'/>Source<xsl:text>"": ""</xsl:text><xsl:value-of select='../countySource'/><xsl:text>"",
        ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
  </xsl:template>

  <xsl:template match='state'><xsl:text>
        ""</xsl:text><xsl:value-of select='name()'/>Source<xsl:text>"": ""</xsl:text><xsl:value-of select='../stateSource'/><xsl:text>"",
        ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
  </xsl:template>

  <xsl:template match='isShippingTaxable'><xsl:text>
        ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
  </xsl:template>

  <xsl:template match='taxRateTotal'><xsl:text>
            ""</xsl:text><xsl:text>taxRate</xsl:text><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>"",
  </xsl:text>
  </xsl:template>

  <xsl:template match=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))]"">
    <xsl:param name='id-special'/>
    <xsl:choose><xsl:when test='$id-special=../ID or not(contains(name(), ""Special""))'>
      <xsl:variable name='jurisdictionlevel' select=""substring-after(name(), 'taxRate')""/>
      <xsl:choose><xsl:when test='position() &gt; 1 or contains(name(), ""Special"")'><xsl:text>,</xsl:text></xsl:when></xsl:choose><xsl:text>
              {""rateDetail"": {
                ""jurisdictionLevel"": ""</xsl:text><xsl:value-of select='$jurisdictionlevel'/><xsl:text>"",
                ""jurisdictionCode"":""</xsl:text><xsl:value-of select=""../*[(starts-with(name(), 'JurCode')) and (substring-after(name(), 'JurCode') = $jurisdictionlevel)]""/><xsl:text>"",
                ""taxRate"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>"",
                ""authorityName"": ""</xsl:text><xsl:value-of select=""../*[(starts-with(name(), 'authorityName')) and (substring-after(name(), 'authorityName') = $jurisdictionlevel)]""/><xsl:text>""}}</xsl:text>
    </xsl:when></xsl:choose>
  </xsl:template>
</xsl:stylesheet>";
    }


    public String jsonXSLT(Dictionary<dynamic, dynamic> xsltArgs)
    {
        return
          @"<?xml version='1.0' encoding='iso-8859-1' ?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
<xsl:output method='text' media-type='text/plain' omit-xml-declaration='yes' doctype-public='text/plain' doctype-system='text/plain'/>
<xsl:strip-space elements='*'/>
<xsl:preserve-space elements='xsl:text'/>
  <xsl:template match='/z2tLookup'>
   <xsl:text>{""z2tLookup"": {
  ""errorInfo"": {
    ""errorCode"": """ + xsltArgs["errorCode"] + @""",
    ""errorMessage"": """ + xsltArgs["errorMessage"] + @""",
    ""elapsedTime"": """ + xsltArgs["elapsedTime"] + @""",
    ""startTime"": """ + xsltArgs["startTime"] + @""",
    ""endTime"": """ + xsltArgs["endTime"] + @""",
    ""ServerName"": """ + xsltArgs["localhost"] + @""",
    ""Version"": """ + xsltArgs["version"] + @""",
    ""warnings"": [
      </xsl:text>" +
            xsltArgs["jsonWarnings"] + @"<xsl:text>]},
  ""addressInfo"": {
    ""addressResolution"": """ + xsltArgs["subscriptionServiceLevel"] + @""",
    ""addresses"": [</xsl:text>
    <xsl:apply-templates select='address'/><xsl:text>]}}}</xsl:text>
  </xsl:template>

  <xsl:template match='warning'>
    <xsl:element name='{name()}'>
        <xsl:value-of select='normalize-space(.)'/>
    </xsl:element>
  </xsl:template>

  <xsl:template match='address'><xsl:variable name='id' select='ID'/><xsl:choose><xsl:when test='position() &gt; 1'><xsl:text>,</xsl:text></xsl:when></xsl:choose><xsl:text>
      {""address"": {</xsl:text>
        <xsl:apply-templates select='zipCode|addressLine1|addressLine2|place|county|state'/><xsl:text>,
        ""Latitude"": """ + xsltArgs["latitude"] + @""",
        ""Longitude"": """ + xsltArgs["longitude"] + @"""</xsl:text>
    <xsl:apply-templates select='//salesTax[ID=$id]|//useTax[ID=$id]'/><xsl:text>,
        ""notes"": [</xsl:text>
       <xsl:apply-templates select='/z2tLookup/note[ID=$id]'/><xsl:text>]}}</xsl:text>
  </xsl:template>

  <xsl:template match='salesTax|useTax'><xsl:variable name='id' select='ID'/><xsl:variable name='taxtype' select='name()'/><xsl:text>,
        ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": {
          ""rateInfo"": {</xsl:text>
         <xsl:apply-templates select='isShippingTaxable|taxRateTotal'/>
   <xsl:text>          ""rateDetails"": [</xsl:text><xsl:apply-templates select=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))]""/><xsl:choose><xsl:when test=""boolean(./*[starts-with(name(), 'taxRate')]) and boolean(/z2tLookup/*[name() = concat($taxtype, 'Specials')]/*[starts-with(name(), 'taxRate')][ID=$id])""><xsl:text>,</xsl:text></xsl:when></xsl:choose><xsl:apply-templates select='//salesTaxSpecials[starts-with(name(), $taxtype)]|//useTaxSpecials[starts-with(name(), $taxtype)]'><xsl:with-param name='id-special' select='$id'/></xsl:apply-templates><xsl:text>]}}</xsl:text>
  </xsl:template>

  <xsl:template match='z2tLookup/note'><xsl:choose><xsl:when test='position() &gt; 1'><xsl:text>,</xsl:text></xsl:when></xsl:choose><xsl:text>
          {""noteDetail"": {</xsl:text>
        <xsl:for-each select='./jurisdiction|./category|./note'><xsl:text>
            ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
        </xsl:for-each>
    <xsl:text>}}</xsl:text>
  </xsl:template>

  <xsl:template match='salesTaxSpecials|useTaxSpecials'><xsl:param name='id-special'/><xsl:variable name='id' select='ID'/>
    <xsl:apply-templates select=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))][$id-special=$id]""><xsl:with-param name='id-special' select='$id-special'/></xsl:apply-templates>
  </xsl:template>

  <xsl:template match='zipCode|addressLine1|addressLine2|place|county|state|isShippingTaxable'><xsl:text>
        ""</xsl:text><xsl:value-of select='name()'/><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>""</xsl:text><xsl:choose><xsl:when test='position() &lt; last()'><xsl:text>,</xsl:text></xsl:when></xsl:choose>
  </xsl:template>

  <xsl:template match='taxRateTotal'><xsl:text>
            ""</xsl:text><xsl:text>taxRate</xsl:text><xsl:text>"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>"",
  </xsl:text>
  </xsl:template>

  <xsl:template match=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))]"">
    <xsl:param name='id-special'/>
    <xsl:choose><xsl:when test='$id-special=../ID  or not(contains(name(), ""Special""))'>
      <xsl:variable name='jurisdictionlevel' select=""substring-after(name(), 'taxRate')""/>
      <xsl:choose><xsl:when test='position() &gt; 1 or contains(name(), ""Special"")'><xsl:text>,</xsl:text></xsl:when></xsl:choose><xsl:text>
              {""rateDetail"": {
                ""jurisdictionLevel"": ""</xsl:text><xsl:value-of select='$jurisdictionlevel'/><xsl:text>"",
                ""jurisdictionCode"":""</xsl:text><xsl:value-of select=""../*[(starts-with(name(), 'JurCode')) and (substring-after(name(), 'JurCode') = $jurisdictionlevel)]""/><xsl:text>"",
                ""taxRate"": ""</xsl:text><xsl:value-of select='.'/><xsl:text>"",
                ""authorityName"": ""</xsl:text><xsl:value-of select=""../*[(starts-with(name(), 'authorityName')) and (substring-after(name(), 'authorityName') = $jurisdictionlevel)]""/><xsl:text>""}}</xsl:text>
    </xsl:when></xsl:choose>
  </xsl:template>
</xsl:stylesheet>";
    }

    public String webXmlXSLT(Dictionary<dynamic, dynamic> xsltArgs)
    {

        string PassiveMessage = xsltArgs["passiveMessage"];
        string stripPassiveMessage = PassiveMessage.Substring(13, PassiveMessage.Length - 15);

        string urgentMessage = xsltArgs["urgentMessage"];
        string stripUrgentMessage = urgentMessage.Substring(13, urgentMessage.Length - 15);
        return
          @"<?xml version='1.0' encoding='iso-8859-1' ?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
  <xsl:template match='/z2tLookup'>
    <xsl:element name='{name()}'>
      <xsl:element name='errorInfo'>
        <errorCode><xsl:text>" + xsltArgs["errorCode"] + @"</xsl:text></errorCode>
        <errorMessage><xsl:text>" + xsltArgs["errorMessage"] + @"</xsl:text></errorMessage>
        <elapsedTime><xsl:text>" + xsltArgs["elapsedTime"] + @"</xsl:text></elapsedTime>
         <startTime><xsl:text>" + xsltArgs["startTime"] + @"</xsl:text></startTime>
         <endTime><xsl:text>" + xsltArgs["endTime"] + @"</xsl:text></endTime>
         <ServerName><xsl:text>" + xsltArgs["localhost"] + @"</xsl:text></ServerName>
            <Version><xsl:text>" + xsltArgs["version"] + @"</xsl:text></Version>
        <xsl:element name='warnings'>
          <!-- xsl:apply-templates select='warning'/ -->" +
                xsltArgs["xmlWarnings"] + @"
        </xsl:element>
          <passiveMessage><xsl:text>" + stripPassiveMessage + @"</xsl:text></passiveMessage>
          <urgentMessage><xsl:text>" + stripUrgentMessage + @"</xsl:text></urgentMessage>

      </xsl:element>
      <xsl:element name='addressInfo'>
        <xsl:element name='addressResolution'><xsl:text>" + xsltArgs["addressResolution"] + @"</xsl:text></xsl:element>
        <xsl:element name='addresses'>
          <xsl:apply-templates select='address'/>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match='warning'>
    <xsl:element name='{name()}'>
        <xsl:value-of select='normalize-space(.)'/>
    </xsl:element>
  </xsl:template>

  <xsl:template match='address'>
    <xsl:variable name='id' select='ID'/>
      <xsl:element name=""{name()}"">
        <xsl:apply-templates select='zipCode|addressLine1|addressLine2|place|county|state'/>
      <xsl:element name='latitude'><xsl:text>" + xsltArgs["latitude"] + @"</xsl:text></xsl:element>
      <xsl:element name='longitude'><xsl:text>" + xsltArgs["longitude"] + @"</xsl:text></xsl:element>
      <xsl:apply-templates select='//salesTax[ID=$id]" + (xsltArgs["useTax"] ? "|//useTax[ID=$id]" : "") + @"'/>
      <xsl:element name='notes'>
        <xsl:apply-templates select='/z2tLookup/note[ID=$id]'/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match='salesTax|useTax'>
    <xsl:variable name='id' select='ID'/>
    <xsl:variable name='taxtype' select='name()'/>
    <xsl:element name=""{name()}"">
        <xsl:element name='rateInfo'>
          <xsl:apply-templates select='isShippingTaxable'/>
          <xsl:apply-templates select='taxRateTotal'/>
          <xsl:apply-templates select='authorityCodeTotal'/>
          <xsl:element name='rateDetails'>
            <xsl:apply-templates select=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))]""/>
            <xsl:apply-templates select='//salesTaxSpecials[starts-with(name(), $taxtype)]" + (xsltArgs["useTax"] ? "|//useTaxSpecials[starts-with(name(), $taxtype)]" : "") + @"'><xsl:with-param name='id-special' select='$id'/></xsl:apply-templates>
          </xsl:element>
        </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match='/z2tLookup/note'><xsl:choose><xsl:when test='position() &gt; 1'><xsl:text></xsl:text></xsl:when></xsl:choose>
    <xsl:element name='noteDetail'>
      <xsl:for-each select='./jurisdiction|./category|./note'>
        <xsl:element name='{name()}'>
          <xsl:value-of select='normalize-space(.)'/>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match='salesTaxSpecials|useTaxSpecials'>
    <xsl:param name='id-special'/>
    <xsl:variable name='id' select='ID'/>
    <xsl:apply-templates select=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))][$id-special=$id]""><xsl:with-param name='id-special' select='$id-special'/></xsl:apply-templates>
  </xsl:template>

  <xsl:template match='zipCode|addressLine1|addressLine2|place|county|state|isShippingTaxable'>
    <xsl:element name='{name()}'>
      <xsl:value-of select='normalize-space(.)'/>
    </xsl:element>
  </xsl:template>

  <xsl:template match=""*[(starts-with(name(), 'authorityCode'))]"">
    <xsl:element name='{name()}'>
      <xsl:value-of select='normalize-space(.)'/>
    </xsl:element>
  </xsl:template>

  <xsl:template match='taxRateTotal'>
    <xsl:element name='taxRate'><xsl:value-of select='normalize-space(.)'/></xsl:element>
  </xsl:template>

  <xsl:template match=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))]"">
    <xsl:param name='id-special'/>
    <xsl:choose>
      <xsl:when test='$id-special=../ID  or not(contains(name(), ""Special""))'>
        <xsl:variable name='jurisdictionlevel' select=""substring-after(name(), 'taxRate')""/>
        <xsl:variable name='jurisdictioncode' select=""concat('authorityCode', substring-after(name(), 'taxRate'))""/>
        <xsl:element name='rateDetail'>
          <xsl:element name='jurisdictionLevel'><xsl:value-of select='$jurisdictionlevel'/></xsl:element>
          <xsl:apply-templates select='../*[contains(name(), $jurisdictioncode)]'/>
          <xsl:element name='jurisdictionCode'><xsl:value-of select=""../*[(starts-with(name(), 'JurCode')) and (substring-after(name(), 'JurCode') = $jurisdictionlevel)]""/></xsl:element>
          <!--xsl:element name='jurisdictionCode'><xsl:value-of select='$jurisdictioncode'/></xsl:element-->
          <xsl:element name='taxRate'><xsl:value-of select='normalize-space(.)'/></xsl:element>
          <xsl:element name='authorityName'><xsl:value-of select=""../*[(starts-with(name(), 'authorityName')) and (substring-after(name(), 'authorityName') = $jurisdictionlevel)]""/></xsl:element>
        </xsl:element>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>";
    }

    public String xmlXSLT(Dictionary<dynamic, dynamic> xsltArgs)
    {

        return
          @"<?xml version='1.0' encoding='iso-8859-1' ?>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>
  <xsl:template match='/z2tLookup'>
    <xsl:element name='{name()}'>
      <xsl:element name='errorInfo'>
        <errorCode><xsl:text>" + xsltArgs["errorCode"] + @"</xsl:text></errorCode>
        <errorMessage><xsl:text>" + xsltArgs["errorMessage"] + @"</xsl:text></errorMessage>
        <elapsedTime><xsl:text>" + xsltArgs["elapsedTime"] + @"</xsl:text></elapsedTime>
         <startTime><xsl:text>" + xsltArgs["startTime"] + @"</xsl:text></startTime>
         <endTime><xsl:text>" + xsltArgs["endTime"] + @"</xsl:text></endTime>
         <ServerName><xsl:text>" + xsltArgs["localhost"] + @"</xsl:text></ServerName>
         <Version><xsl:text>" + xsltArgs["version"] + @"</xsl:text></Version>
        <xsl:element name='warnings'>
          <!-- xsl:apply-templates select='warning'/ -->" +
                xsltArgs["xmlWarnings"] + @"
        </xsl:element>

      </xsl:element>
      <xsl:element name='addressInfo'>
        <xsl:element name='addressResolution'><xsl:text>" + xsltArgs["addressResolution"] + @"</xsl:text></xsl:element>
        <xsl:element name='addresses'>
          <xsl:apply-templates select='address'/>
        </xsl:element>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match='warning'>
    <xsl:element name='{name()}'>
        <xsl:value-of select='current()'/>
    </xsl:element>
  </xsl:template>

  <xsl:template match='address'>
    <xsl:variable name='id' select='ID'/>
      <xsl:element name=""{name()}"">
        <xsl:apply-templates select='zipCode|addressLine1|addressLine2|place|county|state'/>
      <xsl:element name='latitude'><xsl:text>" + xsltArgs["latitude"] + @"</xsl:text></xsl:element>
      <xsl:element name='longitude'><xsl:text>" + xsltArgs["longitude"] + @"</xsl:text></xsl:element>
      <xsl:apply-templates select='//salesTax[ID=$id]" + (xsltArgs["useTax"] ? "|//useTax[ID=$id]" : "") + @"'/>
      <xsl:element name='notes'>
        <xsl:apply-templates select='/z2tLookup/note[ID=$id]'/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match='salesTax|useTax'>
    <xsl:variable name='id' select='ID'/>
    <xsl:variable name='taxtype' select='name()'/>
    <xsl:element name=""{name()}"">
        <xsl:element name='rateInfo'>
          
          <xsl:apply-templates select='taxRateTotal'/>
          <xsl:apply-templates select='authorityCodeTotal'/>
          <xsl:element name='rateDetails'>
            <xsl:apply-templates select=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))]""><xsl:with-param name='id-special' select='$id'/></xsl:apply-templates>
            <xsl:apply-templates select='//salesTaxSpecials[starts-with(name(), $taxtype)]" + (xsltArgs["useTax"] ? "|//useTaxSpecials[starts-with(name(), $taxtype)]" : "") + @"'><xsl:with-param name='id-special' select='$id'/></xsl:apply-templates>
          </xsl:element>
        </xsl:element>
    </xsl:element>
  </xsl:template>

  <xsl:template match='/z2tLookup/note'><xsl:choose><xsl:when test='position() &gt; 1'><xsl:text></xsl:text></xsl:when></xsl:choose>
    <xsl:element name='noteDetail'>
      <xsl:for-each select='./jurisdiction|./category|./note'>
        <xsl:element name='{name()}'>
          <xsl:value-of select='current()'/>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match='salesTaxSpecials|useTaxSpecials'>
    <xsl:param name='id-special'/>
    <xsl:variable name='id' select='ID'/>
    <xsl:apply-templates select=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))][$id-special=$id]""><xsl:with-param name='id-special' select='$id-special'/></xsl:apply-templates>
  </xsl:template>

  <xsl:template match='zipCode|addressLine1|addressLine2|place|county|state'>
    <xsl:element name='{name()}'>
      <xsl:value-of select='current()'/>
    </xsl:element>
  </xsl:template>

  <xsl:template match=""*[(starts-with(name(), 'authorityCode'))]"">
    <xsl:element name='{name()}'>
      <xsl:value-of select='current()'/>
    </xsl:element>
  </xsl:template>

  <xsl:template match='taxRateTotal'>
    <xsl:element name='taxRate'><xsl:value-of select='normalize-space(.)'/></xsl:element>
  </xsl:template>

  <xsl:template match=""*[(starts-with(name(), 'taxRate')) and not(contains(name(), 'Total'))]"">
    <xsl:param name='id-special'/>
<xsl:variable name='id' select='ID'/>
    <xsl:choose>
      <xsl:when test='$id-special=../ID  or not(contains(name(), ""Special""))'>
        <xsl:variable name='jurisdictionlevel' select=""substring-after(name(), 'taxRate')""/>
        <xsl:variable name='jurisdictioncode' select=""concat('authorityCode', substring-after(name(), 'taxRate'))""/>
        <xsl:element name='rateDetail'>
          <xsl:element name='jurisdictionLevel'><xsl:value-of select='$jurisdictionlevel'/></xsl:element>
          <xsl:apply-templates select='../*[contains(name(), $jurisdictioncode)][$id-special=$id]'/>
          <xsl:element name='jurisdictionCode'><xsl:value-of select=""../*[(starts-with(name(), 'JurCode')) and (substring-after(name(), 'JurCode') = $jurisdictionlevel)]""/></xsl:element>
          <!--xsl:element name='jurisdictionCode'><xsl:value-of select='$jurisdictioncode'/></xsl:element-->
          <xsl:element name='taxRate'><xsl:value-of select='normalize-space(.)'/></xsl:element>
          <xsl:element name='authorityName'><xsl:value-of select=""../*[(starts-with(name(), 'authorityName')) and (substring-after(name(), 'authorityName') = $jurisdictionlevel)]""/></xsl:element>
        </xsl:element>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>";
    }

    public bool IsReusable
    {
        // To enable pooling, return true here.
        // This keeps the handler in memory.
        get
        {
            return true;
        }
    }

    //Changes SM - May'14
    private static String GetTimestamp(DateTime value) {
            return value.ToString("yyyy-MM-dd HH:mm:ss.ffff");
        }

    private static String getErrorMessage(int p_errorCode)
    {
        SqlCommand sql;
        SqlDataAdapter adapter;
        DataSet ds = new DataSet();
        ds.DataSetName = "z2tLookup";
        string errorMessage;
        //retreiving error message from types table
        SqlConnection connection = new SqlConnection(defaultConnectionString);
        
        connection.Open();
        sql = new SqlCommand("z2t_Types_lookup", connection);

        sql.CommandType = CommandType.StoredProcedure;

        // using (sql.Parameters) {}
        // - function to add
        sql.Parameters.Add(new SqlParameter("@value", SqlDbType.NVarChar, -1));
        sql.Parameters["@value"].Value = p_errorCode.ToString();

        sql.Parameters.Add(new SqlParameter("@class", SqlDbType.NVarChar, -1));
        sql.Parameters["@class"].Value = "ErrorCode";

        sql.Parameters.Add(new SqlParameter("@description", SqlDbType.NVarChar, -1)).Direction = ParameterDirection.Output;
        sql.Parameters["@description"].Value = DBNull.Value;


        //foreach (SqlParameter e in sql.Parameters) {Response.Write(e.ParameterName + ": " + e.Value + " <" + e.DbType + ">\n");}
        adapter = new SqlDataAdapter(sql);
        adapter.Fill(ds);

        errorMessage = sql.Parameters["@description"].Value.ToString();

        connection.Close();

        return errorMessage;
    }
}
