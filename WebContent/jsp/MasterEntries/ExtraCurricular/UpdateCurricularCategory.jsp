<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();

com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularCategoryBean extraCurricularCategoryBean = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularCategoryBean();
String[] reqcurricularcategoryname;
String instituteid = null;
String userid = null;
int no_of_rows= 0 ;
int insert = 0;
String op = "";
String return_file = null;
String reqcurricularcategoryid = null;
String updateoperation = null;
String requeststatus = "";
String extracurriduplicate = "";
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	
	updateoperation = request.getParameter("curricularoperation");
	if(updateoperation.equals("UpdateCategory"))
	{
		reqcurricularcategoryname = request.getParameterValues("reqcurricularcategoryname");
	reqcurricularcategoryid = request.getParameter("reqcurricularcategoryid");
	
	
	
	extraCurricularCategoryBean.setExtracurricularcategoryid(reqcurricularcategoryid);
	extraCurricularCategoryBean.setExtcurricularcategoryname(reqcurricularcategoryname);

	
	no_of_rows = extraCurricularQuery.updateExtraCurricularCategory(extraCurricularCategoryBean);
	
	if(no_of_rows == 1000){
		extracurriduplicate	+= reqcurricularcategoryname[0];
	}
	else{
		no_of_rows				+= insert;
	}
	
	if(no_of_rows > 0 && no_of_rows!=1000)
	{
		op = " Extra Curricular category Name Successfully Updated.";
	}
	else
	{
		op = "Extra Curricular category Name Updation Failed.";
		no_of_rows = 0;
		
	}
	
	if(extracurriduplicate != null && extracurriduplicate.length()>2)
		op	+= " The Following Fees Head already exists. "+extracurriduplicate;
	
	//op="Curricular Category Succesfully Updated";
	//return_file = request.getContextPath()+"/jsp/MasterEntries/ExtraCurricular/ExtraCurricularCategoryView.jsp";
	}
	else if(updateoperation.equals("UpdateCategoryStatus"))
	{
		reqcurricularcategoryid = request.getParameter("reqcurricularcategoryid");
		requeststatus = request.getParameter("requeststatus");
		
		extraCurricularCategoryBean.setExtracurricularcategoryid(reqcurricularcategoryid);
		extraCurricularCategoryBean.setCurricularstatus(requeststatus);
		no_of_rows = extraCurricularQuery.updateExtraCurricularCategoryStatus(extraCurricularCategoryBean);
		
		if(requeststatus.equals("T"))
			op = "Trashed";
		if(requeststatus.equals("X"))
			op = "Deleted";
		if(requeststatus.equals("A"))
			op = "Restored";
		
		//return_file =request.getContextPath()+"/jsp/MasterEntries/ExtraCurricular/ExtraCurricularCategoryView.jsp";
		
		
		
	}
	

	
	return_file =request.getContextPath()+"/jsp/MasterEntries/ExtraCurricular/ExtraCurricularCategoryView.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+no_of_rows+"&returnurl="+return_file);
	

	

		
}catch(Exception e){}	
	
	
%>