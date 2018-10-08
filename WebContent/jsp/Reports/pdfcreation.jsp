<jsp:useBean id="load_help" scope="page" class="com.iGrandee.Report.SubjectAllotmentList"/>
<%@ page import="com.iGrandee.Common.DateTime,java.util.ArrayList,java.util.ResourceBundle,java.io.File"%>
<%
try
{
DateTime datobj=new DateTime();
String instituteid=session.getValue("instituteid")+"";
String sessionid=request.getParameter("req_sessionid")+"";
String sessionname=request.getParameter("req_sessionname")+"";
String boardid=request.getParameter("req_boardid")+"";
String boardname=request.getParameter("req_boardname")+"";
load_help.SubjectAllotmentList(sessionname,sessionid,instituteid,boardid,boardname);
ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");
String storagepath = bundle.getString("storagepath");
String time=datobj.showTime("Time").replaceAll(":","_");
String path=storagepath+instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Subject allotment List/SubjectAllotmentList "+datobj.showTime("calendar")+" "+time+".pdf";
File fs= new File(path);
boolean boo = fs.exists();
String sss = instituteid+"/archivalpdfs/"+sessionname+"_"+sessionid+"/Subject allotment List/SubjectAllotmentList "+datobj.showTime("calendar")+" "+time+".pdf";
String paths  = request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+sss;
StringBuffer buffer=new StringBuffer();
String temp_str=null;
buffer.append("<result>");
buffer.append("<var>"+boo+"</var>");
paths=paths.replaceAll("&","&amp;");
paths=paths.replaceAll("'","&#39;");
buffer.append("<downloadfile>"+paths+"</downloadfile>");
buffer.append("</result>");
response.setContentType("text/xml");
response.setHeader("Cache-Control", "no-cache");
response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
}
catch(Exception ex)
{
	ex.printStackTrace();
}
%>
