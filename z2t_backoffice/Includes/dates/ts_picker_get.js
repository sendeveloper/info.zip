// str_target is the element to write the selected date into
// str_datetime is a date

function reshow_calendar(str_target, str_datetime, format) {
  
  return;}

function show_calendar(str_target, str_datetime, format) {
      //alert(str_target);
      //alert(str_datetime); 
  format = format === undefined ? "/" : format;
  var subFolder = "http://info.zip2tax.com/z2t_Backoffice/includes/dates/"
  var arr_months = ["January", "February", "March", "April", "May", "June",
		    "July", "August", "September", "October", "November", "December"];
  var week_days = ["S", "M", "T", "W", "T", "F", "S"];
  var n_weekstart = 0; // day week starts from (normally 0 or 1)
  
  var dt_datetime = typeof(str_datetime) == "object" ? str_datetime : (str_datetime == null || str_datetime =="" ?  new Date() : str2dt(str_datetime));

  var dt_prev_month = new Date(dt_datetime);
  dt_prev_month.setMonth(dt_datetime.getMonth() - 1);
  var dt_next_month = new Date(dt_datetime);
  dt_next_month.setMonth(dt_datetime.getMonth() + 1);
  
  var dt_prev_year = new Date(dt_datetime);
  dt_prev_year.setYear(dt_datetime.getFullYear() - 1);
  var dt_next_year = new Date(dt_datetime);
  dt_next_year.setYear(dt_datetime.getFullYear() + 1);
  
  var dt_firstday = new Date(dt_datetime);
  dt_firstday.setDate(1);
  dt_firstday.setDate(1 - (7 + dt_firstday.getDay() - n_weekstart)%7);
  var dt_lastday = new Date(dt_next_month);
  dt_lastday.setDate(0);
  
  // print calendar header
  var str_target2;
  switch (str_target.constructor) {
    case "String":
      str_target2 = ".'" + str_target + "'"
      break;
    default: 
    str_target2 = "[" + str_target + "]";
      break;}

  var str_buffer2 = new String (
    "<html>\n" +
      "<head>\n" +
      " <title>Calendar</title>\n\n" +
      " <script type=\"text/javascript\" src=\"../lib.js\"></script>" +
      " <style type='text/css'>\n" +
      "    td {\n" +
      "        font-size: 12px;\n" +
      "        font-family: Verdana, Arial, Helvetica, sans-serif;\n" +
      "        color: #FFFFFF;\n" +
      "    }\n\n" +
      
      "    td.datehead {\n" +
      "        font-size: 16px;\n" +
      "        font-family: Verdana, Arial, Helvetica, sans-serif;\n" +
      "        font-weight: bold;\n" +
      "        color: #FFFFFF;\n" +
      "        background-color: #4682B4;\n" +
      "    }\n</style>\n\n" +
      
    "</head>\n" +
      
    "<body bgcolor='#FFFFFF'>\n" +
      "<center>\n" +
      "<table cellspacing='0' border='0' width='220'>\n" +
      "<tr><td bgcolor='#4682B4'>\n" +
      "<table cellspacing='1' cellpadding='3' border='0' width='100%'>\n" +
      
    "<tr>\n" +
      
    "<td class='datehead'>" +
      "<a href=\"javascript:window.opener.show_calendar('" +
      str_target + "', '" + dt2dtstr(dt_prev_month) + "');\">" +
      "<img src='" + subFolder + "prev.gif' width='16' height='16' border='0'" +
      " alt='Previous Month'></a></td>\n\n" +
      
    "<td colspan='5' align='center' class='datehead'>" +
      arr_months[dt_datetime.getMonth()] + "</td>\n\n" +
      
    "<td align='right' class='datehead'>" +
      "<a href=\"javascript:window.opener.show_calendar('" +
      str_target + "', '"  + dt2dtstr(dt_next_month) + "');\">" +
      "<img src='" + subFolder + "next.gif' width='16' height='16' border='0'" +
      " alt='Next Month'></a></td>\n\n" +
      
    "</tr><tr>\n" +
      
    "<td class='datehead'>" +
      "<a href=\"javascript:window.opener.show_calendar('" +
      str_target + "', '" + dt2dtstr(dt_prev_year) + "');\">" +
      "<img src='" + subFolder + "prev.gif' width='16' height='16' border='0'" +
      " alt='Previous Year'></a></td>\n\n" +
      
    "<td colspan='5' align='center' class='datehead'>" +
      dt_datetime.getFullYear() + "</td>\n\n" +
      
    "<td align='right' class='datehead'>" +
      "<a href=\"javascript:window.opener.show_calendar('" +
      str_target + "', '"  + dt2dtstr(dt_next_year) + "');\">" +
      "<img src='" + subFolder + "next.gif' width='16' height='16' border='0'" +
      " alt='Next Year'></a></td></tr>\n\n");

	var dt_current_day = new Date(dt_firstday);

	// print weekdays titles
	str_buffer2 += "<tr>\n";
	for (var n=0; n<7; n++)
		str_buffer2 += "	<td bgcolor='#87CEFA' align='center'>" +
		week_days[(n_weekstart + n) % 7] + "</td>\n";

	// print calendar table
	str_buffer2 += "</tr>\n";
	while (dt_current_day.getMonth() == dt_datetime.getMonth() ||
		dt_current_day.getMonth() == dt_firstday.getMonth()) {
		// print row heder
		str_buffer2 += "<tr>\n";
		for (var n_current_wday=0; n_current_wday<7; n_current_wday++) {
				if (dt_current_day.getDate() == dt_datetime.getDate() &&
					dt_current_day.getMonth() == dt_datetime.getMonth())
					// print current date
					str_buffer2 += "	<td bgcolor='#FFB6C1' align='right'>";
				else if (dt_current_day.getDay() == 0 || dt_current_day.getDay() == 6)
					// weekend days
					str_buffer2 += "	<td bgcolor='#DBEAF5' align='right'>";
				else
					// print working days of current month
					str_buffer2 += "	<td bgcolor='#FFFFFF' align='right'>";

				if (dt_current_day.getMonth() == dt_datetime.getMonth())
					// print days of current month
				  str_buffer2 += "<a href=\"javascript:window.opener" + str_target2 +
					".value='" + dt2dtstr(dt_current_day) + "'; window.close();\">" +
					"<font color='black'>";
				else 
					// print days of other months
					str_buffer2 += "<a href=\"javascript:window.opener" + str_target2 +
					".value='" + dt2dtstr(dt_current_day) + "'; window.close();\">" +
					"<font color='gray'>";
				str_buffer2 += dt_current_day.getDate() + "</font></a></td>\n";
				dt_current_day.setDate(dt_current_day.getDate() + 1);
		}
		// print row footer
		str_buffer2 += "</tr>\n";
	}

        //end of html
	str_buffer2 += "</table>\n</td>\n</tr>\n</table>\n</body>\n</html>\n";


	var vWinCal = window.open("", "Calendar", 
		"width=250,height=250,status=no,resizable=yes,top=200,left=200");
	vWinCal.opener = self;
	var calc_doc = vWinCal.document;
	calc_doc.write (str_buffer2);
	calc_doc.close();
}


