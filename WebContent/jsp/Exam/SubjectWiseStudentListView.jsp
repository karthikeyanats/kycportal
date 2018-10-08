<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.topperweaker.rangeheader")%> | Powered by i-Grandee</title>
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>        

<script type="text/javascript">
	
function goBack()
{
	document.Topper_Form.action="SubjectWiseStudentListSearch.jsp";
	document.Topper_Form.submit();
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
<% if(loginusercategory.equals("SA"))
	{%>
    <h2><%=bundle.getString("label.topperweaker.rangerootpathview")%></h2>
    <% }
    else
    {%>
    <h2><%=bundle.getString("label.topperweaker.rangeprincirootpathview")%></h2>
    <%} %>
		<form name="Topper_Form" action="" method="post">
		
		    <table id="rounded-corner" border=0 summary="Department List" width="100%">
		    	<thead>
		    		<tr>
		            	<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.topperweaker.selectinfo")%></th>
		            	<th scope="col" class="rounded-q4" width="10"></th>        
		        	</tr>
		    	</thead>
       
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>
<%
ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();

ArrayList studentList=null;
String req_sessionname="";
String req_sessionvalue="";
String req_boardname="";
String req_boardvalue="";
String req_examname="";
String req_examvalue="";
String req_coursename="";
String req_coursevalue="";
String subjectname="";
String req_subjectvalue="";
String req_students="";
req_sessionname=request.getParameter("req_sessionname");
req_sessionvalue=request.getParameter("req_sessionvalue");
req_boardname=request.getParameter("req_boardname");
req_boardvalue=request.getParameter("req_boardvalue");
req_examname=request.getParameter("req_examname");
req_examvalue=request.getParameter("req_examvalue");
req_coursename=request.getParameter("req_coursename");
req_coursevalue=request.getParameter("req_coursevalue");
subjectname=request.getParameter("subjectname")+"";
String subjectid=request.getParameter("subject")+"";

String[] fromrange 				= request.getParameterValues("fromrange");
String[] torange 				= request.getParameterValues("torange");

%>
		<table width='100%' align='center' id="rounded-corner" border='0' cellpadding='5' cellspacing='0' >
			<tr >
				<td class=tablebold width='15%'><%=bundle.getString("label.topperweaker.AcademicYear")%></td>
				<td class=tablebold width="2%">:</td>
				<td>
						<%=req_sessionname%>
				</td>
			

				<td class=tablebold width='10%'><%=bundle.getString("label.topperweaker.Board")%> </td>
				<td class=tablebold width="2%">:</td>
				<td>
					<%=req_boardname%>
				</td>
			</tr>
			<tr>
				<td class=tablebold><%=bundle.getString("label.topperweaker.ExamName")%> </td>
				<td class=tablebold width="2%">:</td>
				<td>
					<%=req_examname%>
				</td>
		
				<td class=tablebold><%=bundle.getString("label.topperweaker.Standard")%> </td>
				<td class=tablebold width="2%">:</td>
				<td>
				<%=req_coursename%>
				</td>
			</tr>
			<tr>
				<td class=tablebold><%=bundle.getString("label.topperweaker.subject")%> </td>
				<td class=tablebold width="2%">:</td>
				<td colspan=4>
					<%=subjectname%>
				</td>
			</tr>
			
					<tfoot>
	    	<tr>
	        	<td colspan="5" class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       	</tr>
    	</tfoot> 
		</table>
 		
    	
	<br>
	
	
	<tbody>
	<tr>
				<td>
					<table id="rounded-corner" border=0  cellspacing=0 cellpadding=5  width="100%">
			    		<thead>
			    	    <tr class=tableheading  > 
			        	<th scope="col" class="rounded-company" width="1" ></th>
			             <th scope="col" class="rounded"  width="10%" ><%=bundle.getString("label.topperweaker.slno")%></th> 
			             <th scope="col" class="rounded"   width="40%" ><%=bundle.getString("label.topperweaker.StudentName")%></th>  
			             <th scope="col" class="rounded"   width="20%" ><%=bundle.getString("label.topperweaker.rollno")%></th>  
			             <th scope="col" class="rounded"   width="15%" ><%=bundle.getString("label.topperweaker.section")%></th>  
			             <th scope="col" class="rounded"   width="15%" ><%=bundle.getString("label.topperweaker.mark")%></th>  
			             <th scope="col" class="rounded-q4"  width="1" ></th>  
			      		 </tr>     
					    </thead>
			      	<tfoot>
				    	<tr>
				        	<td colspan="6" class="rounded-foot-left"><em></em></td>
				        	<td class="rounded-foot-right">&nbsp;</td>
				       	</tr>
			    	</tfoot> 
					    <tbody>
	<%if(fromrange!=null && fromrange.length>0 && torange!=null && torange.length>0)
	{
		for(int i=0;i<fromrange.length;i++)
		{
				%>	
				
						    
								    <%
								    HashMap studentMap=new HashMap();  
							    	studentList			= examQuery.subjectWiseStudentList(req_coursevalue,req_examvalue,subjectid,fromrange[i],torange[i]);
							    	if(studentList!=null && studentList.size()>0)
							    	{
							    		String temp="";
							    		for(int x=0;x<studentList.size();x++)
							    		{
							    			studentMap=(HashMap)studentList.get(x);
							    			String range=studentMap.get("markrange")+"";
							    			if(!temp.equals(range))
							    			{
								    			out.println("<tr>");
								    			out.println("<td colspan=7 class=tablebold> Mark Range :<font color=red>");
								    			out.println(range);
								    			out.println("</font></td>");
								    			out.println("</tr>");
								    			temp=range;
							    			}
							    			out.println("<tr>");
							    			out.println("<td>");
							    			out.println("</td>");
											out.println("<td>");
							    			out.println((x+1));
							    			out.println("</td>");
							    			out.println("<td>");
							    			out.println(studentMap.get("studentname")+"");
							    			out.println("</td>");
							    			out.println("<td>");
							    			out.println(studentMap.get("rollno")+"");
							    			out.println("</td>");
							    			out.println("<td>");
							    			out.println(studentMap.get("sectionname")+"");
							    			out.println("</td>");
							    			out.println("<td>");
							    			out.println(studentMap.get("marktaken")+"");
							    			out.println("</td>");
							    			out.println("<td>");
							    			out.println("</td>");
							    			out.println("</tr>");
							    		}
							    	}
							    	else
							    	{
							    		out.println("<tr>");
						    			out.println("<td colspan=7 class=tablebold> Mark Range :<font color=red>");
						    			out.println(fromrange[i]+" to "+torange[i]);
						    			out.println("</font></td>");
						    			out.println("</tr>");
						    			out.println("<tr>");
						    			out.println("<td colspan=7 class=tablebold align=center>Student Not Found Under This Range</td>");
						    			out.println("</tr>");
							    	}
	
								    %>
								    
			<%}}%>
			</tbody>
								</table>
							</td>
						</tr>
			</tbody>
			
		</table>   
	</table>
	<br><br>
		
			<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.topperweaker.back")%> </strong><span class="bt_blue_r"></span></a>
	
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>