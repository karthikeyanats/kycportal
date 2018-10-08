<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.StudentDiary.StudentDiaryQuery" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.StudentDiary.StudentDiaryBean" />

	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();

String ids = request.getParameter("ids");
String names = request.getParameter("names");
ArrayList getStaffStandards=new ArrayList();
ArrayList getStaffid=new ArrayList();
HashMap newgetStaffid=new HashMap();

HashMap newgetStaffStandards=new HashMap();
//System.out.println("**********"+ids+names);
String userid=(String)session.getValue("userid");
//System.out.println("***userid*******"+userid);

if(names.equals("standard"))
{
	getStaffStandards=query_object.getStaffStandards("standard",userid);
	//System.out.println("*******getStaffStandards***"+getStaffStandards);
try
{
	for(int i=0;i<getStaffStandards.size();i++)
	{
		newgetStaffStandards=(HashMap)getStaffStandards.get(i);
	
					    buffer.append("<result>");
						buffer.append("<actiondate>"+(String)newgetStaffStandards.get("standardid")+"</actiondate>");
						buffer.append("<actiondate>"+(String)newgetStaffStandards.get("standardname")+"</actiondate>");

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
}

else if(names.equals("section"))
{
	getStaffStandards=query_object.getStaffStandards("section",userid);
try
{//sectionid, sectionname
	for(int i=0;i<getStaffStandards.size();i++)
	{
		newgetStaffStandards=(HashMap)getStaffStandards.get(i);
	
					    buffer.append("<result>");
						buffer.append("<actiondate>"+(String)newgetStaffStandards.get("sectionid")+"</actiondate>");
						buffer.append("<actiondate>"+(String)newgetStaffStandards.get("sectionname")+"</actiondate>");

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
}
else if(names.equals("subject"))
{
	getStaffStandards=query_object.getStaffStandards("subject",userid);
try
{
	for(int i=0;i<getStaffStandards.size();i++)
	{
		newgetStaffStandards=(HashMap)getStaffStandards.get(i);
	
					    buffer.append("<result>");
						buffer.append("<actiondate>"+(String)newgetStaffStandards.get("subjectscheduleid")+"</actiondate>");
						buffer.append("<actiondate>"+(String)newgetStaffStandards.get("subjectname")+"</actiondate>");

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
}
%>



