<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="scholar_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery" />
<jsp:useBean id="scholarBean" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarBean" />
<%@ page language="java" import="java.util.*"%>
<%
	String op="";
	int result=0;
	String return_file = null;
	try
	{
	String scholarid=request.getParameter("scholarid_hidden");
	String instituteid = (String)session.getValue("instituteid");
	String createdby = (String)session.getValue("userid");
	String ipaddress = request.getRemoteAddr();

	scholarBean.setScholarshipid(scholarid);
	scholarBean.setCreatedby(createdby);
	scholarBean.setInstituteid(instituteid);
	scholarBean.setIpaddress(ipaddress);

	result = scholar_query_object.RestoreScholarship(scholarBean);
	if(result>0)
		op=" Scholarship Restored Successfully";
	else
		op="Scholarship Restoration Failed";
	
	return_file = request.getContextPath()+"/jsp/MasterEntries/Scholarship/ScholarshipList.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	
	}catch(Exception e){}
%>