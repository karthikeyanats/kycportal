<jsp:useBean id="examname_query_object" scope="page"
	class="com.iGrandee.Exam.ExamnameEntry" />
<jsp:useBean id="examnameBean" scope="page"
	class="com.iGrandee.Exam.ExamnameBean" />
<%@ page language="java" import="java.util.*"%>
<%
	String op=null;
	String return_file=null;
	int result = 0;
	String curstatus = "T";
try{
		String examnameid=request.getParameter("examnameid_hidden");
		//System.out.println("Examid TRASH::::::>>>>"+examnameid);
		String examname = request.getParameter("examname_hidden");
		String examremarks=request.getParameter("examremarks_hidden");
		String createdby=request.getParameter("createdby_hidden");
		//System.out.println("createdby TRASH::::::>>>>"+createdby);
		String instituteid = (String)session.getValue("instituteid");
		//String ipaddress = request.getLocalAddr();
		String LogStatus = "Trashed";
		examnameBean.setExamnameid(examnameid);
		examnameBean.setInstituteid(instituteid);
		examnameBean.setExamnamestatus(curstatus);
		examnameBean.setCreatedby(createdby);
		
		result = examname_query_object.updateTrashExamname(examnameBean);
		if(result>0)
			op="Examname Successfully Trashed";
		else
			op="Examname Failed to Trash";

		return_file = request.getContextPath()+"/jsp/Exam/ExamnameEntry.jsp";
		response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
		
}catch(Exception e){}
	
%>
