<%@ page import="java.util.ArrayList,java.util.HashMap"%>
<%
String[] eventname;
String[] eventdate;
String[] eventvenu; 
String userid  = null;
int no_of_rows = 0;
String return_file ="";
String op="";
String reqyearofsessionid ="";
String reqcurricularcategoryid ="";
String eventoperation = "";
String curriculareventid = "";
try
{
	com.iGrandee.MasterEntries.ExtraCurricular.CurricularEventBean  curricularEventBean = new com.iGrandee.MasterEntries.ExtraCurricular.CurricularEventBean();
	com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();
	
	
	eventoperation = request.getParameter("eventoperation");
	
//System.out.print("******"+eventoperation);
	
	if(eventoperation.equals("Insert"))
	{
		reqyearofsessionid = request.getParameter("yearsessionid");
		reqcurricularcategoryid = request.getParameter("extracurricularcategoryid");
		//System.out.println("****reqyearofsessionid*******"+reqyearofsessionid);
		eventname = request.getParameterValues("eventname");
		eventdate = request.getParameterValues("eventdate");
		eventvenu = request.getParameterValues("eventvenu");
		  
		curricularEventBean.setSessionid(reqyearofsessionid);
		//curricularEventBean.setExtracurricularcategoryid(reqcurricularcategoryid);
		curricularEventBean.setExtracurricularactivityid(reqcurricularcategoryid);
		
		curricularEventBean.setEventdate(eventdate);
		curricularEventBean.setCurriculareventname(eventname);
		curricularEventBean.setVenu(eventvenu);
		userid = (String)session.getValue("userid");
		curricularEventBean.setCreatedby(userid);
		no_of_rows = extraCurricularQuery.insertExtraCurricularEvent(curricularEventBean);
		out.println("no_of_rows"+no_of_rows);
		if(no_of_rows>0)
		op="Event Inserted Succesfully ";
		else
			op="Event Insertion Failed"; 
		
		return_file = request.getContextPath()+"/jsp/MasterEntries/ExtraCurricular/CurricularEventList.jsp?reqstatus=A";
	}
	else if(eventoperation.equals("UpdateEvent"))
	{
		eventname = request.getParameterValues("eventname");
		eventdate = request.getParameterValues("eventdate");
		eventvenu = request.getParameterValues("eventvenue");
		curriculareventid = request.getParameter("curriculareventid");
		
		curricularEventBean.setCurriculareventid(curriculareventid);
		curricularEventBean.setEventdate(eventdate);
		curricularEventBean.setCurriculareventname(eventname);
		curricularEventBean.setVenu(eventvenu);
		no_of_rows = extraCurricularQuery.updateExtraCurricularEvent(curricularEventBean);
		//out.println("no_of_rows"+no_of_rows);
		if(no_of_rows>0)
		op="Event Succesfully Updated";
		else
			op="Event Updation  Failed";	
		return_file = request.getContextPath()+"/jsp/MasterEntries/ExtraCurricular/CurricularEventList.jsp?reqstatus=A";

	
	}
	else if(eventoperation.equals("UpdateEventStatus"))
	{
		curriculareventid = request.getParameter("curriculareventid");
		String eventstatus = request.getParameter("eventstatus");
		curricularEventBean.setCurriculareventid(curriculareventid);
		curricularEventBean.setEventstatus(eventstatus);
		no_of_rows = extraCurricularQuery.updateEventStatus(curricularEventBean);
		if(eventstatus.equals("T"))
		{
			if(no_of_rows>0)
			op = "Event Successfully  Trashed";
			else
				op = "Event Trash Failed";	
		}
		if(eventstatus.equals("R"))
		{
			if(no_of_rows>0)
				op = "Event Successfully Restored";
				else
					op = "Event Restore  Failed";
		}
		
		return_file = request.getContextPath()+"/jsp/MasterEntries/ExtraCurricular/CurricularEventList.jsp?reqstatus=A";

	}
	
	
	else if(eventoperation.equals("eventdelrestore"))
	{
		curriculareventid = request.getParameter("curriculareventid");
		String eventstatus = request.getParameter("eventstatus");
		curricularEventBean.setCurriculareventid(curriculareventid);
		curricularEventBean.setEventstatus(eventstatus);
		no_of_rows = extraCurricularQuery.updateEventStatus(curricularEventBean);
		if(eventstatus.equals("X"))
		{
			if(no_of_rows>0)
			op = "Event Successfully Deleted";
			else
				op = "Event Deletion Failed";	
		}
		if(eventstatus.equals("A"))
		{
			if(no_of_rows>0)
				op = "Event Successfully  Restored";
				else
					op = "Event Restore Failed";
		}
		
		return_file = request.getContextPath()+"/jsp/MasterEntries/ExtraCurricular/ExtraCurricularTrashList.jsp?reqstatus=T";

	}
	
		
		response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+no_of_rows+"&returnurl="+return_file);


}catch(Exception e){e.printStackTrace();}
%>