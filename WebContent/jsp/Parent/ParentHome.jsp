<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.parenthome.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script language='javascript'>
	
	function callStudent(obj){
		
		document.workallotment.userid.value = obj.getAttribute("userid");
		document.workallotment.action 		= "TimeTable.jsp";
		document.workallotment.submit(); 
	}	

</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<!--   include file="../include/PlainHeader.jsp"  -->
<%@ include file="../include/ParentHeader.jsp" %>



    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.parenthome.entryheading") %></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Parent.ParentHome"%>



	<%
		ParentHome home		= new ParentHome();
		HashMap hashmap		= null;	
		HashMap hashmap1	= null;	
		String parentid		= (String)session.getValue("parentid");
		ArrayList details	= home.loadChildrenDetails(parentid);
		ArrayList topper	= null;
		ArrayList weaker	= null;
		String studentid	= "";
		String studentid1	= "";

		
		
	%>
	<form name='workallotment' method='post'>
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' >

								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.parenthome.StudentDetails") %></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='2'>								
							
											<%
												
												if(details != null && details.size()>0){
													for(int y=0;y<details.size();y++){
														
														hashmap		= (HashMap)details.get(y);
														studentid	= (String)hashmap.get("studentallocationid");
														out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
														out.print("<tr><td rowspan='6' width='20%'><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+hashmap.get("imagepath")+"' alt='Student Photo' title='' border='0'  width='120' height='120'/></td><td width='17%' class='tablebold'>"+bundle.getString("label.parenthome.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+hashmap.get("studentname")+"</td></tr>");
														out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.AcademicYear")+"</td><td  class='tablebold'>:</td><td>"+hashmap.get("sessionname")+"</td></tr>");
														if(hashmap.get("groupname") == null)
															out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.StandardName")+"</td><td class='tablebold'>:</td><td>"+hashmap.get("standardname")+"</td></tr>");
														else
															out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.StandardName")+"</td><td class='tablebold'>:</td><td>"+hashmap.get("standardname")+"&nbsp;&nbsp;[&nbsp;"+hashmap.get("groupname")+"&nbsp;]</td></tr>");												
														out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.SectionName")+"</td><td class='tablebold'>:</td><td>"+hashmap.get("sectionname")+"</td></tr>");
														out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.BoardName")+"</td><td class='tablebold'>:</td><td>"+hashmap.get("boardname")+"</td></tr>");
														out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.RollNo.")+"</td><td class='tablebold'>:</td><td>"+hashmap.get("rollno")+"</td></tr>");
														
														topper 	= home.checkStandardTopperWeeker((String)hashmap.get("standardscheduleid"),"desc","3");
														weaker 	= home.checkStandardTopperWeeker((String)hashmap.get("standardscheduleid"),"asc","10");
														
														if(topper != null && topper.size()>0){
															for(int x=0;x<topper.size();x++){

																hashmap1	= (HashMap)topper.get(x);
																studentid1	= (String)hashmap1.get("studentallocationid");
																if(studentid1 != null && studentid != null && studentid1.equals(studentid)){
																	out.print("<tr style='display:none'><td colspan='4' class='tablebold' ><div class='valid_box'><center>"+bundle.getString("label.parenthome.message1")+ hashmap1.get("totalmark")+"."+bundle.getString("label.parenthome.message2")+(x+1)+"</center></div></td></tr>");
																	break;
																}
															}
														}
														
														if(weaker != null && weaker.size()>0){
															for(int x=0;x<weaker.size();x++){

																hashmap1	= (HashMap)weaker.get(x);
																studentid1	= (String)hashmap1.get("studentallocationid");
																if(studentid1 != null && studentid != null && studentid1.equals(studentid)){
																	out.print("<tr style='display:none'><td colspan='4' class='tablebold'><div class='error_box'><center>"+bundle.getString("label.parenthome.message3")+hashmap1.get("totalmark")+bundle.getString("label.parenthome.message2")+(x+1)+"</center></div></td></tr>");
																	break;
																}
															}
														}	
														//System.out.println("hashmap.get('studentallocationstatus')"+hashmap.get("studentallocationstatus"));
														if(hashmap.get("studentallocationstatus").equals("A"))
														{
														out.print("<tr><td colspan='4' align='right'><a href='#' class='bt_blue' userid='"+hashmap.get("userid")+"' onclick='callStudent(this)'><span class='bt_blue_lft'></span><strong>"+bundle.getString("button.parenthome.Enter")+"</strong><span class='bt_blue_r'></span></td></tr>");
														}
														else if(hashmap.get("studentallocationstatus").equals("C"))  
														{
														out.print("<tr><td colspan='4' class='tablebold' ><div class='warning_box'><center>"+bundle.getString("label.parenthome.message4")+"</center></div></td></tr>");
														}
														out.print("</table>");
													}
												}
											%>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
		<input type='hidden' name='userid' value=''>
		
	</form>

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>