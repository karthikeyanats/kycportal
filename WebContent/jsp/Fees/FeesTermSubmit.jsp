<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%

	String instituteid 			= null;
	String userid 				= null;
	String[] feestermname		= null;
	int rows 					= 0;
	int insert					= 0;
	String subjectduplicate		= "";
	String return_file 			= "";
	String message				= "";
	String feestermoperation 	= "";
	com.iGrandee.Fees.FeesTermQuery  feestermQuery = new com.iGrandee.Fees.FeesTermQuery();
	com.iGrandee.Fees.FeesTermBean feestermBean = new com.iGrandee.Fees.FeesTermBean();
	try
	{
	
	
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	feestermoperation = request.getParameter("feestermoperation");
	
	if(feestermoperation.equals("insert"))
	{
		
		feestermname = request.getParameterValues("feestermname");
			
		for(int x=0;x<feestermname.length;x++)
		{ 
			if(!feestermname[x].equals(""))
			{
				feestermBean.setTermname(feestermname[x]);
				feestermBean.setCreatedby(userid);
				feestermBean.setInstituteid(instituteid);
				insert  = feestermQuery.insertFeesTerm(feestermBean);
				 
				if(insert == 1000){
					subjectduplicate	+= feestermname[x]+",";
				}
				else{
					rows				+= insert;
				}
			}
		}
		
		if(rows >0)
			message = "Successfully FeesTerm Inserted.";
		else
			message = "FeesTerm Insertion failed.";
		
		if(subjectduplicate != null && subjectduplicate.length()>2)
			message	+= " The Following FeesTerm already exists. "+subjectduplicate.substring(0,subjectduplicate.length()-1);
		
		return_file = request.getContextPath()+"/jsp/Fees/FeesTerm.jsp";
	
	
	}
	else if (feestermoperation.equals("updatestatus"))
	{
		//feestermBean.setFeesoperation("updatefeeshead");
		
	
	}else if (feestermoperation.equals("udpatefeesterm"))
	{
		
		feestermname = request.getParameterValues("feestermname");
		
		for(int x=0;x<feestermname.length;x++)
		{
			if(!feestermname[x].equals(""))
			{
				feestermBean.setTermname(feestermname[x]);
				feestermBean.setCreatedby(userid);
				feestermBean.setFeestermid(instituteid);
				feestermBean.setFeesoperation("updatefeeshead");
				
				rows += feestermQuery.updateFeesterm(feestermBean);
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
