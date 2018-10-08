<%
String yearofsessionname = null;
String yearofsessionid = null;
String boardid = null;
String boardname = null;
String standardname = null;
String standardscheduleid = null;
String[] feesscheduleamount;
String[] feesscheduleid;
String[] feesheadid;
String userid =null;
String[] opmode;
String return_file ="";
com.iGrandee.Fees.FeesSchedule feesschedulequery 		= new com.iGrandee.Fees.FeesSchedule();  
com.iGrandee.Fees.FeesScheduleBean  feesscheduleBean 	= new com.iGrandee.Fees.FeesScheduleBean();
int rows =0;
String message = "";
try
{
	
	 yearofsessionid = request.getParameter("yearofsessionid");
	  yearofsessionname = request.getParameter("yearofsessionname");
	  
	  boardid = request.getParameter("boardid");
	  boardname = request.getParameter("boardname");
	  
	  standardscheduleid = request.getParameter("standardscheduleid");
	  standardname = request.getParameter("standardname");
 feesscheduleamount = request.getParameterValues("feesscheduleamount");
 feesscheduleid = request.getParameterValues("feesscheduleid");
 feesheadid= request.getParameterValues("feesheadid");
 standardscheduleid = request.getParameter("standardscheduleid");
 userid = (String)session.getValue("userid");
  
	opmode  = request.getParameterValues("opmode");
	//out.println("Lfasdfdasf"+feesheadid.length);
	for(int x=0;x<feesheadid.length;x++)
	{
		if(!feesscheduleamount[x].equals(""))
		{
			//out.println("<br>amoutn"+feesscheduleamount[x]);

			//out.println("<br>opmode"+opmode[x]);
			if(opmode[x].equals("insert"))
			{
				
				feesscheduleBean.setFeesheadid(feesheadid[x]);
				feesscheduleBean.setFeesscheduleid(feesscheduleid[x]);
				feesscheduleBean.setStandardscheduleid(standardscheduleid);
				feesscheduleBean.setFeesscheduleamount(feesscheduleamount[x]);
				feesscheduleBean.setCreatedby(userid);
				rows +=feesschedulequery.insertStandardFeesStructure(feesscheduleBean);
				if(rows >0)
				{
					message = "Fees Allotment Successfully Inserted";
				}else{
					message = "Allotment Insertion failure";
				}
			}
			else if(opmode[x].equals("update"))
			{
				feesscheduleBean.setFeesscheduleid(feesscheduleid[x]);
				feesscheduleBean.setFeesscheduleamount(feesscheduleamount[x]);
				rows +=feesschedulequery.updateFeesschedule(feesscheduleBean);
				if(rows >0)
				{
					message = "Fees Allotment Successfully Updated";
				}else{
					message = "Allotment Updation failure";
				}
			}
		}
		//out.println("ASDF"+x);
	}
	return_file = request.getContextPath()+"/jsp/Fees/StandardFeesStructure.jsp";


}catch(Exception e){e.printStackTrace();}


%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.submitlessonform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="submitlessonform" action="" method="post">
<input type="hidden" name="result" value="<%=rows %>">
     	<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid%>"/>
		<input type="hidden" name="standardname" value="<%=standardname%>"/>   
    	<input type="hidden" name="yearofsessionid" value="<%=yearofsessionid%>"/>
    	<input type="hidden" name="yearofsessionname" value="<%=yearofsessionname%>"/> 
    	<input type="hidden" name="boardid" value="<%=boardid%>"/> 
    	<input type="hidden" name="boardname" value="<%=boardname%>"/>
    	<input type="hidden" name="returnurl" value="<%=return_file%>">
    	<input type="hidden" name="message" value="<%=message%>">
    	
   
</form>
</body>
</html>

