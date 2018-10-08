<html>
<LINK REL=stylesheet HREF="<%= request.getContextPath() %>/jsp/css/sty.css">

<head>
</head>
<body class="bodycolor"  topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" >
<%@ page language="java" %>
<%@ page import="java.util.ArrayList,java.util.HashMap,java.sql.*" %>
<jsp:useBean id="sss"  scope="page" class="com.iGrandee.Common.ConnectionManager"/>

 <%
        ArrayList categoryList = null;

		//query	= new Query();
		//categoryList = query.showDb("select * from category_tb");
String sqlquery = request.getParameter("req_query");
out.println("<table border=1 cellpadding=5 cellspacing=0 width='90%' align=center><tr><td>");
out.println("<a class=tablebold></a><a class=tablelight>"+sqlquery+"</td></tr></table><br>");
Connection connection;
	try
	{
		connection = sss.getKycConnection();
				Statement stmt 			= connection.createStatement();
				ResultSet rs		 		= stmt.executeQuery(sqlquery);
				ResultSetMetaData rsmd			= rs.getMetaData();
				int column_count	= rsmd.getColumnCount();
out.println("<table border=1 cellpadding=3 cellspacing=0 align=center><tr class=tablehead ><td> SL.No.</td>");
				for(int colcnt=1;colcnt<=column_count;colcnt++)
				{
					out.print("<td>"+rsmd.getColumnLabel(colcnt)+"</td>");
				}
out.println("</tr>");int inc =1;
String req_string = "";
				while(rs.next())
				{
					out.println("<tr class=tablelight><td>"+(inc++)+"</td>");

					for(int colcnt1=1;colcnt1<=column_count;colcnt1++)
					{
							req_string = rs.getString(colcnt1);
						if(req_string  == null || req_string.equals(""))
								req_string = "No Value";
						else
							req_string =  req_string;

						out.println("<td>"+req_string+"</td>");
					}
					out.println("</tr>");
				}

out.println("</table>");
					//for(int colcnt=1;colcnt<=column_count;colcnt++)
}catch(Exception e){}
 %><br>
 <center><input type=button name=backfun value="BACK" class=tablelight onclick=window.history.back()></center>