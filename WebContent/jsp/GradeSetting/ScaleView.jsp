<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.GradeSetting.GradeScaleQuery" />
<jsp:useBean id="gradeBean" scope="page"
	class="com.iGrandee.GradeSetting.ScaleBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.scaleentry.scalelisttitle")%>  </title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="JavaScript">
function goAction(obj,flage)
{
	document.MainForm.scaleid.value=obj.getAttribute("scaleid");
	if(flage=="Edit")
	{
		if(confirm("Do you want to Update the Scale Name...?"))
		{
			document.MainForm.action= "ScaleUpdate.jsp";
			document.MainForm.submit();
		}
	}
	else
	{
		if(confirm("Do you want to Trash the Scale Name...?"))
		{
			document.MainForm.action= "ScaleTrashPreview.jsp";
			document.MainForm.submit();
		}
	}

}
function goBack()
{
		document.MainForm.action= "ScaleEntry.jsp";
		document.MainForm.submit();
}
function TrashListview()
{
		document.MainForm.action= "ScaleTrashView.jsp";
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
         <h2><%=bundle.getString("label.scaleentry.viewrootpath")%></h2>
     
<%@ page import="java.util.*"%>

<%
String instituteid=session.getValue("instituteid")+"";
ArrayList ScaleList=new ArrayList();
ScaleList=query_object.getScaleList(instituteid,"A");
 
%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="scaleid" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.scaleentry.slno")%></th>
        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.scaleentry.scalename")%> </th>
  	        <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.scaleentry.dateofcreation")%> </th>
  	        <th scope="col" class="rounded" width="8%"><%=bundle.getString("label.scaleentry.edit")%> </th>
  	        <th scope="col" class="rounded-q4" width="8%"><%=bundle.getString("label.scaleentry.trash")%> </th>
        	
            
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
				HashMap scaleListMap=new HashMap();
				if(ScaleList!=null && ScaleList.size()>0)
				{
					for(int i=0;i<ScaleList.size();i++)
					{
						scaleListMap=(HashMap)ScaleList.get(i);
						out.print("<tr valign='top'>");
						out.print("<td class='tablelight' width='5%'>"+(i+1)+"</td>");
						out.print("<td class='tablelight' width='40%' >"+scaleListMap.get("scalename")+"</td>");
						out.print("<td class='tablelight' width='%'>"+scaleListMap.get("newdates")+"</td>");
						out.print("<td class='tablelight' width='8%'><a href='#' scaleid='"+scaleListMap.get("scaleid")+"' onclick=goAction(this,'Edit')><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='Edit' border=0 /></a></td>");
						out.print("<td class='tablelight' width='8%' ><a href='#' scaleid='"+scaleListMap.get("scaleid")+"' onclick=goAction(this,'Trash')><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='Trash' border=0 /></a></td>");
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
				  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.scaleentry.trashlist")%> </strong><span class="bt_red_r"></span></a>
		
		    
		    
		    
		
	
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