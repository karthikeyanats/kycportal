
 <%@ page
					import="com.iGrandee.Parent.ParentHome"%>
			
	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String circularid = request.getParameter("circularid");
//System.out.println(circularid);
String flage=request.getParameter("flage");
ParentHome parentquery = new ParentHome();
//System.out.println("oooooooo"+request.getQueryString());
try
{
	if(flage=="A" || flage.equals("A"))
	{
	
		String s=null;
	

		ArrayList circulararray=new ArrayList();
		ArrayList institutearray=new ArrayList();
		HashMap circularmap=null;
		circulararray=parentquery.CircularViewListForStudentPage(circularid);
		

			//out.println(circulararray); 
			if (circulararray != null && circulararray.size() > 0)
			{
			for (int i = 0; i < circulararray.size(); i++) 
			{
				
				circularmap=(HashMap)circulararray.get(i);
				String edate=(String)circularmap.get("dateofcreation");
				String subject=(String)circularmap.get("subject");
				String attachments = (String) circularmap.get("attachments");
				String details = (String) circularmap.get("details");
				

			    buffer.append("<result>");
				buffer.append("<actiondate>"+subject+"</actiondate>");
				buffer.append("<actiontaken>"+details+"</actiontaken>");
				buffer.append("<actiondate>"+edate+"</actiondate>");
				buffer.append("<actiontaken>"+attachments+"</actiontaken>");

				buffer.append("</result>");
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
			}
			
			
					
		
		
	
	
	}
	else  if(flage=="B" || flage.equals("B"))
	{

		String instituteid=(String)session.getValue("instituteid");

		HashMap institutemap=null;
		
		ArrayList institutearray=parentquery.InstituteDetailForCircularStudentPage(instituteid);
		//System.out.println(institutearray); 

		
			if (institutearray != null && institutearray.size() > 0)
			{
			for (int i = 0; i < institutearray.size(); i++) 
			{
				
					institutemap=(HashMap)institutearray.get(i);
				String institutename=(String)institutemap.get("institutename");
				String country=(String)institutemap.get("country");
				String state = (String) institutemap.get("state");
				String institutelogo = (String) institutemap.get("institutelogo");
				

				    buffer.append("<result>");
				buffer.append("<actiondate>"+institutename+"</actiondate>");
				buffer.append("<actiontaken>"+country+"</actiontaken>");
				buffer.append("<actiondate>"+state+"</actiondate>");
				buffer.append("<actiontaken>"+institutelogo+"</actiontaken>");

				buffer.append("</result>");
			}
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
					
	
	
			
		
}
catch(Exception e)
{
	System.out.println("propactionerror"+e);
}
%>



