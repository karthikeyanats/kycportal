<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.StaffList.StaffCategoryQuery" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.StaffList.StaffCategoryBean" />
	


<%
	int no_of_rows 				= 0;
	String mode 				= "";
	int rows 					= 0;
	int insert					= 0;
	String subjectduplicate		= "";
	
	
	
try {
	
	mode = request.getParameter("mode_of_operation");
	
	String staffcategoryid_temp = request.getParameter("staffcategoryid_temp");
	String staffcategoryname_temp = request.getParameter("staffcategoryname_temp");

	String ipaddress = request.getRemoteAddr();
	String instituteid=(String)session.getValue("instituteid");
	instituteBean.setInstituteid(instituteid);

	instituteBean.setStaffcategoryid(staffcategoryid_temp);
	instituteBean.setStaffcategoryname(staffcategoryname_temp);
	instituteBean.setStaffcategoryoperation(mode);
	insert = query_object.updateStaffcategory(instituteBean);  
	String op="";
	
	
	if(insert == 1000){
		subjectduplicate	+= staffcategoryname_temp;
	}
	else{
		no_of_rows				+= insert;
	}

	
	if(mode.equals("updatestaffcategory"))
	{
		op = "Updated";
	}else if(mode.equals("staffcategorytrash"))
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
	else if(mode.equals("staffdeactive"))
	{
		op="Deactivated";
	}//
	else if(mode.equals("activeststus"))
	{
		op="Activated";
	}
	
	String message="";

	if(mode.equals("updatestaffcategory") || mode.equals("staffcategorytrash") || mode.equals("activeststus") || mode.equals("staffdeactive"))
	{
		if(no_of_rows >0)
			message = "Successfully StaffCategory "+op+".";
		else
			message = "StaffCategory "+op+" failed.";	
		
		if(subjectduplicate != null && subjectduplicate.length()>2)
			message	+= " The Following StaffCategory already exists. "+subjectduplicate;
		

			String return_file =request.getContextPath()+"/jsp/Staff/staffcategoryview.jsp";  
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	}else if(mode.equals("deleteststus") || mode.equals("restoreststus"))
	{
		if(no_of_rows >0)
			message = "Successfully StaffCategory "+op;
		else
			message = "StaffCategory "+op+" failed";	

			String return_file =request.getContextPath()+"/jsp/Staff/staffcategoryTrashList.jsp";  
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	}else if(mode.equals("staffdeactive") )
	{
		if(no_of_rows >0)
			message = "Successfully StaffCategory "+op;
		else
			message = "StaffCategory "+op+" failed";	

			String return_file =request.getContextPath()+"/jsp/Staff/staffcategoryDeactiveList.jsp";  
		 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	}



	
	
	 	
	 	

} catch (NullPointerException e)
{//System.out.println("IN JSP PAGE");
	e.printStackTrace();

}
%>
