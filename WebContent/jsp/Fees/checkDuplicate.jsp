
<jsp:useBean id="validate" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />

	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String fieldname1 = request.getParameter("fieldname1");
String instituteid="";
instituteid=(String)session.getValue("instituteid"); 


String tabname=request.getParameter("tabname");


try
{ 
	if(tabname.equals("feeshead"))
	{
		boolean aa=validate.checkDuplicatewithstatus("feeshead","feesheadname",fieldname1,"feesheadstatus",instituteid);

					    buffer.append("<result>");
						buffer.append("<actiondate>"+aa+"</actiondate>");

						buffer.append("</result>");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
   
else if(tabname.equals("feestermname"))
   { 
	boolean aa=validate.checkDuplicatewithstatus("feestermname","termname",fieldname1,"termstatus",instituteid);

    buffer.append("<result>");
	buffer.append("<actiondate>"+aa+"</actiondate>");

	buffer.append("</result>");
response.setContentType("text/xml");
response.setHeader("Cache-Control", "no-cache");
response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
   }
else if(tabname.equals("feesheadupdate"))
{
	com.iGrandee.Fees.FeesHeadQuery FeesHeadQuery = new com.iGrandee.Fees.FeesHeadQuery();
String feesheadid=request.getParameter("feesheadid");
String feesheadname=request.getParameter("feesheadname");

	 boolean aa=FeesHeadQuery.checkDuplicateupdate(feesheadid,feesheadname,instituteid);

				    buffer.append("<result>");
					buffer.append("<actiondate>"+aa+"</actiondate>");

					buffer.append("</result>");
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
}

else if(tabname.equals("feestermupdate"))
{
	com.iGrandee.Fees.FeesHeadQuery FeesHeadQuery = new com.iGrandee.Fees.FeesHeadQuery();
String termid=request.getParameter("termid");
String termname=request.getParameter("termname");

	 boolean aa=FeesHeadQuery.checkDuplicateupdateFeesTerm(termid,termname,instituteid);
 
				    buffer.append("<result>");
					buffer.append("<actiondate>"+aa+"</actiondate>");

					buffer.append("</result>");
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
}	
}	

catch(Exception e)
{
	//System.out.println("propactionerror"+e);
}
%>



