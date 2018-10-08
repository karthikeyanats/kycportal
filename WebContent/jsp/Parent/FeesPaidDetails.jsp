<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">

function loadStandard()
{
	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	
	document.standardForm.action="StandardList.jsp";
	document.standardForm.submit();
}
function goSubject(obj)
{

	document.standardForm.reqboardid.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].value;
	document.standardForm.reqboardname.value = document.standardForm.standardboard.options[document.standardForm.standardboard.options.selectedIndex].text;
	document.standardForm.reqstandardid.value = obj.getAttribute("standardid");
	document.standardForm.reqstandardname.value = obj.getAttribute("standardname");
	document.standardForm.reqgroupstatus.value = obj.getAttribute("groupstatus");
	document.standardForm.action="../Subject/SubjectCreation.jsp";
	document.standardForm.submit();
	

}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Fees / Fees Paid Details</h2>
    <form name="standardForm" action="" method="post">
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

     <%
     
     com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();      String instituteid = null;
     ArrayList studentfeescollectionList = null;
     String reqboardid = null;
     String studentallcationid = null;
     
     try
     {
    	 instituteid = (String)session.getValue("instituteid");
    	 studentallcationid = (String)session.getValue("studentid");
       	  //reqboardid = request.getParameter("reqboard");
    }catch(Exception e){}
    
    %>
    	<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="1%"></th>
					            <th scope="col" class="rounded" width="98%">Student Details</th>
					            <th scope="col" class="rounded-q4" width="1%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='3'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%'>Student Name</td><td width='1%'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td>Academic Year</td><td>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td>Standard Name</td><td>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td>Standard Name</td><td>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td>Section Name</td><td>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td>Board Name</td><td>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td>Medium Name</td><td>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("</table>");
								%>	
							</td>
						</tr>
					</table><br><br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10">Sl.No</th>
        	<th scope="col" class="rounded">Bank Name</th>
        	<th scope="col" class="rounded"> DD Number </th>
        	<th scope="col" class="rounded"> DD Date </th>
        	<th scope="col" class="rounded"> Amount (In Rs.)</th>
        	<th scope="col" class="rounded"> Payment Type</th>
        	<th scope="col" class="rounded-q4"> Paid Date and Time</th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   	    	<%
   	    	String temp_termid="";
      	  studentfeescollectionList = feesscheduleQuery.studentFeesCollectionDetails(studentallcationid,"parent");
	
			if(studentfeescollectionList!=null && studentfeescollectionList.size()>0)
	    	{ int inc = 1;
	    	for(int y=0;y<studentfeescollectionList.size();y++){
				
	    		HashMap studentfeescollectionListMap		= (HashMap)studentfeescollectionList.get(y);
				
	    		String feescollectionid     = (String)studentfeescollectionListMap.get("feescollectionid");
	    		String termfeesid      = (String)studentfeescollectionListMap.get("termfeesid");
	    		String termid      = (String)studentfeescollectionListMap.get("termid");
	    		String termname     = (String)studentfeescollectionListMap.get("termname");
	    		String bankname      = (String)studentfeescollectionListMap.get("bankname");
	    		String ddno     = (String)studentfeescollectionListMap.get("ddno");
	    		String dddate     = (String)studentfeescollectionListMap.get("dddate");
	    		String collectionamount      = (String)studentfeescollectionListMap.get("collectionamount");
	    		String scholarshipid      = (String)studentfeescollectionListMap.get("scholarshipid");
	    		String feescollectiondate      = (String)studentfeescollectionListMap.get("feescollectiondate");
	    		String feescollectionstatus      = (String)studentfeescollectionListMap.get("feescollectionstatus");
	    		String scholarshipname      = (String)studentfeescollectionListMap.get("scholarshipname");
	    	%>
		<tr>
		<%
		if(!temp_termid.equals(termid))
		{
		out.println("<tr><td colspan=7 class=tablebold>"+termname+"</td></tr>");
		temp_termid = termid;
		}
		%>
		<td><%=inc++ %></td>
		<td><%= bankname%></td>
		<td><%=ddno%></td>
		<td><%=dddate %></td>
		<td><%=collectionamount %></td>
		<td><%= scholarshipname%></td>
		<td><%= feescollectiondate%></td>
		
	    	</tr>
	    	<%
				} }else
		    	{
					out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
		    	//out.println("<tr><td colspan=5>Data not Found</td></tr>");
		    	}%>	 
		    	</tbody>
	     </table>
	 
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>

