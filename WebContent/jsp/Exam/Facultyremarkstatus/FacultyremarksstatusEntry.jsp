<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.facultyremarkstatus.entrytitle") %></title>

<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="../jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>
<script type="text/javascript" src="../jsp/jconfirmaction.jquery.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script language="javascript" type="text/javascript" src="niceforms.js"></script>

<script language="JavaScript">

	
function submitfun()
{
	
	if(document.MainForm.facultyremarkname[0].value.length <1 && document.MainForm.facultyremarkname[1].value.length< 1  && document.MainForm.facultyremarkname[2].value.length< 1)
	{
		alert("Empty Remark Type not allowed");
		return false;
	}
	if(document.MainForm.facultyremarkname[0].value.length >1 || document.MainForm.facultyremarkname[1].value.length > 1 || document.MainForm.facultyremarkname[2].value.length > 1)
	{
		document.MainForm.action= "FacultyRemarkSubmit.jsp";
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
	
<%@ include file="../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2><%=bundle.getString("label.facultyremarkstatus.entryrootpath")%></h2>
     

<table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="50%">
<tr><td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" colspan=4 width='60%'><%=bundle.getString("label.facultyremarkstatus.entrytableheading") %></th>
             <th scope="col" class="rounded-q4" width="40%" align="right"><font color=red>*</font> <%=bundle.getString("label.facultyremarkstatus.mandatoryfields") %></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=4 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

	<tr valign="top">
            <td class="tablebold" valign="top" width="30%" ><%=bundle.getString("label.facultyremarkstatus.facultyremarktype") %> 1<font color="red"> *</font></td>
            <td class=tablebold width="2%">:</td>
				<td valign="top" class="tablelight" colspan=3><input type="text" name="facultyremarkname"
					validate="Faculty Remark Name" class=tablelight size="50" value=""
					maxlength=45></td>
			</tr> 
			<tr valign="top">
            <td class="tablebold" valign="top" width="30%" ><%=bundle.getString("label.facultyremarkstatus.facultyremarktype") %> 2</td>
				<td class=tablebold width="2%">:</td>
				<td valign="top" class="tablelight" colspan=3><input type="text" name="facultyremarkname"
					validate="Faculty Remark Name" class=tablelight size="50" value=""
					maxlength=45></td>
			</tr> 
			<tr valign="top"> 
            <td class="tablebold" valign="top" width="30%" ><%=bundle.getString("label.facultyremarkstatus.facultyremarktype") %> 3</td>
				<td class=tablebold width="2%">:</td>
				<td valign="top" class="tablelight" colspan=3><input type="text" name="facultyremarkname"
					validate="Faculty Remark Name" class=tablelight size="50" value=""
					maxlength=45></td>
					
					
			</tr> 
			 </tbody>
	 </table>
</td>
</tr>
   
    
    
</table>


     <!--  <a href="#" onclick="resetfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.facultyremarkstatus.reset")%></strong><span class="bt_blue_r"></span></a>-->
     <a href="FacultyRemarkList.jsp"   class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.facultyremarkstatus.viewallracks")%></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.facultyremarkstatus.submit")%></strong><span class="bt_green_r"></span></a>






     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>