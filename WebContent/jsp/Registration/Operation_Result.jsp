<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
function backtopagefun()
{
	document.operationform.action	= document.operationform.returnurl.value;
	document.operationform.submit();
}
</script>
</head>
<body>
<%@ page language="java" import="java.util.*,java.net.URLDecoder,org.apache.commons.codec.binary.Base64"%>

<div id="main_container">
	<div class="header">
   
    </div>

    <div class="main_content">



    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
		<form name="operationform"  id="operationform" method="post">
		<%
			int rows 			= 0;
				
				try
				{
					rows		= Integer.parseInt(request.getParameter("result"));
						
					if(rows >0){
						
						%>
							<br><br><br><br><h2>Result Info</h2>
							
							<div class="valid_box">
						        <center><%=request.getParameter("message")%></center>
						     </div>
						
						<% 
					}
					else{
					%>
						<br><br><br><br><h2>Result Info</h2>
						<div class="error_box">
					        <center><%=request.getParameter("message") %></center>
					     </div>
					<% }
				%>
				        <a href="#" class="bt_green" onclick="backtopagefun()"><span class="bt_green_lft"></span><strong>Go Back</strong><span class="bt_green_r"></span></a>
				<%
					
					String parameter = "";
					for(java.util.Enumeration e = request.getParameterNames();e.hasMoreElements(); ){
						parameter = (String)e.nextElement();
						if(parameter != null && !(parameter.equals("result") || parameter.equals("message")))
						{String actualvalue = URLDecoder.decode(new String(Base64.decodeBase64(
								((String)request.getParameter(parameter)).getBytes()), "UTF-8"),"UTF-8");
						out.print("<input type='hidden' name='"+parameter+"' value='"+actualvalue+"'>");
						}
						//if(parameter != null && !(parameter.equals("result") || parameter.equals("message")))
						//out.print("<input type='hidden' name='"+parameter+"' value='"+request.getParameter(parameter)+"'>");
					}
			}catch(Exception e){}
				%>
		</form>
 </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

    

</div>
</body>
</html>