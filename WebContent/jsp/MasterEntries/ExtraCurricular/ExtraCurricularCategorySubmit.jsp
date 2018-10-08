<%@ page import="java.util.ArrayList,java.util.HashMap"%>
<%
String[] categoryname;
String userid  = null;
int no_of_rows = 0;
ArrayList resultList = null;
String return_file ="";
String op="";
try
{
	com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularCategoryBean  extraCurricularBean = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularCategoryBean();
	com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery extraCurricularQuery = new com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery();

	categoryname = request.getParameterValues("curricularcategory");
	userid = (String)session.getValue("userid");
	extraCurricularBean.setExtcurricularcategoryname(categoryname);
	extraCurricularBean.setCreatedby(userid);
	String instituteid=session.getValue("instituteid")+"";
	extraCurricularBean.setInstituteid(instituteid);
	//no_of_rows = extraCurricularQuery.insertExterCurricularCategory(extraCurricularBean);
	resultList = extraCurricularQuery.insertExterCurricularCategory(extraCurricularBean);
	

	
	if(resultList!=null && resultList.size()>0)
	{
		no_of_rows = Integer.parseInt((String)resultList.get(0));
		op = (String)resultList.get(1);
	}
		
	//op="Succesfully Inserted";
	System.out.print("no_of_rows-->"+no_of_rows+"op-->"+op);
	return_file =request.getContextPath()+ "/jsp/MasterEntries/ExtraCurricular/ExtraCurricularCategoryView.jsp";
	
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+no_of_rows+"&returnurl="+return_file);
	


}catch(Exception e){}
%>