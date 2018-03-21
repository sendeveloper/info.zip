var httpHelp = new XMLHttpRequest();


function help(id) {
    var f = '/z2t_BackOffice/includes/Help/HelpRead.asp' +
		'?ID=' + escape(id) + 
		'&Now=' + escape(Date())
    httpHelp.open("GET", f, true);
    httpHelp.onreadystatechange = readHelp;
    httpHelp.send(null);
    }

function clickHelpOk() {
    document.getElementById('helpDiv').style.visibility = 'hidden';
    }

function readHelp(){
 	  if (httpHelp.readyState == 4) 
            {
            var res = httpHelp.responseXML;
            if (res.getElementsByTagName('HelpResponseTitle').item(0).innerText == 'error')
                {
                alert('Help File Look-Up Error');
                }
            else
                {
                var helpScreen = document.getElementById('helpDiv');
				//alert(res.getElementsByTagName('HelpResponseTitle')[0].firstChild.nodeValue); 

                var w = res.getElementsByTagName('Width')[0].firstChild.nodeValue; 
                var h = res.getElementsByTagName('Height')[0].firstChild.nodeValue; 
                var t = parseInt(res.getElementsByTagName('Top')[0].firstChild.nodeValue); 
                var l = res.getElementsByTagName('Left')[0].firstChild.nodeValue; 
                var sTop = document.body.scrollTop;

                helpScreen.style.width = w + 'px';
                helpScreen.style.height = h + 'px';
                helpScreen.style.top = t + sTop;
                helpScreen.style.left = l;

                document.getElementById('helpTitle').innerHTML = 
                    res.getElementsByTagName('HelpResponseTitle')[0].firstChild.nodeValue; 

                document.getElementById('helpBody').innerHTML = 
                    res.getElementsByTagName('HelpResponseBody')[0].firstChild.nodeValue; 

                helpScreen.style.visibility = 'visible';
                }
            } 
        }
