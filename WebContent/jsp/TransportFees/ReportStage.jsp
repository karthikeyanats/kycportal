<%@page import="org.apache.http.auth.NTCredentials"%>
<jsp:useBean id="query_object" scope="page" class="com.iGrandee.TransportFees.TransportStageAction" />
 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Stage Report / Session wise Students</title> 

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>  
<script language="JavaScript">

function gostudentview(obj)
{
	document.discountform.routename.value=obj.getAttribute("routename");
	document.discountform.studentapprovalid.value=obj.getAttribute("studentapprovalid");
	document.discountform.transportstagename.value=obj.getAttribute("transportstagename");
	document.discountform.action= "ReportStageStudentview.jsp";
	document.discountform.submit();
} 

 
function goback() 
{
document.discountform.action= "transportroute.jsp";
document.discountform.submit();
}

function printfun()
{
window.open("PrintPreview ReportStage.jsp","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
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
                 
                <h2>Transport Fees / Stage Report  / Stage wise Students </h2>
                 

<%@ page import="java.util.*"%>

<%
ArrayList StageList=new ArrayList();
HashMap sessionMap=new HashMap();
String roleids="";
String instituteid=null;
if(session.getValue("instituteid")!=null){
	instituteid=(String)session.getValue("instituteid");
} 


StageList=query_object.getstagecounts(instituteid); 
%>
<form name="discountform" method="post" action="">
<input type="hidden" name="sessionid" value=""/>
<input type="hidden" name="sessionname" value=""/>
<input type="hidden" name="discountcategoryid" value="">

 

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%">Sl.No</th>
<!--         	<th scope="col" class="rounded" width="30%">Route Name</th>
 -->        	<th scope="col" class="rounded" width="30%">Stage Name</th>
        	
        	<th scope="col" class="rounded-q4" width="20%">No.of.Students </th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<% 
				int count=0;int nost=0;
				String temp_transportrouteid = "";
				if(StageList!=null && StageList.size()>0)	
				{	String as=request.getContextPath();						

					for(int i=0;i<StageList.size();i++)
					{
						count++;
						//out.print("<tr valign='top'>");
						sessionMap=(HashMap)StageList.get(i);
						String transportrouteid = (String)sessionMap.get("transportrouteid");
						
						if(!temp_transportrouteid.equals(transportrouteid)){
							
							out.print("<tr><td class='tablelight' valign='top' colspan=3><a class=tablebold>Route Name :</a> "+sessionMap.get("routename")+"</td></tr>");
							temp_transportrouteid = transportrouteid;
							count=1;
							}
						nost=Integer.parseInt(sessionMap.get("count")+"");
						out.print("<tr><td class='tablelight' valign='top'>"+(count)+"</td>");

						
						out.print("<td class='tablelight' valign='top'>"+sessionMap.get("transportstagename")+"</td>");
						
						if(nost!=0)
							out.print("<td class='tablelight' valign='top'><a href='#' routename='"+sessionMap.get("routename")+"' transportstagename='"+sessionMap.get("transportstagename")+"' studentapprovalid="+sessionMap.get("studentapprovalid")+" onclick='gostudentview(this)'>"+sessionMap.get("count")+"</a></td>");
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
				<td align="right" colspan="4">
					<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>
				</td>
			</tr>
			
		</table>
				
	
	
	 
		  
		  	
	<tr><td>
			
</td></tr>	

</TABLE>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->

<input type="hidden" name="transportstagename" value=""/>
<input type="hidden" name="studentapprovalid" value=""/>
<input type="hidden" name="routename" value=""/>


    <div class="clear"></div>
    </div> <!--end of main content-->
     
<%@ include file="../include/footer.jsp" %>

</div>
 
    </form>
	
</body>
</html>