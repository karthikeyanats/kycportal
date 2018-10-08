
<html>
<head>

 <title>AdminConsole</title>
<script src="<%=request.getContextPath()%>/adminconsole/js/dtree.js" >
</script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/adminconsole/dtree.css">
</head>

<body leftmargin=0 rightmargin=0 topmargin=0 bottommargin=0 >
<form name="xx">
     <table border="0" cellpadding="0" bgcolor="#fcfcfc" cellspacing="0" width="100%" height="100%">

     <tr  valign='top'>
       <td width=100%>
       	<table class="dtree" border=0 width=1000px>
		<tr><td>
       	<script type="text/javascript">

 	   d = new dTree('d');
            d.add(0,-1,"KYC",'','','','<%=request.getContextPath()%>/adminconsole/image/globe.gif','','');
           	d.add(100,0,"<a href='#'>Product</a>",'','','','<%= request.getContextPath()%>/adminconsole/image/folder.gif','','');
           	d.add(1,100,"<a href=\"<%= request.getContextPath()%>/adminconsole/dynamicsettingskyc_test.jsp?pname=kycportal\" title=\"kyc\" target=\"tree\">kyc</a>",'','','','<%= request.getContextPath()%>/adminconsole/image/services.gif','','');
           	d.add(200,0,"<a href='#'>Log</a>",'','','','<%= request.getContextPath()%>/adminconsole/image/folder.gif','','');
            d.add(1,200,"<a href=\"<%= request.getContextPath()%>/adminconsole/Log_details.jsp\" title=\"KYC Portal log details\" target=\"tree\">Log Details</a>",'','','','<%= request.getContextPath()%>/adminconsole/image/services.gif','','');       
    	    d.add(600,0,"<a href=\"<%= request.getContextPath()%>/adminconsole/systemproperty.jsp\" title=\"Data\" target=\"tree\">System Properties</a>",'','','','<%= request.getContextPath()%>/adminconsole/image/folder.gif','','');
	   document.write(d);
        </script>
</td></tr></table>
       </td>
      </tr>

     </table>


</form>
 </body>
</html>