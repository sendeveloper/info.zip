    var foc = '';
    var data1 = '';
    var data2 = '';
    var countRefresh = 0;
    var usedZip = '';


    var z2t_status = '';
    var z2t_AccountID = '';
    var z2t_loggedin = '';
    var z2t_login = '';

    var isIE = 1;    
    if (navigator.appName == "Netscape")
        { 
        isIE = 0;
        }

    function blurField(f)
        {
        if (f == 'zip')
            {
            if (document.getElementById('inputzip').value.length == 5)
                {
                getRate();
                }
            }
        if (f == 'amt')
            {
            if (document.getElementById('inputamt').value.length > 0)
                {
                getTax();
                }
            }
        }

    function clickGetRate()
        {
        }

    function clickGetTax()
        {
        }

    function clickLogin()
        {
        var URL = 'http://www.zip2tax.com/login/z2t_Login.asp';
        openPopUp(URL);
        }

    function clickSpacedMan(path)
        {
        path  = '.html';
        UserTracking('Clicked SpacedMan','z2t_index.html',usedZip,'');
        window.location = path;
        }

    function focusField(f)
        {
        foc=f;
        }

    function formLoad()
        {
        getSessionVariables;
        UserTracking('formLoad','z2t_index.html','','');
        }

    function formLoad2()
        {
        getSessionVariables;
        UserTracking('formLoad (client)','z2t_index.html','','');
        }

    function keytest(e) 
        {
        if (window.event||window.Event)
            {
            e = window.event||window.Event;
            if (e.keyCode == 13) 
                {
                e.keyCode = 0;
                if (foc == 'amt')
                    {
                    //getTax();
                    document.getElementById('inputzip').focus();
                    }
                else
                    {
                    //getRate();
                    document.getElementById('inputamt').focus();
                    }
                }
            }
        }

    function getRate() 
        {
        var zip = document.getElementById('inputzip').value;

        if (zip.length == 5)
            {
			var URL = 'http://www.zip2tax.com/includes/ajax/TaxLookUp.asp' +
				'?Zip=' + escape(zip) +
				'&User=zip2tax.com' +
				'&Now=' + escape(Date());

            http.open("GET", URL, true);
            http.onreadystatechange = readRate;
            http.send(null);
            }
        else
            {
            alert('Zip Code Must Have 5 Numbers');
            }
        }

    function readRate() 
        {
	  if (http.readyState == 4) 
            {
            var res = http.responseXML;
            if (getInnerText(res.getElementsByTagName('zip').item(0)) == 'error')
                {
                alert('Zip Code '   document.getElementById('inputzip').value   ' Not Found!');
                document.getElementById('inputzip').value = '';
                document.getElementById('inputzip').focus();
                }
            else if (getInnerText(res.getElementsByTagName('city').item(0)) == 'Daily Max')
                {
                alert('Your IP Address has exceeded the number of free look-ups for today.  Consider purchasing a subscription.');
                UserTracking('Over 10 Daily Look-ups Nag Box','z2t_index.html',usedZip,'');
                document.getElementById('inputzip').value = '';
                document.getElementById('inputzip').focus();
                }
            else if (getInnerText(res.getElementsByTagName('city').item(0)) == 'IP Max')
                {
                alert('You have exceeded your total number of free look-ups.  Please call toll free 1-866-492-8494 to purchase a subscription.');
                UserTracking('Over 70 Look-ups Nag Box','z2t_index.html',usedZip,'');
                document.getElementById('inputzip').value = '';
                document.getElementById('inputzip').focus();
                }
            else
                {
                var resultIPTotal = getInnerText(res.getElementsByTagName('iptotal').item(0));
                var resultUserName = getInnerText(res.getElementsByTagName('username').item(0));
                if (resultUserName == '' && resultIPTotal > 50)
                    {
                    UserTracking('Over 50 Look-ups Nag Box','z2t_index.html',usedZip,'');
                    alert('Your IP Address has had '   resultIPTotal   ' free look-ups.  Consider purchasing a subscription.');
                    }

                var cityPath = getInnerText(res.getElementsByTagName('citypath').item(0));
                usedZip = getInnerText(res.getElementsByTagName('zip').item(0));

                document.getElementById('result_zip').innerHTML = 
                    '<a href="javascript:clickSpacedMan(\''   cityPath   '\');" class="result">'  
                    //'<a href='   cityPath   '.html target="_new" class="result">'  
                    usedZip   '</a>'; 

                document.getElementById('result_city').innerHTML = 
                    '<a href="javascript:clickSpacedMan(\''   cityPath   '\');" class="result">'  
                    getInnerText(res.getElementsByTagName('city').item(0))   '</a>'; 

                document.getElementById('result_county').innerHTML = 
                    getInnerText(res.getElementsByTagName('county').item(0)); 

                document.getElementById('result_state').innerHTML = 
                    getInnerText(res.getElementsByTagName('state').item(0)); 

                document.getElementById('result_rate').innerHTML = 
                    getInnerText(res.getElementsByTagName('rate').item(0)); 

                if (getInnerText(res.getElementsByTagName('rate').item(0)) == '')
                    {
                    document.getElementById('result_jur').innerHTML = 
                        'Sorry, no tax tables for '    
                        getInnerText(res.getElementsByTagName('state').item(0))
                          ' at this time';                
                    }
                else
                    {
                    document.getElementById('result_jur').innerHTML =              
  		            getInnerText(res.getElementsByTagName('jurisdiction').item(0));
                    }

                //User Stats Window
                if (resultUserName == '')
                    {
                    document.getElementById('ip_line1').innerHTML = 
                        'Look ups for your IP Address ('    
                        getInnerText(res.getElementsByTagName('ipaddress').item(0))
                          ')';                
                    document.getElementById('ip_line2').innerHTML = 
                        getInnerText(res.getElementsByTagName('ipcount').item(0))
                          ' today, '   resultIPTotal   ' total';                
                    }
                else
                    {
                    document.getElementById('ip_line1').innerHTML = 
                        'Look ups for your Username ('   resultUserName   ')';                
                    document.getElementById('ip_line2').innerHTML = 
                        getInnerText(res.getElementsByTagName('usercount').item(0))
                          ' today, '            
                          getInnerText(res.getElementsByTagName('usertotal').item(0))
                          ' total';                
                    }

                //Reset query input
                document.getElementById('inputzip').value = '';
                getTax();
                }
            }
        }

    function getTax() 
        {
        var amt = RoundUp(Number(document.getElementById('inputamt').value));
        if(isNaN(amt)) 
            { amt = 0; }

        if (amt == 0)
            {
            amt = parseFloat(document.getElementById('result_amt').innerHTML);
            }

        if(isNaN(amt)) 
            { amt = 0; }

        if (amt == 0)
            {
            document.getElementById('result_amt').innerHTML = CurrencyFormatted(0);
            document.getElementById('result_tax').innerHTML = CurrencyFormatted(0);
            document.getElementById('result_tsale').innerHTML = CurrencyFormatted(0);                
            document.getElementById('inputamt').focus();
            }
        else
            {
            document.getElementById('result_amt').innerHTML = CurrencyFormatted(amt);
            data1 = amt;
            var r = parseFloat(document.getElementById('result_rate').innerHTML);
            var tot = RoundUp(Number(amt * r)/100);
            data2 = tot;
            document.getElementById('result_tax').innerHTML = CurrencyFormatted(tot);
            tot  = RoundUp(Number(amt));
            document.getElementById('result_tsale').innerHTML = CurrencyFormatted(tot);
            document.getElementById('inputamt').value = '';
            document.getElementById('inputamt').focus();
            UserTracking('Calculate Amount','z2t_index.html',data1,data2);
            }
        }

    function getSessionVariables() 
        {
            http.open("GET", "http://www.zip2tax.com/includes/ajax/TaxLookUp.asp?Zip="   escape(zip)   "&User=zip2tax.com"   "&Now="   escape(Date()), true);
            http.onreadystatechange = readSessionVariables;
            http.send(null);
        }

    function readSessionVariables() 
        {
	  if (http.readyState == 4) 
            {
            var res = http.responseXML;
            z2t_status = getInnerText(res.getElementsByTagName('data').item(0));
            z2t_AccountID = getInnerText(res.getElementsByTagName('data').item(1));
            z2t_loggedin = getInnerText(res.getElementsByTagName('data').item(2));
            z2t_login = getInnerText(res.getElementsByTagName('data').item(3));
            }
        }




    function RoundUp(num)
        {
        num  = .0005;
        return Math.round(num*100)/100;
        }

    function CurrencyFormatted(amount)
    {
        var i = parseFloat(amount);
        if(isNaN(i)) 
            { i = 0.00; }

        var minus = '';
        if(i < 0) { minus = '-'; }

        i = Math.abs(i);
        i = parseInt((i   .005) * 100);
        i = i / 100;

        s = new String(i);
        if(s.indexOf('.') < 0) { s  = '.00'; }
        if(s.indexOf('.') == (s.length - 2)) { s  = '0'; }
        s = minus   s;

        return s;
    }

    function numbersonly(myfield, e, dec)
        {
        var key;
        var keychar;

        if (window.event)    
           key = window.event.keyCode;
        else if (e)
           key = e.which;
        else
           return true;
        keychar = String.fromCharCode(key);

        // Enter key hit
        if (key==13)
            {
                if (foc == 'amt')
                    {
                    //causes getTax() to fire
                    document.getElementById('inputzip').focus();
                    }
                else
                    {
                    //causes getRate() to fire
                    document.getElementById('inputamt').focus();
                    }
            }

        // control keys
        if ((key==null) || (key==0) || (key==8) || 
            (key==9) || (key==27) )
           return true;

        // numbers
        else if ((("0123456789").indexOf(keychar) > -1))
           return true;

        // decimal point jump
        else if (dec && (keychar == "."))
           {
           myfield.form.elements[dec].focus();
           return false;
           }
        else
           return false;
        }

    function openPopUp(URL)
        {
        window.open(URL,'',
            'scrollbars=yes,fullscreen=no,resizable=yes,height=750,width=1000,left=10,top=10');
        }

    function openPopUpSize(URL, w, h)
        {
        window.open(URL,'',
            'scrollbars=yes,fullscreen=no,resizable=yes,height='   h   ',width='   w   ',left=10,top=10');
        }


    function SetScreen(w, h)
        {
        window.resizeTo(w, h);
        CenterScreen(w, h);
        }

    function CenterScreen(w, h)
        {
        var leftprop, topprop;
 
        var leftvar = (window.screen.availWidth - w) / 2;
        var rightvar = (window.screen.availHeight - h) / 2;

        if (isIE)
            {
            leftprop = leftvar;
            topprop = rightvar;
            }
        else 
            {
            leftprop = (leftvar - pageXOffset);
            topprop = (rightvar - pageYOffset);
            }

        window.moveTo(leftprop,topprop);
        }

function whichKey(e)
    {
    if (isIE)
        {
        return e.keyCode;
        }
    else
        {
        return e.which;
        }
    }