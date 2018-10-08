<jsp:useBean id="scholar_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery" />
<jsp:useBean id="scholarBean" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.util.*"%> 
<%
	String op="";
	int result=0;
	String return_file = null;
	
 	String scholarname = request.getParameter("scholarname");
 	String scholardesc = request.getParameter("scholardesc");
 	String scholarid = request.getParameter("scholarid1_hidden");
 	//System.out.println("scholarid>>>>"+scholarid);
 	String instituteid = (String) session.getValue("instituteid");
 	String createdby = (String) session.getValue("userid");
 	String ipaddress = request.getRemoteAddr();
 	//scholarBean.setCreatedBy(createdby);
 	scholarBean.setInstituteid(instituteid);
 	//scholarBean.setIpaddess(ipaddress);

 	scholarBean.setScholarshipid(scholarid);
 	scholarBean.setScholarshipname(scholarname);
 	scholarBean.setScholarshipdescription(scholardesc);
 	scholarBean.setCreatedby(createdby);
 	scholarBean.setIpaddress(ipaddress);
 		
 	result = scholar_query_object.UpdateEditScholarship(scholarBean);
 	if(result>0)
		op=" Scholarship Successfully Updated";
	else
		op="Scholarship Failed to Update";
	
 	return_file = request.getContextPath()+"/jsp/MasterEntries/Scholarship/ScholarshipList.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
 %>
