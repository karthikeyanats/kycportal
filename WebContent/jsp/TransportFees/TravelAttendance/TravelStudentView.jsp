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
document.discountform.action= "TravelStageView.jsp";
document.discountform.submit();
}

function CheckFund(obj)
{
	chkid = obj.getAttribute("chkid");
	alert("chkid==>>>"+chkid);
	if(obj.checked)
	{
		
	}
	
}


var checkflag = false;
var a=0;
function CheckFun(obj)
{
	if(obj.checked)
		a++;
	else
		a--;


}

function allocatefun()
{
		var test=false;
			
			
		if(document.discountform.chkid.length==undefined)
		{
			if(document.discountform.chkid.checked==true)
			{
				if(confirm("Are you sure want to Add the Student?"))
				{
				document.discountform.action="./TravelStudentSubmit.jsp";
    	  		document.discountform.submit();
    	  		}
			}
			else
			{
				alert("Select CheckBox")
			}
		}
		else
		{
  		for(i=0;i<document.discountform.chkid.length;i++)
  		{
  			if(document.discountform.chkid[i].checked==true)
  			{
  			        test=true;
  			}

  		}
  		if(test==true )
		{
			if(confirm("Are you sure want to Add the Student?"))
			{
    	   	document.discountform.action="./TravelStudentSubmit.jsp";
    	  	document.discountform.submit();
    	  	}

        }
        else
        {
			alert("Select CheckBox")
		}
	}

}


function selectallfun(obj)
{
	//alert("Calling Function");

	if(obj.checked){
		
		if(document.discountform.chkid.length)
		for(var x=0;x<document.discountform.chkid.length;x++)
		{
			document.discountform.chkid[x].checked=true;
		}
	}
	else{

		if(document.discountform.chkid.length)
		for(var x=0;x<document.discountform.chkid.length;x++)
		{
			document.discountform.chkid[x].checked=false;
		}
		
		
	}
}



</script>
</head>

<body>
<form name="discountform" method="post" action="">

<div id="main_container">

	<div class="header">
	
<%@ include file="../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
           <h2>Transport Fees / Travel Attendance / Category View / Route List / Stage List / Student View</h2>
         
<%@ page import="java.util.*"%>

<%
ArrayList studentList=new ArrayList();
ArrayList containList=new ArrayList();
HashMap hashmap=new HashMap();
HashMap innermap=new HashMap();
String roleids="";
String transportcategoryname = request.getParameter("transportcategoryname");
String transportcategoryid = request.getParameter("transportcategoryid");
String routename = null; 
routename = request.getParameter("routename");
String instituteid=null;
String sessionname = (String)session.getValue("sessionname");
if(session.getValue("instituteid")!=null){
	instituteid=(String)session.getValue("instituteid");
} 
String sessionid=null;String transportstageid=null;



if(request.getParameter("transportstageid")!=null)
{
	transportstageid=(String)request.getParameter("transportstageid");
	
}
String studentapprovalid=null;String[] studentapprovalidarr=null;
%>
<form name="discountform" method="post" action="">

<input type="hidden" name="transportstageid" value="">
<input type="hidden" name="transportcategoryid" value="<%=transportcategoryid%>">
<input type="hidden" name="routename" value="<%=routename%>">
<input type="hidden" name="transportstagename" value="<%=(request.getParameter("transportstagename"))%>">
<input type="hidden" name="transportrouteid" value="<%=(request.getParameter("transportrouteid"))%>">

 <jsp:useBean id="catid" scope="page" class="com.iGrandee.TransportFees.TransportRouteAction" />
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>

<table width="100%" >
				<tr>
			    		<td width="15%">  
			    			<h4></>Year of Session: </h4>
			    		</td>
			    		<td>
			    			<%=sessionname %>
			    		</td>
			    		<td width="15%"> 
			    			<h4></>Category Name: </h4>
			    		</td>
			    		<td> 
			    			
			    			
			    			<%
			    			
			    			 FeesSettingsAction  YearofSession = new FeesSettingsAction();
			    			
			    			if(transportcategoryid.equals("Term 1") || transportcategoryid.equals("Term 2") || transportcategoryid.equals("Term 3"))
			    			{	
			    				transportcategoryname = 	YearofSession.gettermname(transportcategoryid);
			    				//out.println("transportcategoryname==>>"+transportcategoryname);
			    			%>
			    				<%=transportcategoryid%>
			    				
			    				
							<%
			    			}else
			    			{	
							transportcategoryname = 	YearofSession.getmonthname(transportcategoryid);
							out.print(transportcategoryname);
			    			}
							%>
			    			
			    		</td>
			    	</tr>
			    	<tr>
			    	<td>
			    		<h4>Route Name:</h4>
			    	</td>
			    	<td>
			    		<%=routename %>
			    	</td>
			    	<td>
			    		<h4>Stage Name:</h4>
			    	</td>
			    	<td>
			    		<%=(request.getParameter("transportstagename"))%>
			    	</td>
			    	</tr>
			    	
			</table>
				


<%-- <table width="100%">
<tr>
    	
    	<td  align="left">
    	<%
			if(request.getParameter("routename")!=null)
		%>
    	
    		<h3>Route Name: &nbsp;<%=(request.getParameter("routename"))%></h3>
    	</td>
    	
<td>
    	<%
			if(request.getParameter("transportstagename")!=null)
		%>
    	
    		<h3>Stage Name: &nbsp;<%=(request.getParameter("transportstagename"))%></h3>
    	</td>
    </tr>
</table>	  --%>

		<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	 <th scope="col" class="rounded-company" width="5%">SL.No</th>
					        	 <th scope="col" class="rounded"	width="20%">Roll No</th>
					        	 <th scope="col" class="rounded" width="20%">Student Name</th>					        	 
					            <th scope="col" class="rounded" width="20%">Standard Name</th>
					            <th scope="col" class="rounded" width="20%">Section Name</th>		            
					            <th scope="col" class="rounded-q4"	width="20%">select All <input type="checkbox" name="chkAll" value='' onClick="selectallfun(this)"></th>
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
								out.print("<td>"+count+".</td>");
								out.print("<td>"+rollno+"</td>");
								out.print("<td>"+Studname+"</td>");
								out.print("<td>"+hashmap.get("standardname")+"</td>");
								out.print("<td>"+hashmap.get("sectionname")+"</td>");
								//out.print("<td><input type='checkbox' chkid='"+count+"' name='chkid' value='"+studentapprovalidarr[k]+"@"+count+"' onClick='CheckFun(this)'></td>");
								out.print("<td><input type='checkbox' name='chkid' value='"+studentapprovalidarr[k]+"@"+count+"' onClick='CheckFun(this)'></td>");
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
						<tr>
							<td colspan="6" align="right">
								<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
								<a href="#" class="bt_green" onClick='allocatefun()'><span class="bt_green_lft"></span><strong>Save</strong><span class="bt_green_r"></span></a>
							</td>
						</tr>		
				
		</table>
	
	 				 		
	</form>
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
     
<%@ include file="../../include/footer.jsp" %>

</div>
 
    </form>
	
</body>
</html>