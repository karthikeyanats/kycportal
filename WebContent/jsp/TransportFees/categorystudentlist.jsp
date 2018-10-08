<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.iGrandee.TransportFees.FeesSettingsAction"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.examnamelist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
function studentview(obj){
	document.feestypeform.transportcategoryname.value=obj.getAttribute("transportcategoryname");
	document.feestypeform.transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feestypeform.action = "studentview.jsp"
	document.feestypeform.submit(); 
} 

function gonotpaid(obj){
	document.feestypeform.transportcategoryname.value=obj.getAttribute("transportcategoryname");
	document.feestypeform.transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feestypeform.action = "notpaidstudentview.jsp"
	document.feestypeform.submit(); 
} 

function paydetail(obj)
{
	var transportcategoryid = obj.getAttribute("transportcategoryid");
	document.feestypeform.transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feestypeform.transportcategoryname.value=obj.getAttribute("transportcategoryname");
	document.feestypeform.action = "Paidresult.jsp";
	document.feestypeform.submit(); 
}
function showstudents(obj)
{
	var transportcategoryid = obj.getAttribute("transportcategoryid");
	document.feestypeform.transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feestypeform.transportcategoryname.value=obj.getAttribute("transportcategoryname");
	document.feestypeform.action = "listoutstudents.jsp";
	document.feestypeform.submit(); 
	
	}

function backfun()
{
	document.feestypeform.action = "newreport.jsp";
	document.feestypeform.submit(); 
	
	}	
