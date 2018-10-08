<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="gradeQuery" scope="page" class="com.iGrandee.Exam.ExamnameEntry"/>
<%
	StringBuffer buffer=new StringBuffer();
	boolean checkString = false;
	if(request.getParameter("action").equals("duplicategradename"))
		{	
		//System.out.println("============>>>>>>>>>>>>>>>"+request.getQueryString());
		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
		if((temp_str=request.getParameter("gradename"))!=null && (temp_str1=request.getParameter("reqgradeid"))!=null  && (temp_str2=request.getParameter("reqsessionid"))!=null)
		{
			//System.out.println("============>>>>>>>>>>>>>>>"+request.getQueryString()+"<<<<<<<<<<<<<<============");
			checkString=gradeQuery.checkDuplicate(temp_str,temp_str2,temp_str1);
			buffer.append("<result>");
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
	}
	else if(request.getParameter("action").equals("duplicaterange"))
	{	
	String temp_str2=null;
	String temp_str3=null;

	if((temp_str2=request.getParameter("reqgradeid"))!=null && (temp_str3=request.getParameter("reqsessionid"))!=null)
	{
		//System.out.println("============>>>>>>>>>>>>>>>"+request.getQueryString()+"<<<<<<<<<<<<<<============");
		ArrayList rangelist=gradeQuery.LoadRangeListforsessionid(temp_str3,temp_str2);
		if(rangelist.size()>0)
		{
			for(int i=0;i<rangelist.size();i++)
				{
					HashMap hash=(HashMap)rangelist.get(i);
					buffer.append("<result>");
					buffer.append("<form>"+hash.get("rangefrom")+"</form>");
					buffer.append("<to>"+hash.get("rangeto")+"</to>");
					buffer.append("</result>");
				}
		}
	}
	response.setContentType("text/xml");
	response.setHeader("Cache-Control", "no-cache");
	response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
}
%>