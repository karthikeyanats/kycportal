<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.frequency.entrytitle") %></title>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>

<script language="JavaScript">

	
function submitfun()
{
	if(check_ForParticularElements(document.MainForm.frequencyname,"text"))
	{
		document.MainForm.action= "FrequencySubmit.jsp";
		document.MainForm.submit();
		
	}

		

}
function resetfun()
{
	document.MainForm.reset();
	document.getElementById("labelid").innerHTML	= "500";
}



</script>
</head>

<body>

<form name="MainForm" method="post" action="">

<div id="main_container">

	<div class="header">
	
<%@ include file="../../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2><%=bundle.getString("label.frequency.entryrootpath")%></h2>
     
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
		<td>
<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	        	
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.frequency.entrytableheading") %></th>
        	<th scope="col" class="rounded" width="1%"></th>
        	<th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded" width="20%" ></th>
            <th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.frequency.mandatoryfields") %></th>    
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>

<table id="rounded-corner" border=0 width="100%">


    <thead>
    				<tr valign="top">
            <td class="tablebold" valign="top"><%=bundle.getString("label.frequency.frequencyname") %><font color=red> *</font></td>
			<td width="1%" class="tablebold">:</td>
				<td valign="top" class="tablelight"><input type="text" name="frequencyname"
					validate="Frequency Name" class=tablelight size="50" value=""
					maxlength=45></td>
			</tr> 
			<tr valign="top"> 
            <td class="tablebold" ><%=bundle.getString("label.frequency.description") %></td>
				<td width="1%" class="tablebold">:</td>
				<td class="tablelight">   
					<textarea validate="Description" class="tablelight" cols=75 rows=2 name="descryption" onkeydown="textCounter_label(document.MainForm.descryption,document.getElementById('labelid'),500)" onkeyup="textCounter(document.MainForm.descryption,document.getElementById('labelid'),500)"></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.frequency.charactercount")%></label>&nbsp;&nbsp;<%=bundle.getString("label.frequency.charactersleft")%></font></i>
						<label id="labelid"></label>
					</td> 
 </tr>
 
 
   		
			    </thead>
			
		</table>
</td>
</tr>
   <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> 
    
    
</table>


     <a href="#" onclick="resetfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.frequency.reset")%></strong><span class="bt_blue_r"></span></a>
     <a href="FrequencyList.jsp"   class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.frequency.viewallfrequencys")%></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.frequency.submit")%></strong><span class="bt_green_r"></span></a>






     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>