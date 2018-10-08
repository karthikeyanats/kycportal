<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.diarycreation.title") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script language='javascript'>

	function goBack(){
		
		document.workallotment.action = "DairyCreation.jsp";
		document.workallotment.submit();
	}
	
	function submitWorks()
	{
		if(check_ForParticularElements(document.workallotment.dairyname,"text",document.workallotment.description,"textarea",document.workallotment.dairydate,"text",document.workallotment.enddate,"text")){

			document.workallotment.action = "DairySubmit.jsp";
			document.workallotment.submit();
		}
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

    <h2><%=bundle.getString("label.diarycreation.rootpath") %></h2>

	<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime"%>

	<%
	
		String sessionid		= (String)session.getValue("sessionid");
		String sessionname		= (String)session.getValue("sessionname");
		String standardid		= request.getParameter("standard");
		String sectionid		= request.getParameter("section");
		String subjectid		= request.getParameter("subject");
		String sectionname		= request.getParameter("sectionname");
		String subjectname		= request.getParameter("subjectname");
		String standardname		= request.getParameter("standardname");
		String todaydate		= DateTime.showTime("calendar");
	
	%>
	
	<form name='workallotment' method='post'>
							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.diarycreation.DiaryCreationDetails") %></th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>							
	
					<table  border=0 bordercolor='blue' align="center" width="90%" cellspacing=0 cellpadding=5>

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
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diarycreation.Subject") %> </td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=subjectname%>
							</td>
						</tr>	
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diarycreation.Section") %> </td>
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
		    
		            <th scope="col" class="rounded-company" align='center' width="98%"><%=bundle.getString("label.diarycreation.DiaryCreation") %></th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>
			<tr>
   				<td colspan=2>
					<table width='100%' cellspacing='0' cellpadding='5'>
						<tr>
							<td class=tablebold width='18%'><%=bundle.getString("label.diarycreation.DiaryName") %><font color=red>*</font></td>
							<td class=tablebold width="1%">:</td>
							<td width='83%' colspan='4'><input type='text' 		name='dairyname' 		size='50' validate='Dairy Name'	maxlength='400'></td>
						</tr>
						<tr valign='top'>
							<td class=tablebold><%=bundle.getString("label.diarycreation.Description") %><font color=red>*</font></td>
							<td class=tablebold>:</td>
							<td colspan='4'><textarea class='tablelight' name='description' rows='5' cols='75' validate='Dairy Description' onkeypress="calculateRemaining(this,500,'remaining')" onkeyup="calculateRemaining(this,500,'remaining')"></textarea><br><span id='remaining'><font color='red'><%=bundle.getString("label.diarycreation.500charactersremaining") %></font></span></td>
						</tr>
						<tr>
							<td class=tablebold width='18%'><%=bundle.getString("label.diarycreation.DiaryDate") %><font color=red>*</font></td>
							<td class=tablebold width='1%'>:</td>
							<td><input type='text' width='31%' 		name='dairydate' 		size='11' validate='Dairy Date' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','workallotment.dairydate','0',event,'Not_Less_Than_CurrentDate',workallotment.todaydate)></td>
							<td class=tablebold width='18%'><%=bundle.getString("label.diarycreation.SubmissionDate") %><font color=red>*</font></td>
							<td class=tablebold width='1%'>:</td>
							<td><input type='text' 	 width='31%'	name='enddate' 		size='11' validate='Submission Date' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','workallotment.enddate','0',event,'Not_Less_Than_StartDate',workallotment.dairydate)></td>
						</tr>												
					</table>
				</td>
   					
			</tr>
		</table>
					
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.diarycreation.Back") %></strong><span class="bt_blue_r"></span></a>
  		<a href="#" id="savebut"  class="bt_green" onclick='submitWorks()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.diarycreation.Submit") %></strong><span class="bt_green_r"></span></a>
		
		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
		<input type='hidden' name='section' 			value='<%=sectionid%>'>
		<input type='hidden' name='subject' 			value='<%=subjectid%>'>
		<input type='hidden' name='standard' 			value='<%=standardid%>'>
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>
		<input type='hidden' name='sectionname' 		value='<%=sectionname%>'>
		<input type='hidden' name='todaydate' 			value='<%=todaydate%>'>

		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>