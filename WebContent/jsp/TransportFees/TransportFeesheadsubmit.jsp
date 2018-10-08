<%@page import="com.iGrandee.TransportFees.TrasportFeesHeadAction"%>
<%@page import="com.iGrandee.TransportFees.TrasportFeesHead"%>
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%

	String instituteid 			= null;
	String userid 				= null;
	String[] feesname		    = null;
	int rows 					= 0;
	int insert					= 0;
	String subjectduplicate		= "";
	String return_file 			= "";
	String message				= "";
	String transportoperation 	= "";
	TrasportFeesHead  transportfeesheadbean = new TrasportFeesHead();
	TrasportFeesHeadAction transportfeesheadaction = new TrasportFeesHeadAction();
	try
	{
	
		if(request.getParameterValues("feesname")!=null){
			feesname = request.getParameterValues("feesname");
			//System.out.println("feesname===>>"+feesname.length);
		}
	instituteid = (String)session.getValue("instituteid");
	transportoperation = request.getParameter("transportoperation");
	
	if(transportoperation.equals("insert"))
	{
		
		
		for(int x=0;x<feesname.length;x++)
		{
			if(!feesname[x].equals(""))
			{
				transportfeesheadbean.setTransportfeesheadname(feesname[x]); 
				transportfeesheadbean.setInstituteid(instituteid);
				insert  = transportfeesheadaction.inserttranspotfeeshead(transportfeesheadbean,"A");
				
				if(insert == 1000){
					subjectduplicate	+= feesname[x]+",";
				}
				else{
					rows				+= insert;
				}
			}
		}
		
		if(rows >0)
			message = "Successfully Fees Head Inserted.";
		else
			message = "Fees Head Insertion failed.";
		
		if(subjectduplicate != null && subjectduplicate.length()>2)
			message	+= " The Following Fees Head already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
		
		return_file = request.getContextPath()+"/jsp/TransportFees/TransportFeesHead.jsp";
	
//	out.println("insert>>>>>>>>>>"+insert);
	}
	else if (transportoperation.equals("updatestatus"))
	{ 
		//transportroutebean.setFeesoperation("updatefeeshead");
		
	
	}else if (transportoperation.equals("udpatetransport"))
	{
		
		feesname = request.getParameterValues("routename");
		
		for(int x=0;x<feesname.length;x++)
		{
			if(!feesname[x].equals(""))
			{
				/* transportfeesheadbean.setTransportfeesheadname(feesname[x]);
				transportfeesheadbean.setInstituteid(instituteid);
				transportfeesheadbean.setTransportoperation("updateroute"); */
				
				//rows += transportrouteaction.updatetranspotroute(transportroutebean);
			}
		}
		
		if(rows >0)
			message = "Succeesfully FeesTerm Updated";
		else
			message = "FeesTerm Updation failed";
		return_file = request.getContextPath()+"/jsp/Fees/FeesTermView.jsp";
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
<input type="hidden" name="result" value="<%=rows %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
</form>
</body>
</html>
