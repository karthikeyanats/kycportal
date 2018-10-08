<html>
<head>
<script type="text/javascript">

	function loadResult()
	{
		
		//document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
		<%-- document.submitlessonform.action="<%=request.getContextPath()%>/jsp/TransportFees/FeesCollection/Feescollectionstudentinfo.jsp"; --%>
		document.submitlessonform.action="<%=request.getContextPath()%>/jsp/TransportFees/FeesCollection/Transportfeescollectionreceipt.jsp";
		document.submitlessonform.submit();
	}

</script>
</head>
<body onload=loadResult()>
	<form name="submitlessonform" action="" method="post">
		<%@ page language="java"%>
		<%@ page import="com.iGrandee.Common.DateTime"%>
		<%@ page import="com.iGrandee.TransportFees.Feescollection.Feescollectionaction,com.iGrandee.TransportFees.Feescollection.TransportFeesCollection"%>

		<%
		com.iGrandee.TransportFees.Feescollection.Feescollectionaction  transportFeesQry = new com.iGrandee.TransportFees.Feescollection.Feescollectionaction();
		com.iGrandee.TransportFees.Feescollection.TransportFeesCollection  feescollectionbean = new com.iGrandee.TransportFees.Feescollection.TransportFeesCollection();
		String studentstageallocationid = null;
		String paidamount = null;
		String rollnumber = null;
		String transportcategoryid = null;
		int result=0;
		String[] transportstageamountallocationid;
		String discountamountid = null;
		String actualpaidamount = null;
		String discountuserid= null;
 String req_sessionid=null;
 String retstr = null;
 String discountusedstatus  = null;
 String req_discountamount  = null;
		try{
			
			studentstageallocationid = request.getParameter("studentstageallocationid");
			paidamount = request.getParameter("paidamount");
			actualpaidamount = request.getParameter("actualpaidamount");
			req_sessionid= request.getParameter("req_sessionid");
			discountusedstatus= request.getParameter("discountusedstatus");
			req_discountamount= request.getParameter("discountamount");
			
			
			
			rollnumber = request.getParameter("rollnumbertext");
			transportcategoryid = request.getParameter("req_transportcategoryid");

			transportstageamountallocationid = request.getParameterValues("transportstageamountallocationid");
			
			if(request.getParameter("discountamountid").equals("null"))
				discountamountid="-";
			else
				discountamountid = request.getParameter("discountamountid");
			
				
			discountuserid = request.getParameter("discountuserid");
			
			feescollectionbean.setRollnumber(rollnumber);
			feescollectionbean.setPaidamount(actualpaidamount);
			feescollectionbean.setTransportcategoryid(transportcategoryid);
			feescollectionbean.setUserstageallocationid(studentstageallocationid);
			feescollectionbean.setTransportstageamountallocationid(transportstageamountallocationid);
			
			feescollectionbean.setDiscountamountid(discountamountid);
			feescollectionbean.setDiscountuserid(discountuserid);
			feescollectionbean.setSessionid(req_sessionid);
			feescollectionbean.setDiscountusedstatus(discountusedstatus);
			
			//result = transportFeesQry.saveFees(feescollectionbean);
			retstr = transportFeesQry.saveFees(feescollectionbean);
			
			
			
			String resultword = "";
			
			/* if (result > 0) {
				resultword = "Student Scholarship Details Successfully Updated";
			} else {
				resultword = "Operation Failed";
			} */
			 if (retstr.equals("empty")) {
					 resultword = "Operation Failed";
					
				} else {
					resultword = "Fees Successfully Collected";
					
				}

			String return_file = "./TransportFees/FeesCollection/Feescollectionstudentinfo.jsp";
		%>

			<input type="hidden" name="rollnumbertext" 	value="<%=request.getParameter("rollnumbertext")%>">
   	<input type="hidden" name="req_transportcategoryid" 	value="<%=request.getParameter("req_transportcategoryid")%>">
   	<input type="hidden" name=req_studentapprovalid 	value="<%=request.getParameter("req_studentapprovalid")%>">
   	<input type="hidden" name="req_sessionid" 	value="<%=request.getParameter("req_sessionid")%>">
   	<input type="hidden" name="retstr" 	value="<%=retstr%>">
   	<input type="text" name="req_discountamount" 	value="<%=request.getParameter("discountamount")%>">
   	
   	
			<%}catch(Exception e){e.printStackTrace();} %>
	</form>
</body>
</html>

