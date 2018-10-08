<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Topper List | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
     

<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>
<%
ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();
ArrayList StudentMarks=new ArrayList();
HashMap StudentMarksHash=new HashMap();
String studentallocationid="";
String standardid="";
String reg_examid="";

studentallocationid=request.getParameter("studentallocationid");
standardid=request.getParameter("standardid");
reg_examid=request.getParameter("regexamid");    
      
       // out.println(studentallocationid+" "+standardid+" "+reg_examid);      
StudentMarks=examQuery.getMarkDetailsForsinglestud(standardid,studentallocationid,reg_examid);   

//out.print(StudentMarks);

%>

<%

out.print("<table border=1 width='100%' align='center'");
out.print("<tr>");
if(StudentMarks!=null && StudentMarks.size()>0 )
{
	for(int i=0;i<StudentMarks.size();i++)
	{
	StudentMarksHash=(HashMap)StudentMarks.get(i);
	String studentname=StudentMarksHash.get("studentname")+"";
	String imagepath=StudentMarksHash.get("imagepath")+"";
	String rollno=StudentMarksHash.get("rollno")+"";
	String marktaken=StudentMarksHash.get("marktaken")+"";
	if(rollno == null || rollno.equals("") || rollno.equals("-") || rollno.equalsIgnoreCase("null"))
	{
	
	rollno="<font size='1px' class='tablelight' ><i>Not Generated</i></font>";

	}    
	else
	{
		rollno=StudentMarksHash.get("rollno")+"";            

	}
	if(marktaken == null || marktaken.equals("") || marktaken.equals("-") || marktaken.equalsIgnoreCase("null"))
	{
		marktaken="<font size='1px' class='tablelight'  ><i>Not Entered</i></font>";
	}
	else
	{
		marktaken=StudentMarksHash.get("marktaken")+"";               
	}
	String sectionname=StudentMarksHash.get("sectionname")+"";
	String subjectname=StudentMarksHash.get("subjectname")+"";
	String standardname=StudentMarksHash.get("standardname")+"";

	out.print("<td><table border=0 align='center'  valign='top'><tr><td class='tablelight' cellpadding='4' cellspacing='2'>"+studentname+"</td></tr><tr><td class='tablelight' cellpadding='4' cellspacing='2'>"+rollno+"</td></tr><tr><td class='tablelight' cellpadding='4' cellspacing='2'>"+sectionname+"</td></tr><tr><td class='tablebold' cellpadding='4' cellspacing='2'>"+subjectname+"</td></tr><tr><td class='tablelight' cellpadding='4' cellspacing='2'><a class='tablebold'>Marks :</a> "+marktaken+"</td></tr></table>");
    
	}  
}
out.print("</tr>");
out.print("</table>");


%>
<br><br>

