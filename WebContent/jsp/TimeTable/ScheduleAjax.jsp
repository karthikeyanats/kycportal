<%@ page language="java" %>
<%@ page import="java.util.ArrayList,java.util.HashMap" %>
<jsp:useBean id='query' scope='page' class='com.iGrandee.TimeTable.PeriodTime.Schedule'/>

<%
try
{
		ArrayList req_list 	= null;
		String userid		= (String)session.getValue("userid");

		HashMap	hashmap	  	= null;
		StringBuffer buffer = new StringBuffer();
		
				
		if(request.getParameter("action") != null && request.getParameter("action").equals("loadsujects"))
		{
			req_list	= query.loadSubjects(
					request.getParameter("sectionid"),
					request.getParameter("staffid")
			);
			
			if(req_list != null && req_list.size()>0){
				for(int y=0;y<req_list.size();y++){
					hashmap		= (HashMap)req_list.get(y);
					
					buffer.append("<Row>");
					buffer.append("<subjectallotmentid>"+hashmap.get("subjectallotmentid")+"</subjectallotmentid>");
					buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
					buffer.append("</Row>");
				}
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
		}
		else if(request.getParameter("action") != null && request.getParameter("action").equals("remaining")){
			
			req_list	= query.checkRemaining(
					request.getParameter("subjectallotment"),
					request.getParameter("staffid")
			);
			
			if(req_list != null && req_list.size()>0){
				for(int y=0;y<req_list.size();y++){
					hashmap		= (HashMap)req_list.get(y);
					
					buffer.append("<Row>");
					buffer.append("<allottedhours>"+hashmap.get("allottedhours")+"</allottedhours>");
					buffer.append("<totalscheduled>"+hashmap.get("totalscheduled")+"</totalscheduled>");
					buffer.append("</Row>");
				}
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
		}else if(request.getParameter("action") != null && request.getParameter("action").equals("remainingforstaff")){
			
			String totalhours	= query.checkRemainingTotalStaff(
					request.getParameter("sessionid"),
					request.getParameter("staffid")
			);
			String schedulehours= query.checkRemainingScheduleStaff(
					request.getParameter("sessionid"),
					request.getParameter("staffid")
			);
			
			
			if(totalhours == null || totalhours.equals("") || totalhours.equalsIgnoreCase("null"))
				totalhours	= "0";
			
			if(schedulehours == null || schedulehours.equals("") || schedulehours.equalsIgnoreCase("null"))
				schedulehours	= "0";
			
					
			buffer.append("<Row>");
			buffer.append("<allottedhours>"+totalhours+"</allottedhours>");
			buffer.append("<totalscheduled>"+schedulehours+"</totalscheduled>");
			buffer.append("</Row>");
			
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
			
		}else if(request.getParameter("action") != null && request.getParameter("action").equals("checkschedule"))
		{
			req_list	= query.checkScheduledStatus(
					request.getParameter("dayid"),
					request.getParameter("sessionid"),
					request.getParameter("periodid"),
					request.getParameter("staffid")
			);
			
			if(req_list != null && req_list.size()>0){
				hashmap		= (HashMap)req_list.get(0);
				buffer.append("<Row>");
				buffer.append("<status>Yes</status>");
				buffer.append("<periodname>"+hashmap.get("periodname")+"</periodname>");
				buffer.append("<dayname>"+hashmap.get("dayname")+"</dayname>");
				buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
				buffer.append("<standardname>"+hashmap.get("standardname")+"</standardname>");
				buffer.append("<sectionname>"+hashmap.get("sectionname")+"</sectionname>");
				buffer.append("</Row>");
			}
			else{
				buffer.append("<Row>");
				buffer.append("<status>No</status>");
				buffer.append("</Row>");				
			}

			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
		}else if(request.getParameter("action") != null && request.getParameter("action").equals("schedule"))
		{
			
			int result	= query.checkScheduledStatusandSchedule(
						request.getParameter("dayid"),
						request.getParameter("sessionid"),
						request.getParameter("periodid"),
						request.getParameter("staffid"),
						request.getParameter("subjectallotment"),
						userid,
						request.getParameter("sectionid"),
						request.getRemoteHost()
				);
			
			if(result == 0){
				
				buffer.append("<Row>");
				buffer.append("<status>0</status>");
				buffer.append("</Row>");				
		
			}
			else if(result == 2){
				
				req_list	= query.checkScheduledStatus(
						request.getParameter("dayid"),
						request.getParameter("sessionid"),
						request.getParameter("periodid"),
						request.getParameter("staffid")
				);
				
				if(req_list != null && req_list.size()>0){
					hashmap		= (HashMap)req_list.get(0);
					buffer.append("<Row>");
					buffer.append("<status>2</status>");
					buffer.append("<periodname>"+hashmap.get("periodname")+"</periodname>");
					buffer.append("<dayname>"+hashmap.get("dayname")+"</dayname>");
					buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
					buffer.append("<standardname>"+hashmap.get("standardname")+"</standardname>");
					buffer.append("<sectionname>"+hashmap.get("sectionname")+"</sectionname>");
					buffer.append("</Row>");
				}
			}
			else if(result == 3){
				
				buffer.append("<Row>");
				buffer.append("<status>3</status>");
				buffer.append("</Row>");				
		
			}
			else if(result == 4){
				
				buffer.append("<Row>");
				buffer.append("<status>4</status>");
				buffer.append("</Row>");				
			}
			else {
				buffer.append("<Row>");
				buffer.append("<status>1</status>");
				buffer.append("</Row>");				
				
			}


			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
		}
}catch(Exception ex)
{
	//System.out.println("Exception in get_requested_list.jsp      :"+ex);
}
%>