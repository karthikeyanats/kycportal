<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Discount.DiscountAction" />


	
<%@ page language="java" import="java.util.*"%>
<%
try{
	

	String discountcategoryname=request.getParameter("discountcategoryname");
	discountcategoryname=discountcategoryname.replaceAll("&quot;","\"");
	String descryption=request.getParameter("discountcategorydescription");
	String discountcategoryid=request.getParameter("discountcategoryid");
	
	 
	
	int courseList = query_object.updatediscount(discountcategoryid,discountcategoryname,descryption);
	
	String message="";
	if(courseList ==1)
	{
		message = "Discount Category Successfully Updated";  
	}
	else if(courseList ==0)
	{
		message = " Discount Category Updation  Failed";	
	}
	else if(courseList ==1000)
	{
		message = " Discount Category Name Already Exist";	
		courseList=1000;
	}

		String return_file =request.getContextPath()+"/jsp/Discount/Discountlist.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
}
catch(Exception e)
{
	e.printStackTrace();	
}
%>
