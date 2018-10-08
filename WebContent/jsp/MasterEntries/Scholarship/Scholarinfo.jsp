
<jsp:useBean id="scholarshipname_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery" />
<jsp:useBean id="scholarshipBean" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarBean" />
	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String institute_id		=(String)session.getValue("instituteid");

try
{

if(request.getParameter("action").equals("checkDuplicate"))
{

	String temp_str=null;
	
	if((temp_str=request.getParameter("scholarshipnames"))!=null)
	{

		//ArrayList list		= examQuery.getExams(temp_str,institute_id);
		ArrayList list = scholarshipname_query_object.checkDuplicateScholarshipname(temp_str,institute_id);

		if(list != null && list.size()>0)
		for(int i=0;i<list.size();i++)
		{
			HashMap map=(HashMap)list.get(i);
			String id=(String)map.get("scholarshipid");
			String name=(String)map.get("scholarshipname");
			buffer.append("<result>");
				buffer.append("<id>"+id+"</id>");
				buffer.append("<name>"+name+"</name>");
			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<scholarship>"+buffer.toString()+"</scholarship>");
	}
}
else
{

}
}
catch(Exception e)
{
	//System.out.println("propactionerror"+e);
}

%>



