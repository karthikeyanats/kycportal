<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Diary Edit | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script language='javascript'>
	
	function goBack(){
		
		document.workallotment.action = "DairyView.jsp";
		document.workallotment.submit();
	}

	function updateQuestion(){

		if(check_ForParticularElements(document.workallotment.topic,"text",document.workallotment.description,"textarea",document.workallotment.dairydate,"text")){
			
			document.workallotment.status.value		= "A";
			document.workallotment.action 			= "DairyUpdate.jsp";
			document.workallotment.submit();
		}
	}
	
	function deleteQuestion(){
		
		document.workallotment.status.value	= "D";
		document.workallotment.action 		= "DairyUpdate.jsp";
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

    <h2><%=bundle.getString("label.diarycreation.editrootpath") %></h2>
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Dairy.Dairy,com.iGrandee.Common.DateTime"%>
	
	<%
		
		String sessionid		= request.getParameter("session");
		String standardid		= request.getParameter("standard");
		String sectionid		= request.getParameter("section");
		String subjectid		= request.getParameter("subject");
		String sectionname		= request.getParameter("sectionname");
		String subjectname		= request.getParameter("subjectname");
		String standardname		= request.getParameter("standardname");
		String sessionname		= request.getParameter("sessionname");
		String dairyid			= request.getParameter("dairyid");
		Dairy	dairy			= new Dairy();
		HashMap	hashmap			= null;
		ArrayList questionList	= dairy.loadDairySingle(dairyid);
	
	%>
	<form name='workallotment' method='post'>
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.diarycreation.DiaryDetails") %></th>
		            <th scope="col" class="rounded-q4" width="10%"></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>							
	
					<table  border=0 bordercolor='blue' align="center" width="100%" >

						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diarycreation.Session") %> </td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=sessionname%>
							</td>
						</tr>	
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.diarycreation.Standard") %> </td>
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
														
		<table id="rounded-corner" border=0  width="100%">
		    <thead>
		    	<tr>
		        	
		            <th scope="col" class="rounded-company" width="85%"><%=bundle.getString("label.diarycreation.UpdateDiary") %> </th>
		            <th scope="col" class="rounded-q4" width="15%" align=right><font color=red>*</font><%=bundle.getString("label.common.mandatory") %></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>
		
					<table border=0 summary="Department List" width="100%">
					
						<%
							String file			= "";
							String status		= "";
							String workdetails	= "";
							int remain			= 500;
							if(questionList != null && questionList.size()>0){
									hashmap		= (HashMap)questionList.get(0);
									file		= (String)hashmap.get("file");
									status		= (String)hashmap.get("status");
									workdetails	= (String)hashmap.get("workdetails");
									
									if(workdetails != null)
										remain	-= workdetails.length();
									out.print("<tr><td class=tablebold>"+bundle.getString("label.diarycreation.DiaryName")+"<font color=red>*</font></td><td class=tablebold>:</td><td colspan='4'><input type='text' name='topic' value='"+hashmap.get("subject")+"' size='50' maxlength='400' class=tablelight></tr>");
									out.print("<tr><td valign='top' class=tablebold>"+bundle.getString("label.diarycreation.Description")+"<font color=red>*</font></td><td valign=top class=tablebold>:</td><td colspan='4'><textarea name='description' rows='5' class=tablelight cols='75' validate='Dairy Description'  onkeypress=calculateRemaining(this,500,'remaining') onkeyup=calculateRemaining(this,500,'remaining')>"+hashmap.get("workdetails")+"</textarea><br><span id='remaining'><font color='red'>"+remain+" characters remaining</font></span></td></tr>");
	
									if(status != null && status.equals("Not Submitted"))
										out.print("<tr><td class=tablebold>"+bundle.getString("label.diarycreation.DiaryDate")+"<font color=red>*</font></td><td class=tablebold>:</td><td><input type='hidden' name='odairydate' value='"+hashmap.get("dairydate")+"'><input type='text' 	name='dairydate' 		size='11' validate='Dairy Date' onfocus='this.blur()' value='"+hashmap.get("dairydate")+"'><input type='button' value='^' onclick=document.workallotment.dairydate.value=document.workallotment.odairydate.value;Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','workallotment.dairydate','0',event,'Not_Less_Than_CurrentDate',workallotment.dairydate)></td><td class=tablebold>"+bundle.getString("label.diarycreation.SubmissionDate")+"<font color=red>*</font></td><td class=tablebold>:</td><td><input type='hidden' name='oenddate' value='"+hashmap.get("dairysubmissiondate")+"'><input type='text' name='enddate' size='11' validate='Submission Date' onfocus='this.blur()' value='"+hashmap.get("dairysubmissiondate")+"'><input type='button' value='^' onclick=document.workallotment.enddate.value=document.workallotment.oenddate.value;Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','workallotment.enddate','0',event,'Not_Less_Than_CurrentDate',workallotment.enddate)></td></tr>");
									else
										out.print("<tr><td class=tablebold>"+bundle.getString("label.diarycreation.DiaryDate")+"<font color=red>*</font></td><td class=tablebold>:</td><td><input type='hidden' name='odairydate' value='"+hashmap.get("dairydate")+"'><input type='text' 	name='dairydate' 		size='11' validate='Dairy Date' onfocus='this.blur()' value='"+hashmap.get("dairydate")+"'><input type='button' value='^' disabled onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','workallotment.dairydate','0',event,'Not_Less_Than_CurrentDate',workallotment.dairydate)></td><td class=tablebold>"+bundle.getString("label.diarycreation.SubmissionDate")+"<font color=red>*</font></td><td class=tablebold>:</td><td><input type='hidden' name='oenddate' value='"+hashmap.get("dairysubmissiondate")+"'><input type='text' name='enddate' size='11' validate='Submission Date' onfocus='this.blur()' value='"+hashmap.get("dairysubmissiondate")+"'><input type='button' value='^' onclick=document.workallotment.enddate.value=document.workallotment.oenddate.value;Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','workallotment.enddate','0',event,'Not_Less_Than_CurrentDate',workallotment.enddate)></td></tr>");										
							}
							else{
								out.print("<tr align='center' class='tablebold'><td colspan='6'><a class='nodata'>Data Not Found</a></td></tr>");
							}
						%>
					</table>
				</td>
			</tr>	
		</table>
			     	
			     	
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.diarycreation.Back")%></strong><span class="bt_blue_r"></span></a>
     	<a href="#" class="bt_red" onclick='deleteQuestion()'><span class="bt_red_lft"></span><strong><%=bundle.getString("button.diarycreation.Delete")%></strong><span class="bt_red_r"></span></a>
		<a href="#" id="savebut"  class="bt_green" onclick='updateQuestion()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.diarycreation.Update")%></strong><span class="bt_green_r"></span></a>
				

		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
		<input type='hidden' name='section' 			value='<%=sectionid%>'>
		<input type='hidden' name='subject' 			value='<%=subjectid%>'>
		<input type='hidden' name='standard' 			value='<%=standardid%>'>
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>
		<input type='hidden' name='sectionname' 		value='<%=sectionname%>'>
		<input type='hidden' name='dairyid' 			value='<%=dairyid %>'>
		<input type='hidden' name='oldfile' 			value='<%=file%>'>
		<input type='hidden' name='dairyid' 			value='<%=dairyid%>'>
		<input type='hidden' name='status' 				value='A'>
		
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>