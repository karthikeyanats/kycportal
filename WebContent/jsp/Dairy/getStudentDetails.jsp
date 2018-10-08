<jsp:useBean id="query_object" scope="page" class="com.iGrandee.Dairy.Dairy" />
<%@ page import="java.util.ArrayList,java.util.HashMap"%>
	
<%
	StringBuffer buffer	= new StringBuffer();
	String section 		= request.getParameter("section");
	String instituteid	= (String)session.getValue("instituteid"); 
	ArrayList StudentDetails 		= null; 
	HashMap hashmap		= null;
try{
		
	StudentDetails=query_object.DiarySmsforstudentParent(section,instituteid);

	if(StudentDetails != null && StudentDetails.size()>0)
	for(int i=0;i<StudentDetails.size();i++)
	{
		
		hashmap		= (HashMap)StudentDetails.get(i);

	    buffer.append("<result>");
			buffer.append("<actiondate>"+hashmap.get("applicantname")+"</actiondate>");
			buffer.append("<actiontaken>"+hashmap.get("smscontactno")+"</actiontaken>");
			
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



