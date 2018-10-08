<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script language='javascript'>

	function callSection(obj){
	
		document.wprkallotment.sectionname.value	= obj.getAttribute("sectionname");
		document.wprkallotment.sectionid.value		= obj.getAttribute("sectionid"); 
		document.wprkallotment.action 				= "ReportSectionSubject.jsp";
		document.wprkallotment.submit();
	}	
	
	function goBack(){
	
		document.wprkallotment.action 				= "ReportStandard.jsp";
		document.wprkallotment.submit();
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
	<%
		ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    <div class="right_content">

    <h2><%=bundle.getString("label.reports.standardwisesectionreport")%></h2>

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
	String examnameid		= request.getParameter("examnameid");
	String examname			= request.getParameter("examname");
	String standardid		= request.getParameter("standardid");
	String standardname		= request.getParameter("standardname");
	ArrayList examList		= reports.sectionPassDetails(examnameid,standardid);

%>
	<form name='wprkallotment' method='post'>
							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
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
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.examname")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
								<%=examname %>
							</td>
						</tr>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.standardname")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
								<%=standardname %>
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
		        	<th scope="col" class="rounded-company" width="15%"><%=bundle.getString("label.schedule.slno")%></th>
		            <th scope="col" class="rounded" width="65%"><%=bundle.getString("label.schedule.section")%></th>
		            <th scope="col" class="rounded-q4" width="20%"><%=bundle.getString("label.schedule.pass")%></th>
		        </tr>
		    </thead>
					
		<%
			String sectionid1		= "";
			String sectionid		= "";
			int count				= 0;
			int totalsubject		= 0;
			int totalpassed			= 0;
			int totalstudents		= 0;
			float percent			= 0.0f;
			String totasubject		= "";
			String passedsubject	= "";

			
			if(examList != null && examList.size()>0){
				for(int y=0;y<examList.size();y++){
					hashmap			= (HashMap)examList.get(y);
					sectionid		= (String)hashmap.get("sectionscheduleid");
					
					if(sectionid1.equals("") || !sectionid.equals(sectionid1)){
						
						if(y >0){
							try{
								percent		= (totalpassed*100/totalstudents);
							}
							catch(Exception e){
								percent		= 0;
							}
							
							out.print("<td>"+percent+"%</td></tr>");

						}

						count++;
						out.print("<tr><td>"+count+".</td><td><a href='#cls' sectionid='"+sectionid+"' sectionname='"+hashmap.get("sectionname")+"' onclick='callSection(this)'>"+hashmap.get("sectionname")+"</a></td>");
						sectionid1	= sectionid;
						
						
						totalstudents	= 0;
						totalpassed		= 0;
						
						
					}
					
					totasubject		= (String)hashmap.get("totalsubject");	
					passedsubject	= (String)hashmap.get("passedsubject");
					
					if(totasubject == null || totasubject.equals("") || totasubject.equalsIgnoreCase("null"))
						totasubject	= "0";
					
					if(passedsubject == null || passedsubject.equals("") || passedsubject.equalsIgnoreCase("null"))
						passedsubject	= "0";

					
					totalstudents ++;
					
				
						
					if(Integer.parseInt(passedsubject) >= Integer.parseInt(totasubject))
						totalpassed ++;
						
						
					if(y == examList.size()-1){
						try{
							percent		= (totalpassed*100/totalstudents);
						}
						catch(Exception e){
							percent		= 0;
						}
						
						out.print("<td>"+percent+"%</td></tr>");
					}
				}
			}
			else{
				out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
				//out.print("<tr><td colspan='3' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
			}

		%>											
		</table>
		
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		
		
		<input type='hidden' name='examname' 		value='<%=examname %>'>
		<input type='hidden' name='examnameid'		value='<%=examnameid %>'>
		<input type='hidden' name='standardid'		value='<%=standardid %>'>
		<input type='hidden' name='standardname'	value='<%=standardname %>'>
		<input type='hidden' name='sectionid'		value=''>
		<input type='hidden' name='sectionname'		value=''>
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>