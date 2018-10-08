<%@ page language="java" import="java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.PDFReport.StudentReportPDF,com.iGrandee.Common.DateTime"%>
<%@page language="java" import="java.util.ResourceBundle,java.io.File"%>
<%  
//com.iGrandee.Report.ExamDetailspdf  examQuery = new com.iGrandee.Report.ExamDetailspdf();
com.iGrandee.Application.RegistrationProcess  applicationQuery = new com.iGrandee.Application.RegistrationProcess();
com.iGrandee.PDFReport.StudentReportPDF  studentReportPDF = new com.iGrandee.PDFReport.StudentReportPDF();
DateTime datobj =new DateTime();
String message="";

try
{
	ResourceBundle bundle  =ResourceBundle.getBundle("resources.serversetup");
	String storagepath = bundle.getString("storagepath");
	StringBuffer buffer=new StringBuffer();
	String paths  = "No Path";

	//String temp_str=null;
	
	File sp= new File(storagepath);
	
	if(sp.exists()){
	int no_of_rows=0;
	String instituteid		= (String)session.getValue("instituteid");
	String req_sessionid	= request.getParameter("req_sessionid");
	String req_sessionname	= request.getParameter("req_sessionname");
	String req_boardname	= request.getParameter("req_boardname");
	String req_boardid 		= request.getParameter("req_boardid");
	ArrayList studentList 	= null;
	//applicantList = applicationQuery.loadApplicantList("1","1","1","A");
	studentList = applicationQuery.displayStudentListforPdf(request.getParameter("req_sessionid"),request.getParameter("req_boardid"));
     //System.out.println(studentList+"--"+req_sessionname+"--"+req_boardname+"--"+instituteid); 
	if(studentList.size()>0)	
     	no_of_rows=studentReportPDF.generatePdf(studentList,req_sessionid,req_sessionname,req_boardname,instituteid);
	//else 
		//out.print("<script>alert('No Data to Generate PDF')</script>");
	//int no_of_rows=examQuery.loadExamSubjectList(instituteid,reg_sessionid,reg_sessionname,boardid,reg_boardnname);    



String time_stamp=datobj.showTime("WithTime");
time_stamp = time_stamp.substring(0,time_stamp.length()-3);
time_stamp = time_stamp.replaceAll(":", "_");

//String filepath=storagepath+"PDFReports/Student List for "+req_sessionname+"--"+req_boardname+".pdf";
String fullPath=storagepath+instituteid+"/archivalpdfs/"+req_sessionname+"_"+req_sessionid+"/Student List"+"/Student List "+time_stamp+".pdf" ;
String filepath=instituteid+"/archivalpdfs/"+req_sessionname+"_"+req_sessionid+"/Student List"+"/Student List "+time_stamp+".pdf" ;
File fs= new File(fullPath);
boolean boo = fs.exists();


//String paths  = "/kycportal/OpenDocument?r1=storagepath&r2="+filepath+".pdf";

 paths  = request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+filepath;

//StringBuffer buffer=new StringBuffer();

//String temp_str=null;
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
	else{
		buffer.append("<result>");
		buffer.append("<var>NoPath</var>");
		paths=paths.replaceAll("&","&amp;");
		paths=paths.replaceAll("'","&#39;");
		buffer.append("<downloadfile>"+paths+"</downloadfile>");
		buffer.append("</result>");
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
		
	}
 	
}catch(Exception e)
{
	System.out.print(e);
}
	
	
	
%>