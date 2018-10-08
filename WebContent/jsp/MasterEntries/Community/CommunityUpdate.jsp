<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.community.updatelistlisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function updateCommunity()
{
if(check_ForParticularElements(document.communityform.communityname,"text"))
	{
		if(check_StartingLetter(document.communityform.communityname,"Community Name"))
   		{
if(confirm("Do you want to Update the Community Details...?"))
{

	document.communityform.action= "CommunityUpdateSubmit.jsp";
	document.communityform.submit();
}
}
}
else{}
}

function backfun()
{
document.communityform.action="CommunityView.jsp";
document.communityform.submit();

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

    <h2><%=bundle.getString("label.community.updatelistrootpath") %></h2>
    
<form name="communityform" action="" method="post">
<%
	String communityid1=request.getParameter("communityid_hidden");
	String communityname=request.getParameter("communityname_hidden");
	String communitydesc=request.getParameter("communitydescription_hidden");
	
	
%>


<table id="rounded-corner" border=0  width="100%">
     <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.community.updatetableheading") %></th>
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
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Community.CommunityQuery  communityQuery = new com.iGrandee.MasterEntries.Community.CommunityQuery();
     String instituteid = null;
          
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  
    }catch(Exception e){}
    
    %>
    <input type=hidden name=communityid1_hidden value=<%=communityid1 %>>
    <tr><td colspan=2><table  width="100%">
    <tr>
    	<td class=tablebold><%=bundle.getString("label.community.communityname") %> <font color="red">*</font></td>
    	<td class=tablebold>:</td>
    	<td><input type="text" class=tablelight name="communityname" size="38" value="<%=communityname %>" maxlength="50"></td>
    </tr>
    <tr>
    	<td  class=tablebold valign=top><%=bundle.getString("label.community.description") %></td>
    	<td class=tablebold valign=top>:</td>
    	<td>
    	<textarea validate="communitydescription" class=tablelight cols=50 rows=2 name="communitydescription" onkeydown="textCounter_label(document.communityform.communitydescription,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.communityform.communitydescription,document.getElementById('labelid'),2000)"><%=communitydesc%></textarea>
    	&nbsp;<a> <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.community.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.community.charactersleft") %></font></i>;</a>
		<label id="labelid"></label>
		</td>
	</tr>
	 </table></td></tr>
    </tbody>
</table>

<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.community.back") %></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="updateCommunity()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.community.update") %></strong><span class="bt_green_r"></span></a>
     
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>