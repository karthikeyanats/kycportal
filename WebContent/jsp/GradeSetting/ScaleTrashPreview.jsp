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
<title><%=bundle.getString("label.scaleentry.trashpreviewtitle")%>  </title>
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="JavaScript">

function goBack()
{
		document.MainForm.action= "ScaleView.jsp";
		document.MainForm.submit();
}
function goUpdate()
{			
			if(confirm("Do you want to Trash the Scale Name...?"))
			{  
	
				document.MainForm.flage.value="Trash";
				document.MainForm.action= "ScaleStatusUpdate.jsp";
				document.MainForm.submit();
			}
		
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
         <h2><%=bundle.getString("label.scaleentry.trashootpath")%></h2>
     
<%@ page import="java.util.*"%>

<%
String instituteid=session.getValue("instituteid")+"";
ArrayList scalelist=new ArrayList();
HashMap scalelistMap=new HashMap();
String scaleid=request.getParameter("scaleid")+"";
scalelist=query_object.getscaleforUpdate(scaleid,"A");
String scalename="";
String newdates="";
String message="";
if(scalelist!=null && scalelist.size()>0)
{
	for(int i=0;i<scalelist.size();i++)
	{
		scalelistMap=(HashMap)scalelist.get(i);
		 scalename=scalelistMap.get("scalename")+"";
		 newdates=scalelistMap.get("newdates")+"";
		
	}
}
 String count=query_object.checkTrashScale(scaleid)+"";  
 if(count!=null && !count.equals("null") && !count.equalsIgnoreCase("null") && !count.equals(""))
 {
	 message="This Scale has been Alloted, so you can not Trash the Scale";

 }


%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="scaleid" value="<%=scaleid%>">
<input type="hidden" name="flage" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.scaleentry.scaleentrytrash")%></th>
        	<th scope="col" class="rounded" width="1%"> </th>
  	        <th scope="col" class="rounded-q4" width="75%" ></th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   		<tr valign="top">
   			<td class="tablebold" width="25%"><%=bundle.getString("label.scaleentry.scalename")%></td>  
   			<td class="tablebold" width="1%">:</td>
   			<td class="tablelight" > <%=scalename%></td>
   			
   		</tr>
   		
   		<tr valign="top">
   			<td class="tablebold" width="20%"><%=bundle.getString("label.scaleentry.dateofcreation")%></td>
   			<td class="tablebold" width="1%">:</td>
   			<td class="tablelight" ><%=newdates%></td>
   			
   		</tr>
		</table>
		
				<a href="#" onclick="goBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.scaleentry.back")%> </strong><span class="bt_blue_r"></span></a>
 		<%
 
 		 if(count!=null && !count.equals("null") && !count.equalsIgnoreCase("null") && !count.equals(""))
 		 {
 			 out.println("<div class='warning_box'>");
 		 	out.println("<a align=left class='tablebold'>"+message+"</a>");
 			 out.println(" </div>");
 		
	}
	 else
	 {%>
		
				 <a href="#" class="bt_green" onclick="goUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.scaleentry.trash")%>  </strong><span class="bt_green_r"></span></a>


	<% }%>
		
		    
		    
		    
		
	
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