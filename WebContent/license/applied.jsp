<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<HTML>
<HEAD>
<title>i-Grandee Product License Status</title>
</HEAD>
<BODY BGCOLOR="#FFFFFF" TEXT="#000000" topmargin="0" leftmargin="0" rightmargin="0" bottommargin="0">
	<FORM name="loginForm" method=post>
		<Table border="0" width="60%" align="center" height="60%">
			<%
				/*out.println("ContextPath:"+request.getContextPath());
				out.println("ServerPath:"+request.getServerName());
				out.println("ServerPort:"+request.getServerPort());
				out.println("Protocol:"+request.getProtocol());*/
				StringBuffer buff = new StringBuffer();
				buff.append("://");
				buff.append(request.getServerName()+":"+request.getServerPort()+request.getContextPath());
				
				//out.println("AuthType:"+request.getAuthType()+"#"+request.isSecure());				
			%>
			<tr><td align="center">License applied successfully !!! &nbsp;<a href="<%= request.isSecure() ? "https"+(buff.toString()) : "http"+(buff.toString()) %>">Home</a></td></tr>			
		</table>
	</FORM>
</BODY>
</HTML>