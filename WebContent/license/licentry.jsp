<html>
<head>
<title>i-Grandee Product License Key</title>
<script type="text/javascript">
String.prototype.startsWith = function(str)
{return (this.match("^"+str)==str)}
String.prototype.endsWith = function(str)
{return (this.match(str+"$")==str)}
function isValid(){
	var myStr2 = document.licform.lickey.value;
	if (myStr2.startsWith(" ")){
		alert("Your key start with empty space.");
		document.licform.lickey.focus();
		return;
	}
	if (myStr2.endsWith(" ")){
		alert("Your key end with empty space.");
		document.licform.lickey.focus();
		return;
	}

	document.licform.submit();
}
</script>
</head>
<body>
<form name=licform method=post action="<%=request.getContextPath() %>/license/applied.jsp">
<table border=0 cellpadding=0  align=center cellspacing=0 height="100%" width="100%">
	<tr><td>
		<table border=0 cellpadding=0 align=center cellspacing=1 width="60%">
		<tr>
			<td colspan=2 align="center"><a style="background-color: yellow;"><%= request.getAttribute("LicenseStatus")==null ? "" : request.getAttribute("LicenseStatus") %></a></td>
		</tr>
		<tr height=40 bgcolor=gray><td colspan=2 align=center class=tablebold>
			<font color=yellow><b>i-Grandee Product License Key Entry</b></font>
		</td></tr>
		<tr bgcolor="#eeeeee">
			<td align=center class=tablebold width="20%"><b>License Key</b></td>
			<td align=center class=tablebold width="80%"><textarea name="lickey" style="resize: none;border-style:groove;width:100%;height:100%;" class="tablelight" ></textarea></td>
		</tr>
		<tr bgcolor=gray>
			<td colspan=2 height=35 class=tablebold align=center width="100%"><input type="button" name='sub_but' class="tablebold" value="Submit" onclick="isValid(this)"></td>
		</tr>
	</table>
</td></tr></table>
</form>
</body>
</html>
