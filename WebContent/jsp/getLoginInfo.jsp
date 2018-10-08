<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="commonDataAccess" scope="page" class="com.iGrandee.Common.CommonDataAccess"/>
<jsp:useBean id="relationcheck" scope="page" class="com.iGrandee.Registration.StudentRegistrationQuery" />

<%

	StringBuffer buffer=new StringBuffer();

	if(request.getParameter("action").equals("schoolname"))
	{	String temp_str=null;
		if((temp_str=request.getParameter("name"))!=null)
		{
			boolean boo=commonDataAccess.checkDuplicate("institution","institutename",temp_str);

			buffer.append("<result>");
				buffer.append("<var>"+boo+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");

	}
	else if(request.getParameter("action").equals("username"))
	{
		String temp_str=null;
		if((temp_str=request.getParameter("name"))!=null)
		{
			boolean boo=commonDataAccess.checkDuplicate("login","username",temp_str);

			buffer.append("<result>");
				buffer.append("<var>"+boo+"</var>");
			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");



	}
	else if(request.getParameter("action").equals("parentname"))
	{
		String temp_str=null;
		if((temp_str=request.getParameter("name"))!=null)
		{
			boolean boo=commonDataAccess.checkDuplicate("parentlogin","parentusername",temp_str);

			buffer.append("<result>");
				buffer.append("<var>"+boo+"</var>");
			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");



	}
	else if(request.getParameter("action").equals("RelationCheck"))
	{
		String temp_str=null;
		if((temp_str=request.getParameter("name"))!=null)
		{
			ArrayList parent=relationcheck.relationcheck(temp_str);
			if(parent.size()>0)
			{
			HashMap innermap=(HashMap)parent.get(0);
			String parentid=(String)innermap.get("parentid");
			String parentusername=(String)innermap.get("parentusername");
			String fathername=(String)innermap.get("fathername")+"";
			String mothername=(String)innermap.get("mothername")+"";
			String uname=(String)innermap.get("uname")+"";
			String imagepath=(String)innermap.get("imagepath")+"";
	
			if(parent.equals(""))
				parentid="nodatafound";
			if(fathername.equals("null"))
				fathername="-";
			if(mothername.equals("null"))
				mothername="-";
			//System.out.println("parent"+parentid);
			
			buffer.append("<result>");
			buffer.append("<var>"+parentid+"</var>");
			buffer.append("<var>"+parentusername+"</var>");
			buffer.append("<var>"+fathername+"</var>");
			buffer.append("<var>"+mothername+"</var>");
			buffer.append("<var>"+uname+"</var>");
			buffer.append("<var>"+imagepath+"</var>");
			buffer.append("</result>");
		}
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<relationcheck>"+buffer.toString()+"</relationcheck>");
	}
%>


