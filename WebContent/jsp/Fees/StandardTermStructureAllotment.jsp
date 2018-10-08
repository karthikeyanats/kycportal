<%@page import="com.iGrandee.Common.DateTime"%>
<%
String yearofsessionname = null;
String yearofsessionid = null;
String boardid = null;
String boardname = null;
String standardname = null;
String standardscheduleid = null;
String[] termfeesamount;
String[] termfeesid;
String[] termid;
String[] duedate;
String userid =null;
String opmode=null;
String return_file ="";
String[] termfeesamountarr=null;
String topay=null;
double tot=0;
int errcount=0;

com.iGrandee.Fees.TermFeesQuery termfeesQuery = new com.iGrandee.Fees.TermFeesQuery();  
com.iGrandee.Fees.TermFeesBean  termfeesBean = new com.iGrandee.Fees.TermFeesBean();
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
	  termfeesamount = request.getParameterValues("termfeesamount");
	  duedate = request.getParameterValues("duedate");
	  termfeesid = request.getParameterValues("termfeesid");
	 
 standardscheduleid = request.getParameter("standardscheduleid");
 userid = (String)session.getValue("userid");
 termid= request.getParameterValues("termid");
	opmode  = request.getParameter("opmode");
	
	if(opmode.equals("insert"))
	{
	for(int x=0;x<termid.length;x++)
	{
		out.println(termid[x]+"<br>");
		if(!termid[x].equals(""))
		{
			
				termfeesBean.setTermid(termid[x]);
				termfeesBean.setTermfeesid(termfeesid[x]);
				termfeesBean.setStandardscheduleid(standardscheduleid);
				termfeesBean.setTermfeesamount(termfeesamount[x]);
				termfeesBean.setDuedate(duedate[x]);
				termfeesBean.setCreatedby(userid);
				rows +=termfeesQuery.insertTermFeesAllotment(termfeesBean);
		}
	}
	
	if(rows >0)
		message = "Successfully Term details inserted";
	else
		message = "Term Details Insertion failed";
		return_file = request.getContextPath()+"/jsp/Fees/FeesStructureLoadStandard.jsp";
	}


	else if(opmode.equals("update"))
	{
		
		termfeesamountarr=request.getParameterValues("termfeesamount");
		topay=request.getParameter("topay");
		
		if(termfeesamountarr!=null)
		{
			for(int k=0;k<termfeesamountarr.length;k++){
				 tot =tot+ Double.parseDouble(termfeesamountarr[k]);
				
			}
			
		out.println("topay>>>>>>>>>>"+topay+"tot>>>>>>>"+tot);	
		}
		if(tot<=Double.parseDouble(topay)){
		for(int x=0;x<termfeesid.length;x++)
		{
				//out.println(termfeesamount[x]);
				termfeesBean.setTermfeesid(termfeesid[x]);
				termfeesBean.setTermfeesamount(termfeesamount[x]);
				termfeesBean.setDuedate(duedate[x]);
				rows +=termfeesQuery.updateTermFeesallotment(termfeesBean);
		}
		}
		else{
			
			message = "Term amount should not exceed Total Amount ";
			errcount++;
		}
		if(errcount==0){

				if(rows >0){
					message = "Successfully Term details updated";
				}
				else if(rows==1){
					
					message = "Term amount should not exceed Total Amount ";
				}
				else{
					message = "Term Details updation failed";
				}
				
		}		
				return_file = request.getContextPath()+"/jsp/Fees/UpdateTermFees.jsp";
	}
	else if(opmode.equals("trashtermfees"))
	{
		String	trashtermfeesid = request.getParameter("reqtermfeesid");
		
				termfeesBean.setTermfeesid(trashtermfeesid);
			termfeesBean.setTermfeesstatus("T");
				rows +=termfeesQuery.updateTermFeesStatus(termfeesBean);
		
				if(rows >0)
					message = "Successfully Term Fees Trashed";
				else
					message = "Term Fees Trash operation is failed";
				
				
				return_file = request.getContextPath()+"/jsp/Fees/UpdateTermFees.jsp";
	}
		
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+rows+"&returnurl="+return_file);

}catch(Exception e){e.printStackTrace();}
//out.println("message>>>>>>>>>>"+message);	
%>
<html>
<head>
<script language="javascript">
function fun1()
{
	 f1.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp"; 
	f1.submit();
}
</script>
</head>
<body onload=fun1()>
<form name=f1 method="post" action="">
<input type="hidden" name="standardscheduleid" value="<%=standardscheduleid%>"/>
		<input type="hidden" name="standardname" value="<%=standardname%>"/>   
    	<input type="hidden" name="yearofsessionid" value="<%=yearofsessionid%>"/>
    	<input type="hidden" name="yearofsessionname" value="<%=yearofsessionname%>"/> 
    	<input type="hidden" name="boardid" value="<%=boardid%>"/> 
    	<input type="hidden" name="boardname" value="<%=boardname%>"/>
    	<input type="hidden" name="message" value="<%=message%>"/>
    	<input type="hidden" name="result" value="<%=rows%>"/>
    	<input type="hidden" name="returnurl" value="<%=return_file%>"/>
    	
    	
    	
</form>
</body>
</html>

