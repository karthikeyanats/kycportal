<%@ page language="java" import="java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Report.Calenderpdf"%>
<%@page language="java" import="java.util.ResourceBundle,java.io.File"%>
<%@page language="java" import="com.iGrandee.Common.DateTime"%>
<%@ page language="java" import="com.iGrandee.Report.Calenderpdf"%>
<%@ page language="java" import="com.iGrandee.SchoolCalender.SchoolCalenderBean"%>
 <%@ page language="java" import=" com.iGrandee.SchoolCalender.SchoolCalenderEntry"%>
 
<%  
com.iGrandee.Report.Calenderpdf  calenderquery = new com.iGrandee.Report.Calenderpdf();
String message="";
SchoolCalenderEntry query_object=new SchoolCalenderEntry();

try
{
	SchoolCalenderBean calendderbean	= new SchoolCalenderBean();
	
	String instituteid			= (String)session.getValue("instituteid");
	String sessionid			= request.getParameter("req_sessionid");
	String req_sessionname			= request.getParameter("req_sessionname");
	String reg_boardnname= request.getParameter("req_boardname");
	String boardid = request.getParameter("req_boardid");
	
	 calendderbean	= new SchoolCalenderBean();
	 calendderbean.setSessionid(sessionid);
	 calendderbean.setboardid(boardid);
	 calendderbean.setinstituteid(instituteid);

		ArrayList eventList = query_object.eventListRK(calendderbean);
		
boolean boo1=false;
if(eventList!=null && eventList.size()>0)
{
int no_of_rows=calenderquery.loadCalenderEventDetails(instituteid,sessionid,req_sessionname,boardid,reg_boardnname);     

	boo1=true;
}
ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");

String storagepath = bundle.getString("storagepath");
DateTime datobj =new DateTime();
String tem_date=datobj.showTime("WithTime");
tem_date = tem_date.substring(0,tem_date.length()-3);
tem_date = tem_date.replaceAll(":", "_");


String tepfile=storagepath+"/archivalpdfs/"+"/SchoolCalender";
File F= new File(tepfile);
boolean boo = F.exists(); 
if(boo)
{
	
}
else
{
	F.mkdirs();
}   
String paths  = request.getContextPath()+"/OpenDocument?r1=storagepath&r2=/archivalpdfs/"+"/SchoolCalender"+"/SchoolCalender "+tem_date+".pdf";
String paths1="";
StringBuffer buffer=new StringBuffer();        

String temp_str=null;
		buffer.append("<result>");
		buffer.append("<var>"+boo1+"</var>");
		paths=paths.replaceAll("&","&amp;");
		paths=paths.replaceAll("'","&#39;");
		buffer.append("<downloadfile>"+paths+"</downloadfile>");
		buffer.append("</result>");
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");

		
		
		

 	
}catch(Exception e)
{
	System.out.print(e);
}
	
	
	
%>