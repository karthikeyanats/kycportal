<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.scaleentry.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">



 function checkfun(obj)
 {
	
	 	for(var i=0;i<document.gradeform.clickbox.length;i++)
	 	{  
	 		if(document.gradeform.clickbox[i].checked)
	 		{
	 				if( check_ForParticularElements(document.gradeform.scalename[i],"text") )
					{
						 
							document.gradeform.scalename[i].disabled=true;
						
						
					}
					else
					{
						document.gradeform.clickbox[i].checked=false;
					}
					
	 		}
	 		else
	 		{
	 					document.gradeform.scalename[i].disabled=false;
						document.gradeform.clickbox[i].checked=false;
						
	 		}
	 		
	 	}
	 
 }

function submitfun()
{
		var status=false;
		for(var i=0;i<document.gradeform.clickbox.length;i++)
	 	{
	 		if(document.gradeform.clickbox[i].checked)
	 		{
	 			if( check_ForParticularElements(document.gradeform.scalename[i],"text") )
				{
	 					 
							document.gradeform.scalename[i].disabled=true;
							status=true;
							
						
			 	} 
		 		
	 		}
	 		
	 		
	 	}   
	 	if(status)
	 	{
	 		for(var i=0;i<document.gradeform.clickbox.length;i++)
	 		{
		 		if(!document.gradeform.clickbox[i].checked)
		 		{
		 			document.gradeform.scalename[i].disabled=true;
					document.gradeform.clickbox[i].disabled=true;
				}
				else
				{
					document.gradeform.scalename[i].disabled=false;
					document.gradeform.clickbox[i].disabled=false;
				}
			}
	 		document.gradeform.action= "ScaleSubmit.jsp";
			document.gradeform.submit();
	 	}
	 	else
	 	{
	 		alert("Select any one Checkbox");
	 		return false;
	 	}
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

    <h2><%=bundle.getString("label.scaleentry.rootpath")%></h2>
<form name="gradeform" action="" method="post">

<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width='10%'><%=bundle.getString("label.scaleentry.slno")%></th>
        	<th scope="col" class="rounded" width='40%'><%=bundle.getString("label.scaleentry.scalename")%></th>
        	 <th scope="col" class="rounded"  width='10%'><%=bundle.getString("label.scaleentry.chk")%></th>
        	
        	<th scope="col" class="rounded-q4" width='40%'></th>
        </tr>
    </thead>
    <tfoot>
    	<tr> 
        	<td colspan=3 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>  

 <%
 for(int i=1,j=0;i<6;i++,j++)
	{
 %> <tr>
 	<td><%=i%></td>
	 <td><input type="text" name="scalename" validate ="Scale Name" size="30" maxlength="45" class="tablelight" /></td>
	 	  <td colspan=2><input type="checkbox" name="clickbox" chkid="<%=j%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 
	 </tr>    
	 <%} %>
	 </tbody>
	 </table>
	 
	      <a href="./ScaleView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.scaleentry.ViewGrade")%></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.scaleentry.Submit")%></strong><span class="bt_green_r"></span></a>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>