<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Send Mail  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/tinymce/jscripts/tiny_mce/tiny_mce.js"></script>



<!-- TinyMCE -->
<script type="text/javascript">
	tinyMCE.init({
		// General options
		mode : "textareas",
		theme : "advanced",
		plugins : "autolink,lists,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist,autosave,visualblocks",

		// Theme options
		//theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
		//theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
		theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
		theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,restoredraft,visualblocks",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,

		// Example content CSS (should be your site CSS)
		content_css : "css/content.css",

		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "lists/image_list.js",
		media_external_list_url : "lists/media_list.js",

		// Style formats
		style_formats : [
			{title : 'Bold text', inline : 'b'},
			{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
			{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
			{title : 'Example 1', inline : 'span', classes : 'example1'},
			{title : 'Example 2', inline : 'span', classes : 'example2'},
			{title : 'Table styles'},
			{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
		],

		// Replace values for the template plugin
		template_replace_values : {
			username : "Some User",
			staffid : "991234"
		}
	});
</script>
<!-- /TinyMCE -->

<script type="text/javascript">
if (document.location.protocol == 'file:') {
	//alert("The examples might not work properly on the local file system due to security settings in your browser. Please use a real webserver.");
}
</script>
<script type="text/javascript">
function sendmailfun()
{
	if(document.sendmailform.usercategoryoption.value=="SA")
	{
	if(document.sendmailform.validwhom.value=="")
	{
		alert("Select any one type");
		return false;
	}
	}
	
	if(document.sendmailform.mailsubject.value == "")
	{
		alert("Subject Should not be empty");
		document.sendmailform.mailsubject.focus();
		return false;
	}
	//alert(tinyMCE.get('mailmessage').getContent());
	//alert(document.sendmailform.mailmessage.value);
	if(tinyMCE.get('mailmessage').getContent() == "")
	{
		alert("Message Should not be empty");
		//document.sendmailform.mailmessage.focus();
		return false;
	}
	
	document.sendmailform.action="./SendMailEditorSubmit.jsp";
	document.sendmailform.submit();
}
function selectwhom(obj)
{
	document.sendmailform.validwhom.value = obj.getAttribute("value");
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
    <h2>General/Send Mail</h2>
 		  <form name="sendmailform" method="post" action="">
 		  
 <TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	<tr>
		<td>
		<table border=0 cellpadding=0 cellspacing=0 align=center>
		<tr><%
				if(request.getParameter("retvalue")==null)
					{out.print("");}
				else
					{out.print("<td><center><b>Mail Successfully Sent</b></center></td>"); request = null;}
			
			%></tr>
		</table>

  <table id="rounded-corner" border=0 summary="Send Mail" width="100%" cellspacing=0
	cellpadding=0>
    <thead>   
   <table border=0 bgcolor=white cellspacing=0 width=83% align=center height=350 cellpadding=0>
   <Tr><td>
   <%
   
   String instituteid = null;
   try{
		loginusercategory 	= (String)session.getValue("usercategory");
		instituteid 	= (String)session.getValue("instituteid");
  // out.println("sentstatus after "+sentstatus);
  
   %>
   </td></Tr>
  <tr valign=top>
      <td>
		<table border=0 summary="Department List" width="100%" cellspacing=0 cellpadding=0>
		<tr valign='top'>
		  		  	<td><a class=tablebold>To </a></td><td>
		  		  	<% if(loginusercategory.equals("T"))
		  		  	{%>
		  		  	<input type="radio" name="towhom" checked value="SendAllStudent"/>Send All Parents
		  		  	<% }else if(loginusercategory.equals("SA")){%>
		  		  	<input type="radio" name="towhom" value="SendAll" onclick='selectwhom(this)'/>Send All
		  		  	<input type="radio" name="towhom" value="SendAllParents" onclick='selectwhom(this)'/>Send All Parents
		  		  	<input type="radio" name="towhom" value="SendAllStaffs" onclick='selectwhom(this)'/>Send All Staff
		  		  	<%} %>
		  		  	</td>
		 </tr>
		  	
		  	<tr valign='top'>
		  		  	<td><a class=tablebold>Subject  </a></td><td><input type=text name="mailsubject" class=tablelight size="70"></input></td>
		  	</tr>
		  	<tr>
		  	<td colspan=2><a class=tablebold>Message</a></td></tr>
		  	<tr>
		  	<td colspan=2><textarea rows=10 cols=100 name="mailmessage" class=tablelight></textarea></td>
		  	
		  	</tr>
		  </table>
		 <a href="#" onclick="sendmailfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Send Mail </strong><span class="bt_blue_r"></span></a>
</TABLE>
</div>
    
    </thead>
</table>
 
 
     </td>
     </tr>
     </TABLE>
     <input type=hidden name="validwhom"></input>
     <input type=hidden name="usercategoryoption" value="<%=loginusercategory %>"></input>
     
      <% }catch(Exception e){e.printStackTrace();
    	  }%>
     </form>
     
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>