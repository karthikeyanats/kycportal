<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.GradeSetting.GradeScaleQuery" />
<jsp:useBean id="scaleBean" scope="page"
	class="com.iGrandee.GradeSetting.ScaleBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.scaleentry.scaletrashlisttitle")%>  </title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<script language="JavaScript">
function goAction(obj,flage)
{
	document.MainForm.scaleid.value=obj.getAttribute("scaleid");
	if(flage=="Delete")
	{
		if(confirm("Do you want to Delete the Scale Name...?"))
		{
				document.MainForm.flage.value="Delete";
				document.MainForm.action= "ScaleStatusUpdate.jsp";
				document.MainForm.submit();
		}
	}
	else
	{
		if(confirm("Do you want to Restore the Scale Name...?"))
		{
				document.MainForm.flage.value="Restore";
				document.MainForm.action= "ScaleStatusUpdate.jsp";
				document.MainForm.submit();
		}
	}

}
function goBack()
{
		document.MainForm.action= "ScaleView.jsp";
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
         <h2><%=bundle.getString("label.scaleentry.trashviewrootpath")%></h2>
     
<%@ page import="java.util.*"%>

<%
String instituteid=session.getValue("instituteid")+"";
ArrayList sacleList=new ArrayList();
sacleList=query_object.getScaleList(instituteid,"T");
 
%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="scaleid" value="">
<input type="hidden" name="flage" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.scaleentry.slno")%></th>
        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.scaleentry.scalename")%> </th>
  	        <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.scaleentry.dateofcreation")%> </th>
  	        <th scope="col" class="rounded" width="8%"><%=bundle.getString("label.scaleentry.delete")%> </th>
  	        <th scope="col" class="rounded-q4" width="8%"><%=bundle.getString("label.scaleentry.restore")%> </th>
        	
            
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
				HashMap sacleListMap=new HashMap();
				if(sacleList!=null && sacleList.size()>0)
				{
					for(int i=0;i<sacleList.size();i++)
					{
						sacleListMap=(HashMap)sacleList.get(i);
						out.print("<tr valign='top'>");
						out.print("<td class='tablelight' width='5%'>"+(i+1)+"</td>");
						out.print("<td class='tablelight' width='40%' >"+sacleListMap.get("scalename")+"</td>");
						out.print("<td class='tablelight' width='%'>"+sacleListMap.get("newdates")+"</td>");
						out.print("<td class='tablelight' width='8%'><a href='#' scaleid='"+sacleListMap.get("scaleid")+"' onclick=goAction(this,'Delete')><img src='"+as+"/jsp/kycpanel/images/user_logout.png' alt='' title='Delete' border=0 /></a></td>");
						out.print("<td class='tablelight' width='8%' ><a href='#' scaleid='"+sacleListMap.get("scaleid")+"' onclick=goAction(this,'Restore')><img src='"+as+"/jsp/kycpanel/images/16-undo1.png' alt='' title='Restore' border=0 /></a></td>");
						out.print("</tr>");
						
					}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.scaleentry.datanotfound")+"</font></td></tr>");

				}
				%>
			
			
		</table>
					<a href="#" onclick="goBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.scaleentry.back")%> </strong><span class="bt_blue_r"></span></a>
		
		    
		    
		    
		
	
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