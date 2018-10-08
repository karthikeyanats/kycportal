<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.topperweaker.totalrangeheader")%> | Powered by i-Grandee</title>
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
	document.Topper_Form.action="TotalMarkRangeStudentListSearch.jsp";
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
    <h2><%=bundle.getString("label.topperweaker.totalrangerootpathview")%></h2>

		<form name="Topper_Form" action="" method="post">
		
		    
       
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Prinicipal.PrinicipalQuery,com.iGrandee.Common.DateTime"%>
<%
PrinicipalQuery  examQuery 	= new PrinicipalQuery();

ArrayList studentList=null;
String req_sessionname="";
String req_sessionid="";

String req_sessionvalue="";
String req_boardname="";
String req_examname="";
String req_examvalue="";
String req_coursename="";
String req_coursevalue="";
String subjectname="";
String req_subjectvalue="";
String req_students="";
req_sessionname=session.getValue("sessionname")+"";
req_sessionid=session.getValue("sessionid")+"";

req_boardname=request.getParameter("req_boardname");
req_examname=request.getParameter("req_examname");
req_examvalue=request.getParameter("req_examvalue");
req_coursename=request.getParameter("req_coursename");
req_coursevalue=request.getParameter("req_coursevalue");
subjectname=request.getParameter("subjectname")+"";
String subjectid=request.getParameter("subject")+"";

String[] fromrange 				= request.getParameterValues("fromrange");
String[] torange 				= request.getParameterValues("torange");

%>
	
<table id="rounded-corner" border=0 width="100%">
		    	<thead>
		    		<tr>
		        		<th scope="col" class="rounded-company" width="10"></th>
		            	<th scope="col" class="rounded" width="100%" colspan=6><%=bundle.getString("label.topperweaker.selectinfo")%></th>
		            	<th scope="col" class="rounded-q4" width="10"></th>        
		        	</tr>
		    	</thead>
		    	<tbody>
		    	<tr >
				<td></td><td class=tablebold width='15%'><%=bundle.getString("label.topperweaker.AcademicYear")%></td>
				<td width=1px class=tablebold>:</td><td>
						<%=req_sessionname%>
				</td>
			

				<td class=tablebold width='10%'><%=bundle.getString("label.topperweaker.Board")%> </td>
				<td width=1px class=tablebold>:</td><td>
					<%=req_boardname%>
				</td><td></td>
			</tr>
			<tr>
				<td></td><td class=tablebold><%=bundle.getString("label.topperweaker.ExamName")%>  </td>
				<td width=1px class=tablebold>:</td><td >
					<%=req_examname%>
				</td>
				<td class=tablebold><%=bundle.getString("label.topperweaker.Standard")%> </td>
				<td width=1px class=tablebold>:</td><td >
					<%=req_coursename%>
				</td><td></td>
			</tr>
			</tbody>
		<tfoot>
	    	<tr>
	        	<td colspan="7" class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       	</tr>
    	</tfoot> 
		</table>
 		
    	
	<br>
	
	
	<tbody>
	<tr>
				<td>
					<table id="rounded-corner1" border=0  cellspacing=2 cellpadding=5  width="100%">
			    		<thead>
			    	    <tr class=tableheading  > 
			             <th scope="col" class="rounded"   colspan=<%=fromrange.length %>><%=bundle.getString("label.gradesystem.range")%> </th>
			             <th scope="col" class="rounded"  rowspan=2><%=bundle.getString("label.topperweaker.Total")%></th>
						<tr class=tableheading  >
						<%
							if(fromrange!=null && fromrange.length>0 && torange!=null && torange.length>0)
								{
									for(int i=0;i<fromrange.length;i++)
									{
										 out.println("<th>"+fromrange[i]+" to "+torange[i]+"</th>");
									}
								}
						%>	
						 
			      		 </tr>     
					    </thead>
			      	<tfoot>
				    	<tr>
				        	<td colspan="<%=(fromrange.length) %>" class="rounded-foot-left"><em></em></td>
				        	<td class="rounded-foot-right">&nbsp;</td>
				       	</tr>
			    	</tfoot> 
					    <tbody>
					    
	<%

			int studcount=0;

  			if(fromrange!=null && fromrange.length>0 && torange!=null && torange.length>0)
			{
				for(int i=0;i<fromrange.length;i++)
				{
					    HashMap studentMap=new HashMap();    
					    String count			= examQuery.LoadStudentRangeWise(req_examvalue,req_coursevalue,fromrange[i],torange[i],req_sessionid);
				    	if(count!=null && Integer.parseInt(count)>0)
				    	{
				    		out.println("<td  class=tablelight align=center>");
				    		%>
				    		[ <a href="./RangeWiseStudentList.jsp?examid=<%=req_examvalue %>&standardscheduleid=<%=req_coursevalue %>&torange=<%=torange[i]%>&fromrange=<%=fromrange[i]%>&standardname=<%=req_coursename %>&boardname=<%=req_boardname %>&sessioname=<%=req_sessionname %>&examname=<%=req_examname%>" onclick="return hs.htmlExpand(this, { objectType: 'iframe',headingText: 'Student List', maincontentId: 'credits', align: 'center', width: 800, height: 600 } )">
							<%=count %></a> ]
				    		<%
				    		studcount +=Integer.parseInt(count);
				    		out.println("</td>");
						}
				    	else
				    	{
				    		out.println("<td  class=tablelight align=center>0</td>");
				    	}
		
					}
				}
   			  out.println("<td  class=tablelight align=center>"+studcount+"</td>");
    		  out.println("</tr>");		
			
		%>
			</tbody>
								</table>
							</td>
						</tr>
			</tbody>
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