function printfun()
{
	//alert("./printtransportreport.jsp?sessionname="+document.feestypeform.sessionname.value+"&transportcategoryname="+document.feestypeform.req_transportcategoryname.value+"&transportcategoryid="+document.feestypeform.req_transportcategoryid.value+"&institutetransporttypeid="+document.feestypeform.institutetransporttypeid.value+"&sessionid="+document.feestypeform.reqsessionid.value)
	window.open("./printtransportreport.jsp?req_paidstatus="+document.feestypeform.req_paidstatus.value+"&sessionname="+document.feestypeform.sessionname.value+"&transportcategoryname="+document.feestypeform.req_transportcategoryname.value+"&transportcategoryid="+document.feestypeform.req_transportcategoryid.value+"&institutetransporttypeid="+document.feestypeform.institutetransporttypeid.value+"&sessionid="+document.feestypeform.reqsessionid.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
}
	
	/* function printfun()
	{
		//document.feestypeform.action = "printtransportreport.jsp";
			window.open("printtransportreport.jsp?&req_sessionname="+document.approvalForm.req_sessionname.value+"&req_sessionid="+document.approvalForm.req_sessionid.value+"&req_boardid="+document.approvalForm.req_boardid.value+"&req_boardname="+document.approvalForm.req_boardname.value+"&standardpublishid="+document.approvalForm.standardpublishid.value+"&req_sessionstatus="+document.approvalForm.req_sessionstatus.value+"","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")

		window.open("printtransportreport.jsp");
		printtransportreport
		document.feestypeform.submit();
	} */

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
    <h2>Transport Fees   
    <%if(request.getParameter("req_paidstatus").equals("paid")){ %>

     / Paid Student List
    <% %>
    <%}else{ %>
    / Pending Student List
    <%} %>
    </h2>
    
<form name="feestypeform"  method="post">


<% 
String transportfeestypeid = null;
String transportcategoryid = null;
String	studentname = null;
String sessionid    = null;String institutetransporttypeid=null;
sessionid= request.getParameter("sessionid");
String req_paidstatus = request.getParameter("req_paidstatus");
institutetransporttypeid= request.getParameter("institutetransporttypeid");
transportcategoryid= request.getParameter("transportcategoryid");
String transportcategoryname= request.getParameter("transportcategoryname");

//out.println(transportcategoryid);

//out.println(paidstatus);

%>
 <input type="hidden" name="sessionid" value="<%=sessionid%>"/>
		<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
     <thead>
    	<tr>
        	<th scope="col" class="rounded-company" colspan=5>Selected Info</th>
        	<th scope="col" class="rounded-q4" width="30%"></th>
        	</tr></thead>
 
 <tr>
 <td class=tablebold> Session Name :</td><td class=tablelight colspan=3 align=left><%=request.getParameter("sessionname") %></td>
 <td class=tablebold>Category Name :</td><td><%=transportcategoryname%></td>
 </tr>
 </table>
		<br></br>
<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded">Student Name</th>
        	<th scope="col" class="rounded">Roll No.</th>
        	<th scope="col" class="rounded">Standard Name</th>
            <th scope="col" class="rounded">Section Name</th>
                       
        	<!-- <th scope="col" class="rounded-q4">E-Mail</th> -->
        	 <th scope="col" class="rounded-q4">Mobile Number</th> 
        </tr>
    </thead>
    
   <!--  <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> -->
     
     <tbody> 	
     <jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.FeesSettingsAction" />
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>
     		 <%
			     FeesSettingsAction  transportmonth = new FeesSettingsAction();			     
			     ArrayList Loadtransportmonth = null;
			  ArrayList paycountlist=null;
					int payno=0;int notpayno=0;

			     HashMap innermap=null; 
				     try
				     {
				    	 //Loadtransportmonth = transportmonth.categorywiseStudentList(transportcategoryid);
				    	 Loadtransportmonth = transportmonth.categorywiseStudentList(transportcategoryid,sessionid);
				    	 //out.println("Loadtransportmonth===>>"+Loadtransportmonth);
					    	 ArrayList archivalDetails = new ArrayList();
					    	 String temp_transportstageid = "";
					    	 String temp1_transportstageid = "";
					    	 String paid=null; String notpaid= null;
					    	 if(Loadtransportmonth!=null && Loadtransportmonth.size()>0)
								{
					    		 
					    		 for (int i = 0, j = 1; i < Loadtransportmonth.size(); i++) {
								
									HashMap feestypeListMap=(HashMap)Loadtransportmonth.get(i);
									
									String standardname   = (String)feestypeListMap.get("standardname");
									String sectionname   	= (String)feestypeListMap.get("sectionname");
									String studprefix = (String)feestypeListMap.get("prefix");
									String firstname   	= (String)feestypeListMap.get("firstname");
									String middlename   	= (String)feestypeListMap.get("middlename");
									String transportstageid   	= (String)feestypeListMap.get("transportstageid");
									String transportstagename   	= (String)feestypeListMap.get("transportstagename");
									String spaidstatus   	= (String)feestypeListMap.get("paidstatus");
									String lastname   	= (String)feestypeListMap.get("lastname");
									String rollnumber   	= (String)feestypeListMap.get("rollno");
									String mobilenumber   	= (String)feestypeListMap.get("mobilenumber");
									
									if(rollnumber ==null)
										rollnumber = "<i>NYG<i>";
									
									String emailid = (String)feestypeListMap.get("emailid");
									if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
							    		studentname = studprefix+""+firstname+"&nbsp;"+lastname;
							    		else
							    		studentname = studprefix+"&nbsp;"+firstname+"&nbsp;"+middlename+"&nbsp;"+lastname;	
									 
									
									%> 
								<%
								
								
								if(req_paidstatus.equals("paid") && spaidstatus.equals("Paid"))
								{if(!temp_transportstageid.equals(transportstageid))
								{
									out.println("<tr><td colspan=6> <a class=tablebold>Stage Name : </a><a class=tablelight>"+transportstagename+"</a></td></tr>");
									temp_transportstageid= transportstageid;
								} 
									out.println("<tr>");
									
									out.println("<td>"+j+++".</td>");
									out.println("<td>"+studentname+"</td>");
									out.println("<td>"+rollnumber+"</td>");
									out.println("<td>"+standardname+"</td>");								
									out.println("<td>"+sectionname+"</td>");
									
									
									//out.println("<td>"+emailid+"</td>");
									out.println("<td>"+mobilenumber+"</td>");
									
								}
								else if(req_paidstatus.equals("pending")  && spaidstatus.equals("Pending"))
								{if(!temp1_transportstageid.equals(transportstageid))
								{
									out.println("<tr><td colspan=6> <a class=tablebold>Stage Name : </a><a class=tablelight>"+transportstagename+"</a></td></tr>");
									temp1_transportstageid= transportstageid;
								}
									out.println("<tr>");
									out.println("<td>"+j+++".</td>"); 
									out.println("<td>"+studentname+"</td>");
									out.println("<td>"+rollnumber+"</td>");
									out.println("<td>"+standardname+"</td>");								
									out.println("<td>"+sectionname+"</td>");
									/* out.println("<td>"+emailid+"</td>"); */
									out.println("<td>"+mobilenumber+"</td>");
								}
									
									
									
										 
									
										
									out.println("</tr>");
					    		 }
							}
					    	 
					    	 else{
								out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					    	 }
				     }	 
					catch(Exception e){
						
						e.printStackTrace();
						
					}
			     %>
    </tbody>
 </table>
 <input type="hidden" name="transportcategoryid" value=""/>
 <input type="hidden" name="transportcategoryname">
 <input type="hidden" name="institutetransporttypeid" value="<%=institutetransporttypeid%>"/>
 	<input type="hidden" name="sessionname" value="<%=request.getParameter("sessionname")%>"/>
 	<input type="hidden" name="sessionid" value="<%=sessionid%>"/>
 <input type="hidden" name="reqsessionid" value="<%=sessionid%>"/>
  <input type="hidden" name="req_transportcategoryname" value="<%=transportcategoryname %>">
  <input type="hidden" name="req_transportcategoryid" value="<%=transportcategoryid %>">
  <input type="hidden" name="req_paidstatus" value="<%=req_paidstatus %>">
  
</form>  
		<a href="#" class="bt_blue" onclick=backfun()><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_blue" onclick=printfun()><span class="bt_blue_lft"></span><strong>Print </strong><span class="bt_blue_r"></span></a>
		<br></br>
<a class=tablebold>	Note :</a> NYG - Not Yet Generated.
     </div><!-- end of right content-->

  </div>   <!--end of center content -->
    <div class="clear"></div> 
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>