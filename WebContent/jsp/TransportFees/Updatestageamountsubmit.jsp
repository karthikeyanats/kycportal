<%@page import="com.iGrandee.TransportFees.StageAmountAllocation"%>
<%@page import="com.iGrandee.TransportFees.StageAmountAllocationAction"%>
<%@page import="com.iGrandee.TransportFees.FeesSettings"%>
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityBean,com.iGrandee.MasterEntries.Community.CommunityQuery"%>
<%
	StageAmountAllocationAction  stageamountallocation = new StageAmountAllocationAction();
	StageAmountAllocation     stageamountallocationBean= new StageAmountAllocation();
	
	String transportfeessettingsid = "";
	String[] transportstageid = null;
	String[] transportfeesheadid = null;
	String[] setttingheadid= null;
	String transportcategoryid="";
	String[] transportfeesamount = null;
	String[] transportstageamountallocationid = null;
	String transportrouteid = request.getParameter("transportrouteid");
	String transportfeestypeid = request.getParameter("transportfeestypeid");
	String req_transportcategoryname = request.getParameter("req_transportcategoryname");
	String req_transportroutename = request.getParameter("req_transportroutename");
	String transportfeestypename = request.getParameter("tn");
	String sessionid = (String)session.getValue("sessionid"); 
	String userid = null;
	String op=null;
	String return_file=null;
	int result = 0;
try
{
	
	
	userid = (String)session.getValue("userid"); 
	transportfeesheadid = (String[])request.getParameterValues("transportfeesheadid");
	//System.out.println("transportfeesheadid===>>>"+transportfeesheadid.length);
	
	transportstageamountallocationid = (String[])request.getParameterValues("transportstageamountallocationid");
	//System.out.println("transportstageamountallocationid===>>>"+transportstageamountallocationid.length);
	
	transportstageid = (String[])request.getParameterValues("transportstageid");
	//System.out.println("transportstageid===>>>"+transportstageid.length);
	
	transportcategoryid = request.getParameter("transportcategoryid");   
	
	transportfeesamount = (String[])request.getParameterValues("checkamount");
	//System.out.println("transportfeesamount===>>>"+transportfeesamount.length);
	
	String[] checkallotamountArray=(String[])request.getParameterValues("checkallotamount"); 
	
	String[] amountvalset2 = (String[])request.getParameterValues("amountvalset");
	
	if(checkallotamountArray!=null && checkallotamountArray.length!=0)
	{
		//System.out.println("checkallotamountArray.length ===>"+checkallotamountArray.length);
		
		
		for(int i=0;i<checkallotamountArray.length;i++) 
		{			
			String totalValues=checkallotamountArray[i];
			System.out.println("totalValues ==>"+totalValues); 
			
			String[] totalvalueCollections=totalValues.split(";");
			
			String firstvalue=totalvalueCollections[0];
			String secondvalue=totalvalueCollections[1];
			String thirdvalue=totalvalueCollections[2];
			String fourthvalue = totalvalueCollections[3];
			
			//System.out.println("firstvalue ==>"+firstvalue); 
			//System.out.println("secondvalue ==>"+secondvalue);
			//System.out.println("thirdvalue ==>"+thirdvalue);
			System.out.println("fourthvalue ==>"+fourthvalue);
			
			stageamountallocationBean.setTransportcategoryid(transportcategoryid);
			
			//System.out.println("transportstageid[i] --->"+transportstageid[i]);
			//System.out.println("transportfeesamount[i].value ====>"+transportfeesamount[i]);
			
			stageamountallocationBean.setTransportstageid(thirdvalue);  
			stageamountallocationBean.setTransportfeesheadid(secondvalue);
			stageamountallocationBean.setAllocatedamount(firstvalue);
			stageamountallocationBean.setCreatedby(userid); 
			stageamountallocationBean.setTransportstageamountallocationstatus("A");
			result = stageamountallocation.Updatetranspotamount(stageamountallocationBean,fourthvalue); 

		}
	}		
	
	
 
	if(result==1000)
		op="Amount already Exists";
	else if(result>0)
		op="Amount Successfully Updated";
	else
		op="Amount Updation Failed";

	return_file = request.getContextPath()+"/jsp/TransportFees/AmountUpdate.jsp";
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	
}catch(Exception e){}	
	
	
%>

<html>
<head>
<script type="text/javascript">
function go()
{
	document.cat_form.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
    document.cat_form.submit();
}

</script>	
</head>
<body onload="go()">
<form name="cat_form" method="post">

	<input type="hidden" name="message" value="<%=op%>"/>  
	<input type="hidden" name="result" value="<%=result%>"/>
	<input type="hidden" name="returnurl" value="<%=return_file%>"/>
	<input type="hidden" name="transportcategoryid" value="<%=request.getParameter("transportcategoryid")%>"/> 
	<input type="hidden" name="transportrouteid" value="<%=transportrouteid%>"/>
	<input type="hidden" name="sessionid" value="<%=sessionid%>">
	<input type="hidden" name="tn" value="<%=transportfeestypename%>">  
	<input type="hidden" name="transportfeestypeid" value="<%=transportfeestypeid%>" />
	<input type="hidden" name="req_transportcategoryname" value="<%=req_transportcategoryname%>" />
	<input type="hidden" name="req_transportroutename" value="<%=req_transportroutename%>" />
	
	
	          
<%

if(request.getParameter("transportcategoryid")!=null){
	out.println("<input type='hidden' name='transportcategoryid' value='"+request.getParameter("transportcategoryid")+"'/>");
	
}	

if(request.getParameter("sessionid")!=null){
	out.println("<input type='hidden' name='sessionid' value='"+request.getParameter("sessionid")+"'/>");
	
}	


if(request.getParameter("transportrouteid")!=null){
	
	out.println("<input type='hidden' name='transportrouteid' value='"+request.getParameter("transportrouteid")+"'/>");
}

if(request.getParameter("transportfeestypename")!=null){
	
	out.println("<input type='hidden' name='transportfeestypename' value='"+request.getParameter("transportfeestypename")+"'/>");
}

if(request.getParameter("transportfeestypeid")!=null){
	
	out.println("<input type='hidden' name='transportfeestypeid' value='"+request.getParameter("transportfeestypeid")+"'/>");
}
	
%>	 
</form>
</body>

</html>


