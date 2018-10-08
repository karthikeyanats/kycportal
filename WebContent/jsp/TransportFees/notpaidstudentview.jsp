<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.FeesSettingsAction" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 
<head>
<title>Traansport Student View</title>

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
	
	document.discountform.transportrouteid.value=obj.getAttribute("transportrouteid");
	document.discountform.action= "ReportRouteStudent.jsp";
	document.discountform.submit();
}

 
function backfun()
{
document.discountform.action= "PaidcatList.jsp";
document.discountform.submit();
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
               <h2>Transport Fees / Paid Report / Session List / Category List /Not Paid Student View </h2>
         
<%@ page import="java.util.*"%> 

<%
ArrayList studentList=new ArrayList();
ArrayList idList=new ArrayList();
HashMap hashmap=new HashMap();
HashMap innermap=new HashMap();
String roleids="";
String instituteid=null;
if(session.getValue("instituteid")!=null){
	instituteid=(String)session.getValue("instituteid");
} 
String sessionid=null;String transportrouteid=null;
ArrayList paidid=null;

%>

<table>
<tr>
    	<td>
    	<%
    	out.println("<input type='hidden' name='institutetransporttypeid' value="+request.getParameter("institutetransporttypeid")+">");
    	out.println("<input type='hidden' name='sessionid' value="+request.getParameter("sessionid")+">");
    	out.println("<input type='hidden' name='transportcategoryid' value="+request.getParameter("transportcategoryid")+">"); 
    	 
		if(request.getParameter("transportcategoryname")!=null)
		%>
    	
			 <h3>Category : &nbsp;<%=(request.getParameter("transportcategoryname")) %></h3> 
	 </td>
    	
    	
    </tr>
</table>	 
<%

%>
		<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	 <th scope="col" class="rounded-company" width="5%">SL.No</th> 
					            <th scope="col" class="rounded" width="25%">Student Name</th>
					            <th scope="col" class="rounded"	width="20%">Roll No</th>
					            <th scope="col" class="rounded"	width="20%">Mobile No</th>
					            <th scope="col" class="rounded-q4" width="30%">Email</th>
					        </tr>
					    </thead>
						<tfoot>
						   	<tr>
						       	<td colspan="4" class="rounded-foot-left"><em></em></td>
						       	<td class="rounded-foot-right">&nbsp;</td>
						    </tr>
						</tfoot>					    
							<%
							paidid=	query_object.getpayecount(request.getParameter("transportcategoryid"));
							
							if(paidid!=null){
								int count=0;
								for(int k=0;k<paidid.size();k++)
								{
									innermap=(HashMap)paidid.get(k);
									
									if(!innermap.get("count").equals("paid")){
										
										out.println("<input type='hidden' name='paidno' value='"+innermap.get("studentapprovalid")+"'/>");
											count++;
									studentList=query_object.getstudentprofileview(innermap.get("studentapprovalid")+"");
									if(studentList != null && studentList.size()>0){
										for(int y=0,j=1;y<studentList.size();y++,j++){
										 
											hashmap			= (HashMap)studentList.get(y);
											String Studname		= (String)hashmap.get("uname");
											String rollno		= hashmap.get("rollno")+"";
											if(rollno.equals("null")){
												rollno="<font color=red><i>-NYG-</i></font>";
												//rollNoNote = rollNoNote+1;
											}
											String mobilenumber		= hashmap.get("mobilenumber")+"";
											if(mobilenumber.equals("null"))
												mobilenumber="-";
											String emailid		= hashmap.get("emailid")+"";
											if(emailid.equals("null"))
												emailid="-";								
											
											String studallocationid	= (String)hashmap.get("studentallocationid");
											String personid	= (String)hashmap.get("personid");

											out.print("<tr>");
											out.print("<td>"+count+"</td>");
											out.print("<td>"+Studname+"</td>");
											out.print("<td>"+rollno+"</td>");
											out.print("<td>"+mobilenumber+"</td>");
											out.print("<td><a href=mailto:'"+emailid+"'>"+emailid+"</a></tad>");
											out.print("</tr>");
										}
									}
									else
									{
										//out.print("<tr><td colspan='3' align='center'> Data Not Found</td></tr>");
										out.println("<tr align='center'><td align='left'>"+count+"</td><td colspan='8' class='tablebold'><font color='red'>Data Not Found</font></td></tr>");
									}
										//out.print("</table>");
										
										
										
			
										
									}
									
									
								}
								
								
							}
							

							
						%>
					
				

		</table>
				
	 	<input type="hidden" name="sessionname" value="<%=request.getParameter("sessionname")%>"/>
	
	
	 				 		<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	
	</form>
		  
	
		  	
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
     
<%@ include file="../include/footer.jsp" %>


 
    
</body>
</html>