<%@ page language="java" %>
<%@ page import="java.util.ArrayList,java.util.HashMap" %>
<jsp:useBean id='query' 	scope='page' class='com.iGrandee.ExamManagement.QuestionPreparation'/>
<jsp:useBean id='online' 	scope='page' class='com.iGrandee.ExamManagement.OnlineExam'/>
<%
	try{
		
		ArrayList req_list 		= null;
		HashMap hashmap			= null;
		String instituteid		= (String)session.getValue("instituteid");
		StringBuffer buffer 	= new StringBuffer();
		String action 			= request.getParameter("action");

		if(action != null && action.equals("lessonname")){
			
			String subjectid 	= request.getParameter("subjectid");
			req_list			= query.loadLessons(subjectid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++){
				
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<lessonid>"+hashmap.get("lessonid")+"</lessonid>");
				buffer.append("<lessonname>"+hashmap.get("lessonname")+"</lessonname>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("questiontype"))
		{
			String lessonid 	= request.getParameter("lessonid");
			req_list			= query.loadQuestionType(lessonid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<typeid>"+hashmap.get("type")+"</typeid>");
				buffer.append("<typename>"+hashmap.get("type")+"</typename>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("dfactor"))
		{
			String lessonid 	= request.getParameter("lessonid");
			String questiontype	= request.getParameter("questiontype");

			req_list			= query.loadDifficultyFactor(lessonid,questiontype);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<dfid>"+hashmap.get("df")+"</dfid>");
				buffer.append("<dfname>"+hashmap.get("df")+"</dfname>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("examtype"))
		{
			String lessonid 	= request.getParameter("lessonid");
			String questiontype	= request.getParameter("questiontype");
			String dfactor		= request.getParameter("dfactor");

			req_list			= query.getExamType(lessonid,questiontype,dfactor);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<examtypeid>"+hashmap.get("examtypeid")+"</examtypeid>");
				buffer.append("<examtypename>"+hashmap.get("examtypename")+"</examtypename>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("mark"))
		{
			String lessonid 	= request.getParameter("lessonid");
			String questiontype	= request.getParameter("questiontype");
			String dfactor		= request.getParameter("dfactor");
			String examtype		= request.getParameter("examtype");


			req_list			= query.getExamMark(lessonid,questiontype,dfactor,examtype);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<markid>"+hashmap.get("mark")+"</markid>");
				buffer.append("<mark>"+hashmap.get("mark")+"</mark>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("noofquestion"))
		{
			String lessonid 	= request.getParameter("lessonid");
			String questiontype	= request.getParameter("questiontype");
			String dfactor		= request.getParameter("dfactor");
			String examtype		= request.getParameter("examtype");
			String mark			= request.getParameter("mark");

			String total= query.getTotalQuestion(lessonid,questiontype,dfactor,examtype,mark);
			String avail= query.getAvailableQuestion(lessonid,questiontype,dfactor,examtype,mark);

			buffer.append("<Row>");
			buffer.append("<totalquestion>"+total+"</totalquestion>");
			buffer.append("<availquestion>"+avail+"</availquestion>");
			buffer.append("</Row>");
		}
		else if(action != null && action.equals("loadexisting"))// Accessed from /jsp/ExamManagement/Preparation.jsp
		{
			String qsid			= request.getParameter("qsid");
			req_list			= query.loadExistingTemplateDetails(qsid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap		= (HashMap)req_list.get(i);
				buffer.append("<Row>");
					buffer.append("<qsdid>"+hashmap.get("qsdid")+"</qsdid>");
					buffer.append("<lessonid>"+hashmap.get("lessonid")+"</lessonid>");
					buffer.append("<df>"+hashmap.get("df")+"</df>");
					buffer.append("<type>"+hashmap.get("type")+"</type>");
					buffer.append("<noqn>"+hashmap.get("noqn")+"</noqn>");
					buffer.append("<marksperqn>"+hashmap.get("marksperqn")+"</marksperqn>");
					buffer.append("<lessonname>"+hashmap.get("lessonname")+"</lessonname>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("boardprepare"))//used from question Preparation
		{
			String sessionid 	= request.getParameter("sessionid");
			req_list			= query.loadBoardNamePrepare(sessionid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<boardid>"+hashmap.get("boardid")+"</boardid>");
				buffer.append("<boardname>"+hashmap.get("boardname")+"</boardname>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("standardprepare"))//used from question Preparation
		{
			String sessionid 	= request.getParameter("sessionid");
			String boardid 		= request.getParameter("boardid");
			
			req_list			= query.loadStandardNamePrepare(sessionid,boardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<standardid>"+hashmap.get("standardscheduleid")+"</standardid>");
				buffer.append("<standardname>"+hashmap.get("standardname")+"</standardname>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("boardapprove"))
		{
			String sessionid 	= request.getParameter("sessionid");
			req_list			= query.loadBoardNameForApproval(sessionid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<boardid>"+hashmap.get("boardid")+"</boardid>");
				buffer.append("<boardname>"+hashmap.get("boardname")+"</boardname>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("standardapprove"))
		{
			String sessionid 	= request.getParameter("sessionid");
			String boardid 		= request.getParameter("boardid");
			
			req_list			= query.loadStandardForApproval(sessionid,boardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<standardid>"+hashmap.get("standardscheduleid")+"</standardid>");
				buffer.append("<standardname>"+hashmap.get("standardname")+"</standardname>");
				buffer.append("</Row>");
			}
		}		
		else if(action != null && action.equals("templateapprove"))
		{
			String subjectid 	= request.getParameter("subjectid");
			
			req_list			= query.loadTemplateForApproval(subjectid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<qsid>"+hashmap.get("qsid")+"</qsid>");
				buffer.append("<examname>"+hashmap.get("examname")+"</examname>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("subjectapprove"))
		{
			String standardid 	= request.getParameter("standardid");
			req_list			= query.loadSubjectForApproval(standardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<subjectid>"+hashmap.get("subjectscheduleid")+"</subjectid>");
				buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("subjectapprove_withoutcode"))
		{
			String sessionid 	= request.getParameter("sessionid");
			String standardid 	= request.getParameter("standardid");
			String examid 		= request.getParameter("examid");
			
			req_list			= query.loadSubjectForApproval_withoutcode(sessionid,examid,standardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<subjectid>"+hashmap.get("subjectid")+"</subjectid>");
				buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
				buffer.append("</Row>");
			}
		}	
		
		else if(action != null && action.equals("templatetypeapprove"))
		{
			String templateid 	= request.getParameter("templateid");
			req_list			= query.loadTemplateTypeForApproval(templateid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<templatetype>"+hashmap.get("templatetype")+"</templatetype>");
				buffer.append("<templatetypename>"+hashmap.get("templatetype")+"</templatetypename>");
				buffer.append("</Row>");
			}
		}					
		else if(action != null && action.equals("examgenerate"))
		{
			String sessionid 	= request.getParameter("sessionid");
			req_list			= query.loadExamNameForGeneration(sessionid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<examnameid>"+hashmap.get("examnameid")+"</examnameid>");
				buffer.append("<examname>"+hashmap.get("examname")+"</examname>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("boardgenerate"))
		{
			String sessionid 	= request.getParameter("sessionid");
			req_list			= query.loadBoardForGeneration(sessionid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<boardid>"+hashmap.get("boardid")+"</boardid>");
				buffer.append("<boardname>"+hashmap.get("boardname")+"</boardname>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("standardgenerate"))
		{
			String sessionid 	= request.getParameter("sessionid");
			String boardid 		= request.getParameter("boardid");
			req_list			= query.loadStandardForGeneration(sessionid,boardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<standardid>"+hashmap.get("standardscheduleid")+"</standardid>");
				buffer.append("<standardname>"+hashmap.get("standardname")+"</standardname>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("standardreport"))
		{
			String sessionid 	= request.getParameter("sessionid");
			String boardid 		= request.getParameter("boardid");

			req_list			= query.loadStandardForReports(sessionid,boardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<standardscheduleid>"+hashmap.get("standardscheduleid")+"</standardscheduleid>");
				buffer.append("<standardname>"+hashmap.get("standardname")+"</standardname>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("subjectgenerate"))
		{
			String standardid 	= request.getParameter("standardid");
			req_list			= query.loadSubjectForGeneration(standardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<subjectid>"+hashmap.get("subjectscheduleid")+"</subjectid>");
				buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
				buffer.append("</Row>");
			}
		}
		else if(action != null && action.equals("subjectreport"))
		{
			String sessionid 	= request.getParameter("sessionid");
			String standardid 	= request.getParameter("standardid");
			
			req_list			= query.loadSubjectForReports(sessionid,standardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<subjectid>"+hashmap.get("subjectid")+"</subjectid>");
				buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("templategenerate"))
		{
			String subjectid 	= request.getParameter("subjectid");
			
			req_list			= query.loadTemplateForGeneration(subjectid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<qsid>"+hashmap.get("qsid")+"</qsid>");
				buffer.append("<examname>"+hashmap.get("examname")+"</examname>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("templatedetails"))
		{
			String templateid 	= request.getParameter("templateid");
			req_list			= query.questionSheetDetails(templateid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<subjectname>-</subjectname>");
				buffer.append("<examname>"+hashmap.get("examname")+"</examname>");
				buffer.append("<lessonname>"+hashmap.get("lessonname")+"</lessonname>");
				buffer.append("<df>"+hashmap.get("df")+"</df>");
				buffer.append("<type>"+hashmap.get("type")+"</type>");
				buffer.append("<noqn>"+hashmap.get("noqn")+"</noqn>");
				buffer.append("<marksperqn>"+hashmap.get("marksperqn")+"</marksperqn>");
				buffer.append("<duration>-</duration>");
				buffer.append("<status>"+hashmap.get("status")+"</status>");
				buffer.append("<instruction>"+hashmap.get("instruction")+"</instruction>");
				buffer.append("<assignstatus>"+hashmap.get("assignstatus")+"</assignstatus>");
				buffer.append("</Row>");
			}
		}			
		else if(action != null && action.equals("boardonline"))
		{
			String sessionid 	= request.getParameter("sessionid");
			req_list			= online.loadBoardForOnlineExam(sessionid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<boardid>"+hashmap.get("boardid")+"</boardid>");
				buffer.append("<boardname>"+hashmap.get("boardname")+"</boardname>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("standardonline"))
		{
			String sessionid 	= request.getParameter("sessionid");
			String boardid 		= request.getParameter("boardid");			
			
			req_list			= online.loadStandardForOnlineExam(sessionid,boardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<standardid>"+hashmap.get("standardscheduleid")+"</standardid>");
				buffer.append("<standardname>"+hashmap.get("standardname")+"</standardname>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("subjectonline"))
		{
			String standardid 	= request.getParameter("standardid");
			req_list			= online.loadSubjectForOnlineExam(standardid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<subjectid>"+hashmap.get("subjectscheduleid")+"</subjectid>");
				buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
				buffer.append("</Row>");
			}
		}	
		
		else if(action != null && action.equals("templateonline"))
		{
			String subjectid 	= request.getParameter("subjectid");
			req_list			= online.loadTemplateForOnlineExam(subjectid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<qsid>"+hashmap.get("qsid")+"</qsid>");
				buffer.append("<examname>"+hashmap.get("examname")+"</examname>");
				buffer.append("<totalmark>"+hashmap.get("totalmark")+"</totalmark>");
				buffer.append("<createddate>"+hashmap.get("createddate")+"</createddate>");
				buffer.append("</Row>");
			}
		}	
		else if(action != null && action.equals("templatedetailsonline"))
		{
			String templateid 	= request.getParameter("templateid");
			req_list			= online.questionSheetDetailsOnlineExam(templateid);

			if(req_list != null && req_list.size()>0)
			for(int i=0;i<req_list.size();i++)
			{
				hashmap	= (HashMap)req_list.get(i);
				buffer.append("<Row>");
				buffer.append("<subjectname>"+hashmap.get("subjectname")+"</subjectname>");
				buffer.append("<examname>"+hashmap.get("examname")+"</examname>");
				buffer.append("<lessonname>"+hashmap.get("lessonname")+"</lessonname>");
				buffer.append("<df>"+hashmap.get("df")+"</df>");
				buffer.append("<type>"+hashmap.get("type")+"</type>");
				buffer.append("<noqn>"+hashmap.get("noqn")+"</noqn>");
				buffer.append("<marksperqn>"+hashmap.get("marksperqn")+"</marksperqn>");
				buffer.append("</Row>");
			}
		}			
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<MainEntity>"+buffer.toString()+"</MainEntity>");


	}catch(Exception ex)
	{
		System.out.println("Exception in QuestionPrepareAjax.jsp      :"+ex);
	}
%>