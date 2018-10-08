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
	//String createdby = request.getParameter("createdby_hidden");
	String instituteid =(String)session.getValue("instituteid");
	//String ipaddress = request.getLocalAddr();

	religionBean.setReligionid(religionid);
	//communityBean.setCreatedby(createdby);
	religionBean.setInstituteid(instituteid);
	//examnameBean.setIpaddess(ipaddress);
	String religionStatus = "Deactivated";
	religionBean.setRelistatus(religionStatus);
	
	result = religion_query_object.ReligionDeactivate(religionBean);
	ArrayList checkdeactive=religion_query_object.checkdeactiveReligion(instituteid,religionid);
	//out.println(checkdeactive.size());
	if(result>0)
    op=" Religion Successfully DeActivated";
	else
		op="Religion DeActivation failed";
	return_file = request.getContextPath()+"/jsp/MasterEntries/Religion/ReligionDeactivatedViewList.jsp";
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
}catch(Exception e){}	
%>
