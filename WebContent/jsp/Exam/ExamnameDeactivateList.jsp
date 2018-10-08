<jsp:useBean id="examname_query_object" scope="page"
	class="com.iGrandee.Exam.ExamnameEntry" />
<jsp:useBean id="examnameBean" scope="page"
	class="com.iGrandee.Exam.ExamnameBean" />
   
<%@ page import="java.io.*,java.util.*"%>

<%
	String op=null;
	String return_file=null;
	int result = 0;

	String examnameid = request.getParameter("examnameid_hidden");
	String createdby = request.getParameter("createdby_hidden");
	String instituteid =(String)session.getValue("instituteid");
	//String ipaddress = request.getLocalAddr();

	examnameBean.setExamnameid(examnameid);
	examnameBean.setCreatedby(createdby);
	examnameBean.setInstituteid(instituteid);
	//examnameBean.setIpaddess(ipaddress);
	String ExamnameStatus = "Deactivated";
	examnameBean.setExamnamestatus(ExamnameStatus);
	
	result  = examname_query_object.ExamnameDeactivate(examnameBean);
	ArrayList checkdeactive=examname_query_object.checkdeactiveExamname(instituteid,examnameid);
	//out.println(checkdeactive.size());
	int courseList1=0;
	if(result>0)
		op="Examname Successfully Deactivated";
	else
		op="Examname Failed to Deactivate";

	return_file = request.getContextPath()+"/jsp/Exam/ExamnameEntry.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);


%>
