

<jsp:useBean id="query_object" scope="page" class="com.iGrandee.MasterEntries.Standard.StandardQuery" />
<jsp:useBean id="allotmentbean" scope="page" class="com.iGrandee.Fees.Allotmentbean" />
<%
String message			= "";
int result = 0;
String return_file		=  "";
String standardscheduleid = request.getParameter("standardscheduleid");



String scholarshipid = request.getParameter("scholarship");
String userid = (String)session.getAttribute("userid");
if(request.getParameter("allocatestatus").equals("allocate"))
{String[] amount = request.getParameterValues("amount");

String[] termfeesid = request.getParameterValues("allocatechk"); 
	for(int i=0;i<amount.length;i++){
		out.println(amount[i]+"__"+termfeesid[i]);
	}
}
else if(request.getParameter("allocatestatus").equals("deallocate"))
{
	String[] deamount = request.getParameterValues("deamount");

	String[] determfeesid = request.getParameterValues("deallocatechk"); 
	for(int i=0;i<deamount.length;i++){
		out.println(deamount[i]+"__"+determfeesid[i]);
	}
}

%>