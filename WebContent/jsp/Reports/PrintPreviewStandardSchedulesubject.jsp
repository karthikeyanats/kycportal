<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard Schedule Subject List | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<script type="text/javascript">
	function goBack()
	{
	window.close();
	}
	
	function printfun()
	{	
	document.getElementById("printbutt").style.visibility='hidden';
	document.getElementById("backbutt").style.visibility='hidden';
	window.print();
	alert("Successfully Printed");
	document.getElementById("printbutt").style.visibility='visible';
	document.getElementById("backbutt").style.visibility='visible';	
	}
	
</script>
</head>
<body>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Registration.InstitutionQurey,com.iGrandee.Schedule.Schedule,com.iGrandee.Common.DateTime"%>
<%
InstitutionQurey insquery=new InstitutionQurey();

		Schedule schedule			= new Schedule();
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList insdetails=insquery.getInstituteDetails(instituteid);
		HashMap	hashmap				= null;
		ArrayList standardList		= null;
		String groupstatus			= "";
		String standardid			= "";
		int count					= 0;
		int stotal					= 0;
		int tcount					= 0;
		int datacount				= 0;
		String sessionid			= request.getParameter("req_sessionid");
		String boardid				= request.getParameter("board");
		String boardname			= request.getParameter("boardname");
		String today				= DateTime.showTime("calendar");
		String archival				= request.getParameter("req_sessionstatus");
		String standardscheduleid	= request.getParameter("req_standardscheduleid");
		String status				= "";

		String tempstandardid		= "";
		ArrayList subjectList=null;
		if(standardscheduleid != null && boardname != null) {
			 subjectList		= schedule.viewSubjects(standardscheduleid);
			}
%>

<form name="Schedule_Form" action="" method="post">

		<table  border=0  width="640" align="center" >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>

		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr>
		<td width="35%" valign=top align="center" class=tablebold>Scheduled Subject</td>
		</tr>
		<tr><td valign=top><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold' align='left'>Academic Year</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align=left>
							
							<%=request.getParameter("req_sessionname") %>
								
							</td>
							<td width='20%' class='tablebold' align='left'>Board</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align=left>
								<%=boardname %>
							</td>
						</tr>
						<tr>
						<td width='20%' class='tablebold' align='left'>Standard</td>
							<td width='1%' class='tablebold' >:</td>
							<td class='tablelight'  align=left >
								<%=request.getParameter("req_standardname") %>
							</td>
							<td colspan=3> </td>
						</tr>
						<%
							if(archival != null && archival.equals("R")){
						%>		
						<tr>
							<td width='20%' class='tablebold' >Archival Details</td>
							<td width='1%' class='tablebold' >:</td>
							<td class='tablelight' width='79%' align=left colspan=4>
								<h2>This is an Archived Year</h2>
							</td>
						</tr>
						<%		
							}
						%>
					</table>					    	
		    	</td>
		    </tr>
		</table>

		<br>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='20%' >
					<table id="rounded-corner" border=1 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>   
					    <thead>
					    	<tr  class='tableheading'>
					        	<th width="7%"  align=left>SL No.</th>
					            <th	width="40%"  align=left>Subject Name</th>
					            <th	width="22%"  align=left>Subject Code</th>
					        </tr>
					    </thead>
						<%
					    try{
					    	
					    	if(subjectList != null && subjectList.size()>0){
					    		int count1 = 1;
					    		
					    		for(int y=0;y<subjectList.size();y++){
					    			
					    			hashmap		= (HashMap)subjectList.get(y);
					    			status		= (String)hashmap.get("status");
					    			if(status.equals("Yes")){
						    			out.print("<tr  class='tablelight'><td  >"+(count1++)+".</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("subjectcode")+"</td>");
						    			datacount++;
									}
									
					    		}
								if(datacount==0){
									out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
									//out.print("<tr><td colspan='3' class='tablelight'align='center'>Data Not Found</td></tr>");
								}
   		
					    	}
					    	else{
								out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
				    			//out.print("<tr><td colspan='3' class='tablelight' align='center'>Data Not Found</td></tr>");
					    	}
					    }
					    catch(Exception e){
					    	
					    }
					    %>
					        
					</table>
				</td></tr>
					
		</table>
		</td></tr>
		<tr align=center><td>&nbsp;
		</td></tr>
		<tr align=center><td>
		<% 
		//out.print("datacount-->"+datacount);
		if(datacount>0){
		%>	
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
		
		</td></tr>
		</table>
		</form>		
</body>

</html>