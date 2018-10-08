<jsp:useBean id="religion_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionQuery" />
<jsp:useBean id="religionBean" scope="page"
	class="com.iGrandee.MasterEntries.Religion.ReligionBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
     
<%@ page language="java" import="java.util.*"%> 
<%
String op="";
int result=0;
String return_file = null;
try{
 	String religionname = request.getParameter("religionname");
 	String religiondesc = request.getParameter("religiondescription");
 	String religionid = request.getParameter("religionid1_hidden");
 	//System.out.println("religionid>>>"+religionid);
 	String instituteid = (String) session.getValue("instituteid");
 	//String ipaddress = request.getLocalAddr();
 	//communityBean.setCreatedBy(createdby);
 	religionBean.setInstituteid(instituteid);
 	//communityBean.setIpaddess(ipaddress);

 	religionBean.setReligionid(religionid);

 	//System.out.println("comm idd>>>"+communityBean.getCommunityid());
 	religionBean.setReligionname(religionname);
 	religionBean.setReligiondescription(religiondesc);
 	result = religion_query_object.UpdateEditReligion(religionBean);
 
 	
 	if(result==1000)
 	{
 		op="Religion Name Already Exists";

 	}
 	else if(result>=1)
 	{
 		op="Religion Successfully Updated";
 	}
 	else if(result==0)
 	{
 		op="Religion Failed to Updated";

 	}
	return_file = request.getContextPath()+"/jsp/MasterEntries/Religion/ReligionView.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	
}catch(Exception e){}
 %>
