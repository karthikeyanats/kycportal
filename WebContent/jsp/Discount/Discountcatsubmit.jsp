<%@page import="com.iGrandee.Discount.DiscountCategorybean"%>
<%@page import="com.iGrandee.Discount.DiscountAction"%>
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%

	String instituteid 			= null;
	String userid 				= null;
	String[] discountname		= null;
	String[] discountdesc		= null;
	int rows 					= 0;
	int insert					= 0;
	String subjectduplicate		= "";
	String return_file 			= "";
	String message				= "";
	String operation 	= "";
	com.iGrandee.Discount.DiscountCategorybean  categorybean = new com.iGrandee.Discount.DiscountCategorybean();
	DiscountAction discountaction = new DiscountAction();
	try
	{
	
		if(request.getParameterValues("discountname")!=null){
			discountname = request.getParameterValues("discountname");
			discountdesc	= request.getParameterValues("descryption");
		}
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	operation = request.getParameter("operation");
	
	if(operation.equals("insert"))
	{
		for(int x=0;x<discountname.length;x++) 
		{
			if(!discountname[x].equals(""))
			{
				categorybean.setDiscountcategoryname(discountname[x]); 
				categorybean.setDiscountcategorydescription(discountdesc[x]);
				categorybean.setDiscountcategorystatus("A");
				categorybean.setInstituteid(instituteid); 
				categorybean.setCreatedby(userid);
				insert  = discountaction.insertdiscountcategory(categorybean);
				
				if(insert == 1000){
					subjectduplicate	+= discountname[x]+",";
				}
				else{
					rows				+= insert;
				}
			}
		}
		
		if(rows >0)
			message = "Successfully Discount Category Inserted.";
		else
			message = "Discount Category Insertion failed.";
		
		if(subjectduplicate != null && subjectduplicate.length()>2)
			message	+= " The Following Discount Category Name already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
		
		return_file = request.getContextPath()+"/jsp/Discount/Discount.jsp";
	
	//out.println("insert>>>>>>>>>>"+insert);
	}
	else if (operation.equals("updatestatus"))
	{
		//categorybean.setFeesoperation("updatefeeshead");
		
	
	}else if (operation.equals("udpatetransport"))
	{
		
	}
	
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+rows+"&returnurl="+return_file);

}catch(Exception e){e.printStackTrace();}

%>
<html>
<head>
<script language="javascript">
function loadResult()
{ 
	document.feesheadsubmitform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.feesheadsubmitform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="feesheadsubmitform" action="" method="post">
<input type="text" name="result" value="<%=rows %>">
<input type="text" name="returnurl" value="<%=return_file%>">
</form>
</body>
</html>
