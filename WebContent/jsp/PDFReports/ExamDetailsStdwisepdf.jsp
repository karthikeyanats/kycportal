<%@ page language="java" import="java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Report.ExamDetailspdf"%>
<%@page language="java" import="java.util.ResourceBundle,java.io.File"%>
<%@page language="java" import="com.iGrandee.Common.DateTime"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>

<%  
com.iGrandee.Report.ExamDetailspdfstdwise  examQuery = new com.iGrandee.Report.ExamDetailspdfstdwise();
String message="";
com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQueryallot = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();

try
{
	int no_of_rows=0;
	ArrayList ExamList=null;
	String instituteid			= (String)session.getValue("instituteid");
	String reg_sessionid			= request.getParameter("req_sessionid");
	String reg_sessionname			= request.getParameter("req_sessionname");
	String reg_boardnname= request.getParameter("req_boardname");
	String boardid = request.getParameter("req_boardid");

ExamList=examQueryallot.LoadExamnameListRKbystdwise(instituteid,reg_sessionid,boardid); 
boolean boo1 = false;

if(ExamList != null && ExamList.size()>0)
	{
		 no_of_rows=examQuery.loadExamSubjectList(instituteid,reg_sessionid,reg_sessionname,boardid,reg_boardnname);    
		 boo1=true;
	}
	

ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");


String storagepath = bundle.getString("storagepath");
DateTime datobj =new DateTime();
String tem_date=datobj.showTime("WithTime");
tem_date = tem_date.substring(0,tem_date.length()-3);
tem_date = tem_date.replaceAll(":", "_");

String tepfile=storagepath+instituteid+"/archivalpdfs/StandardWiseExamList/StandardWiseExamList"+tem_date+".pdf" ;
File F= new File(tepfile);
boolean boo = F.exists(); 


String paths  = request.getContextPath()+"/OpenDocument?r1=storagepath&r2=/archivalpdfs/StandardWiseExamList/StandardWiseExamList"+tem_date+".pdf" ;
String paths1="";
StringBuffer buffer=new StringBuffer();

File F1= new File(paths);
boo = F1.exists(); 


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