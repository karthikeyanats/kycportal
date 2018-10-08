<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language='javascript'>

	function callStandards(obj){
	
		document.wprkallotment.examname.value	= obj.getAttribute("examname");
		document.wprkallotment.examnameid.value	= obj.getAttribute("examnameid"); 
		document.wprkallotment.action = "ReportStandard.jsp";
		document.wprkallotment.submit();
	}	
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>
	<%
		ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
	
	<%
	String sessioncategory = (String)session.getValue("usercategory");
	if(sessioncategory == "HM" || sessioncategory.equals("HM")){
	%>	
    <h2>Result Analysis</h2>
    <% 
	}
	else if(sessioncategory == "SA" || sessioncategory.equals("SA"))
	{
	%>	
	    <h2><%=bundle.getString("label.reports.reportsresultanalysis")%></h2> 
	<%
	}
    %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Report.Reports"%>
	
<%
	Reports reports 		= new Reports();
	String instituteid 		= (String)session.getValue("instituteid");
	String userid 			= (String)session.getValue("userid");
	HashMap	hashmap			= null;
	String sessionid		= (String)session.getValue("sessionid");
	String sessionname		= (String)session.getValue("sessionname");
	ArrayList examList		= reports.examDetails(sessionid);

%>
	<form name='wprkallotment' method='post'>

							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.schedule.academicyear")%></th>
		            <th scope="col" class="rounded-q4" width="1%"></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>							
					<table  border=0 bordercolor='blue' align="center" width="100%" cellspacing=5 cellpadding=0>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
								<%=sessionname %>
							</td>
						</tr>
					</table>
  						</td>
  					</tr>
  				</table>
  				<br>
			     				
				<table id="rounded-corner" border=0 summary="Department List" width="100%">
				    <thead>
				    	<tr>
				        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schedule.slno")%></th>
				            <th scope="col" class="rounded-q4" width="90%"><%=bundle.getString("label.schedule.examname")%></th>
				        </tr>
				    </thead>
							<%
								if(examList != null && examList.size()>0){
									for(int y=0;y<examList.size();y++){
										hashmap		= (HashMap)examList.get(y);
										out.print("<tr><td>"+(y+1)+".</td><td align='left'><a href='#cls' examnameid='"+hashmap.get("examnameid")+"' examname='"+hashmap.get("examname")+"' onclick='callStandards(this)'>"+hashmap.get("examname")+"</a></td></tr>");
									}
								}
								else{
									out.println("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
									//out.print("<tr><td colspan='2' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
								}

							%>											
				</table>
			     						
		
		<input type='hidden' name='examname' 		value=''>
		<input type='hidden' name='examnameid'		value=''>
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>