<jsp:useBean id="religion_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionQuery" />
<jsp:useBean id="religionBean" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.io.*,java.util.*"%>

<%
	String op="";
	int result=0;
	String return_file = null;
try{
	String religionid = request.getParameter("religionid_hidden");
	//System.out.println("DELETE communityid::::>>>"+communityid);
	//String createdby=request.getParameter("createdby_hidden");
	//System.out.println("DELETE createdby::::>>>"+createdby);
	//String createdby = "1";
	String instituteid = (String)session.getValue("instituteid");
	//String ipaddress = request.getLocalAddr();
	religionBean.setReligionid(religionid);
	//communityBean.setCreatedby(createdby);
	religionBean.setInstituteid(instituteid);
	//examnameBean.setIpaddess(ipaddress);
	
	result = religion_query_object.DeleteReligion(religionBean);
	if(result>0)
		op="Religion Deleted Successfully";
	else
		op="Religio Deletion Failed";
	
	return_file = request.getContextPath()+"/jsp/MasterEntries/Religion/ReligionView.jsp";

	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
}catch(Exception e){}
%>
