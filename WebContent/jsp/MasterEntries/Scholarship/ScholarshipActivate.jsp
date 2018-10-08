<jsp:useBean id="scholar_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery" />
<jsp:useBean id="scholarBean" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    
<%@ page import="java.io.*,java.util.*"%>

	<%
		String op="";
		int result=0;
		String return_file = null;
	try{
		String scholarshipid = request.getParameter("scholarid_hidden");
		//System.out.println("ACTIVATE scholarshipid:::::>>>>"+scholarshipid);	
		String createdby = (String)session.getValue("userid");
		String instituteid =(String)session.getValue("instituteid");
		String ipaddress = request.getRemoteAddr();

		scholarBean.setScholarshipid(scholarshipid);
		scholarBean.setCreatedby(createdby);
		scholarBean.setInstituteid(instituteid);
		scholarBean.setIpaddress(ipaddress);

		result = scholar_query_object.ActivateScholarship(scholarBean);
		//System.out.println("ACTIVATE QUERY:::::>>>>>"+result);
		if(result>0)
			op="Scholarship Successfully Activated";
		else
			op="Scholarship Activation Failed";
		
		return_file = request.getContextPath()+"/jsp/MasterEntries/Scholarship/ScholarshipList.jsp";
		response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
		
	}catch(Exception e){}
	%>
