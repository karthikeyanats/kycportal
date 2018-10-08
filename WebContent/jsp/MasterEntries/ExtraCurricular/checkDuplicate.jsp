<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String fieldname1 = request.getParameter("fieldname1");


String tabname=request.getParameter("tabname");


try
{
	if(tabname.equals("extracurricularcategory"))
	{		com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
		
	boolean aa=extraCurricularQuery.checkduplicate("extracurricularcategory","extcurricularcategoryname",fieldname1,"curricularstatus");
					    buffer.append("<result>");
						buffer.append("<actiondate>"+aa+"</actiondate>");

						buffer.append("</result>");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
   

	if(tabname.equals("curricularevent"))
	{
		com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();

		String extracurricularcategoryid=request.getParameter("extracurricularcategoryid");
		 String sessionid=request.getParameter("sessionid")+"";
		boolean aa=extraCurricularQuery.checkduplicateforCurricularevent("curricularevent","curriculareventname",fieldname1,extracurricularcategoryid,"eventstatus",sessionid);
					    buffer.append("<result>"); 
						buffer.append("<actiondate>"+aa+"</actiondate>"); 

						buffer.append("</result>");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
	if(tabname.equals("extracuriculaerupdateupdate"))
	{
		com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();

		String extracurricularcategoryid=request.getParameter("reqcurricularcategoryid");
		boolean aa=extraCurricularQuery.checkduplicateforCurriculareventUpdate(fieldname1,extracurricularcategoryid);

		
					    buffer.append("<result>");
						buffer.append("<actiondate>"+aa+"</actiondate>");

						buffer.append("</result>");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
	if(tabname.equals("extracuriculaereventupdateupdate"))
	{
		com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();

		String extracurricularcategoryid=request.getParameter("reqcurricularcategoryid");
		String reqcategoryids=request.getParameter("reqcategoryids");
		boolean aa=extraCurricularQuery.checkduplicateforCurriculareventNewUpdateCategor(fieldname1,extracurricularcategoryid,reqcategoryids);

		
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



