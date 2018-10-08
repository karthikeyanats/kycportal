<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.GradeSetting.GradeScaleQuery" />
<jsp:useBean id="gradeBean" scope="page"
	class="com.iGrandee.GradeSetting.GradeBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String message="";
	
	String[] gradename=request.getParameterValues("gradename");
	String userid=session.getValue("userid")+"";
	String instituteid=session.getValue("instituteid")+"";

	gradeBean.setCreatedby(userid);
	gradeBean.setGradename_Array(gradename);
	gradeBean.setInstituteid(instituteid);
	ArrayList courseList = query_object.insertGrade(gradeBean);   

	
		String return_file =request.getContextPath()+"/jsp/GradeSetting/GradeEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+courseList.get(1)+"&result="+courseList.get(0)+"&returnurl="+return_file);
	 	
 	%>
