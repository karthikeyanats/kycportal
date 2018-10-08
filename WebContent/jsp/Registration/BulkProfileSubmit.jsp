<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		//document.wkrkallotmentsubmit.action = "./../Operation_Result.jsp";
		document.wkrkallotmentsubmit.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
		document.wkrkallotmentsubmit.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Schedule</title>
</head>
<body onload='LoadStatus()'>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Registration.StudentRegistrationBean,com.iGrandee.Registration.StudentRegistrationQuery"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	
		String status					= null;
		int result						= 0;
		StudentRegistrationQuery qentry	= new StudentRegistrationQuery();
		StudentRegistrationBean  bean	= new StudentRegistrationBean();
		String userid					= (String)session.getValue("userid");
		String instituteid				= (String)session.getValue("instituteid");
	
		try {
			
			bean.setCreatedby(userid);
			bean.setInstituteid(instituteid);
			bean.setIpaddress(request.getRemoteAddr());
			bean.setApplicationnos(request.getParameterValues("applicationno"));
	    	bean.setPrefixs(request.getParameterValues("prefix"));
	    	bean.setFirstnames(request.getParameterValues("firstname"));
	    	bean.setMiddlenames(request.getParameterValues("middlename"));
	    	bean.setLastnames(request.getParameterValues("lastname"));
	    	bean.setDateofbirths(request.getParameterValues("dateofbirth"));
	    	bean.setGenders(request.getParameterValues("gender"));
	    	bean.setFathernames(request.getParameterValues("fathername"));
	    	bean.setMothernames(request.getParameterValues("mothername"));
	    	bean.setNationalitys(request.getParameterValues("nationality"));
	    	bean.setLanguages(request.getParameterValues("language"));
	    	bean.setBloodgroups(request.getParameterValues("bloodgroup"));
	    	bean.setStreet1s(request.getParameterValues("street1"));
	    	bean.setStreet2s(request.getParameterValues("street2"));
	    	bean.setCountrys(request.getParameterValues("country"));
	    	bean.setStates(request.getParameterValues("state"));
	    	bean.setCitys(request.getParameterValues("city"));
	    	bean.setPincodes(request.getParameterValues("pincode"));
	    	bean.setLandlinenos(request.getParameterValues("landlineno"));
	    	bean.setMobilenos(request.getParameterValues("mobileno"));
	    	bean.setEmails(request.getParameterValues("email"));
	    	bean.setSmscontacts(request.getParameterValues("smscontact"));
	    	bean.setGuardiannames(request.getParameterValues("guardianname"));
	    	bean.setGuardianrelation(request.getParameterValues("guardianrelation"));
	    	bean.setSelfemployed(request.getParameterValues("selfemployed"));
	    	bean.setOrganizationnames(request.getParameterValues("organizationname"));
	    	bean.setIncome(request.getParameterValues("income"));
	    	bean.setPosition(request.getParameterValues("position"));
	    	bean.setPhysicallychallenged(request.getParameterValues("physicallychallenged"));
	    	bean.setChildofexserviceman(request.getParameterValues("childofexserviceman"));
	    	bean.setPersonalphysicalmarks(request.getParameterValues("personalphysicalmarks"));
	    	bean.setExistingstudentrollnos(request.getParameterValues("existingstudentrollno"));
	    	bean.setStudentapprovalids(request.getParameterValues("studentapprovalid"));
	    	bean.setStandardscheduleid(request.getParameter("standardid"));
			result					= qentry.bulkStudentRegistration(bean);
	
		}catch(Exception e){
			
		}
		
		if(result >0)
			status	= "Profile(s) Updated Successfully.";
		else
			status	= "Profile(s) Updation Failed.";
		
		
		if(bean.getResultstaus() != null && bean.getResultstaus().length() >2)
			status	+= "Profile already updated for the following Application No"+bean.getResultstaus();

	%>
	
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='text'   name='returnurl' 		value='./Registration/BulkProfileEntry.jsp'>

	</form>
</body>
</html>