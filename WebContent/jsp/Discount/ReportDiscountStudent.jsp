<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportStageAction" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Stage wise Students</title>

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
	document.discountform.transportstageid.value=obj.getAttribute("transportstageid");
	document.discountform.action= "ReportDiscountCategory.jsp";
	document.discountform.submit();
}

 
function backfun()
{
document.discountform.action= "ReportDiscount.jsp";
document.discountform.submit();
}

/* function printfun()
{
alert("Calling");	
window.open("PrintPreview ReportDiscountStudent.jsp?studentapprovalid="+document.discountform.studentapprovalid.value"","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
} */

function printfun()
{
	//alert("Print Fun");
	//alert(document.discountform.discountcategoryname.value);
	window.open("PrintPreview ReportDiscountStudent.jsp?studentapprovalid="+document.discountform.studentapprovalid.value+"&discountcategoryname="+document.discountform.discountcategoryname.value+"","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
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
           <h2>Discount / Discount Category Report / Session wise Students / Discount Category wise Students</h2>
         
<%@ page import="java.util.*"%>

<%
ArrayList studentList=new ArrayList();
ArrayList containList=new ArrayList();
HashMap hashmap=new HashMap();
HashMap innermap=new HashMap();
String roleids="";
String instituteid=null;
if(session.getValue("instituteid")!=null){
	instituteid=(String)session.getValue("instituteid");
} 
String sessionid=null;String transportstageid=null;

String discountcategoryname=null;

if(request.getParameter("discountcategoryname")!=null)
{
	discountcategoryname=(String)request.getParameter("discountcategoryname");
	
}
String studentapprovalid=null;String[] studentapprovalidarr=null;
%>

<input type="hidden" name="transportstageid" value="">
<input type="hidden" name="discountcategoryname" value="<%=discountcategoryname%>">

<table width="100%">
<tr>
    	
    	<td  align="left">
    	<%
			if(request.getParameter("discountcategoryname")!=null)
		%>
    	
    		<h3>Discount Category Name: &nbsp;<%=discountcategoryname%></h3>
    	</td>
    </tr>
</table>	 
<%

%>
		<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	 <th scope="col" class="rounded-company" width="5%">SL.No</th>
					        	 <th scope="col" class="rounded" width="20%">Section Name</th>
					        	 
					            <th scope="col" class="rounded" width="20%">Student Name</th>
					            <th scope="col" class="rounded" width="20%">Standard Name</th>
					            
					            <th scope="col" class="rounded"	width="20%">Roll No</th>
					            <th scope="col" class="rounded-q4"	width="20%">Mobile No</th>
					        </tr>
					    </thead>
						<tfoot>
						   	<tr>
						       	<td colspan="5" class="rounded-foot-left"><em></em></td>
						       	<td class="rounded-foot-right">&nbsp;</td>
						    </tr>
						</tfoot>					    
							<%
							studentapprovalid=request.getParameter("studentapprovalid");
							studentapprovalidarr=studentapprovalid.split(","); 
							if(studentapprovalidarr!=null){   
								int count=0;
							for(int k=0;k<studentapprovalidarr.length;k++){	
							studentList=query_object.getstudentstandard(studentapprovalidarr[k]);
						if(studentList != null && studentList.size()>0){
							for(int y=0,j=1;y<studentList.size();y++,j++){
								count++;
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
								out.print("<td>"+hashmap.get("sectionname")+"</td>");
								
								out.print("<td>"+Studname+"</td>");
								out.print("<td>"+hashmap.get("standardname")+"</td>");
								
								out.print("<td>"+rollno+"</td>");
								out.print("<td>"+mobilenumber+"</td>");
								out.print("</tr>");
							}
						}
						else
						{
							//out.print("<tr><td colspan='3' align='center'> Data Not Found</td></tr>");
							out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
						}
							
							
							
							}
						}
						%>
				
		</table>
	
	 				 		<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	 				 		<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>
	 				 		
	 				 		
	 				 		
	 				 		
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
     
<%@ include file="../include/footer.jsp" %>

</div>
 <input type="hidden" name="studentapprovalid" value="<%=studentapprovalid%>">
    </form>
	
</body>
</html>