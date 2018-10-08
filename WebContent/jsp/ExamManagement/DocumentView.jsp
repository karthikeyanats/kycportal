<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title> Operation Result | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
function backtopagefun()
{
	document.operationform.action	= "QuestionGenerateView.jsp";
	document.operationform.submit();
}
</script>
</head>
<body>
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
	<form name="operationform"  id="operationform" method="post">
	<%@ page import='com.iGrandee.ExamManagement.IGPdfWriter,com.iGrandee.ExamManagement.IGRtfWriter' %>
	
		<%
			int rows 			= 0;
			String type			= request.getParameter("typetogen");
	    	String templateid	= request.getParameter("template");
	    	String templatename	= request.getParameter("templatename");
			IGPdfWriter pdf		= new IGPdfWriter();
			IGRtfWriter rtf		= new IGRtfWriter();
			
			try{
				
				if(type != null && type.equals("PDF"))
					pdf.createPdfRtf(type,templateid);
				else
					rtf.createPdfRtf(type,templateid);
				
				rows	= 1;
				
			}catch(Exception e){
				
				rows	= 0;
			}
						
			if(rows >0){
			%>
				<br><br><br><br><h2>Result Info</h2>
				
				<%if(type != null && type.equals("PDF")){%>
					<div class="valid_box">
				        <center>PDF Created Successfully<br><a href='<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=Reports/<%=templatename%>_<%=templateid%>.pdf' target='_new'>View PDF</a></center>
				    </div>
				<%}else{ %>
				
					<div class="valid_box">
				        <center>RTF Created Successfully<br><a href='<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=Reports/<%=templatename%>_<%=templateid%>.rtf' target='_new'>View RTF</a></center>
				    </div>
				
				<% 
				}
			}
			else{
			%>
				<br><br><br><br><h2>Result Info</h2>
			     
				<%if(type != null && type.equals("PDF")){%>
					<div class="error_box">
				        <center>PDF Creation Failed</center>
				    </div>
				<%}else{ %>
				
					<div class="error_box">
				        <center>RTF Creation Failed</center>
				    </div>
			     
			<% 
					}
				}
		%>
		        <a href="#" class="bt_green" onclick="backtopagefun()"><span class="bt_green_lft"></span><strong>Go Back</strong><span class="bt_green_r"></span></a>
		<%
			
			String parameter = "";
			for(java.util.Enumeration e = request.getParameterNames();e.hasMoreElements(); ){
				parameter = (String)e.nextElement();
				if(parameter != null)
				out.print("<input type='hidden' name='"+parameter+"' value='"+request.getParameter(parameter)+"'>");
			}
		%>
		</form>
 </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

	<%@ include file="../include/footer.jsp" %>
    
    
    
    

</div>
</body>
</html>