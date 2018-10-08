<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="extraquery" scope="page" class="com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery" />
<%
	StringBuffer buffer=new StringBuffer();
	if(request.getParameter("action").equals("standard"))
	{	
	String temp_str=null;
	String temp_str1=null;
	String temp_str2=null;
		if((temp_str=request.getParameter("boardid"))!=null && (temp_str1=request.getParameter("sessionid"))!=null && (temp_str2=request.getParameter("instituteid"))!=null)
		{
			ArrayList standList=extraquery.loadstandard(temp_str,temp_str1,temp_str2);
			//System.out.println("====>>>"+standList);
			if(standList != null && standList.size()>0)
			for(int y=0;y<standList.size();y++){
			HashMap	hashmap		= (HashMap)standList.get(y);
			String standardscheduleid=(String)hashmap.get("standardscheduleid");
			String standardname=(String)hashmap.get("standardname");
			String groupname=(String)hashmap.get("groupname")+"";
			if(!groupname.equals("null"))
			standardname=standardname+" -"+groupname;
			buffer.append("<result>");
			buffer.append("<var>"+standardscheduleid+"</var>");
			buffer.append("<var>"+standardname+"</var>");
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
				ArrayList standList=extraquery.loadsection(temp_str1,temp_str2);
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
	else if(request.getParameter("action").equals("student"))
	{
		String temp_str1=null;
		String temp_str2=null;
		String temp_str3=null;
		String temp_str4=null;
		String temp_str5=null;


		if((temp_str1=request.getParameter("sessionid"))!=null && (temp_str2=request.getParameter("standardscheduleid"))!=null && (temp_str3=request.getParameter("section"))!=null && (temp_str4=request.getParameter("instituteid"))!=null && (temp_str5=request.getParameter("eventid"))!=null)
		{
			ArrayList parent=extraquery.loadstudent(temp_str2,temp_str1,temp_str3,temp_str4,temp_str5);
			//System.out.println(parent);
			for(int i=0;i<parent.size();i++) 
			{
			HashMap innermap=(HashMap)parent.get(i);
			
			String curriculareventid=(String)innermap.get("curriculareventid");
			String studentallocationid=(String)innermap.get("studentallocationid");
			String rollno=(String)innermap.get("rollno");
			String applicantname=(String)innermap.get("applicantname");
			buffer.append("<result>");
			buffer.append("<var>"+studentallocationid+"</var>");
			buffer.append("<var>"+rollno+"</var>");
			buffer.append("<var>"+applicantname+"</var>");
			buffer.append("<var>"+curriculareventid+"</var>");

			buffer.append("</result>");
			}
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<student>"+buffer.toString()+"</student>");
	}
	
%>


