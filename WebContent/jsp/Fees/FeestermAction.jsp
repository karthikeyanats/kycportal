

<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.Fees.FeesTermQuery" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.Fees.FeesTermBean" />
	
	

<%
	int no_of_rows 				= 0;
	String mode 				= "";
	int rows 					= 0;
	int insert					= 0;
	String subjectduplicate		= "";

try {
	mode = request.getParameter("mode_of_operation");
	
	String feesheadid_temp = request.getParameter("feesheadid_temp");
	String feesheadname_temp = request.getParameter("feesheadname_temp");

	String ipaddress = request.getRemoteAddr();
	String instituteid=(String)session.getValue("instituteid");
	instituteBean.setInstituteid(instituteid);
	instituteBean.setFeestermid(feesheadid_temp);
	instituteBean.setTermname(feesheadname_temp);
	instituteBean.setFeesoperation(mode);
	
	insert = query_object.updateFeesterm(instituteBean);
	
	String op="";
	
	
	if(insert == 1000){
		subjectduplicate	+= feesheadname_temp;
	}
	else{
		no_of_rows				+= insert;
	}	

	
	if(mode.equals("updatefeesterm"))
	{
		op = "Updated";
	}else if(mode.equals("updatestatus"))
	{
		op = "Trashed";
	}
	else if(mode.equals("deleteststus"))
	{
		op = "Deleted";
	}
	else if(mode.equals("restoreststus"))
	{
		op = "Restored";
	}
	else if(mode.equals("deactiveststus"))
	{
		op = "Deactivated";
	}
	else if(mode.equals("activeststus"))
	{
		op = "Activated";
	}
	

	String message="";

	if(mode.equals("updatefeesterm") || mode.equals("updatestatus")   || mode.equals("deactiveststus"))
	{
		if(no_of_rows >0)
			message = "Successfully Fees Term "+op+".";
		else
			message = "Fees Term "+op+" failed.";	
		
		if(subjectduplicate != null && subjectduplicate.length()>2)
			message	+= " The Following Fees Term already exists. "+subjectduplicate;
		

			String return_file =request.getContextPath()+"/jsp/Fees/FeesTermView.jsp";  
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	}
	if(mode.equals("deleteststus") || mode.equals("restoreststus"))
	{
		if(no_of_rows >0)
			message = "Successfully Fees Term "+op;
		else
			message = "Fees Term "+op+" failed";	

			String return_file =request.getContextPath()+"/jsp/Fees/feestermTrashList.jsp";  
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	}
	if(mode.equals("activeststus"))
	{ 
		if(no_of_rows >0)
			message = "Successfully Fees Term "+op;
		else
			message = "Fees Term "+op+" failed";	

			String return_file =request.getContextPath()+"/jsp/Fees/feestermDeactiveList.jsp";  
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	} 
	 	
	 	
	 	

} catch (NullPointerException e)
{//System.out.println("IN JSP PAGE");
	e.printStackTrace();

}
%>
