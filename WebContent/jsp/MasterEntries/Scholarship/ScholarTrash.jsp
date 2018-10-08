<jsp:useBean id="scholar_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery" />
<jsp:useBean id="scholarBean" scope="page"
	class="com.iGrandee.MasterEntries.Scholarship.ScholarBean" />
  

<%@ page language="java" import="java.util.*"%>
<%
	String op="";
	int result=0;
	String return_file = null;
	String scholarstatus = "T";
	try
	{
	String scholarid=request.getParameter("scholarid_hidden");
	//System.out.println("TRASH Action scholarid:::>>>"+scholarid);
	String scholarname = request.getParameter("scholarname_hidden");
	String scholardesc=request.getParameter("scholardescription_hidden");
	String instituteid = (String)session.getValue("instituteid");
	String createdby = (String)session.getValue("userid");
	String ipaddress = request.getRemoteAddr();
	String LogStatus = "Trashed";

	
		scholarBean.setScholarshipid(scholarid);
		scholarBean.setInstituteid(instituteid);
		scholarBean.setScholarshipstatus(scholarstatus);
		scholarBean.setIpaddress(ipaddress);
		scholarBean.setCreatedby(createdby);
	
		result = scholar_query_object.updateTrashScholarname(scholarBean);
		if(result>0)
			op=" Scholarship Successfully Trashed";
		else
			op="Scholarship Failed to Trash";
	
		return_file = request.getContextPath()+"/jsp/MasterEntries/Scholarship/ScholarshipTrashedView.jsp";
		response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
		
	}catch(Exception e){}
	
%>




