<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.StudentDiary.StudentDiaryQuery" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.StudentDiary.StudentDiaryBean" />

	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String startdate = request.getParameter("startdate");
String enddate = request.getParameter("enddate");
ArrayList arrays=new ArrayList();
HashMap newarrays=new HashMap();
//System.out.println("*********"+startdate+enddate);
 arrays=query_object.searchStudentDiary(startdate,enddate);
System.out.println("**************"+arrays);
try
{
	for(int i=0;i<arrays.size();i++)
	{
		newarrays=(HashMap)arrays.get(i);
	    buffer.append("<result>");
		buffer.append("<actiondate>"+(String)newarrays.get("subject")+"</actiondate>");
		buffer.append("<actiondate>"+(String)newarrays.get("subdates")+"</actiondate>");
		buffer.append("<actiondate>"+(String)newarrays.get("diaryallocationid")+"</actiondate>");

		

		buffer.append("</result>");
}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
}
	
		

catch(Exception e)
{
	System.out.println("propactionerror"+e);
}
%>



