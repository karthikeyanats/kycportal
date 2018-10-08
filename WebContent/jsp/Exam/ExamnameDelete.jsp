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
	String Examnameid = request.getParameter("examnameid_hidden");
	//System.out.println("DELETE Examnameid::::>>>"+Examnameid);
	String createdby=request.getParameter("createdby_hidden");
	//System.out.println("DELETE createdby::::>>>"+createdby);
	//String createdby = "1";
	String instituteid = (String)session.getValue("instituteid");
	//String ipaddress = request.getLocalAddr();
	examnameBean.setExamnameid(Examnameid);
	examnameBean.setCreatedby(createdby);
	examnameBean.setInstituteid(instituteid);
	//examnameBean.setIpaddess(ipaddress);
	
	result = examname_query_object.DeleteExamnames(examnameBean);

	if(result>0)
		op=" Examname Successfully Deleted";
	else
		op="Examname Failed to Delete";

	return_file = request.getContextPath()+"/jsp/Exam/ExamnameEntry.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
}catch(Exception e){}
	
%>
