
<jsp:useBean id="communityname_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityQuery" />
<jsp:useBean id="communitynameBean" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityBean" />
	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String institute_id		=(String)session.getValue("instituteid");

try
{

if(request.getParameter("action").equals("checkDuplicate"))
{

	String temp_str=null;
	
	if((temp_str=request.getParameter("communitynames"))!=null)
	{

		//ArrayList list		= examQuery.getExams(temp_str,institute_id);
		ArrayList list = communityname_query_object.checkDuplicateCommunityname(temp_str,institute_id);

		if(list != null && list.size()>0)
		for(int i=0;i<list.size();i++)
		{
			HashMap map=(HashMap)list.get(i);
			String id=(String)map.get("communityid");
			String name=(String)map.get("communityname");
			buffer.append("<result>");
				buffer.append("<id>"+id+"</id>");
				buffer.append("<name>"+name+"</name>");
			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<community>"+buffer.toString()+"</community>");
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



