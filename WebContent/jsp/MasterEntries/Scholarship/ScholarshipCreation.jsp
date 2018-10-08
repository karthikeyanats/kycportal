<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.scholarship.entrytitle") %>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function addScholar()
{
	if(document.scholarform.scholarshipname.value == "")
	{
	alert("Scholarship Name should not be empty");
	document.scholarform.scholarshipname.focus();
	return false;
	}
	else
	{
		document.scholarform.action="ScholarshipSubmit.jsp";
		document.scholarform.submit();
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
addScholar()
	//var scholarshipnames=obj.getAttribute("scholarshipnames");
  	// var url = "Scholarinfo.jsp?action=checkDuplicate&scholarshipnames="+document.scholarform.scholarshipname.value;
  	 //alert("URL>>>>"+url);
 	 /* var req =initRequest();
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
 	   req.send(null);*/
 	}
 	
 
function parseMessages(parseXML,check_var)
{

	   var rootobj=parseXML.getElementsByTagName("scholarship");
	   //alert("rootobj>>>>"+rootobj);
		var clength=rootobj[0].childNodes.length;
		//alert("clength>>>>"+clength);
		if(clength>0)
		{
		alert("Scholarship Name already Exist")
		reset()
		}
		else
		{
		
		addScholar()
		}
	}
	function reset()
	{
	document.scholarform.reset();
	document.scholarform.scholarshipname.focus();
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

    <h2><%=bundle.getString("label.scholarship.entryrootpath") %></h2>
<form name="scholarform" action="" method="post">

<table id="rounded-corner" border=0 summary="Department List"
	width="100%">
	<thead>
		<tr class="tablebold">
		
			<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.scholarship.entrytableheading") %>
			</th>
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
		<%
			String instituteid = null;
			try {
				instituteid = (String) session.getValue("instituteid");
			} catch (Exception e) {
			}
		%>
		<tr>
			
			<td colspan=2>
			<table border=0 width="100%">
				<tr>
					<td class=tablebold><%=bundle.getString("label.scholarship.scholarshipname") %> <font color="red">*</font></td>
					<td class=tablebold>:</td>					
					<td><input type="text" class=tablelight name="scholarshipname"
						size="38" maxlength="50"></td>
				<tr>
					<td class=tablebold><%=bundle.getString("label.scholarship.description") %></td>
					<td class=tablebold>:</td>
					<td>
    					<textarea validate="scholarshipdescription" class=tablelight cols=50 rows=2 name="scholarshipdescription" onkeydown="textCounter_label(document.scholarform.scholarshipdescription,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.scholarform.scholarshipdescription,document.getElementById('labelid'),2000)"></textarea>
    					&nbsp;<a> <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.scholarship.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.scholarship.charactersleft") %></font></i>;</a>
						<label id="labelid"></label>
					</td>
			</table>
			</td>
		
		</tr>
	</tbody>
</table>

<a href="./ScholarshipList.jsp" class="bt_blue"><span
	class="bt_blue_lft"></span><strong><%=bundle.getString("button.scholarship.viewallscholarship") %></strong><span
	class="bt_blue_r"></span></a> <a href="#" class="bt_green"
	onclick="checkNames(this)"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.scholarship.submit") %></strong><span
	class="bt_green_r"></span></a></form>
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>