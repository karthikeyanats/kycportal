
<jsp:useBean id="religionname_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionQuery" />
<jsp:useBean id="religionBean" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionBean" />
	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String institute_id		=(String)session.getValue("instituteid");

try
{

if(request.getParameter("action").equals("checkDuplicate"))
{

	String temp_str=null;
	
	if((temp_str=request.getParameter("religionnames"))!=null)
	{

		//ArrayList list		= examQuery.getExams(temp_str,institute_id);
		ArrayList list = religionname_query_object.checkDuplicateReligionname(temp_str,institute_id);

		if(list != null && list.size()>0)
		for(int i=0;i<list.size();i++)
		{
			HashMap map=(HashMap)list.get(i);
			String id=(String)map.get("religionid");
			String name=(String)map.get("religionname");
			buffer.append("<result>");
				buffer.append("<id>"+id+"</id>");
				buffer.append("<name>"+name+"</name>");
			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<religion>"+buffer.toString()+"</religion>");
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



