<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle,java.util.Date,com.iGrandee.Registration.InstitutionQurey"%>
<%
ResourceBundle headBundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<html>
<head>
<title><%=headBundle.getString("label.datewisebooksearch.entrytitle") %></title>

</head>

<body  bgcolor="#ffffff" topmargin=10 leftmargin=0 rightmargin=0>
<%
Date d=new Date();
int month=1+d.getMonth();
int year= 1900+d.getYear();
String date=d.getDate()+" - "+month+" - "+year;
%>

<table  border=0 width=98% class=tablebold cellpadding='0' cellspacing='0'>
		
		<tr height=100px ><td>
		<table border=0  cellpadding='0' cellspacing='0' style="float:left;" align=left width="100%">
				<%
				InstitutionQurey insquery=new InstitutionQurey();
				ArrayList insdetails=insquery.getInstituteDetails((String)session.getValue("instituteid"));
				
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
        		zip="Zipcode :"+zip;
        	
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
        	out.println("<td>&nbsp;"+contactaddress+"</td>"); 
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+state+","+country+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+zip+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;Phone:"+landlinenumber+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;Fax:"+fax+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;Email:"+emailid+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+url+"</td>");
        	out.println("</tr>");
        	}%>
        	</table>
		</td></tr>
		</table>
		
		<!--  
		<table  border=0  width=640 >
		<tr height=50px><td align=center>
		<table  border=0 width=100% class=tablebold cellpadding='0' cellspacing='0'>
		
		<tr height=100px ><td>
		<table border=0  cellpadding='0' cellspacing='0' style="float:left;" align=left>
		<
    	if(insdetails!=null && insdetails.size()>0)
    	{
    		HashMap map=(HashMap)insdetails.get(0);
        	String inslogo=map.get("institutelogo")+"";
        	String insname=map.get("institutename")+"";
        	String contactaddress=map.get("contactaddress")+"";
        	String country=map.get("country")+"";
        	String landlinenumber=map.get("landlinenumber")+"";
        	String state=map.get("state")+"";
        	String mobilenumber=map.get("mobilenumber")+"";
        	String emailid=map.get("emailid")+"";
        	String url=map.get("url")+"";
        	if(url.equals("-"))
        		url="";
        	out.println("<tr align=left>");
        	out.println("<td rowspan=7 valign=top><img src='/kycportal/OpenDocument?r1=storagepath&r2="+inslogo+"' width=110 height=110></td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+insname+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+contactaddress+"</td>"); 
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+state+","+country+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+landlinenumber+","+landlinenumber+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+emailid+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>&nbsp;"+url+"</td>");
        	out.println("</tr>");
        	}%>
        	</table>
		</td>
</tr>
		</table>-->
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.Report.BookJournalReport" />
<%@ page import="java.util.HashMap,java.text.NumberFormat,java.util.Locale"%>
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>
<%
ArrayList BookList=new ArrayList();
String sessionid=session.getValue("sessionid")+"";
String instituteid=session.getValue("instituteid")+"";
String startdate="";
String enddate="";
String flage_temp=request.getParameter("flage_temp");

ArrayList JournalList=new ArrayList();
	startdate=request.getParameter("startdate");
	enddate=request.getParameter("enddate");
	


Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));

%>
<form name="MainForm" method="post" action="">
<div id="main_container">

	<div class="header">
	

   
	   </div>

    <div class="main_content">
    

    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
    <%

	if(flage_temp.equals("Book"))
	{
    //out.print("<h2>"+headBundle.getString("label.datewisebookissue.entryrootpath1")+"</h2>");
    
	}
	else if(flage_temp.equals("Journal"))
	{
	   // out.print("<h2>"+headBundle.getString("label.datewisebookissue.entryrootpath2")+"</h2>");

	}



%>	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->



</div>

    </form>
	
</body>
</html>