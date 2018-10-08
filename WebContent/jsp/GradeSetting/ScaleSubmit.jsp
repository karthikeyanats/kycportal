<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.GradeSetting.GradeScaleQuery" />
<jsp:useBean id="gradeBean" scope="page"
	class="com.iGrandee.GradeSetting.ScaleBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String message="";
	
	String[] scalename=request.getParameterValues("scalename");
	String userid=session.getValue("userid")+"";
	String instituteid=session.getValue("instituteid")+"";

	gradeBean.setCreatedby(userid);
	gradeBean.setScalename_Array(scalename); 
	gradeBean.setInstituteid(instituteid);
	ArrayList courseList = query_object.insertScale(gradeBean);   

	
		String return_file =request.getContextPath()+"/jsp/GradeSetting/ScaleEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+courseList.get(1)+"&result="+courseList.get(0)+"&returnurl="+return_file);
	 	
 	%>
