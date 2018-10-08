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
			 subjectList		= schedule.viewSections(standardscheduleid,instituteid);
			}
%>

<form name="Schedule_Form" action="" method="post">

		<table  border=0  width="640" align=center >
		<tr height=50px><td align=left>
		<table  border=0 width=98% class=tablebold cellpadding='0' cellspacing='0'>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
		<tr height=100px ><td>
								<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		</table>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center><%=bundle.getString("label.schedule.schedeledsection")%>
		</td></tr>
		<tr><td valign=top><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold' align='left'><%=bundle.getString("label.schedule.academicyear")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align=left>
							
							<%=request.getParameter("req_sessionname") %>
								
							</td>
							<td width='20%' class='tablebold' align='left'><%=bundle.getString("label.schedule.board")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align=left>
								<%=boardname %>
							</td>
						</tr>
						<tr>
						<td width='20%' class='tablebold' align='left'><%=bundle.getString("label.schedule.standardname")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'  align=left>
								<%=request.getParameter("req_standardname") %>
							</td>
							<td colspan=3></td>
						</tr>
						<%
							if(archival != null && archival.equals("R")){
						%>		
						<tr>
							<td width='20%' class='tablebold' ><%=bundle.getString("label.schedule.archivaldetails")%></td>
							<td width='1%' class='tablebold' >:</td>
							<td class='tablelight' width='79%' align=left colspan=4>
								<h2><%=bundle.getString("label.schedule.archivalmessage1")%></h2>
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
					        	<th width="7%"  align=left><%=bundle.getString("label.schedule.slno")%></th>
					            <th	width="40%"  align=left><%=bundle.getString("label.schedule.section")%></th>
					            <th	width="22%"  align=left><%=bundle.getString("label.schedule.desc")%></th>
					        </tr>
					    </thead>
						<%
					    try{
					    	if(subjectList != null && subjectList.size()>0){
					    		for(int y=0;y<subjectList.size();y++){
					    			hashmap		= (HashMap)subjectList.get(y);
					    			status		= (String)hashmap.get("status");
					    			
					    			out.print("<tr class='tablelight' ><td>"+(y+1)+".</td><td>"+hashmap.get("sectionname")+"</td><td>"+hashmap.get("description")+"</td>");
					    			datacount++;
					    		}
					    	}
					    	else{
					    		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
					    		//out.print("<tr><td colspan='5'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
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
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value='<%=bundle.getString("label.schedule.print")%>' >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value='<%=bundle.getString("label.schedule.close")%>'>
		
		</td></tr>
		</table>
		</form>		
</body>

</html>