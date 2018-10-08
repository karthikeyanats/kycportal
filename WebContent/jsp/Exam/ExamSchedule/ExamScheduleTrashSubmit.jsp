<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>
	
<%
	com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean ExamAllotmentBean = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean();
	ExamAllotmentQuery	schedule	= new ExamAllotmentQuery();

	String op="";
	int result=0;
	String return_file = null;
	String[] checkstandard=null;
	String[] examdate=null;
	String[] starttime=null;
	String[] endtime=null;
try{	
		checkstandard= request.getParameterValues("checkstandard");
		//System.out.println("checkstandard>>>"+checkstandard[0]);
		String sessionid		= request.getParameter("reg_sessionid");
		//System.out.println("res_sessionid>>>"+sessionid);
		String examallotmentid		= request.getParameter("exallotid");
		//System.out.println("res_examallotmentid>>>"+examallotmentid);
		String instituteid		= (String)session.getValue("instituteid");
		ExamAllotmentBean.setInstituteid(instituteid);
		//System.out.println("res_instituteid>>>"+instituteid);
		String userid		= (String)session.getValue("userid");
		//System.out.println("res_userid>>>"+userid);
		 examdate			= request.getParameterValues("starts");
		//System.out.println("res_examdate>>>"+examdate[0]);
		starttime			= request.getParameterValues("starttime");
		//System.out.println("res_starttime>>>"+starttime[0]);
		 endtime			= request.getParameterValues("endtime");
		//System.out.println("res_endtime>>>"+endtime[0]);
		String allotedby 		=	(String)session.getValue("userid");
		//System.out.println("allotedby>>>"+allotedby);
		
		//result					= schedule.scheduleExams(checkstandard,examallotmentid,allotedby,instituteid,examdate,starttime,endtime);
		result					= schedule.TrashScheduleExams(checkstandard,examallotmentid,allotedby,instituteid,examdate,starttime,endtime);
		   
		if(result >0)
			op	= "Scheduled Exam Trashed Successfully";
		else
			op	= "Trashing Scheduled Exam Failed";
		
		return_file = request.getContextPath()+"/jsp/Exam/ExamSchedule/Examschedulecreation.jsp";
		response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	}catch(Exception e){}
%>	