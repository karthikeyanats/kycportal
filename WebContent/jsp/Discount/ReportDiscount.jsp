<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Discount.DiscountAction" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Discount Category wise Student</title>

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language="JavaScript">

function gostudentview(obj)
{
	document.discountform.discountcategoryname.value=obj.getAttribute("discountcategoryname");
	document.discountform.studentapprovalid.value=obj.getAttribute("studentapprovalid");
	document.discountform.action= "ReportDiscountStudent.jsp";
	document.discountform.submit();
}

 
function goback() 
{
document.discountform.action= "transportroute.jsp";
document.discountform.submit();
}

function printfun()
{
	
//window.open("PrintPreview categorystudentlist.jsp?transportcategoryname="+document.feestypeform.transportcategorynames.value+"&transportcategoryid="+document.feestypeform.transportcategoryids.value+"&sessionname="+document.feestypeform.sessionname.value+"&sessionid="+document.feestypeform.sessionid.value+"","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
window.open("PrintPreview ReportDiscount.jsp","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
}

</script>
</head>

<body>
<form name="discountform" method="post" action="">

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
                 <h2>Discount / Discount Category Report / Session wise Students </h2>

<%@ page import="java.util.*"%>

<%
ArrayList Discountreport=new ArrayList();
HashMap sessionMap=new HashMap();
String roleids="";
String instituteid=null;
if(session.getValue("instituteid")!=null){
	instituteid=(String)session.getValue("instituteid");
} 
Discountreport=query_object.getdiscountcategoryreport(instituteid);
%>
<form name="discountform" method="post" action="">
<input type="hidden" name="sessionid" value="">
<input type="hidden" name="sessionname" value="">
<input type="hidden" name="discountcategoryid" value="">
<input type="hidden" name="studentapprovalid" value="">
<input type="hidden" name="discountcategoryname" value="">



<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%">Sl.No</th>
        	<th scope="col" class="rounded" width="40%">Discount Category Name  </th>
  	        
  	        <th scope="col" class="rounded-q4" width="35%">No.of.Students </th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% 
				int count=0;int catcount=0;
				if(Discountreport!=null && Discountreport.size()>0)
				{							 
					
					for(int i=0;i<Discountreport.size();i++)
					{
						count++;
						out.print("<tr valign='top'>");
						sessionMap=(HashMap)Discountreport.get(i);
						catcount=Integer.parseInt(sessionMap.get("count")+"");   
						out.print("<td class='tablelight' valign='top'>"+(count)+".</td>");
						out.print("<td class='tablelight' valign='top'>"+sessionMap.get("discountcategoryname")+"</td>");
						if(catcount!=0)
							out.print("<td class='tablelight' valign='top'><a href='#' discountcategoryname="+sessionMap.get("discountcategoryname")+"   studentapprovalid="+sessionMap.get("studentapprovalid")+"  onclick='gostudentview(this)'>"+sessionMap.get("count")+"</a></td>");
						else
							out.print("<td class='tablelight' valign='top'>"+sessionMap.get("count")+"</td>");
				} 
				}
				else
				{ 
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");


				} 
				

				%>
			
			<tr>
				<TD align="center" colspan="3">
					<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>
				</TD>
			</tr>
			
		</table>
			
	<tr>
	<td>
			
</td></tr>	

</TABLE>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
     
<%@ include file="../include/footer.jsp" %>

</div>
 
    </form>
	
</body>
</html>