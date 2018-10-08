<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.community.entrytitle") %>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript">
function insertvalues()
{
	if(document.communityform.communityname.value == "")
	{
	alert("Community Name should not be empty");
	document.communityform.communityname.focus();
	return false;
	}
	else
	{
		document.communityform.action="CommunitySubmit.jsp";
		document.communityform.submit();
	}
}

function textCounter(field,cntfield,maxlimit)
{
  if (field.value.length > maxlimit) // if too long...trim it!
    {
       alert("Maximum "+maxlimit+" Characters only Allowed");
       field.value = field.value.substring(0, maxlimit);
    }
  else
    {
       cntfield.value = maxlimit - field.value.length;
    }
}

function checkNames(obj)
{
	var communitynames=obj.getAttribute("communitynames");
  	 var url = "CommunityInfo.jsp?action=checkDuplicate&communitynames="+document.communityform.communityname.value;
  	 //alert("URL>>>>"+url);
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {

 			   if (req.status == 200)
 			   {
  				  parseMessages(req.responseXML,"LoadReply");
 			   }
 			   else if (req.status == 204)
 			   {
 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
 	}
 	
 
function parseMessages(parseXML,check_var)
{
	   var rootobj=parseXML.getElementsByTagName("community");
		var clength=rootobj[0].childNodes.length;
		if(clength>0)
		{
		alert("Community Name already Exist")
		reset()
		}
		else
		{
		insertvalues()
		}
	}
	function reset()
	{
	document.communityform.reset();
	document.communityform.communityname.focus();
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

    <h2><%=bundle.getString("label.community.entryrootpath") %></h2>
<form name="communityform" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List" width="100%">
   
    <thead>
    	<tr>
      
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.community.entrytableheading") %></th>
               	<th scope="col" class="rounded-q4" width="20%" align=right ><font color=red>*</font> <%=bundle.getString("label.common.mandatory") %></th>

            
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
     ArrayList BoardList = null;
     
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  
    }catch(Exception e){}
    
    %>
    <tr><td colspan=2>
    
    <table id="rounded-corner1" width="100%">
    <tr>
    <td class=tablebold><%=bundle.getString("label.community.communityname") %> <font color="red">*</font></td>
    <td class=tablebold>:</td>
    <td><input type="text" class=tablelight name="communityname" size="38" maxlength="50"></td>
    </tr>
    <tr>
    	<td class=tablebold><%=bundle.getString("label.community.description") %></td>
    	<td class=tablebold valign=top>:</td> 
    	<td>
    	<textarea validate="communitydescription" class=tablelight cols=50 rows=2 name="communitydescription" onkeydown="textCounter_label(document.communityform.communitydescription,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.communityform.communitydescription,document.getElementById('labelid'),2000)"></textarea>
    	&nbsp;<a> <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.community.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.community.charactersleft") %></font></i>;</a>
		<label id="labelid"></label>
	</td>
    </tr>
	 </table></td></tr>
    </tbody>
</table>

     <a href="./CommunityView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.community.viewallcommunity") %> </strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="insertvalues()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.community.submit") %></strong><span class="bt_green_r"></span></a>
     
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>