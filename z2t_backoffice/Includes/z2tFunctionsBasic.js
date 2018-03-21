    var isIE = 1;
    if (navigator.appName == "Netscape")
        { 
        isIE = 0;
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

        if(navigator.appName == "Microsoft Internet Explorer")
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

    function openPopUp(URL)
        {
        window.open(URL,'',
            'scrollbars=yes,fullscreen=no,resizable=yes,height=10,width=10,left=10,top=10');
        }

    function Submit() 
		{
        document.frm.submit();
		}
