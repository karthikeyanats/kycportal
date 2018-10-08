<%@page import="com.iGrandee.TransportFees.TransportRouteAction"%>
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%

	String instituteid 			= null;
	String userid 				= null;
	String[] routename		= null;
	String[] routenamedesc		= null;
	int rows 					= 0;
	int insert					= 0;
	String subjectduplicate		= "";
	String return_file 			= "";
	String message				= "";
	String transportoperation 	= "";
	com.iGrandee.TransportFees.TransportRoute  transportroutebean = new com.iGrandee.TransportFees.TransportRoute();
	TransportRouteAction transportrouteaction = new TransportRouteAction();
	try
	{
	
		if(request.getParameterValues("routename")!=null){
			routename = request.getParameterValues("routename");
			routenamedesc	= request.getParameterValues("descryption"); 
		}
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	transportoperation = request.getParameter("transportoperation");
	
	if(transportoperation.equals("insert"))
	{
		
		
		for(int x=0;x<routename.length;x++)
		{
			if(!routename[x].equals("")) 
			{
				transportroutebean.setRoutename(routename[x]); 
				transportroutebean.setCreatedby(userid);
				transportroutebean.setInstituteid(instituteid);
				transportroutebean.setRoutedescription(routenamedesc[x]);
				transportroutebean.setRoutestatus("A");
				insert  = transportrouteaction.inserttranspotroute(transportroutebean);
				
				if(insert == 1000){
					subjectduplicate	+= routename[x]+",";
				}
				else{
					rows				+= insert;
				}
			}
		}
		
		if(rows >0)
			message = "Successfully TransportRoute Inserted.";
		else
			message = "Transport route insertion failed";
		
		if(subjectduplicate != null && subjectduplicate.length()>2)
			message	+= " The Following Route Name already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
		
		return_file = request.getContextPath()+"/jsp/TransportFees/transportroute.jsp";
	
	out.println("insert>>>>>>>>>>"+insert);
	}
	else if (transportoperation.equals("updatestatus"))
	{
		//transportroutebean.setFeesoperation("updatefeeshead");
		
	
	}else if (transportoperation.equals("udpatetransport"))
	{
		
		routename = request.getParameterValues("routename");
		
		for(int x=0;x<routename.length;x++)
		{
			if(!routename[x].equals(""))
			{
				transportroutebean.setRoutename(routename[x]);
				transportroutebean.setRoutedescription(routenamedesc[x]);
				transportroutebean.setCreatedby(userid);
				transportroutebean.setInstituteid(instituteid);
				transportroutebean.setTransportoperation("updateroute");
				
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
<input type="text" name="result" value="<%=rows %>">
<input type="text" name="returnurl" value="<%=return_file%>">
</form>
</body>
</html>
