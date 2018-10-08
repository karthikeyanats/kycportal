<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.Fees.FeesHeadQuery" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.Fees.FeesHeadBean" />
	


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

	instituteBean.setFeesheadid(feesheadid_temp);
	instituteBean.setFeesheadname(feesheadname_temp);
	instituteBean.setFeesoperation(mode);
	insert = query_object.updateFeeshead(instituteBean);
	String op="";
	
	
	if(insert == 1000){
		subjectduplicate	+= feesheadname_temp;
	}
	else{
		no_of_rows				+= insert;
	}

	
	if(mode.equals("updatefeeshead"))
	{
		op = "Updated";
	}else if(mode.equals("feesheadtrash"))
	{
		op = "Trashed";
	}else if(mode.equals("deleteststus"))
	{
		op="Deleted";
	}
	else if(mode.equals("restoreststus"))
	{
		op="Restored";
	}
	else if(mode.equals("feesheaddeactive"))
	{
		op="Deactivated";
	}//
	else if(mode.equals("activeststus"))
	{
		op="Activated";
	}
	
	String message="";

	if(mode.equals("updatefeeshead") || mode.equals("feesheadtrash") || mode.equals("activeststus") || mode.equals("feesheaddeactive"))
	{
		if(no_of_rows >0)
			message = "Successfully Fees Head "+op+".";
		else
			message = "Fees Head "+op+" failed.";	
		
		if(subjectduplicate != null && subjectduplicate.length()>2)
			message	+= " The Following Fees Head already exists. "+subjectduplicate;
		

			String return_file =request.getContextPath()+"/jsp/Fees/FeesHeadView.jsp";  
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	}else if(mode.equals("deleteststus") || mode.equals("restoreststus"))
	{
		if(no_of_rows >0)
			message = "Successfully Fees Head "+op;
		else
			message = "Fees Head "+op+" failed";	

			String return_file =request.getContextPath()+"/jsp/Fees/feesheadTrashList.jsp";  
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	}else if(mode.equals("feesheaddeactive") )
	{
		if(no_of_rows >0)
			message = "Successfully Fees Head "+op;
		else
			message = "Fees Head "+op+" failed";	

			String return_file =request.getContextPath()+"/jsp/Fees/feesheadDeactiveList.jsp";  
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	}



	
	
	 	
	 	

} catch (NullPointerException e)
{//System.out.println("IN JSP PAGE");
	e.printStackTrace();

}
%>
