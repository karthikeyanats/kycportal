<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Exam Name List | Powered by i-Grandee</title>
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
	document.getElementById("printbutt").style.visibility='visible';
	document.getElementById("backbutt").style.visibility='visible';	
	}
	
</script>
</head>
<body>
	<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.InstitutionQurey,com.iGrandee.Exam.ExamnameEntry"%>
<%
	String instituteid		= (String)session.getValue("instituteid");
	InstitutionQurey insquery=new InstitutionQurey();
	ArrayList insdetails=insquery.getInstituteDetails(instituteid);
	int datacount=0;
	%>
<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 align=center>
		<tr height=50px><td align=left>
				<%@ include file="../include/reportprintheader.jsp"%>
		
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td class='tablebold' width="35%" valign=top align=center><%=bundle1.getString("label.schedule.examnamelist")%>
		</td></tr>
		<tr><td valign=top>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td  class='tablebold' align='left'><%=bundle1.getString("label.schedule.academicyear")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'  width='60%' align=left>
							
							<%=request.getParameter("req_sessionname") %>
								
							</td>
							
						</tr>
					<%if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
											{
											%>
											
											<tr class='tablebold' height='23'>
													<td  class='tablebold'   ><%=bundle1.getString("label.schedule.archivaldetails")%></td>
													<td  class='tablebold' width='1'  >:</td>
													<td  class='tablelight'  align=left><h2><%=bundle1.getString("label.schedule.archivalmessage1")%></h2></td>
											</tr>
											<%
											} 
											%>		
					</table>					    	
		    	</td>
		    </tr>
		</table>

		<table width='100%' align='center' border='0' >
			<tr>
				<td width='20%' >
					<table id="rounded-corner" border=1 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>   
					    <thead>
					    	<tr  class='tableheading'>
		        	        	<th align=left width="10%"><%=bundle1.getString("label.schedule.slno")%></th>
					            <th width="30%" align=left ><%=bundle1.getString("label.schedule.examname")%></th>
					            <th width="35%" align=left ><%=bundle1.getString("label.schedule.examremarks")%></th>
					            <th width="35%" align=left ><%=bundle1.getString("label.schedule.dateofcreation")%></th>
					        </tr>
					    </thead>
						<%
     com.iGrandee.Exam.ExamnameEntry  examnameEntry = new com.iGrandee.Exam.ExamnameEntry();
     ArrayList LoadExamnameList = null;
     try
     {
    	  //LoadExamnameList=examnameEntry.listExamname(instituteid);
    	  LoadExamnameList=examnameEntry.LoadExamnameList(request.getParameter("req_sessionid"));
    	  
    	

    	ArrayList archivalDetails = new ArrayList();
    	 if(LoadExamnameList!=null && LoadExamnameList.size()>0)
			{
    		 for (int i = 0, j = 1; i < LoadExamnameList.size(); i++) {
			
				HashMap ExamnameListMap=(HashMap)LoadExamnameList.get(i);
				datacount++;
				String examnameid       	= (String)ExamnameListMap.get("examnameid");
				String examname 		  	= (String)ExamnameListMap.get("examname");
				String examnameremarks  	= (String)ExamnameListMap.get("remarks");
				String dateofcreation      	= (String)ExamnameListMap.get("dateofcreation");
				String createdby      		= (String)ExamnameListMap.get("createdby");
				if(!archivalDetails.contains(examnameid))
				{
				%>
				
				<tr  class='tablelight' >
        	 <td valign=top><%=j++ %></td>
            <td valign=top><%=examname %></td>
            <td valign=top><%=examnameremarks %></td>
            <td valign=top><%=dateofcreation %></td>
                    
        </tr>
				<%
				archivalDetails.add(examnameid);
    		 }
    		 }
			}
    	 	else{
     			//out.println("<tr><td colspan=9 align=center>Data not found</td></tr>");
    	 		out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>"+bundle1.getString("label.schedule.datanotfound")+"</font></td></tr>");
    	 	}
     }catch(Exception e){}
          
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
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value='<%=bundle1.getString("label.schedule.print")%>' >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value='<%=bundle1.getString("label.schedule.close")%>' >
		
		</td></tr>
		</table>
		</form>		
</body>

</html>