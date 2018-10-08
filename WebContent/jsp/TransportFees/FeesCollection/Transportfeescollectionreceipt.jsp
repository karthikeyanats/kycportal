<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">
function backtopagefun()
{
	 document.operationform.action	="./Feescollectionrollnumber.jsp";
	document.operationform.submit();
}

function getPrint()
{
	window.open("./transportfeesreceipt.jsp?transportfeescollectionid="+document.operationform.retstr.value+"&rollnumbertext="+document.operationform.rollnumbertext.value+"&reqtransportcategoryid="+document.operationform.req_transportcategoryid.value+"&req_discountamount="+document.operationform.req_discountamount.value);
}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
		<form name="operationform"  id="operationform" method="post">
		<%
			int rows 			= 0;
				String rowstr = null;
				try
				{
					//rows		= Integer.parseInt(request.getParameter("result"));
					rowstr = request.getParameter("retstr");
					
						
					if(!rowstr.equals("empty")){
						
						%>
							<br><br><br><br><h2>Result Info</h2>
							
							<div class="valid_box">
						        <center>Fees Successfully Collected</center>
						     </div>
					     
						
						<% 
					}
					else{
					%>
						<br><br><br><br><h2>Result Info</h2>
						<div class="error_box">
					        <center>Fees Collection Process is failed</center>
					     </div>
					<% }
				%>
				        <a href="#" class="bt_green" onclick="backtopagefun()"><span class="bt_green_lft"></span><strong>Go Back</strong><span class="bt_green_r"></span></a>
				        <%if(!rowstr.equals("empty")){ %>
				        <a href="#" class="bt_green" onclick="getPrint()"><span class="bt_green_lft"></span><strong>Print Receipt</strong><span class="bt_green_r"></span></a>
				        <%}%>
				        
				<%
					
				
			}catch(Exception e){e.printStackTrace();}
				%>
			
							<input type="hidden" name="rollnumbertext" 	value="<%=request.getParameter("rollnumbertext")%>">
   	<input type="hidden" name="req_transportcategoryid" 	value="<%=request.getParameter("req_transportcategoryid")%>">
   	<input type="hidden" name=req_studentapprovalid 	value="<%=request.getParameter("req_studentapprovalid")%>">
   	<input type="hidden" name="req_sessionid" 	value="<%=request.getParameter("req_sessionid")%>">
   	<input type="hidden" name="retstr" 	value="<%=rowstr%>">
   	 	<input type="hidden" name="req_discountamount" 	value="<%=request.getParameter("req_discountamount")%>">
		</form>
 </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>