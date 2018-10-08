<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
	
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.announcement.entrytitle") %>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

var counter	 = 1;


function submitNews()
{
	
	
if(document.main_Form.content[0].value.length <1 && document.main_Form.content[1].value.length< 1)
{
alert("Empty Content is not allowed");
return false;
}

if(document.main_Form.content[0].value.length >1 || document.main_Form.content[1].value.length > 1)
{

	document.main_Form.action = "./SubmitAnnouncement.jsp";
	document.main_Form.submit();
			

}
	
}


function updateFun()
{
	document.main_Form.action = "./Update_Announcement.jsp";
	document.main_Form.submit();
}


var add_news = 1;


function resetfun()
{

	
		document.getElementById("labelid1").innerHTML	= "2000";
	
		document.getElementById("labelid2").innerHTML	= "2000";
	
		document.main_Form.reset();
	
}

function listFun(list)
{

if(list=="TRASHlIST")
{
document.main_Form.list.value=list
document.main_Form.action = "./List_Announcement.jsp";
	document.main_Form.submit();
	}
	else
	{
	document.main_Form.list.value=list
		document.main_Form.action = "./List_DeactAnnouncement.jsp";
	document.main_Form.submit();
	}
}
</script>
</head>
<body>

<jsp:useBean id="datebeans" scope="page" class="com.iGrandee.Common.DateTime"/>
<%@ page import="java.io.*,java.util.*"%>


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

    <h2><%=bundle.getString("label.announcement.entryrootpath") %></h2>
 		  <form name="main_Form" method="post" action="">
 
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%" cellspacing=0
	cellpadding=0>
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.announcement.entrytableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font>&nbsp;<%=bundle.getString("label.announcement.mandatoryfields") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
</table>
  <table id="rounded-corner" border=0 summary="Announcement Entry" width="100%" cellspacing=0
	cellpadding=0>


    <thead>   
   <TABLE border=0 bgcolor=white cellspacing=0 width=100% align=center height=350 cellpadding=0>
  <TR valign="TOP" >
      <TD>


		  <table id="rounded-corner" border=0 summary="Department List" width="100%" cellspacing=0
	cellpadding=0>
    <thead>
		  	<tr valign='top'><td >
		  		<table border=0 width="100%" align="center" id="table_creater" >
		  			<tr height=20 class=tablehead>
		  				<td colspan='2' align=center><font color=brown size=3></font></td>
		  			</tr>
		  			<tr valign='top' height=20>
						<td align="left" class=annocementform><a class=tablebold><%=bundle.getString("label.announcement.content1") %><font color="red">&nbsp; *</font> </a>
						 &nbsp;</td>
						 <td width="1%" class="tablebold">:</td>
						<td  class=tablelight>
						<input type=hidden name='tempann' value='2000' >
						<textarea rows=4 cols=60" class="tabledivision" name="content" onkeydown="textCounter_label(document.main_Form.content[0],document.getElementById('labelid1'),2000)" onkeyup="textCounter_label(document.main_Form.content[0],document.getElementById('labelid1'),2000)" ></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid1" ><%=bundle.getString("label.announcement.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.announcement.charactersleft") %></font></i>
							
						</td>
					</tr>
			
					<tr valign='top' height=20>
						<td align="left" class=annocementform><a class=tablebold><%=bundle.getString("label.announcement.content2") %><font color="red">&nbsp; *</font> </a>
						 &nbsp;</td>
						 <td width="1%" class="tablebold">:</td>
						 <td  class=tablelight>
						<input type=hidden name='tempann' value='2000' >
						<textarea rows=4 cols=60" class="tabledivision" name="content" onkeydown="textCounter_label(document.main_Form.content[1],document.getElementById('labelid2'),2000)" onkeyup="textCounter_label(document.main_Form.content[1],document.getElementById('labelid2'),2000)" ></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid2" ><%=bundle.getString("label.announcement.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.announcement.charactersleft") %></font></i>
							
						</td>
					</tr>
					
					
		  		</table>

		  	
		  
		  	</tr>

			
		  </table>

			<input type=hidden name='list' value='' > 
			 
			  <a href="#" onclick="resetfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.announcement.reset") %> </strong><span class="bt_blue_r"></span></a>
           <a href="#" class="bt_red" onclick="listFun('TRASHlIST')"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.announcement.trashlist") %></strong><span class="bt_red_r"></span></a>
	      <a href="#" class="bt_red" onclick="listFun('DEACTIVElIST')"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.announcement.deactivatelist") %></strong><span class="bt_red_r"></span></a>
			  <a href="#" class="bt_blue" onclick="updateFun()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.announcement.vieweditdelete") %></strong><span class="bt_blue_r"></span></a>
		  	<a href="#" onclick="submitNews()" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.announcement.insert") %> </strong><span class="bt_green_r"></span></a>
		  		  		
		  		  		
		  		  		
</TABLE>
</div>
    
    </thead>
</table>
 
 
     </td>
     </tr>
     </TABLE>
     </form>
     
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>