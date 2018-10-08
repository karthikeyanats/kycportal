<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="attencequery" scope="page" class="com.iGrandee.Attendance.AttendanceQuery" />
<jsp:useBean id="registrationQuery" scope="page" class="com.iGrandee.Application.RegistrationProcess" />

<%
	StringBuffer buffer=new StringBuffer();
	if(request.getParameter("action").equals("standard"))
	{	
	String temp_str=null;
	String temp_str1=null;
	String temp_str2=null;
		if((temp_str=request.getParameter("boardid"))!=null && (temp_str1=request.getParameter("sessionid"))!=null && (temp_str2=request.getParameter("instituteid"))!=null)
		{
			//ArrayList standList=attencequery.loadstandard(temp_str,temp_str1,temp_str2);
			ArrayList standList=registrationQuery.loadStandardForStaff((String)session.getValue("userid"),temp_str1,temp_str);
			
			if(standList != null && standList.size()>0)
			for(int y=0;y<standList.size();y++){
			HashMap	hashmap		= (HashMap)standList.get(y);
			String standardscheduleid=(String)hashmap.get("standardscheduleid");
			String standardname=(String)hashmap.get("standardname");
			String groupname=(String)hashmap.get("groupname")+"";
			if(!groupname.equals("null") && !groupname.equals("NoGroup"))
			standardname=standardname+" -"+groupname;
			buffer.append("<result>");
			buffer.append("<var>"+standardscheduleid+"</var>");
			buffer.append("<var>"+standardname+"</var>");
			buffer.append("<var>"+hashmap.get("enddate")+"</var>");
			buffer.append("<var>"+hashmap.get("startdate")+"</var>");
			
 			buffer.append("</result>");
			}
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<standard>"+buffer.toString()+"</standard>");
	}
	else if(request.getParameter("action").equals("section"))
	{	
		String temp_str1=null;
		String temp_str2=null;
			if((temp_str1=request.getParameter("standardscheduleid"))!=null && (temp_str2=request.getParameter("instituteid"))!=null)
			{
				//ArrayList standList=attencequery.loadsection(temp_str1,temp_str2);
				ArrayList standList=registrationQuery.loadSectionForStaff((String)session.getValue("userid"),temp_str1);
				
				//System.out.println("====>>>"+standList);
				if(standList != null && standList.size()>0)
				for(int y=0;y<standList.size();y++){
				HashMap	hashmap		= (HashMap)standList.get(y);
				String sectionname=(String)hashmap.get("sectionname");
				String sectionscheduleid=(String)hashmap.get("sectionscheduleid");
				buffer.append("<result>");
				buffer.append("<var>"+sectionscheduleid+"</var>");
				buffer.append("<var>"+sectionname+"</var>");
	 			buffer.append("</result>");
				}
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<section>"+buffer.toString()+"</section>");
		}
	
%>


