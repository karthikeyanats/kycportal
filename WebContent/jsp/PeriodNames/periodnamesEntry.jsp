<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.periodnames.entrytitle") %></title>

<link rel="stylesheet" type="text/css" href="../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<script type="text/javascript" src="jsp/jconfirmaction.jquery.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script language="javascript" type="text/javascript" src="niceforms.js"></script>

<script language="JavaScript">

	
function submitfun()
{
	if(check_ForParticularElements(document.MainForm.periodname,"text"))
	{
		document.MainForm.action= "PeriodNameSubmit.jsp";
		document.MainForm.submit();
		
	}

		

}
function resetfun()
{
	document.MainForm.reset();
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
         <h2><%=bundle.getString("label.periodnames.entryrootpath")%></h2>
     
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
		<td>
			<table id="rounded-corner" border=0  width="100%">
			    <thead>
			    	<tr>
			        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.periodnames.entrytableheading") %></th>
			        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.periodnames.mandatoryfields") %></th>
			            
			        </tr>
			    </thead>
			
			     <tbody>
			</tbody>
			</table>

<table id="rounded-corner" border=0 width="100%">
    <thead>
		<tr valign="top">
            <td class="tablebold" valign="top"><%=bundle.getString("label.periodnames.periodname") %><font color=red> *</font></td>
			<td valign="top" class="tablelight" colspan=2><input type="text" name="periodname" validate="Period Name" class=tablelight size="50" value="" maxlength=45></td>
		</tr> 
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
</table>
</td>
</tr>

    
    
</table>

     <a href="../TimeTable/PeriodTime.jsp"   class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.periodnames.back")%></strong><span class="bt_blue_r"></span></a>
     <a href="#" onclick="resetfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.periodnames.reset")%></strong><span class="bt_blue_r"></span></a>
     <a href="PeriodNameList.jsp"   class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.periodnames.viewallracks")%></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.periodnames.submit")%></strong><span class="bt_green_r"></span></a>






     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>