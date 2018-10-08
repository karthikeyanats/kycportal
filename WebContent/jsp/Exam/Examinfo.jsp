<jsp:useBean id="examname_query_object" scope="page"
	class="com.iGrandee.Exam.ExamnameEntry" />
<jsp:useBean id="examnameBean" scope="page"
	class="com.iGrandee.Exam.ExamnameBean" />
	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
	StringBuffer buffer=new StringBuffer();
	String institute_id		=(String)session.getValue("instituteid");

try
{

if(request.getParameter("action").equals("checkDuplicate"))
{

	String temp_str=null;
	
	if((temp_str=request.getParameter("examnames"))!=null)
	{

		ArrayList list = examname_query_object.checkDuplicateExamname(temp_str,institute_id);

		if(list != null && list.size()>0)
		for(int i=0;i<list.size();i++)
		{
			HashMap map=(HashMap)list.get(i);
			String id=(String)map.get("examnameid");
			String name=(String)map.get("examname");
			buffer.append("<result>");
				buffer.append("<id>"+id+"</id>");
				buffer.append("<name>"+name+"</name>");
			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<exam>"+buffer.toString()+"</exam>");
	}
}
else
{

}
}
catch(Exception e)
{
	
}

%>



