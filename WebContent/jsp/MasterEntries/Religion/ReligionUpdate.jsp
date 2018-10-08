<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.religion.updatelistlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">
function updateFun()
{
if(check_ForParticularElements(document.religionupdateform.religionname,"text"))
	{
		if(check_StartingLetter(document.religionupdateform.religionname,"Religion Name"))
   		{
if(confirm("Do you want to Update the Religion Details...?"))
{

	document.religionupdateform.action= "ReligionUpdateSubmit.jsp";
	document.religionupdateform.submit();
}
}
}
else{}
}

function backfun()
{
document.religionupdateform.action="ReligionView.jsp";
document.religionupdateform.submit();

}


</script>
</head>
<body>
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

    <h2><%=bundle.getString("label.religion.updatelistrootpath") %></h2>
    
<form name="religionupdateform" action="" method="post">
<%
	String religionid1=request.getParameter("religionid_hidden");
	String religionname=request.getParameter("religionname_hidden");
	String religiondesc=request.getParameter("religiondescription_hidden");
	
	
%>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
     <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.religion.updatetableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.common.mandatory") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Religion.ReligionQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Religion.ReligionQuery  religionQuery = new com.iGrandee.MasterEntries.Religion.ReligionQuery();
     String instituteid = null;
          
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  
    }catch(Exception e){}
    
    %>
    <input type=hidden name=religionid1_hidden value=<%=religionid1 %>>
    <tr><td colspan=2><table  width="100%">
    <tr ><td class=tablebold><%=bundle.getString("label.religion.religionname") %><font color="red">*</font></td>
    <td class=tablebold>:</td>
    <td><input type="text" class=tablelight name="religionname" size="38" value="<%=religionname %>" maxlength="50"></td>
    <tr><td class=tablebold valign=top><%=bundle.getString("label.religion.description") %> </td>
    <td class=tablebold valign=top>:</td>
    <td>
    	<textarea validate="religiondescription" class=tablelight cols=50 rows=2 name="religiondescription" onkeydown="textCounter_label(document.religionupdateform.religiondescription,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.religionupdateform.religiondescription,document.getElementById('labelid'),2000)"><%=religiondesc%></textarea>
    	&nbsp;<a> <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.religion.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.religion.charactersleft") %></font></i>;</a>
		<label id="labelid"></label>
	</td>
	 </table></td></tr>
    </tbody>
</table>

<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.religion.back") %></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="updateFun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.religion.update") %></strong><span class="bt_green_r"></span></a>
     
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>