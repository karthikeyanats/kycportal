<jsp:useBean id="religion_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionQuery" />
<jsp:useBean id="religionBean" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  

<%@ page language="java" import="java.util.*"%>
<%
	String op="";
	int result=0;
	String return_file = null;
	String curstatus = "T";
	try{
	String religionid=request.getParameter("religionid_hidden");
	//System.out.println("TRASH Action commid:::>>>"+religionid);
	String religionname = request.getParameter("religionname_hidden");
	String religiondesc=request.getParameter("religiondescription_hidden");
	String instituteid = (String)session.getValue("instituteid");
	//String ipaddress = request.getLocalAddr();
	String LogStatus = "Trashed";

	
	religionBean.setReligionid(religionid);
	religionBean.setInstituteid(instituteid);
	religionBean.setRelistatus(curstatus);
	result = religion_query_object.updateTrashReligionname(religionBean);
	if(result>0)	
		op="Religion Trashed Successfully";
	else
		op="Religion Trash Failed";
	
	return_file =request.getContextPath()+"/jsp/MasterEntries/Religion/ReligionTrashedView.jsp";

	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	}catch(Exception e){}
%>
