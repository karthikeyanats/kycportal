<%@page import="com.iGrandee.Discount.DiscountAction"%>
<%@page import="com.iGrandee.Discount.DiscountBean"%>
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%

	String instituteid 			= null;
	String createdby 			= null;
	String [] discountcategoryid   =null;
	String [] amount   =null;
	String operation			=null;
	int rows					=0;
	String message				=null;
	String return_file			=null;
	String yearsession			=null;
	DiscountAction  discountactionbean = new DiscountAction();
	DiscountBean discountBean = new DiscountBean();
	String []editcatid=null;String []editamount=null;String sessionname=null;
	String sessionid=null;
	try
	{
		
		
	
	if(request.getParameterValues("discountcategoryid")!=null)	
		discountcategoryid=request.getParameterValues("discountcategoryid");
	
	if(session.getValue("instituteid")!=null)
		instituteid = (String)session.getValue("instituteid");
	
	if(session.getValue("userid")!=null)
		createdby = (String)session.getValue("userid");
	
	if(request.getParameter("operation")!=null)
		operation=(String)request.getParameter("operation");
	
	if(request.getParameter("yearsession")!=null)
		yearsession=(String)request.getParameter("yearsession");
	
	if(request.getParameterValues("amount")!=null)
		amount=request.getParameterValues("amount");	
	//out.println("operation>>>>."+operation);
	
	if(operation.equals("insert")) 
	{
		
		if(request.getParameter("yearsession")!=null){
			sessionid=request.getParameter("yearsession");
		}
		
		for(int k=0;k<discountcategoryid.length;k++) 
		{
			
		discountBean.setCreatedby(createdby);
		discountBean.setDiscountamountstatus("A");
		discountBean.setDiscountcategoryid(discountcategoryid[k]);
		discountBean.setSessionid(yearsession);
		discountBean.setDiscountpercentage(amount[k]);
		

		rows+=	discountactionbean.insertdiscountamount(discountBean);
		
			 
		}
		if(rows >0) 
			message = "Discount Category Percentage Created  Successfully";
		else
			message = "Failed while Discount Category Percentage Creation";
		
		
		return_file = request.getContextPath()+"/jsp/Discount/Discountcreation.jsp";
	
	}
	else if (operation.equals("updatestatus"))
	{
		if(request.getParameterValues("editamount")!=null)
			editcatid=request.getParameterValues("discountamountid");
		
		if(request.getParameterValues("discountamountid")!=null)
			editamount=request.getParameterValues("editamount");
		
		if(request.getParameter("sessionname")!=null){
			sessionname=request.getParameter("sessionname");
		}
		
		if(request.getParameter("sessionid")!=null){
			sessionid=request.getParameter("sessionid");
		}
		
		
		for(int k=0;k<editcatid.length;k++)
		{
		rows+=discountactionbean.updatediscount(editcatid[k],editamount[k]);	
			
			//out.println("editamount>>>>["+k+"]>>"+editamount[k]);
		}
		
		if(rows >0)
			message = "Discount Category Percentage Updated  Successfully";
		else
			message = "Failed while Discount Category Percentage Updation";
		
		
		return_file = request.getContextPath()+"/jsp/Discount/Discountcreation.jsp";
	
	}else if (operation.equals("delete"))
	{
		if(request.getParameter("sessionid")!=null){
			sessionid=request.getParameter("sessionid");
		}
		return_file = request.getContextPath()+"/jsp/Discount/Discountedit.jsp";
		String discountamountid=null;
		discountamountid=request.getParameter("hiddendiscountamountid");
		rows=	discountactionbean.removediscountamount(discountamountid);
		
		if(rows >0)
			message = "Discount Category Percentage Deleted  Successfully";
		else
			message = "Failed while Discount Category Percentage Delete";
	} 
	

}
	catch(Exception e){
		e.printStackTrace();
		}
 
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
<input type="hidden" name="result" value="<%=rows %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=message%>">
<input type="hidden" name="sessionname" value="<%=sessionname%>">
<input type="hidden" name="sessionid" value="<%=sessionid%>">
<input type="hidden" name="yearsession" value="<%=sessionid%>">

</form>
</body>
</html>
