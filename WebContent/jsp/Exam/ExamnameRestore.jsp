<jsp:useBean id="examname_query_object" scope="page"
    class="com.iGrandee.Exam.ExamnameEntry" />
<jsp:useBean id="examnameBean" scope="page"
	class="com.iGrandee.Exam.ExamnameBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String op="";
	int result=0;
	String return_file = null;
	try{
	String examnameid=request.getParameter("examnameid_hidden");
	//System.out.println("RESTORE Examname id:::>>>"+examnameid);
	//String createdby = "1";
	String createdby = request.getParameter("createdby_hidden");
	//System.out.println("RESTORE Createdby id:::>>>"+createdby);
	String instituteid = (String)session.getValue("instituteid");
	//String ipaddress = request.getLocalAddr();

	examnameBean.setExamnameid(examnameid);
	examnameBean.setCreatedby(createdby);
	examnameBean.setInstituteid(instituteid);
	
	
	//examnameBean.setIpaddess(ipaddress);

	result = examname_query_object.RestoreExamname(examnameBean);
	if(result>0)
		op=" Examname Successfully Restored";
	else
		op="Examname Failed to Restore";

	return_file = request.getContextPath()+"/jsp/Exam/ExamnameEntry.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	}catch(Exception e){}
%>
