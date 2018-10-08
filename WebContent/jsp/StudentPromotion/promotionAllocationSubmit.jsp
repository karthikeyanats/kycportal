<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
//String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";
String[] chkBoxId=null;
chkBoxId= request.getParameterValues("chk");

String promoSecSchedId = "";
//String promoStatus = "";
com.iGrandee.Promotion.PromotionQuery  promotionQuery = new com.iGrandee.Promotion.PromotionQuery();
com.iGrandee.Promotion.PromotionBean promotionBean = new com.iGrandee.Promotion.PromotionBean();
try
{
	//instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	promoSecSchedId = request.getParameter("sectionSchedId");
	//promoStatus		= request.getParameter("promoResult");	
	
	//if(feestermoperation.equals("insert"))
	int j=0;
	if(chkBoxId!=null){
		for(int i=0;i<chkBoxId.length;i++){
		String[] var=null;
		var=chkBoxId[i].split("@");

		String allocationId=var[0];
		String candRegId=var[1];
		String rollNo=var[2];
		String promotionId=var[3];
		String promoStatus=var[4];
		String position=var[5];
		int pos=Integer.parseInt(position);

		promotionBean.setStudentallocationid(allocationId);
		promotionBean.setCandidateregisterid(candRegId);
		promotionBean.setRollno(rollNo);
		promotionBean.setStudentpromotionid(promotionId);		
		promotionBean.setSectionscheduleid(promoSecSchedId);
		promotionBean.setPromotionstatus(promoStatus);
		promotionBean.setCreatedby(userid);
		
		rows += promotionQuery.insertAllocationPromotion(promotionBean);
		}
		
	}
	
	if(rows>0)
		op = "Promoted Students Allocated Successfully";
	else
		op = "Promoted Students Allocation Failed";
	
	return_file = request.getContextPath()+"/jsp/StudentPromotion/PromotedStudentAllocation.jsp";
	//return_file = "/jsp/StudentPromotion/PromotedStudentAllocation.jsp";
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_re.jsp?op="+op+"&rows="+rows+"&forwardfile="+return_file);

}catch(Exception e){
	//System.out.println("Exception in promotionAllocationSubmit-->"+e);
	e.printStackTrace();}

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
