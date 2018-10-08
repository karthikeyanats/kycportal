<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

</head>
<body style="background:none;">
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime,java.util.ArrayList,java.util.HashMap"%>

<%
PrinicipalQuery  examQuery 	= new PrinicipalQuery();
String examid=request.getParameter("examid");
String standardscheduleid=request.getParameter("standardscheduleid");
String fromrange=request.getParameter("fromrange");
String torange=request.getParameter("torange");
String examname=request.getParameter("examname");
String standardname=request.getParameter("standardname");
String boardname=request.getParameter("boardname");
String sessioname=request.getParameter("sessioname");
ArrayList studentlist	= examQuery.LoadStudentListforRangeWise(examid,standardscheduleid,fromrange,torange,session.getValue("sessionid")+"");
//out.println(studentlist); 
%>
<table width='800px' align='center' id="rounded-corner_home" border='0' cellpadding='5' cellspacing='0' >
			<thead>
			    	    <tr > 
				             <th scope="col" class="rounded-company"  width="1px"  ></th> 
				             <th scope="col" class="rounded" colspan=6 width=100% ><%=bundle.getString("label.topperweaker.selectinfo")%></th>
				             <th scope="col" class="rounded-q4"  width="1px"  ></th>   
						</tr>  
			</thead>
			<tfoot>
				    	<tr>
				        	<td colspan=7 class="rounded-foot-left"><em></em></td>
				        	<td class="rounded-foot-right">&nbsp;</td>
				       	</tr>
			</tfoot> 
			<tbody>
				<tr>
					<td></td>
					<td class=tablebold width='15%'><%=bundle.getString("label.topperweaker.AcademicYear")%></td>
					<td width=1px class=tablebold>:</td><td>
							<%=sessioname%>
					</td>
					<td class=tablebold width='10%'><%=bundle.getString("label.topperweaker.Board")%> </td>
					<td width=1px class=tablebold>:</td><td>
						<%=boardname%>
					</td>
					<td></td>
					
				</tr>
				<tr>
					<td></td>
					<td class=tablebold><%=bundle.getString("label.topperweaker.ExamName")%> </td>
					<td width=1px class=tablebold>:</td><td >
						<%=examname%>
					</td>
					<td class=tablebold><%=bundle.getString("label.topperweaker.Standard")%> </td>
					<td width=1px class=tablebold>:</td><td >
						<%=standardname%>
					</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td class=tablebold><%=bundle.getString("label.gradesystem.range")%>  </td>
					<td width=1px class=tablebold>:</td><td colspan=4>
						<%=fromrange+" to "+torange%>
					</td>
					
					<td></td>
				</tr>
			</tbody>
		</table>
		<br>
		<table width='800px' align='center' id="rounded-corner_home" border='0' cellpadding='5' cellspacing='0' >
			<thead>
			    	    <tr > 
				             <th scope="col" class="rounded-company"  width="1px"  ></th>
	              
				             <th scope="col" class="rounded"  width=10px><%=bundle.getString("label.topperweaker.slno")%></th>
   				             <th scope="col" class="rounded"  width="40%"><%=bundle.getString("label.topperweaker.StudentName")%></th>
   				             <th scope="col" class="rounded" width="10%" ><%=bundle.getString("label.topperweaker.rollnosrt")%></th>
   				             <th scope="col" class="rounded"  width="20%"><%=bundle.getString("label.topperweaker.section")%></th>
   				             <th scope="col" class="rounded" width="20%" ><%=bundle.getString("label.topperweaker.TotalMarks")%></th>
				             <th scope="col" class="rounded-q4"  width="1px"  ></th>   
						</tr>  
			</thead>
			<tfoot>
				    	<tr>
				        	<td colspan=6 class="rounded-foot-left"><em></em></td>
				        	<td class="rounded-foot-right">&nbsp;</td>
				       	</tr>
			</tfoot> 
			<tbody>
			<%
			if(studentlist!=null && studentlist.size()>0)
				{
					for(int i=0;i<studentlist.size();i++)
					{
						HashMap innermap=(HashMap)studentlist.get(i);
						out.println("<tr>");
						out.println("<td></td>");
						String rollno=innermap.get("rollno")+"";
						if(rollno.equals("null") || rollno.equals(""))
							rollno="-";
						out.println("<td class=tablelight>"+(i+1)+"</td>");
						out.println("<td class=tablelight>"+innermap.get("uname")+"</td>");
						out.println("<td class=tablelight>"+rollno+"</td>");
						out.println("<td class=tablelight>"+innermap.get("sectionname")+"</td>");
						out.println("<td class=tablelight>"+innermap.get("total")+"</td>");
						out.println("<td></td>");

						out.println("</tr>");
					}
				}
			%>
			</tbody>
		</table>
</body>
</html>