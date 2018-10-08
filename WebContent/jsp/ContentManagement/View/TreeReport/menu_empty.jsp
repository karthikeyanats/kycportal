<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/School_style.css"/>
<script language='javascript'>
function closeMedia()
{
		window.parent.location.replace("../../ContentList.jsp");
}
function khanMedia()
{
	
	window.parent.location.replace("../ContentFrameKhan.jsp");
		//window.parent.location.replace("../../ContentList.jsp");
}
function kycMedia()
{
	//document.menutop_form.action = window.parent.location.replace("../ContentFrame.jsp"); 
	//document.menutop_form.submit();
	window.parent.location.replace("../ContentFrame.jsp?req_subjectscheduleid="+document.menutop_form.menu_subjectid.value+"&req_subjectname="+document.menutop_form.menu_subjectname.value);
}

</script>
</head>

<body >
<form name=menutop_form action="">
 <%@ page language="java" import="java.util.ResourceBundle" %>

<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>



<%
	String user_name = "";
	String user_role = "";
	String user_inst = "";
	String user_mode = "";
	String temp_name = "";
	String fullname = "";
	String std_name="";
	String user_category="";
	String sessionname = "";
	String boardname = "";
	String standardname = "";
	String subjectname="";
	String subjectid="";
	try
	{
		user_name = (String)session.getValue("username");
		user_role = (String)session.getValue("userrolename");
		user_inst = (String)session.getValue("institutename");
		user_mode = (String)session.getValue("userinstitutemode");
		user_category= (String)session.getValue("usercategory");
		sessionname = (String)session.getValue("sessionname");
		boardname = (String)session.getValue("boardname");
		standardname = (String)session.getValue("standardname");
		subjectname= (String)session.getValue("subjectname");
		subjectid= (String)session.getValue("reqkhansubjectid");
		std_name=(String)session.getValue("standardname");
		fullname  = (String)session.getValue("userfullname");
		temp_name = user_inst;

		if(temp_name.length() > 70)
			temp_name = temp_name.substring(0,66)+"..";
		

	}
	catch(NullPointerException npe){}
%>

<div style="position:absolute;visibility:visible;top:0;left:0%;width:25%">
<table width="100%" bgcolor=white border=0 bordercolor=red cellspacing=0 cellpadding=0>
	<tr class="tablelight">
		<td class="hintbold" valign=top><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Virtualkyc_logo-v2.png" onClick="kycMedia()" style="cursor:pointer" title="Virtual KYC"></td>
	</tr>
</table>
</div>

<div style="position:absolute;visibility:visible;top:0;left:25%;width:80%">
<table width="100%" border=0 bordercolor=red bgcolor=white align="right">
	<tr class="tablebold">
		<td class="tablebold" width="15%">Name</td>
		<td class="hintbold">:</td>
		<td class="tablebold" colspan=4><span id="user_name"><font color="brown"><%= fullname %></font></span></td>
		<td rowspan=3 width=9% ><img src="./content_images/khanacademy.jpg" height="75" width="150" onClick="khanMedia()" style="cursor:pointer" title="Khan Academy"></td>
		<td rowspan=3 width=9% ><img src="./content_images/quit.gif" onClick="closeMedia()" style="cursor:pointer" title="Go Back"></td>

	</tr>
	<tr class="tablebold">
		<td class="hintbold">Session</td>
		<td class="hintbold">:</td>
		<td class="tablebold" ><span id="user_institute" title="<%= sessionname %>"><font color="brown"><%= sessionname %></font></span></td>
		<td class="hintbold">Board-Medium</td>   
		<td class="hintbold">:</td>
		<td class="tablebold"><span id="std_name"><font color="brown"><%= boardname %></font></span></td>
	</tr>
	<tr class="tablebold">
		<td class="hintbold">Standard</td>
		<td class="hintbold">:</td>
		<td class="tablebold" ><span id="user_institute" title="<%= standardname %>"><font color="brown"><%= standardname %></font></span></td>
		<td class="hintbold">Subject</td>
		<td class="hintbold">:</td>
		<td class="tablebold"><span id="std_name"><font color="brown"><%= subjectname %></font></span></td>
	</tr>
</table>
</div>
<input type=text name=user_categoryhidden value="<%=user_category %>" >

<input type=hidden name=menu_subjectid value="<%=subjectid %>" >
<input type=hidden name=menu_subjectname value="<%=subjectname %>" >

<input type=hidden name=req_subjectscheduleid value="<%=subjectid %>" >
<input type=hidden name=req_subjectname value="<%=subjectname %>" >

</form>

<table style="visibility:hidden">
<tr>
	<td id="speech_content_text"></td>
	<td id="speech_content_file"></td>
</tr>
</table>
</body>
</html>