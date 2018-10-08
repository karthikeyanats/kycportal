<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Know Your Child - <%=bundle.getString("label.usernotutil.title")%> | Powered by i-Grandee</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language="JavaScript">

function submitfun()
{
	if(document.MainForm.selectoption[0].checked || document.MainForm.selectoption[1].checked)
	{
		if(document.MainForm.selectoption[0].checked)
		{
			document.MainForm.action="./UserNotUtilStandard.jsp";
			document.MainForm.submit();
		}
		else if(document.MainForm.selectoption[1].checked)
		{
			document.MainForm.action="./UserNotUtilStaff.jsp";
			document.MainForm.submit();
		}
	}
	else
	{
	alert("Select any one Option")
	}
	
}

</script>
</head>

<body>

<%

%>
<form name="MainForm" method="post" action="">
<div id="main_container">

	<div class="header">
	
<%@ include file="../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2><%=bundle.getString("label.usernotutil.entryrootpath")%></h2>
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
		<td>
		
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="40%"><%=bundle.getString("label.usernotutil.entryrootpath") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="10%" ></th>
            <th scope="col" class="rounded" width="10%" ></th>
            <th scope="col" class="rounded" width="15%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ></th>
            
        </tr>
    </thead>
    
     <tbody>
</tbody>
</table>

<table id="rounded-corner" border=0  width="100%">

    <thead>
    		 
			<tr>
	   		 <td align="center" colspan=6>
	   
		    <input type="radio" name="selectoption" value="Students" class="tablebold" ><font size=3>Student</font>&nbsp;&nbsp;
		    <input type="radio" name="selectoption" value="Others" class="tablebold"><font size=3>Others</font>
   
		    </td>
		    </tr>
			 </thead>  
			<tfoot>
    	<tr>  
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
		</table>

</table>
<br>
    </br>

    

     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.usernotutil.Submit")%></strong><span class="bt_green_r"></span></a>






     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>