<jsp:useBean id="circularQuery" 		scope="page" class="com.iGrandee.Circular.CircularEntryQuery"/>
<%@ page import="java.util.ArrayList,java.util.HashMap"%>
	
<%
	StringBuffer buffer	= new StringBuffer();
String mode=request.getParameter("mode");
String ids="";
String deptid="";
String roleid="";


	ArrayList StudentDetails 		= null; 
	HashMap hashmap		= null;

try{
		
	if(mode.equals("Standard"))
	{
	ids=request.getParameter("ids");
	StudentDetails=circularQuery.smsforcircular(ids);  
	} 
	else if(mode.equals("Role"))
	{
		roleid=request.getParameter("roleid");
		deptid=request.getParameter("deptid");
		StudentDetails=circularQuery.smsforcircularRolewise(roleid,deptid);  

	}
	else if(mode.equals("staff"))
	{
		ids=request.getParameter("ids");
		StudentDetails=circularQuery.smsforcircularStaffwise(ids);  


	}
	else if(mode.equals("student"))
	{
		ids=request.getParameter("ids");
		StudentDetails=circularQuery.smsforcircularStudentwise(ids);   


	}
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