// datetime parsing and formatting routimes. modify them if you wish other datetime format

function str2dt (str_datetime) 
    {
    //var re_date = /^(\d+)\-(\d+)\-(\d+)\s+(\d+)\:(\d+)\:(\d+)$/;
    var re_date = /^(\d+)\/(\d+)\/(\d+)$/;

    if (!re_date.exec(str_datetime))
        return alert("Invalid Datetime format: " + str_datetime);
        //return (new Date (RegExp.$3, RegExp.$2-1, RegExp.$1, RegExp.$4, RegExp.$5, RegExp.$6));

    if (!DateEntry) {var DateEntry = 'mm/dd/yyyy'}
    if (DateEntry == 'dd/mm/yyyy')
        {
        return (new Date (RegExp.$3, RegExp.$2-1, RegExp.$1));
        }
    else
        {
        return (new Date (RegExp.$3, RegExp.$1-1, RegExp.$2));
        }
    }


function dt2dtstr (dt_datetime, format) {   
  format = format === undefined ? "/" : format;
  switch (format) {
  case "/":
    if (!DateEntry) {var DateEntry = 'mm/dd/yyyy'}
    if (DateEntry == 'dd/mm/yyyy') {
      return (new String (dt_datetime.getDate() + "/" + (dt_datetime.getMonth() + 1) + "/" + dt_datetime.getFullYear()));}
    else {
      return (new String ((dt_datetime.getMonth() + 1) + "/" + dt_datetime.getDate() + "/" + dt_datetime.getFullYear()));}
    break;
  case "-":
    return new String (dt_datetime.getFullYear() + "-" + (dt_datetime.getFullMonth() + 1) + "-" + dt_datetime.getFullDate())
    break;
  default:
    throw("Invalid dt2dtstr format");
    break;}
  return undefined;}

function dt2tmstr (dt_datetime) {
  return (new String (dt_datetime.getHours() + ":" + dt_datetime.getMinutes() + ":" + dt_datetime.getSeconds()));}



// document.getElementsByClass
document.getElementsByClass = function(className) {
  return document.getElementsByTagName("*").filter(function(e){
    return this.className.split(" ").filter(function(e) {
      return (e == className);}).length > 0;})}

// find elements in page (returns array when class or tagname are used)
//   use .class, #id, tagname, or _tagname
function get(id) {
  switch (ifnull(id.match(/^(?:\.)|(?:#)|(?:_)/), [""])[0]) {
  case ".": // class
    return document.getElementsByClass(id.replace(/^\./, ""));
    break;
  case "#": // id
    return document.getElementById(id.replace(/^#/, ""));
    break;
  case "_": // tag
  default:
    return document.getElementsByTagName(id.replace(/^_/, ""));
    break;}
  return undefined;}
