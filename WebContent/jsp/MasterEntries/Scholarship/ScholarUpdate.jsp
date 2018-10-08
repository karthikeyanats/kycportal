<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.scholarship.updatelistlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function updateFun()
{
if(check_ForParticularElements(document.scholarupdateform.scholarname,"text"))
	{
		if(check_StartingLetter(document.scholarupdateform.scholarname,"Scholarship Name"))
   		{
if(confirm("Do you want to Update the Scholarship Details...?"))
{

	document.scholarupdateform.action= "ScholarUpdateSubmit.jsp";
	document.scholarupdateform.submit();
}
}
}
else{}
}

function backfun()
{
document.scholarupdateform.action="ScholarshipList.jsp";
document.scholarupdateform.submit();

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
    <h2><%=bundle.getString("label.scholarship.updatelistrootpath") %></h2>
    
<form name="scholarupdateform" action="" method="post">
<%
	String scholarid1=request.getParameter("scholarid_hidden");
	String scholarname=request.getParameter("scholarname_hidden");
	String scholardesc=request.getParameter("scholardesc_hidden");
%>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
     <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.scholarship.updatetableheading") %></th>
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
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery  scholarshipQuery = new com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery();
     String instituteid = null;
          
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  
    }catch(Exception e){}
    
    %>
    <input type=hidden name=scholarid1_hidden value=<%=scholarid1 %>>
    <tr><td colspan=2><table  width="100%">
    <tr ><td class=tablebold><%=bundle.getString("label.scholarship.scholarshipname") %> <font color="red">*</font></td>
    <td class=tablebold>:</td>
    <td><input type="text" class=tablelight name="scholarname" size="38" value="<%=scholarname %>" maxlength="50"></td>
    
    <tr><td class=tablebold><%=bundle.getString("label.scholarship.description") %></td>
    <td class=tablebold>:</td>
    <td>
    					<textarea validate="scholardesc" class=tablelight cols=50 rows=2 name="scholardesc" onkeydown="textCounter_label(document.scholarupdateform.scholardesc,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.scholarupdateform.scholardesc,document.getElementById('labelid'),2000)"><%=scholardesc%></textarea>
    					&nbsp;<a> <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.scholarship.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.scholarship.charactersleft") %></font></i>;</a>
						<label id="labelid"></label>
					</td>
	 </table></td></tr>
    </tbody>
</table>

<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.scholarship.back") %></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="updateFun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.scholarship.update") %></strong><span class="bt_green_r"></span></a>
     
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>