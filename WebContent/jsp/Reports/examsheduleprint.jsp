<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.exam.examscheduletitle")%> | Powered by i-Grandee</title>
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Registration.InstitutionQurey,com.iGrandee.Prinicipal.PrinicipalQuery"%>
<%
	String instituteid		= (String)session.getValue("instituteid");
	InstitutionQurey insquery=new InstitutionQurey();
	ArrayList insdetails=insquery.getInstituteDetails(instituteid);
	int datacount=0;
	%>
<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 align=center>
		<tr height=50px><td align=center>
		<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center>Exam Allotment List
		</td></tr>
		<tr><td valign=top>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold' align='left'>Academic Year</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'  width='79%' align=left>
							
							<%=request.getParameter("req_sessionname") %>
								
							</td>
							
						</tr>
					<%if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
											{
											%>
											
											<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%' valign=top  align='left'>Archival Details</td>
													<td  class='tablebold' width='1' valign=top >:</td>
													<td valign=top class='tablelight'  width='20%' align=left><h2>This is an Archived Year</h2></td>
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
					
						<%
						PrinicipalQuery  Prinicipal = new PrinicipalQuery();
						com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
						
     ArrayList subjectList = null;
	  //subjectList=Prinicipal.LoadExamSubjectListforsession(request.getParameter("req_sessionid"));
	  subjectList=Prinicipal.LoadExamSubjectListforboard(request.getParameter("req_examnameid"),request.getParameter("req_sessionid"));
	  //out.print(subjectList);
	  //int duration=0;
		String duration = null;
		String examtype = null;
		  if(subjectList!=null && subjectList.size()>0)
			{ 
			 
			  ArrayList examlist =new ArrayList();
			  ArrayList examlist1 =new ArrayList();

			String standardscheduleid="";
			String boardmediumid="";
			
		 	for (int i2 = 0; i2 < subjectList.size(); i2++)
		 	{
				HashMap subjectListMap2=(HashMap)subjectList.get(i2);

				//String examname      = (String)subjectListMap2.get("examname");
				String examname      = request.getParameter("req_examname");
				//String examnameid      = (String)subjectListMap2.get("examnameid");
				String examnameid      = request.getParameter("req_examnameid");
				
				 if(!examlist.contains(examnameid))
				 	{
					 int inc = 1;
			 			out.println("<table>");
			 			out.println("<tr>");
				 		out.println("<td class=tablebold> <font color=red size=3px>"+examname+"</font</td>");
				 		out.println("</tr>");
			 			out.println("</table>");
			 			out.println("<br>");
				 		%>
				 		<table border=1 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>   
								    <thead>
								    	<tr  class='tablebold'>
					        	        	<th align=left width="10%"><%=bundle.getString("label.exam.SL.No")%></th>
								            <th  align=left  		width="30%"><%=bundle.getString("label.exam.SubjectName")%></th>
								            <th  align=left  		width="17%"><%=bundle.getString("label.exam.ExamDate")%></th>
								            <th  align=left 		width="11%"><%=bundle.getString("label.exam.StartTime")%></th>
								            <th  align=left 		width="10%"><%=bundle.getString("label.exam.EndTime")%></th>
								            <th align=left 	width="9%"><%=bundle.getString("label.exam.Duration")%></th>
								            <th align=left 	width="9%"><%=bundle.getString("label.examdetails.examtype")%></th>
								        </tr>
								    </thead>
								    <tbody>
				 		<%
			 			for (int i1 = 0; i1 < subjectList.size(); i1++)
						 	{
							HashMap subjectListMap1=(HashMap)subjectList.get(i1);

		 					//String examnameid1      = (String)subjectListMap1.get("examnameid");
		 					String examnameid1      = request.getParameter("req_examnameid");
				 				if(examnameid.equals(examnameid1))
							 	{
					 				datacount++;
									HashMap subjectListMap=(HashMap)subjectList.get(i1);
									String groupname      = (String)subjectListMap.get("groupname")+"";
									String standardname      = (String)subjectListMap.get("standardname");
									if(!groupname.equals("null"))
									{
									standardname=standardname+"  -"+groupname;
									}
									String subjectname      = (String)subjectListMap.get("subjectname");
									String standardid      = (String)subjectListMap.get("standardscheduleid");
									String boardid      = (String)subjectListMap.get("boardid");
									String examdate      = (String)subjectListMap.get("examdate");
									String examtimein      = (String)subjectListMap.get("examtimein");
									//char timein[] =examtimein.toCharArray();
									//examtimein=timein[0]+""+timein[1]+":"+timein[2]+""+timein[3];
									String examtimeout      = (String)subjectListMap.get("examtimeout");
									String examtimeinampm      = (String)subjectListMap.get("examtimeinampm");
									String examtimeoutampm      = (String)subjectListMap.get("examtimeoutampm");
									 duration      = (String)subjectListMap.get("duration");
									 examtype      = (String)subjectListMap.get("examtype");
									 
									//char timeout[] =examtimeout.toCharArray();
									//examtimeout=timeout[0]+""+timeout[1]+":"+timeout[2]+""+timeout[3];
						
									if(examdate == null){
										examdate= " ";}
									if(examtimein == null){
										examtimein= " ";}
									if(examtimeout == null){
										examtimeout= " ";}
									
									//if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
										//duration = examQuery.getHourMin(examtimein,examtimeout);
									
									//if(subjectListMap.get("examtimein") != null && subjectListMap.get("examtimeout")!=null)
									//duration = Integer.parseInt((String)subjectListMap.get("examtimeout"))-Integer.parseInt((String)subjectListMap.get("examtimein"));
							 		//out.println("duration>>>"+duration);
							 		
									if(!boardmediumid.equals(boardid))
									{
							 			out.println("<tr>");
								 		out.println("<td colspan=7 class='tableheading'>( "+(String)subjectListMap.get("boardmedium")+" )</td>");
								 		out.println("</tr>");
								 		boardmediumid=boardid;
									}
									
							 		if(!standardscheduleid.equals(standardid))
									{
							 			out.println("<tr>");
								 		out.println("<td colspan=7 class='tableheading'>"+standardname+"</td>");
								 		out.println("</tr>");
								 		standardscheduleid=standardid;
									}
									//char durationar [] =(duration+"").toCharArray();
									//String durationstring="";
									//if(duration<1000)
									//durationstring=durationar[0]+":"+durationar[1]+durationar[2];
									//else
										//durationstring=durationar[0]+durationar[1]+":"+durationar[2]+durationar[3];
						
							 		out.println("<tr class='tablelight' >");
							 		out.println("<td >"+inc+"</td>");
							 		out.println("<td>"+subjectname+"</td>");
							 		out.println("<td>"+examdate+"</td>");
							 		out.println("<td>"+examtimeinampm+"</td>");
							 		out.println("<td>"+examtimeoutampm+"</td>");
							 		out.println("<td>"+duration+"</td>");
							 		out.println("<td>"+examtype+"</td>");
							 		
							 		out.println("</tr>");
							 		inc++;
							 	}
					 		}
				 		examlist.add(examnameid);
				 	}
			 		out.println("</tbody>");
			 		out.println("</table>");
				}
		 		out.println("</td></tr>");
				}
				  else
					  {
						out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
				   		//out.println("<tr><td colspan=6 align=center>Data not found</td></tr>");
				 		out.println("</table>");
				   	  }
				%>
				<table width=100%>
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