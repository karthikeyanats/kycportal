<%-- <table  border=1 width=98% class=tablebold cellpadding='0' cellspacing='0'>
		
		<tr height=100px ><td>
		<table border=1  cellpadding='0' cellspacing='0' style="float:left;" align=left width="100%">
				<%
    	if(insdetails!=null && insdetails.size()>0)
    	{
    		java.util.HashMap map=(java.util.HashMap)insdetails.get(0);
        	String inslogo=map.get("institutelogo")+"";
        	String insname=map.get("institutename")+"";
        	String contactaddress=map.get("contactaddress")+"";
        	String country=map.get("country")+"";
        	String landlinenumber=map.get("landlinenumber")+"";
        	String state=map.get("state")+"";
        	String mobilenumber=map.get("mobilenumber")+"";
        	String emailid=map.get("emailid")+"";
        	String url=map.get("url")+"";
        	String zip=map.get("zip")+"";
        	String fax=map.get("fax")+"";
        	        	
        	if(url.equals("-") || url.equals("") || url.trim()=="")
        		url="";
        	else
        		url="Website :"+url;
        	if(zip.equals("-") || zip.equals("") || zip.trim()=="")
        		zip="";
        	else
        		zip="<a class=tablebold>Pincode :</a><a class=tablelight>"+zip+"</a>";
        	
        	out.println("<tr align=right>");
        	out.println("<td rowspan=3 valign=top><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+inslogo+"' width=100 height=110></td>");
        	out.println("</tr>");
        	out.println("<tr>");
        	out.println("<td valign=top>");
        	out.println("<table  align=left width='60%'>");
        	out.println("<tr align=left>");
        	out.println("<td class=tablelight>&nbsp;<h3>"+insname+"</h3></td>");
        	out.println("<table border=0 align=right>");
        	out.println("<tr align=left>");
        	out.println("<td class=tablelight>&nbsp;"+contactaddress+"</td>"); 
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td class=tablelight>&nbsp;"+state+","+country+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+zip+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;<a class=tablebold>Phone:</a><a class=tablelight>"+landlinenumber+"</a></td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;<a class=tablebold>Fax:</a><a class=tablelight>"+fax+"</a></td>");
        	out.println("</tr>");
        	/* the following this out.println("<tr align=left>");
        	out.println("<td>&nbsp;Email:"+emailid+"</td>");
        	out.println("</tr>");*/
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+url+"</td>");
        	out.println("</tr>"); 
        	}%>
        	</table>
		</td></tr>
		</table> --%>
	<%	
	String head_inslogo=null;
	String head_insname=null;
	String head_contactaddress=null;
	String head_country=null;
	String head_landlinenumber=null;
	String head_state=null;
	String head_mobilenumber=null;
	String head_city = null;
	String head_emailid=null;
	String head_url=null;
	String head_zip=null;
	String head_fax=null;
	
	String head_institutelogo 	= (String)session.getValue("institutelogo");
	
		if(insdetails!=null && insdetails.size()>0)
    	{
    		java.util.HashMap map=(java.util.HashMap)insdetails.get(0);
    		head_inslogo=map.get("institutelogo")+"";
        	head_insname=map.get("institutename")+"";
        	head_city=map.get("city")+"";
        	 head_contactaddress=map.get("contactaddress")+"";
        	 head_country=map.get("country")+"";
        	 head_landlinenumber=map.get("landlinenumber")+"";
        	 head_state=map.get("state")+"";
        	 head_mobilenumber=map.get("mobilenumber")+"";
        	 head_emailid=map.get("emailid")+"";
        	 head_url=map.get("url")+"";
        	 head_zip=map.get("zip")+"";
        	 head_fax=map.get("fax")+"";
        	        	
        	if(head_url.equals("-") || head_url.equals("") || head_url.trim()=="")
        		head_url="";
        	else
        		head_url="<a class=tablebold>Website: </a>"+head_url;
        	if(head_zip.equals("-") || head_zip.equals("") || head_zip.trim()=="")
        		head_zip="";
        	else
        		head_zip="<a class=tablebold></a><a class=tablelight>"+head_zip+"</a>";
        
        	}%>
		
		
		<table  border=0 width=98% class=tablebold cellpadding='0' cellspacing='0' align=center>
		
		<tr>
		<td valign=top><img src="<%=request.getContextPath()%>/OpenDocument?r1=path&r2=<%=head_institutelogo %>" alt="" title="" border="0"  width="100" height="110"/></td>
		<td>
				<table border=0  cellpadding='0' cellspacing='0' style="float:left;" align=left width="100%">
				<tr align=center class=tablelight><td><h3><%=head_insname %></h3></td></tr>
				<tr align=center class=tablelight><td><b>(GOVT. RECOGNISED)</b></td></tr>
				<tr  align=center class=tablelight><td><%= head_contactaddress%>, <a class=tablelight><%=head_city %></a> - <%= head_zip%></td></tr>
				<tr  align=center><td>&nbsp;<a class=tablebold>Phone: </a><a class=tablelight><%=head_landlinenumber%></a></td></tr>
				<tr  align=center class=tablelight><td><a class=tablebold>Email: </a><%= head_emailid%>, <%= head_url%></td></tr>
				</table>
		</td></tr>
		</table>