<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Scholarship.ScholarBean,com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery"%>
<%
	com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery scholarshipquery = new com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery();
	com.iGrandee.MasterEntries.Scholarship.ScholarBean scholarbean = new com.iGrandee.MasterEntries.Scholarship.ScholarBean();
	String scholarshipname = "";
	String scholarshipdescription = "";
	String instituteid = null;
	String userid = null;
	int result = 0;
	String op = "";
	String return_file = null;
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	scholarshipname = request.getParameter("scholarshipname");
	scholarshipdescription = request.getParameter("scholarshipdescription");
	String ipaddress = request.getRemoteAddr();

	scholarbean.setScholarshipname(scholarshipname);
	scholarbean.setScholarshipdescription(scholarshipdescription);
	scholarbean.setInstituteid(instituteid);
	scholarbean.setCreatedby(userid);
	scholarbean.setIpaddress(ipaddress);
	
	result = scholarshipquery.insertScholarship(scholarbean);
	if(result == 1000)
		op="scholarship name Already Exist";
	else if(result>0)
		op="Scholarship Successfully Inserted";
	else 
		op="Scholarship Insertion Failed";
	
	
	return_file = request.getContextPath()+"/jsp/MasterEntries/Scholarship/ScholarshipList.jsp";
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
		
}catch(Exception e){}	

%>