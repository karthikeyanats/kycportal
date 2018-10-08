<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.diarycreation.title") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
	
	function callEdit(obj){
		if(confirm("Do you want to Update the Diary...?"))
			{
				document.workallotment.dairyid.value = obj.getAttribute("studentdiaryid");
				document.workallotment.action = "DairyEdit.jsp";
				document.workallotment.submit();
			}
	
	}
	
	function callEvaluate(obj){
		
		document.workallotment.dairyid.value 	= obj.getAttribute("studentdiaryid");
		document.workallotment.dairyname.value	= obj.getAttribute("dairyname");
		document.workallotment.action = "TrackDairy.jsp";
		document.workallotment.submit();
	
	}	
	
	function goBack(){
		
		document.workallotment.action = "DairyCreation.jsp";
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

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.diarycreation.rootpath1") %></h2>

	<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Dairy.Dairy"%>

	<%
		
		String sessionid		= (String)session.getValue("sessionid");
		String sessionname		= (String)session.getValue("sessionname");
		String standardid		= request.getParameter("standard");
		String sectionid		= request.getParameter("section");
		String subjectid		= request.getParameter("subject");
		String sectionname		= request.getParameter("sectionname");
		String subjectname		= request.getParameter("subjectname");
		String standardname		= request.getParameter("standardname");
		Dairy	dairy			= new Dairy();
		HashMap	hashmap			= null;
		ArrayList questionList	= dairy.loadDairy(subjectid,sectionid);
	
	%>
	
	<form name='workallotment' method='post'>
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.diarycreation.DiaryDetails") %></th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>							
					<table  border=0 bordercolor='blue' align="center" width="90%" cellspacing='0' cellpadding='5'>

						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diarycreation.AcademicYear") %></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=sessionname%>
							</td>
						</tr>	
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diarycreation.Standard") %></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=standardname%>
							</td>
						</tr>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diarycreation.Subject") %></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=subjectname%>
							</td>
						</tr>	
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diarycreation.Section") %></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=sectionname%>
							</td>
						</tr>									
					</table>
				</td>
			</tr>
		</table>
		<br>
							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.diarycreation.S.No") %>.</th>
		            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.diarycreation.DiaryName") %></th>
		            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.diarycreation.Description") %>sss</th>
		            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.diarycreation.DiaryDate") %></th>
		            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.diarycreation.SubmissionDate") %></th>
		            <th scope="col" class="rounded-q4" width="5%"><%=bundle.getString("label.diarycreation.Edit") %></th>
		            
		        </tr>
		    </thead>

			<%
				if(questionList != null && questionList.size()>0){
					for(int y=0;y<questionList.size();y++){
						hashmap		= (HashMap)questionList.get(y);
						
						String work= (String) hashmap.get("workdetails");
						
						out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subject")+"</td><td>"+hashmap.get("workdetails")+"</td>");
						out.print("<td>"+hashmap.get("dairydate")+"</td><td>"+hashmap.get("dairysubmissiondate")+"</td>");
						out.print("<td><a href='#' studentdiaryid='"+hashmap.get("studentdiaryid")+"' onclick='callEdit(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_edit.png' alt='Edit' title='Edit' border='0' /></a></td></tr>");
					}
				}
				else
					out.println("<tr align='center' class='tablebold'><td colspan='6'><a class'nodata'><font color=red>Data Not Found</font></a></td></tr>");
			%>
		</table>
			     	
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.diarycreation.Back") %></strong><span class="bt_blue_r"></span></a>
				
		
		<input type='hidden' name='session' 			value='<%=sessionid%>'/>
		<input type='hidden' name='sessionname' 		value='<%=sessionname%>'/>
		<input type='hidden' name='section' 			value='<%=sectionid%>'/>
		<input type='hidden' name='subject' 			value='<%=subjectid%>'/>
		<input type='hidden' name='standard' 			value='<%=standardid%>'/>
		<input type='hidden' name='standardname' 		value='<%=standardname%>'/>
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'/>
		<input type='hidden' name='sectionname' 		value='<%=sectionname%>'/>
		<input type='hidden' name='dairyid' 			value=''/>
		<input type='hidden' name='dairyname' 			value=''/>
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>