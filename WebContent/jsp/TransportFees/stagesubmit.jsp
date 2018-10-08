<%@page import="com.iGrandee.TransportFees.TransportStage"%>
<%@page import="com.iGrandee.TransportFees.TransportStageAction"%>
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%

	String instituteid 			= null;
	String userid 				= null;
	String[] stagename		= null;
	String[] routenamedesc		= null;
	int rows 					= 0;
	int insert					= 0;
	String subjectduplicate		= "";
	String return_file 			= "";
	String message				= "";
	String transportoperation 	= "";
	String transportrouteid		="";
	
	if(request.getParameter("transportrouteid")!=null){
		transportrouteid			=request.getParameter("transportrouteid");
	}
	TransportStage  transportroutebean = new TransportStage();
	TransportStageAction transportrouteaction = new TransportStageAction();
	try
	{
	
		if(request.getParameterValues("stagename")!=null){
			stagename = request.getParameterValues("stagename");
			routenamedesc	= request.getParameterValues("descryption");
		}
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	transportoperation = request.getParameter("transportoperation");
	
	if(transportoperation.equals("insert"))
	{
		for(int x=0;x<stagename.length;x++)
		{ 
			if(!stagename[x].equals(""))
			{ 
				transportroutebean.setTransportstagename(stagename[x]); 
				transportroutebean.setCreatedby(userid);
				transportroutebean.setTransportrouteid(transportrouteid); 
				if(routenamedesc[x].equals(""))
					transportroutebean.setTransportstagedescription("-");
				else
					transportroutebean.setTransportstagedescription(routenamedesc[x]);
				transportroutebean.setTransportstagestatus("A");
				insert  = transportrouteaction.inserttransportstage(transportroutebean);
				
				if(insert == 1000){
					subjectduplicate	+= stagename[x]+",";
				}
				else{
					rows				+= insert;
				}
				  
			}
		}
		
		if(rows >0)
			message = "Successfully Stage Inserted.";
		else
			message = "Stage Insertion failed.";
		
		 if(subjectduplicate != null && subjectduplicate.length()>2)
			message	+= " The Following Stage Name already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
		
		return_file = request.getContextPath()+"/jsp/TransportFees/Stage.jsp";
	
	System.out.println("insert>>>>>>>>>>"+insert);
	}
	else if (transportoperation.equals("updatestatus"))
	{
		//transportroutebean.setFeesoperation("updatefeeshead");
		
	
	}else if (transportoperation.equals("udpatetransport"))
	{
	}
	
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+rows+"&returnurl="+return_file);

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

<input type="hidden" name="message" value="<%=message%>">
<input type="hidden" name="transportrouteid" value="<%=transportrouteid %>">
<input type="hidden" name="result" value="<%=rows %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
  <%
String routename=null;
if(request.getParameter("routename")!=null){
	routename=request.getParameter("routename");
	out.println("<input type='hidden' name='routename' value='"+routename+"'>");
	
} 
         
         %>
</form>
</body>
</html>
