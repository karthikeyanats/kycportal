<jsp:useBean id="examname_query_object" scope="page"
	class="com.iGrandee.Exam.ExamnameEntry" />
<jsp:useBean id="examnameBean" scope="page"
	class="com.iGrandee.Exam.ExamnameBean" />
    
<%@ page import="java.io.*,java.util.*"%>

<%
	String op="";
	int result=0;
	String return_file = null;
try{
		String examnameid = request.getParameter("examnameid_hidden");
		//System.out.println("ACTIVATE examnameid:::::>>>>"+examnameid);	
		String createdby = request.getParameter("createdby_hidden");
		//System.out.println("ACTIVATE createdby:::::>>>>"+createdby);
		String instituteid =(String)session.getValue("instituteid");
		
		//String ipaddress = request.getLocalAddr();

		examnameBean.setExamnameid(examnameid);
		examnameBean.setCreatedby(createdby);
		examnameBean.setInstituteid(instituteid);
		//examnameBean.setIpaddess(ipaddress);

		result = examname_query_object.ActivateExamname(examnameBean);
		if(result>0)
			op=" Examname Successfully Activated";
		else
			op="Examname Failed to Activate";
	
		return_file = request.getContextPath()+"/jsp/Exam/ExamnameEntry.jsp";
		response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
}catch(Exception e){}
	%>
