<jsp:useBean id="community_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityQuery" />
<jsp:useBean id="communityBean" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
     
<%@ page language="java" import="java.util.*"%> 
<%
String op="";
int result=0;
String return_file = null;
try{
 	String commname = request.getParameter("communityname");
 	String commdesc = request.getParameter("communitydescription");
 	String commid = request.getParameter("communityid1_hidden");
 	//System.out.println("COMMM"+commid);
 	String instituteid = (String) session.getValue("instituteid");
 	//String ipaddress = request.getLocalAddr();
 	//communityBean.setCreatedBy(createdby);
 	communityBean.setInstituteid(instituteid);
 	//communityBean.setIpaddess(ipaddress);

 	communityBean.setCommunityid(commid);

 	//System.out.println("comm idd>>>"+communityBean.getCommunityid());
 	communityBean.setCommunityname(commname);
 	communityBean.setCommunitydescription(commdesc);
 	result = community_query_object.UpdateEditCommunity(communityBean);
 	if(result == 1000)
		op="Community Name Already Exist";
 	else if(result>0)
 		op="Community Updated Successfully";
 	else
 		op="Community Updation failed";
	return_file = request.getContextPath()+"/jsp/MasterEntries/Community/CommunityView.jsp";
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
}catch(Exception e){}
 %>
