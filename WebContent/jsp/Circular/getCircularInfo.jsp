<%@page import="java.net.URLEncoder"%>
<%@page import="com.iGrandee.Circular.CircularEntryQuery,com.iGrandee.Attendance.AttendanceQuery,com.iGrandee.Prinicipal.PrinicipalQuery"%>
<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<%
PrinicipalQuery circularQuery2=new PrinicipalQuery();
CircularEntryQuery circularQuery =new CircularEntryQuery();
AttendanceQuery circularQuery1 =new AttendanceQuery();
%>
<%
	StringBuffer buffer=new StringBuffer();
	String instituteid			= (String)session.getValue("instituteid");
	//System.out.println("===>>>>"+request.getQueryString());
	if(request.getParameter("action").equals("year"))
	{
		ArrayList list		= circularQuery.loadyearofsession(instituteid);
		for(int i=0;i<list.size();i++)
		{
			HashMap map=(HashMap)list.get(i);
			String id=(String)map.get("sessionid");
			String name=(String)map.get("sessionname");
			buffer.append("<result>");
			buffer.append("<sessionid>"+id+"</sessionid>");
			buffer.append("<sessionname>"+name+"</sessionname>");
			buffer.append("</result>");
		}
 		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<year>"+buffer.toString()+"</year>");
	}
	else if(request.getParameter("action").equals("board"))
	{
		ArrayList list		= circularQuery1.loadboard(instituteid);
		for(int i=0;i<list.size();i++)
		{
			HashMap map=(HashMap)list.get(i);
			String id=(String)map.get("boardid");
			String name=(String)map.get("boardname");
			String mediumname=(String)map.get("mediumname")+"";
			if(!mediumname.equals("null"))
				name=name+" -"+mediumname;
			buffer.append("<result>");
			buffer.append("<boardid>"+id+"</boardid>");
			buffer.append("<boardname>"+name+"</boardname>");
			buffer.append("</result>");
		}
 		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<board>"+buffer.toString()+"</board>");
	}
	
	else if(request.getParameter("action").equals("standard"))
	{
		String temp_str		= null;
		ArrayList list		= null;

		if((temp_str=request.getParameter("yearid"))!=null)
		{
			String courseCollection=request.getParameter("yearid");
			String boardid=request.getParameter("boardid");
			list=circularQuery1.loadstandard(boardid,courseCollection,instituteid);
					for(int i=0;i<list.size();i++)
					{
						HashMap map=(HashMap)list.get(i);
						String standardschedule_id=(String)map.get("standardscheduleid");
						String name=(String)map.get("standardname");
						String Groupname=(String)map.get("groupname")+"";
						if(!Groupname.equals("null"))
							name=name+" -"+Groupname;
						buffer.append("<result>");
							buffer.append("<standardid>"+standardschedule_id+"</standardid>");
							buffer.append("<standardname>"+name+"</standardname>");
						buffer.append("</result>");
					}

					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<standard>"+buffer.toString()+"</standard>");
				}
			}
	else if(request.getParameter("action").equals("institute"))
	{
		ArrayList list=circularQuery.loadinstitute();
		for(int i=0;i<list.size();i++)
		{
			HashMap map=(HashMap)list.get(i);
			String id=(String)map.get("instituteid");
			String name=(String)map.get("institutename");

			buffer.append("<result>");
				buffer.append("<instituteid>"+id+"</instituteid>");
				buffer.append("<institutename>"+name+"</institutename>");
			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<institute>"+buffer.toString()+"</institute>");
 	}
	else if(request.getParameter("action").equals("department"))
	{
		String temp_str=null;
			ArrayList list=circularQuery2.loadActiveDepartments(instituteid); 
			for(int i=0;i<list.size();i++)
			{
				HashMap map=(HashMap)list.get(i);
				String id=(String)map.get("departmentid");
				String name=(String)map.get("departmentname");
				buffer.append("<result>");
				buffer.append("<departmentid>"+id+"</departmentid>");  
				buffer.append("<departmentname>"+name.replaceAll("&","%26")+"</departmentname>");
				buffer.append("</result>");
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<department>"+buffer.toString()+"</department>");
		}
	else if(request.getParameter("action").equals("role"))
	{
		String temp_str=null;
		if((temp_str=request.getParameter("departmentid"))!=null)
		{ 
			String tempvar="";
			ArrayList list=circularQuery2.loadstaffusingdepartment(temp_str);
			for(int i=0;i<list.size();i++)
			{
				HashMap map=(HashMap)list.get(i);
				String id=(String)map.get("roleid");
 				String name=(String)map.get("rolename");
				if(!tempvar.equals(id))
				{
				buffer.append("<result>");
				buffer.append("<roleid>"+id+"</roleid>");
 				buffer.append("<rolename>"+name+"</rolename>");
				buffer.append("</result>");
				tempvar=id;
				}
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<role>"+buffer.toString()+"</role>");
		}
	}
	else if(request.getParameter("action").equals("staff"))
	{
		String temp_str=null;
		if((temp_str=request.getParameter("departmentid"))!=null)
		{
			ArrayList list=circularQuery2.loadstaffusingdepartment(temp_str);
			//System.out.println("====>>>"+list);
			for(int i=0;i<list.size();i++)
			{
				HashMap map=(HashMap)list.get(i);
				String id=(String)map.get("staffid");
				String name=(String)map.get("username");
				String rname=(String)map.get("rolename");
				buffer.append("<result>");
					buffer.append("<personid>"+id+"</personid>");
					buffer.append("<personname>"+name+"</personname>");
					buffer.append("<rolename>"+rname+"</rolename>");
				buffer.append("</result>");
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<staff>"+buffer.toString()+"</staff>");
		}
	}
	else if(request.getParameter("action").equals("student"))
	{
		String temp_str=null;
		if((temp_str=request.getParameter("sectionscheduleid"))!=null)
		{
			ArrayList list=circularQuery2.loadstudentforsectionscheduleid(temp_str,"T"); 
				//System.out.println("===>>>"+list);
			for(int i=0;i<list.size();i++)
			{
				HashMap map=(HashMap)list.get(i);
				String personid=(String)map.get("personid");
				String name=(String)map.get("uname");
				String studentallocationid=(String)map.get("studentallocationid");

				buffer.append("<result>");
					buffer.append("<personid>"+personid+"</personid>");
					buffer.append("<personname>"+name+"</personname>");
					buffer.append("<studentid>"+studentallocationid+"</studentid>");
				buffer.append("</result>");
			}
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<student>"+buffer.toString()+"</student>");
		}
	}
	else if(request.getParameter("action").equals("section"))
		{
			String temp_str=null;
			if((temp_str=request.getParameter("standardscheduleid"))!=null)
			{
				ArrayList list=circularQuery2.loadsection(temp_str,instituteid);
				for(int i=0;i<list.size();i++)
				{
					HashMap map=(HashMap)list.get(i);
					String id=(String)map.get("sectionscheduleid");
					String name=(String)map.get("sectionname");

					buffer.append("<result>");
						buffer.append("<sectionid>"+id+"</sectionid>");
						buffer.append("<sectionname>"+name+"</sectionname>");
					buffer.append("</result>");
				}
				response.setContentType("text/xml");
				response.setHeader("Cache-Control", "no-cache");
				response.getWriter().write("<section>"+buffer.toString()+"</section>");
			}
	}

%>


