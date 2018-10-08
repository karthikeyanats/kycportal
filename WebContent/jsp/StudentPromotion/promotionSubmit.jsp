<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
//String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";

String[] chkBoxId=null;
chkBoxId= request.getParameterValues("chk");

String promoStdSchedId = "";
String promoStatus = "";
com.iGrandee.Promotion.PromotionQuery  promotionQuery = new com.iGrandee.Promotion.PromotionQuery();
com.iGrandee.Promotion.PromotionBean promotionBean = new com.iGrandee.Promotion.PromotionBean();
try
{
	//instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	promoStdSchedId = request.getParameter("promoStdSchedId");
	promoStatus		= request.getParameter("promoResult");	
	
	//if(feestermoperation.equals("insert"))
	int j=0;
	if(chkBoxId!=null){
		for(int i=0;i<chkBoxId.length;i++){
		String[] var=null;
		var=chkBoxId[i].split("@");

		String allocationId=var[0];
		String position=var[1];
		int pos=Integer.parseInt(position);

		promotionBean.setStudentallocationid(allocationId);
		promotionBean.setStandardscheduleid(promoStdSchedId);
		promotionBean.setPromotionstatus(promoStatus);
		promotionBean.setCreatedby(userid);
		rows += promotionQuery.insertPromotion(promotionBean);
		}		
	}
	if(rows>0)
	{
		if(promoStatus.equals("Pass"))
			op = "Students Promoted Successfully";
		else
			op = "Students Depromoted";
	}
	else
	{
		if(promoStatus.equals("Pass"))
			op = "Students Promotion Failed";
		else
			op = "Students Depromotion Failed";
	}

	return_file = request.getContextPath()+"/jsp/StudentPromotion/StudPromoSelect.jsp";
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_re.jsp?op="+op+"&rows="+rows+"&forwardfile="+return_file);

}catch(Exception e){e.printStackTrace();}

%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.promosubmitform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.promosubmitform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="promosubmitform" action="" method="post">
<input type="hidden" name="result" value="<%=rows %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=op%>">
</form>
</body>
</html>
