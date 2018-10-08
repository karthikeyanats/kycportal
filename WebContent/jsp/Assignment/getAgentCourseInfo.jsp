<%@ page language="java"%>
<%@ page import="java.util.HashMap,java.util.ArrayList,com.iGrandee.Assignment.Assignment"%>
<%
	StringBuffer buffer		= new StringBuffer();
	Assignment assign		= new Assignment();
	String userid			= (String)session.getValue("userid");
	ArrayList	required	= null;
	HashMap		hashmap		= null;
	
	if(request.getParameter("action").equals("standard"))//this is used at Allotassignment.
	{
		String sessionid	= request.getParameter("yearid");
		required			= assign.loadStandardForStaff(userid,sessionid); 
		
		if(required != null && required.size()>0){
			for(int y=0;y<required.size();y++){
				hashmap		= (HashMap)required.get(y);
				
				buffer.append("<result>");
				buffer.append("<standardscheduleid>"+hashmap.get("standardscheduleid")+"</standardscheduleid>");
				buffer.append("<standardname>"+hashmap.get("standardname")+"</standardname>");
				buffer.append("</result>");
			}
		}

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
	
	}
	else if(request.getParameter("action").equals("subject"))
	{	
		
		String standardid		= request.getParameter("standard");
		required				= assign.loadSubjectForStaff(userid,standardid);

		if(required != null && required.size()>0){
			for(int y=0;y<required.size();y++){
				hashmap		= (HashMap)required.get(y);
				
				buffer.append("<result>");
				buffer.append("<subjectscheduleid>"+hashmap.get("subjectscheduleid")+"</subjectscheduleid>");
				buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
				buffer.append("</result>");
			}
		}

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
		
	}
	else if(request.getParameter("action").equals("lesson"))//used at assignment allocation
	{
		String subjectid		= request.getParameter("subject");
		required				= assign.loadLessonForStaff(userid,subjectid);

		if(required != null && required.size()>0){
			for(int y=0;y<required.size();y++){
				hashmap		= (HashMap)required.get(y);
				
				buffer.append("<result>");
				buffer.append("<lessonscheduleid>"+hashmap.get("lessonscheduleid")+"</lessonscheduleid>");
				buffer.append("<lessonname>"+hashmap.get("lessonname")+"</lessonname>");
				buffer.append("</result>");
			}
		}

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
	}
	else if(request.getParameter("action").equals("section"))//used at assignment allocation
	{
		String subjectid		= request.getParameter("subject");
		required				= assign.loadSectionForStaff(userid,subjectid);

		if(required != null && required.size()>0){
			for(int y=0;y<required.size();y++){
				hashmap		= (HashMap)required.get(y);
				
				buffer.append("<result>");
				buffer.append("<sectionscheduleid>"+hashmap.get("sectionscheduleid")+"</sectionscheduleid>");
				buffer.append("<sectionname>"+hashmap.get("sectionname")+"</sectionname>");
				buffer.append("</result>");
			}
		}

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
	}

	else if(request.getParameter("action").equals("student"))
	{
		String sectionid	= request.getParameter("section");
		String topicid		= request.getParameter("assignment");
		
		//System.out.println(""+sectionid+"<===>"+topicid);
		
		required				= assign.loadAssignmentStudent(sectionid,topicid);
		
		if(required != null && required.size()>0){
			for(int y=0;y<required.size();y++){
				hashmap		= (HashMap)required.get(y);
				
				buffer.append("<result>");
				buffer.append("<studentallocationid>"+hashmap.get("studentallocationid")+"</studentallocationid>");
				buffer.append("<studentname>"+hashmap.get("studentname")+"</studentname>");
				buffer.append("<assignmentdate>"+hashmap.get("assignmentdate")+"</assignmentdate>");
				buffer.append("<submissiondate>"+hashmap.get("submissiondate")+"</submissiondate>");
				buffer.append("<assignmentid>"+hashmap.get("assignmentid")+"</assignmentid>");
				buffer.append("<status>"+hashmap.get("status")+"</status>");
				buffer.append("<remarks>"+hashmap.get("remarks")+"</remarks>");
				buffer.append("</result>");
			}
		}
		
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
	}
	else if(request.getParameter("action").equals("topic"))//used at assignment allocation
	{
		String lessonid		= request.getParameter("lesson");
		String sectionid	= request.getParameter("section");
		
		required				= assign.loadTopicForStaff(lessonid,sectionid);

		if(required != null && required.size()>0){
			for(int y=0;y<required.size();y++){
				hashmap		= (HashMap)required.get(y);
				
				buffer.append("<result>");
				buffer.append("<questionid>"+hashmap.get("questionid")+"</questionid>");
				buffer.append("<questionname>"+hashmap.get("questionname")+"</questionname>");
				buffer.append("</result>");
			}
		}

		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");
	}

%>


