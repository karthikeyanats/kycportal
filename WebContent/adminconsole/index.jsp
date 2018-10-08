<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html>
<head>
<title>::: Welcome to KYC Portal :::</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<script type="text/javascript">
function submitfun()
{

	var uname=Trim(document.MainForm.uname.value);
	var psw=Trim(document.MainForm.psw.value);
	if(check_ForParticularElements(document.MainForm.uname,"text",document.MainForm.psw,"text"))
	{
		
	
			url = "checkUnamePsw.jsp?username="+uname+"&password="+psw;
			
				try
				  {
				  // Firefox, Opera 8.0+, Safari
				  req=new XMLHttpRequest();
				  }
				catch (e)
				  {
				  // Internet Explorer
				  try
				    {
				    req=new ActiveXObject("Msxml2.XMLHTTP");
				    }
				  catch (e)
				    {
				    req=new ActiveXObject("Microsoft.XMLHTTP");
				    }
				  }
				  
				  
				  req.onreadystatechange = function()
						{
						//	alert(req.readyState)
							if (req.readyState == 4)
							   {
								//   alert(req.status)
							  		 if(req.status == 200)
									 {
					              			var parseXML=req.responseXML;
				
											var rootObj=parseXML.getElementsByTagName("checkUnamePsw");
											var cNode_1=rootObj[0].childNodes.length;
											var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
											var finalValue1=rootObj[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue;
											if(finalValue=="false")
											{
												alert("Invalid UserName");
												document.MainForm.uname.focus();
												return false;
											}
											if(finalValue1=="false")
											{
												alert("Invalid Password");
												document.MainForm.psw.focus();
												return false;
											}
											if(finalValue=="true" && finalValue1=="true")
											{
											
												document.MainForm.action="indexnew.jsp";
												document.MainForm.submit();
												
											}
			
									  }
								   	 else if (req.status == 204)
								     {
									 }
							   	}
					   };
					req.open("GET",url,true);
					req.send(null);
		
		
	}
		
		
		
		
	
		
} 
function loadfun()
{
	document.MainForm.uname.focus();
}
</script>
</head>
<body onload="loadfun()" style="background-image:none;background-color: white" >
<form name="MainForm" method="post" action="">
<table width="100%" height="100%" align=center border=0>
		<tr>
			<td class="tablebold" colspan=0 align=center><h2><%=bundle.getString("label.adminconsole.header") %></h2></td>
		</tr>
<tr valign=top>
	<td>
		<table width="50%" align=center border=1 cellpadding=6>
		
			<tr >
				<td class="tablebold"><%=bundle.getString("label.adminconsole.username") %></td>
				<td class="tablebold" width="1%">:</td>
				<td class="tablelight"><input type="text" name="uname" validate="User Name" value=""></td>
			</tr>  
			<tr>
				<td class="tablebold"><%=bundle.getString("label.adminconsole.password") %></td>
				<td class="tablebold" width="1%">:</td>
				<td class="tablelight"><input type="password" name="psw" validate="Password" value=""></td>
			</tr> 
			<tr>
				<td colspan=3 align=center><input type="button" name="butt" value="Submit" onclick="submitfun()"></td>
			</tr>
		</table>
	</td>
</tr>
</table>
</form>
</body>
