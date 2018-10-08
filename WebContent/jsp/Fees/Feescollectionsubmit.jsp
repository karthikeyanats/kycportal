<%@page import="com.iGrandee.Fees.FeesCollectionBean"%>
<%@page import="com.iGrandee.Fees.FeesCollectionQuery"%> 
<% 
 
	 FeesCollectionQuery  feesCollectionQuery 	= new FeesCollectionQuery();
	 FeesCollectionBean feesCollectionBean 		= new FeesCollectionBean();
	
	 int rows 				= 0;
	 String return_file 	= "";
	 String message 		= "";
	 String retstr=null;
 
	feesCollectionBean.setTermfeesid(request.getParameter("termcheckid"));
  	feesCollectionBean.setStudentapprovalid(request.getParameter("studentapprovalid"));
  	feesCollectionBean.setCreatedby((String)session.getAttribute("userid"));
  	feesCollectionBean.setPaidamount(request.getParameter("paidamount"));
  	
  	  	
  	feesCollectionBean.setBanknames(request.getParameterValues("bankname"));
  	feesCollectionBean.setDdnos(request.getParameterValues("ddnumber"));
  	feesCollectionBean.setDddates(request.getParameterValues("dddate"));
  	feesCollectionBean.setCollectionamounts(request.getParameterValues("ddamount"));
  	feesCollectionBean.setPaymenttypes(request.getParameterValues("paymenttype"));
  	feesCollectionBean.setScholarshipids(request.getParameterValues("scholarshiptype"));
  	
  	feesCollectionBean.setSchemeforstudentid(request.getParameterValues("schemeforstudentid"));
  	
  	
  //	rows+=feesCollectionQuery.addFeesCollection(feesCollectionBean);
  String feesreceitpid=feesCollectionQuery.addFeesCollectionwithreceipt(feesCollectionBean);
  

	  	
	  	
/*    	if(rows >0)
		message = "Fees Collection successfully Inserted";
	else
		message = "Fees Collection Insertion failure";
 */
 System.out.println("feesreceitpid-->"+feesreceitpid);
 if(feesreceitpid!=null){
	 retstr= feesreceitpid;
		message = "Fees Collection successfully Inserted";}
	else{retstr="empty";
		message = "Fees Collection Insertion failure";}
 
 
  	return_file =  request.getContextPath()+"/jsp/Fees/FeesCollectionStudentinfo.jsp";
    	  
    	  
%>
<html>
<head>

<script type="text/javascript">

	function loadResult()
	{
		<%-- document.feescollectionsubmitform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
		document.feescollectionsubmitform.submit(); --%>
		
		  document.feescollectionsubmitform.action="<%=request.getContextPath()%>/jsp/Fees/Academicfeesresultinfo.jsp";
			document.feescollectionsubmitform.submit(); 
		
		
	}

</script>
</head>
<body onload=loadResult()>
<form name="feescollectionsubmitform" action="" method="post">
<input type="hidden" name="result" 			value="<%=rows %>">
<input type="hidden" name="returnurl" 		value="<%=return_file%>">
<input type="hidden" name="rollnumbertext" 	value="<%=request.getParameter("rollnumbertext")%>">
<input type="hidden" name="message" 		value="<%=message%>">
<input type="hidden" name="feesreceitpid" 		value="<%=feesreceitpid%>">
<input type="hidden" name="retstr" 		value="<%=retstr%>">


</form>
</body>
</html>
