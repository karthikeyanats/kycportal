<%@ page 		language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean 	id="validate" 	scope="page" class="com.iGrandee.Common.CommonDataAccess" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Student Profile Entry</title> 

<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>


<script language="JavaScript">

	function submitfun(){
	//	alert("Calling submit function");
		if(check_ForParticularElements(document.MainForm.session,"select",document.MainForm.board,"select",document.MainForm.standard,"select",document.MainForm.term,"select",document.MainForm.profilefile,"text")){
		
			var ext		= document.MainForm.profilefile.value.substring(document.MainForm.profilefile.value.lastIndexOf(".")+1)
		
			if(ext == "xls"){
			
				
				document.MainForm.sessionname.value		= document.MainForm.session.options[document.MainForm.session.options.selectedIndex].text;
				document.MainForm.standardname.value	= document.MainForm.standard.options[document.MainForm.standard.options.selectedIndex].text; 
				document.MainForm.boardname.value		= document.MainForm.board.options[document.MainForm.board.options.selectedIndex].text;
				document.MainForm.termname.value		= document.MainForm.term.options[document.MainForm.term.options.selectedIndex].text; 
			
				document.MainForm.action= "./BulkProfileViewAut.jsp";
				document.MainForm.submit();			
			}
			else{
				
				alert("Please select *.xls file only.")			
			}
		}
	}
	
	function changeBoard(){
	
		if(check_ForParticularElements(document.MainForm.session,"select",document.MainForm.board,"select")){
			document.MainForm.standard.options.selectedIndex	= 0;
			document.MainForm1.session.value	= document.MainForm.session.options[document.MainForm.session.options.selectedIndex].value;
			document.MainForm1.board.value		= document.MainForm.board.options[document.MainForm.board.options.selectedIndex].value;
			document.MainForm1.submit();
		}
	}	

	function changeSession(){
		
		if(check_ForParticularElements(document.MainForm.session,"select")){
			document.MainForm1.session.value	= document.MainForm.session.options[document.MainForm.session.options.selectedIndex].value;
			document.MainForm1.submit();
		}
	}
	
	 function Loadtermname()   
		{ 
			if(check_ForParticularElements(document.MainForm.session,"select",document.MainForm.board,"select",document.MainForm.standard,"select")){
				
				document.MainForm1.session.value	= document.MainForm.session.options[document.MainForm.session.options.selectedIndex].value;
				document.MainForm1.board.value		= document.MainForm.board.options[document.MainForm.board.options.selectedIndex].value;
				//document.MainForm1.standardname.value	= document.MainForm.standard.options[document.MainForm.standard.options.selectedIndex].value;
				document.MainForm1.term.value	= document.MainForm.standard.options[document.MainForm.standard.options.selectedIndex].value;
				document.MainForm1.standard.value	= document.MainForm.standard.options[document.MainForm.standard.options.selectedIndex].value;
				
				//document.MainForm1.action="BulkProfileEntryAut.jsp";
				document.MainForm1.submit();
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
    <h2>Enrollment / Student Enrollment / Student Profile Entry [ Bulk ]</h2>
     
	<%@ page import="java.util.*,com.iGrandee.TimeTable.PeriodTime.WorkAllotment"%>
	
	<form name="MainForm1" method="post" action="">

		<input type='hidden' name='session' value=''>
		<input type='hidden' name='board' 	value=''>
		<input type="hidden" name="term" value="">
		<input type="hidden" name="standard" value="">
			
		

	</form>	
	
	
	<form name="MainForm" method="post" action="" enctype="multipart/form-data">
	
	<input type='hidden' name='sessionname' 	value=''>
	<input type='hidden' name='standardname' 	value=''>
	<input type='hidden' name='boardname' 		value=''>
	<input type='hidden' name='termname' 		value=''>
	
	<%
		
		WorkAllotment	 wallot	= new WorkAllotment();
		String instituteid 		= (String)session.getValue("instituteid");
		ArrayList academicList	= wallot.loadAcadamicYear(instituteid);
		HashMap	hashmap			= null;
		String sessionid		= request.getParameter("session");
		String boardid			= request.getParameter("board");
		String termid			= request.getParameter("term");
		ArrayList standardList	= null;
		ArrayList boardList		= null;
		
		if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null")){
			boardList		= wallot.boardDetails(instituteid,sessionid);
		}
	
		if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null") && boardid != null && !boardid.equals("") && !boardid.equalsIgnoreCase("null")){
			standardList	= wallot.loadScheduledStandards(sessionid,instituteid,boardid); 
		}
		
	
	%>
	
 	<input type='hidden' name='sessionid' 	value='<%=sessionid%>'>
	<input type='hidden' name='boardid' 	value='<%=boardid%>'>
 
 
	<table id="rounded-corner" border=0  width="100%">
	    <thead>
	    	<tr>
	        	<th scope="col" class="rounded-company" width="90%" >Select Information</th>
	        	<th scope="col" class="rounded-q4" width="10%" ></th>
	        </tr>
	    </thead>
	    
	    <tfoot>
	    	<tr>
	        	<td   class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       </tr>
	    </tfoot>
	    
		<tbody>
			<tr>
		    	<td colspan=2>
		     		<table  border=0 summary="Department List" width="100%">
			   			<tr>
							<td class="tablebold" width="25%">Academic Year</td>
							<td class=tablebold>:</td>
							<td>
								<select name='session' validate='Academic Year' onchange='changeSession()'>
									<option value='0'>-Select Academic Year-</option>
									<%
										if(academicList != null && academicList.size()>0){
											for(int y=0;y<academicList.size();y++){
												hashmap		= (HashMap)academicList.get(y);
												
												if(sessionid != null && sessionid.equals(""+hashmap.get("sessionid")))
													out.print("<option selected value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
												else
													out.print("<option value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
											}
										}
									%>
								</select>
							</td>
							<td class="tablebold" align=right>Board</td>
							<td class=tablebold>:</td>
							<td>
								<select name='board' validate='Board Name' onchange='changeBoard()'>
								<option value='0'>-Select Board Name-</option>
								<%
									if(boardList != null && boardList.size()>0){
										for(int y=0;y<boardList.size();y++){
											hashmap		= (HashMap)boardList.get(y);
											if(boardid != null && boardid.equals(""+hashmap.get("boardid")))
												out.print("<option selected value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"</option>");
											else
												out.print("<option value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"</option>");
										}
									}
								%>											
								</select>
							</td>
						</tr>
						<tr>
							<td class="tablebold" align=left width="25%">Standard Name</td>
							<td class=tablebold>:</td>
							<td>
								<select name='standard' validate='Standard' onchange="Loadtermname()">
								<option value='0'  selected >-Select Standard-</option>
								<%
									if(standardList != null && standardList.size()>0){
										for(int y=0;y<standardList.size();y++){
											hashmap		= (HashMap)standardList.get(y);
											if(request.getParameter("standard")!=null && request.getParameter("standard").equals(hashmap.get("standardscheduleid")))
											{out.print("<option selected value='"+hashmap.get("standardscheduleid")+"'>"+hashmap.get("standardname")+"</option>");}
											else
											{
												out.print("<option value='"+hashmap.get("standardscheduleid")+"'>"+hashmap.get("standardname")+"</option>");
											}
										}
									}
								%>											
								</select>
							</td>
							
							
							<td class="tablebold" align=left width="25%">Term Name</td>
							<td class=tablebold>:</td>
							<td>
								<select name='term' validate='Term Name'>
								<option value='0' selected>-Select Term-</option>
								 <%
								 
								 ArrayList termsList = null;
								 String feestermid			= "";
						 			String feestermid_t			= "";
								 
								 
								 termsList	= wallot.getStandardTerms(termid); 
								
									if(termsList != null && termsList.size()>0)
									for (int j = 0; j < termsList.size(); j++){ 
										
										hashmap		= (HashMap)termsList.get(j);
								 		feestermid_t	= (String)hashmap.get("termfeesid");								 		
								 		if(request.getParameter("term")!=null && request.getParameter("term").equals(hashmap.get("termfeesid")))
										{
											out.print("<option value="+hashmap.get("termfeesid")+">"+hashmap.get("termname")+"</option>");
										}
								 		else
								 		{
								 			out.print("<option value="+hashmap.get("termfeesid")+">"+hashmap.get("termname")+"</option>");
								 		}
										
									}
								%>		 									
								</select>
							</td>
							
							
						</tr>
						
						
					</table>
				</td>
			</tr>
		</tbody>
	</table>
	<br> 
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
	    <thead>
	    	<tr>
	        	<th scope="col" class="rounded-company" width="75%">Student Profile Entry [Bulk]</th>
	        	<th scope="col" class="rounded-q4" width="25%" class='tablebold'><a href='./SampleBulkTemplate.xls' target='_new'>Download Sample Template</a></th>
	            
	        </tr>
	    </thead>
	    <tfoot>
	    	<tr>
	        	<td  class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       </tr>
	    </tfoot>
	     <tbody>
		     <tr>
		     	<td colspan=2>
				     <table width=100%>
				     <tr>
						<td class="tablebold" align=center colspan=2>Select File<font color='red'>*</font></td>
						<td class=tablebold>:</td>
						<td><input type="file" name="profilefile" validate="Student Profile File" class=tablelight onkeypress='this.blur()' maxlength=100></td>
					</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
	
	<a href="#" onclick="submitfun()"  class="bt_green" align=center><span class="bt_green_lft"></span><strong>Load</strong><span class="bt_green_r"></span></a> 


</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>