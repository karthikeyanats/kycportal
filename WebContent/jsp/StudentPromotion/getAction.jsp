<%@ page language="java"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>

<%
	com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	
	String finalValue=null;
	StringBuffer buffer=new StringBuffer();

	String Action=request.getParameter("Action");

	
	if(Action.equals("getApplicationNo"))
	{
		//String appNo=request.getParameter("appNo"); 
		String checkNumber=registrationQuery.checkAppNo(request.getParameter("appNo"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }

	else if(Action.equals("getApplicationNoInReg"))
	{
		//String appNo=request.getParameter("appNo"); 
		String checkNumber=registrationQuery.checkAppNoInReg(request.getParameter("appNo"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	else if(Action.equals("getApplicationNoinApprv"))
	{
		//String appNo=request.getParameter("appNo");  
		String checkNumber=registrationQuery.checkAppNoInApprv(request.getParameter("appNo"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }	
	else  if(Action.equals("getRollNoGenStudents"))
 	{
		String checkNumber=registrationQuery.checkRollNoGenStudents(request.getParameter("sectionSchedId"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
 	}
	
	else  if(Action.equals("getRollNoPrefix"))
 	{
		String checkNumber=registrationQuery.checkRollNoPrefix(request.getParameter("rollNoPre"),request.getParameter("yearofsessionid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
 	}
	
	else  if(Action.equals("getRollNo"))
 	{
		//String appNo=request.getParameter("appNo"); 
		String checkNumber=registrationQuery.checkRollNo(request.getParameter("rollNo"),request.getParameter("instituteId"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
 	}
	 	 
	 else if(Action.equals("loadStandard"))
	 {
		 
			String sessionid=request.getParameter("sessionid");
			String boardid=request.getParameter("boardid");
			String accessno=request.getParameter("accessno");
			ArrayList standardList=registrationQuery.listStandard(sessionid,boardid);

	 		String standardId=null;
	 		String standardName=null;
	 		String standardScheduleId=null;
	 		String groupId=null;
	 		String groupName=null;
	 		String totalSeats=null;
	 		String allocatedSeats=null;
	 		
	 		if(standardList!=null && standardList.size()!=0)
	 		{
	 			for(int a=0;a<standardList.size();a++)
	 			{
					HashMap map1=(HashMap)standardList.get(a);
					standardId=(String)map1.get("standardid");
					standardName=(String)map1.get("standardname");
					standardScheduleId=(String)map1.get("standardscheduleid");
					groupId=(String)map1.get("groupid");
					groupName=(String)map1.get("groupname");
					totalSeats=(String)map1.get("totalseats");
					allocatedSeats=(String)map1.get("allocatedseats");
					
					if(!groupName.equals("NoGroup"))
					{												
						standardName = standardName+" - "+groupName; 
					}
		

					buffer.append("<result>");
	 					//buffer.append("<standardId>"+standardId+"</standardId>");	 					
	 					buffer.append("<standardScheduleId>"+standardScheduleId+"</standardScheduleId>");
	 					buffer.append("<standardName>"+standardName+"</standardName>");
	 					buffer.append("<totalSeats>"+totalSeats+"</totalSeats>");
	 					buffer.append("<allocatedSeats>"+allocatedSeats+"</allocatedSeats>"); 					
	 					//buffer.append("<groupId>"+groupId+"</groupId>");
	 					//buffer.append("<groupName>"+groupName+"</groupName>");	 					
	 				buffer.append("</result>");
	 			}
	 		}
	 	response.setContentType("text/xml");
	 	response.setHeader("Cache-Control", "no-cache");
	 	response.getWriter().write("<standardList>"+buffer.toString()+"</standardList>");
	 }	 

	 else if(Action.equals("loadSection"))
	 {
		 
			String secSchedId=request.getParameter("secSchedId");
			ArrayList sectionList=registrationQuery.listSections(secSchedId);

	 		String sectionId=null;
	 		String sectionName=null;
	 		String sectionSchedId=null;

			if(sectionList !=null && sectionList.size() >0)
			{
				for(int s1=0;s1<sectionList.size();s1++)
				{
					HashMap map1=(HashMap)sectionList.get(s1);
					sectionId=(String)map1.get("sectionid");
					sectionName=(String)map1.get("sectionname");
					sectionSchedId=(String)map1.get("sectionscheduleid");
					
			
				buffer.append("<result>");					
	 			buffer.append("<sectionSchedId>"+sectionSchedId+"</sectionSchedId>");
	 			buffer.append("<sectionName>"+sectionName+"</sectionName>");		
	 			buffer.append("</result>");
	 			}
	 		}
	 	response.setContentType("text/xml");
	 	response.setHeader("Cache-Control", "no-cache");
	 	response.getWriter().write("<sectionList>"+buffer.toString()+"</sectionList>");
	 }
	
	 else if(Action.equals("getExamSubjectSchedule"))
	 {
		String checkNumber=registrationQuery.checkExamSubjectSched(request.getParameter("examallotmentid"),request.getParameter("subjectscheduleid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	 else if(Action.equals("getExamSubjectPublish"))
	 {
		String checkNumber=registrationQuery.checkExamSubjectPublish(request.getParameter("examallotmentid"),request.getParameter("subjectscheduleid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }	
		
	 else if(Action.equals("getExamNameSchedule"))
	 {
		String checkNumber=registrationQuery.checkExamName(request.getParameter("examnameid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	 else if(Action.equals("getCommunity"))
	 {
		String checkNumber=registrationQuery.checkCommunityName(request.getParameter("communityid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	 else if(Action.equals("getReligion"))
	 {
		String checkNumber=registrationQuery.checkReligionName(request.getParameter("religionid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	 else if(Action.equals("getScholarship"))
	 {
		String checkNumber=registrationQuery.checkScholarshipName(request.getParameter("scholarshipid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }

	 else if(Action.equals("getFeesHead"))
	 {
		String checkNumber=registrationQuery.checkFeesHead(request.getParameter("feesheadid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	 else if(Action.equals("getFeesTerm"))
	 {
		String checkNumber=registrationQuery.checkFeesTerm(request.getParameter("termid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	 else if(Action.equals("getFacultyRemarkStatus"))
	 {
		String checkNumber=registrationQuery.checkFacultyRemarks(request.getParameter("fremarkstatusid")); 
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }	
	
	 else if(Action.equals("getStaffCategory"))
	 {
		String checkNumber=registrationQuery.checkStaffcategory(request.getParameter("staffcategoryid"));
		checkNumber=checkNumber.trim();
		if(checkNumber!=null && checkNumber!="")
		{
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	
	 else if(Action.equals("checkroute"))
	 {
		String checkroute=registrationQuery.checkroute(request.getParameter("routeid"));
		
		if(checkroute!=null && checkroute!="")
		{
			checkroute=checkroute.trim();
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	
	
	 else if(Action.equals("feescollectioncheckid")) 
	 {
		//String checkfeeshead=registrationQuery.checkfeescollection(request.getParameter("feestermid1"));
		String checkfeeshead=registrationQuery.checkfeescollection(request.getParameter("schemeforstudentid"));
		
		if(checkfeeshead!=null && checkfeeshead!="")
		{
			checkfeeshead=checkfeeshead.trim();
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 } 
	
	
	  else if(Action.equals("checkfeeshead")) 
	 {
		String checkfeeshead=registrationQuery.checkfeeshead(request.getParameter("transportfeesheadid"));
		
		if(checkfeeshead!=null && checkfeeshead!="")
		{
			checkfeeshead=checkfeeshead.trim();
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 } 
	
	 
	 else if(Action.equals("Stagenameaction"))
	 {
		String checkSamestagename=registrationQuery.checkSamestagename(request.getParameter("routeid"),request.getParameter("stagename"));
		
		if(checkSamestagename!=null && checkSamestagename!="")
		{
			checkSamestagename=checkSamestagename.trim();
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	 
	 
	 else if(Action.equals("CheckReduceAmount"))
	 {
		String checkamtid=registrationQuery.checkreduceamount(request.getParameter("transportstageamountallocationid"));
		
		if(checkamtid!=null && checkamtid!="")
		{
			checkamtid=checkamtid.trim();
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	 
	
	  else if(Action.equals("CheckAmountID"))
		 {
			String checkamtid=registrationQuery.checkamountid(request.getParameter("transportstageamountallocationid"));
			
			if(checkamtid!=null && checkamtid!="")
			{
				checkamtid=checkamtid.trim();
				finalValue="1";
			}
			else
			{
				finalValue="0";
			}

			buffer.append("<result>");
			buffer.append("<finalValue>"+finalValue+"</finalValue>");
			buffer.append("</result>");

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
		 }
	
	
	 else if(Action.equals("checkstage"))
	 {
		String checkroute=registrationQuery.checkroutestage(request.getParameter("transportstageid"));
		if(checkroute!=null && checkroute!="")
		{ 
			checkroute=checkroute.trim();

			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	 else if(Action.equals("checkdiscount"))
	 {
		String checkroute=registrationQuery.checkdiscount(request.getParameter("discountcategoryid"));
		if(checkroute!=null && checkroute!="")
		{ 
			checkroute=checkroute.trim();
 
			finalValue="1";
		}
		else
		{
			finalValue="0";
		}

		buffer.append("<result>");
		buffer.append("<finalValue>"+finalValue+"</finalValue>");
		buffer.append("</result>");

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<checkNumber>"+buffer.toString()+"</checkNumber>");
	 }
	
	
	
%>