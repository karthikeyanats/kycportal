<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.GradeSetting.GradeScaleQuery" />
<jsp:useBean id="gradeBean" scope="page"
	class="com.iGrandee.GradeSetting.GradeBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.gradeentry.gradetrashlisttitle")%>  </title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<script language="JavaScript">
function goAction(obj,flage)
{
	document.MainForm.gradeid.value=obj.getAttribute("gradeid");
	if(flage=="Delete")
	{
		if(confirm("Do you want to Delete the Grade Name...?"))
		{
				document.MainForm.flage.value="Delete";
				document.MainForm.action= "GradeStatusUpdate.jsp";
				document.MainForm.submit();
		}
	}
	else
	{
		if(confirm("Do you want to Restore the Grade Name...?"))
		{
				document.MainForm.flage.value="Restore";
				document.MainForm.action= "GradeStatusUpdate.jsp";
				document.MainForm.submit();
		}
	}

}
function goBack()
{
		document.MainForm.action= "GradeView.jsp";
		document.MainForm.submit();
}

</script>
</head>

<body>
<form name="MainForm" method="post" action="">

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
         <h2><%=bundle.getString("label.gradeentry.trashviewrootpath")%></h2>
     
<%@ page import="java.util.*"%>

<%
String instituteid=session.getValue("instituteid")+"";
ArrayList gradeList=new ArrayList();
gradeList=query_object.getGradeList(instituteid,"T");
 
%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="gradeid" value="">
<input type="hidden" name="flage" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.gradeentry.slno")%></th>
        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.gradeentry.gradename")%> </th>
  	        <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.gradeentry.dateofcreation")%> </th>
  	        <th scope="col" class="rounded" width="8%"><%=bundle.getString("label.gradeentry.delete")%> </th>
  	        <th scope="col" class="rounded-q4" width="8%"><%=bundle.getString("label.gradeentry.restore")%> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
		
				<% 
				String as=request.getContextPath();	
				HashMap gradeListMap=new HashMap();
				if(gradeList!=null && gradeList.size()>0)
				{
					for(int i=0;i<gradeList.size();i++)
					{
						gradeListMap=(HashMap)gradeList.get(i);
						out.print("<tr valign='top'>");
						out.print("<td class='tablelight' width='5%'>"+(i+1)+"</td>");
						out.print("<td class='tablelight' width='40%' >"+gradeListMap.get("gradename")+"</td>");
						out.print("<td class='tablelight' width='%'>"+gradeListMap.get("newdates")+"</td>");
						out.print("<td class='tablelight' width='8%'><a href='#' gradeid='"+gradeListMap.get("gradeid")+"' onclick=goAction(this,'Delete')><img src='"+as+"/jsp/kycpanel/images/user_logout.png' alt='' title='Delete' border=0 /></a></td>");
						out.print("<td class='tablelight' width='8%' ><a href='#' gradeid='"+gradeListMap.get("gradeid")+"' onclick=goAction(this,'Restore')><img src='"+as+"/jsp/kycpanel/images/16-undo1.png' alt='' title='Restore' border=0 /></a></td>");
						out.print("</tr>");
						
					}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.gradeentry.datanotfound")+"</font></td></tr>");

				}
				%>
			
			
		</table>
					<a href="#" onclick="goBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradeentry.back")%> </strong><span class="bt_blue_r"></span></a>
		
		    
		    
		    
		
	
	<tr><td>
		
			
</td></tr>	

</TABLE>
 </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>