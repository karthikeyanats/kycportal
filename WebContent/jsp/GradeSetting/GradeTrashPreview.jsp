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
<title><%=bundle.getString("label.gradeentry.trashpreviewtitle")%>  </title>
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script language="JavaScript">

function goBack()
{
		document.MainForm.action= "GradeView.jsp";
		document.MainForm.submit();
}
function goUpdate()
{			
			if(confirm("Do you want to Trash the Grade Name...?"))
			{  
	
				document.MainForm.flage.value="Trash";
				document.MainForm.action= "GradeStatusUpdate.jsp";
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
         <h2><%=bundle.getString("label.gradeentry.trashootpath")%></h2>
     
<%@ page import="java.util.*"%>

<%
String instituteid=session.getValue("instituteid")+"";
ArrayList gradelist=new ArrayList();
HashMap gradelistMap=new HashMap();
String gradeid=request.getParameter("gradeid")+"";
gradelist=query_object.getgradeforUpdate(gradeid,"A");
String gradename="";
String newdates="";
String message="";
if(gradelist!=null && gradelist.size()>0)
{
	for(int i=0;i<gradelist.size();i++)
	{
		gradelistMap=(HashMap)gradelist.get(i);
		 gradename=gradelistMap.get("gradename")+"";
		 newdates=gradelistMap.get("newdates")+"";
		
	}
}
 String count=query_object.checkTrashGrade(gradeid)+"";  
 if(count!=null && !count.equals("null") && !count.equalsIgnoreCase("null") && !count.equals(""))
 {
	 message="This Grade has been Alloted, so you can not Trash the Grade";

 }


%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="gradeid" value="<%=gradeid%>">
<input type="hidden" name="flage" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.gradeentry.gradeentrytrash")%></th>
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
   			<td class="tablebold" width="25%"><%=bundle.getString("label.gradeentry.gradename")%></td>  
   			<td class="tablebold" width="1%">:</td>
   			<td class="tablelight" > <%=gradename%></td>
   			
   		</tr>
   		
   		<tr valign="top">
   			<td class="tablebold" width="20%"><%=bundle.getString("label.gradeentry.dateofcreation")%></td>
   			<td class="tablebold" width="1%">:</td>
   			<td class="tablelight" ><%=newdates%></td>
   			
   		</tr>
		</table>
		
				<a href="#" onclick="goBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradeentry.back")%> </strong><span class="bt_blue_r"></span></a>
 		<%
 
 		 if(count!=null && !count.equals("null") && !count.equalsIgnoreCase("null") && !count.equals(""))
 		 {
 			 out.println("<div class='warning_box'>");
 		 	out.println("<a align=left class='tablebold'>"+message+"</a>");
 			 out.println(" </div>");
 		
	}
	 else
	 {%>
		
				 <a href="#" class="bt_green" onclick="goUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.gradeentry.trash")%>  </strong><span class="bt_green_r"></span></a>


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