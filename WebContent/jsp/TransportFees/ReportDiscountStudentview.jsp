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
	document.discountform.sessionid.value=obj.getAttribute("sessionid");
	document.discountform.discountcategoryid.value=obj.getAttribute("discountcategoryid");
	document.discountform.action= "ReportDiscountCategory.jsp";
	document.discountform.submit();
}

 
function backfun()
{
document.discountform.action= "ReportDiscountStudent.jsp";
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
         <h2>Report / Session wise Students / Discount Category wise Students / Student View</h2>
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
String sessionid=null;String discountcategoryid=null;

if(request.getParameter("sessionid")!=null)
{
	sessionid=(String)request.getParameter("sessionid");
	
}

if(request.getParameter("discountcategoryid")!=null)
{
	discountcategoryid=(String)request.getParameter("discountcategoryid");
	
}

%>
<form name="discountform" method="post" action="">
<input type="hidden" name="sessionid" value="<%=sessionid%>">
<input type="hidden" name="discountcategoryid" value="">
<%
if(request.getParameter("sessionname")!=null)
%>
<input type="hidden" name="sessionname" value="<%=request.getParameter("sessionname")%>">

<table>
<tr>
    	<td>
    	<%
		if(request.getParameter("sessionname")!=null)
		%>
    	
			 <label>Year of session : &nbsp;</label> <%=request.getParameter("sessionname")%></h3> 
	 </td>
    	<td>
    	<%
			if(request.getParameter("discountcategoryname")!=null)
		%>
    	
    		<h3>Discount Category Name: &nbsp;<%=(request.getParameter("discountcategoryname"))%></h3>
    	</td>
    	
    </tr>
</table>	
<%
idList=query_object.getstudentid(sessionid,discountcategoryid); 
if(idList!=null){
for(int k=0;k<idList.size();k++){		
	innermap=(HashMap)idList.get(k);
		studentList=query_object.getstudentprofileview(innermap.get("studentapprovalid")+"");
%>
		<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="12%">Sl No.</th>
					            <th scope="col" class="rounded" width="30%">Student Name</th>
					            <th scope="col" class="rounded"	width="20%">Roll No</th>
					            <th scope="col" class="rounded"	width="18%">Mobile No</th>
					            <th scope="col" class="rounded-q4" width="20%">Email</th>
					        </tr>
					    </thead>
						<tfoot>
						   	<tr>
						       	<td colspan="4" class="rounded-foot-left"><em></em></td>
						       	<td class="rounded-foot-right">&nbsp;</td>
						    </tr>
						</tfoot>					    
							<%
							
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
								out.print("<td>"+j+".</td>");
								out.print("<td><a href='#studentprofile' name='studentprofile' personid='"+personid+"' rollno='"+rollno+"' onclick='studentprofileview(this)' >"+Studname+"</a></td>");
								out.print("<td>"+rollno+"</td>");
								out.print("<td>"+mobilenumber+"</td>");
								out.print("<td><a href=mailto:'"+emailid+"'>"+emailid+"</a></td>");
								out.print("</tr>");
							}
						}
						else
						{
							//out.print("<tr><td colspan='3' align='center'> Data Not Found</td></tr>");
							out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
						}
							out.print("</table>");
							
							
							}
						}
						%>
					
				

		</table>
				
	
	
	 				 		<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	 
		  
		  	
	<tr><td>
			
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