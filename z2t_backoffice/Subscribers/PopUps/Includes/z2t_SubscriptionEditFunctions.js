
        function blockBadChars(e)
            {
            if(window.event)
                {
                k = window.event.keyCode; // IE 
                }
            else
                {
                k = e.which; // Firefox
                }


            //var k = window.event.keyCode;
            if (k > 14 && k < 48 || (k > 57 && k < 65) || (k > 90 && k < 97) || k > 122) 
                {
                if(window.event)
                    {
                    window.event.keyCode = 0;
                    }
                else
                    {
                    e.preventDefault(); 
                    e.stopPropagation(); 
                    }
                }
            }

        function fixQuotes() 
            {
            var s = document.getElementById('Alias').value;
                {
            	for (i=0; i < s.length; i++)
            	    {
            	    if ('\"' == s.substring(i,i+1))
            	        {
                        document.getElementById('Alias').value = s.replace('\"','\'');
            	        }
            	    }
                }
            }

        function clickSendEmail() 
            {
            var u = document.getElementById('UserName').value;

            if (u == '')
                {
                    alert('Please enter a Username');
                    document.getElementById('UserName').focus();
                    return;
                }

            if (u.length < 3)
                {
                    alert('Username must be at least 3 characters long!');
                    document.getElementById('UserName').focus();
                    return;
                }

            var e = document.getElementById('Email').value;
            window.open('chat/EmailChatCode.asp?UserName=' + u + '&Email=' + e,'','fullscreen=no,width=10,height=10');
            alert('E-mail sent');
            }

        function checkChatStatus () 
            {
            var u = document.getElementById('UserName').value;
            var e = document.getElementById('Email').value;
            u = u.toUpperCase() + e.toUpperCase();
            var n = 0
            for (i=0; i < u.length; i++)
                {
                n += getASCII(u.substring(i,i+1));
                }

            var c = document.getElementById('ChatCode').value;
            if (c.toString() == n.toString())
                {
                document.getElementById('chatStatus').innerHTML = '<font color="red">Registered</font>';
                }
            else
                {
                document.getElementById('chatStatus').innerHTML = '<font color="red">Unregistered</font>';
                }
            }

        function checkUserName () 
            {
            var u = document.getElementById('UserName').value;
            if (u != '')
                {
                if (u.length < 3)
                    {
                    alert('Username must be at least 3 characters long!');
                    document.getElementById('UserName').focus();
                    }
                else            
                    {
	            http.open("GET", "chat/eye_chat_checkUserName.asp?u=" + escape(u), true);
	            http.onreadystatechange = readUserName;
	            http.send(null);
                    }
                }
            checkChatStatus();
            }

	function readUserName()
            {
	    if (http.readyState == 4) 
                {
                var r = http.responseText;
                if (r == UserID)
                    {
                    //alert('This Username is in use by you.');
                    }
                else            
                    {
                    if (r != 0)
                        {
                        var u = document.getElementById('UserName').value;
                        alert('The Username ' + u + ' is already in use.  Please select another.');
                        document.getElementById('UserName').value = '';
                        document.getElementById('UserName').focus();
                        }
                    }
                }
            }

        function getASCII(char) 
            {
            for (var i=1;i<=255;i++) 
                {
                if (unescape('%' + i.toString(16)) == char)
                return i;
                }
            return 0;
            }

