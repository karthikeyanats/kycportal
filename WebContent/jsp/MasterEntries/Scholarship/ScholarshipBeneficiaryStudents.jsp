<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	
	var count	= 0; 

	function loadStandards(){
		if(check_ForParticularElements(document.Schedule_Form.session,"select")){
			//document.Schedule_Form.archival.value	= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].getAttribute("status");
			document.Schedule_Form.submit();
		}
	}
	
	function loadStandards1(){
	//alert("call");
		if(check_ForParticularElements(document.Schedule_Form.session,"select")){
			//document.Schedule_Form.archival.value	= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].getAttribute("status");
			if(check_ForParticularElements(document.Schedule_Form.board,"select")){
				document.Schedule_Form.submit();
			}
		}
		else
			document.Schedule_Form.board.options.selectedIndex	= 0;
			
	}	
	
	function Loadscholarshipname(obj)
	{
//		obj.getAttribute("standardid");
		document.Schedule_Form.instituteid.value=obj.getAttribute("instituteid");
		document.Schedule_Form.standardid.value=obj.getAttribute("standardid");
		document.Schedule_Form.action="BeneficiaryStuCount.jsp";
		document.Schedule_Form.submit();
	}
	
	function checkCount(obj){
		var pos	= obj.getAttribute("pos");
		if(obj.checked){
			if(check_ForParticularElements(document.Schedule_Form.starts[pos],"text",document.Schedule_Form.ends[pos],"text")){
					count++;
			}
			else
				obj.checked = false;
		}
		else{
			count--;
		}
	}
	function publishStandard(){
		
		if(check_ForParticularElements(document.Schedule_Form.lastdate,"text",document.Schedule_Form.session,"select")){
			
			if(count>0){
			
				for(var i=0;i<document.Schedule_Form.checkstandard.length;i++){
				
					if(!document.Schedule_Form.checkstandard[i].checked){
						
						document.Schedule_Form.starts[i].disabled 	= true;
						document.Schedule_Form.ends[i].disabled 	= true;
						document.Schedule_Form.groups[i].disabled 	= true;						
					
					}
				}

				document.Schedule_Form.action = "PublishStandard.jsp";
				document.Schedule_Form.submit();
			}
			else{
				
				alert("Please select atleast a standard to publish");			
			}
		}
	}
	
	function trashedStandard(){
	
		if(check_ForParticularElements(document.Schedule_Form.session,"select",document.Schedule_Form.board,"select")){
			
			document.Schedule_Form.sessionname.value	= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
			document.Schedule_Form.boardname.value		= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
			document.Schedule_Form.action 				= "TrashedStandard.jsp";
			document.Schedule_Form.submit();
		}
	}	
	
	function callEdit(obj){
	if(confirm("Do you want to Update the Standard Details ...?"))
	{
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "ViewPublished.jsp";
		document.Schedule_Form.submit();
		}
	}
	
	function loadSubject(obj){
	
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "ViewSubjects.jsp";
		document.Schedule_Form.submit();
	}
	
	function loadSections(obj){
	
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "ViewSections.jsp";
		document.Schedule_Form.submit();
	}
	
	function callTrash(obj){
	if(confirm("Do you want to Trash the Standard Details ...?"))
	{
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.standardname.value		= obj.getAttribute("standardname");
		document.Schedule_Form.action = "StandardTrashPreview.jsp";
		document.Schedule_Form.submit();
		}
	}	
	
	
	
	
</script>
</head>
<body>
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
	<%    
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    <h2>Master Entries / Beneficiary Scholarship List</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Schedule.Schedule,com.iGrandee.Common.DateTime"%>
<%

try{
		Schedule schedule			= new Schedule();
		String instituteid			= (String)session.getValue("instituteid");
		
		ArrayList sessionList		= schedule.sessionDetails(instituteid);
		ArrayList boardList			= schedule.boardDetails(instituteid);
		HashMap	hashmap				= null;
		ArrayList standardList		= null;
		String groupstatus			= "";
		String standardid			= "";
		int count					= 0;
		int stotal					= 0;
		int tcount					= 0;
		String sessionid			= request.getParameter("session");
		String boardid				= request.getParameter("board");
		String today				= DateTime.showTime("calendar");
		String archival				= request.getParameter("archival");
		String tempstandardid		= "";
		
		if(sessionid != null && boardid != null) {
			standardList			= schedule.standardDetails(instituteid,sessionid,boardid);
		}
%>

<form name="Schedule_Form" action="" method="post">


<table id="rounded-corner" border=0 summary="Department List" width="80%">
    <thead>
    	<tr>
        	 
        	 <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.schedule.academicyearandboard")%></th>      
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.schedule.mandatoryfield") %></th> 
        </tr>
    </thead>
		    <tr>
		    	<td colspan='2'>
					<table width='100%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%><font color=red>*</font></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='session' validate='<%=bundle.getString("label.schedule.academicyear")%>' onchange='loadStandards()'>
									<option value='0'>-Academic Year-</option>
									<%
										if(sessionList != null && sessionList.size()>0)
											for(int y=0;y<sessionList.size();y++){
												hashmap		= (HashMap)sessionList.get(y);
												if(sessionid != null && sessionid.equals((String)hashmap.get("sessionid")))
													out.print("<option selected value='"+hashmap.get("sessionid")+"' status='"+hashmap.get("sessionstatus")+"'>"+hashmap.get("sessionname")+"</option>");
												else
													out.print("<option value='"+hashmap.get("sessionid")+"' status='"+hashmap.get("sessionstatus")+"'>"+hashmap.get("sessionname")+"</option>");
											}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.board")%><font color=red>*</font></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='board' validate='<%=bundle.getString("label.schedule.board")%>' onchange='loadStandards1()'>
									<option value='0'>-Select Board-</option>
									<%
										if(boardList != null && boardList.size()>0)
											for(int y=0;y<boardList.size();y++){
												hashmap		= (HashMap)boardList.get(y);
												if(boardid != null && boardid.equals((String)hashmap.get("boardid")))
													out.print("<option selected value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
												else
													out.print("<option value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
											}
									%>
								</select>
							</td>
						</tr>
						
					</table>					    	
		    	</td>
		    </tr>
		</table>

		<br>
		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0  width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schedule.slno")%></th>
					            <th scope="col" class="rounded" 		width="26%"><%=bundle.getString("label.schedule.standardname")%></th>
					            <th scope="col" class="rounded" 		width="30%"><%=bundle.getString("label.scholarship.beneficiarystudents")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("label.scholarship.beneficiarystudentsmale")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("label.scholarship.beneficiarystudentsfemale")%></th>
					            <th scope="col" class="rounded-q4" 		width="17%"><%=bundle.getString("label.studentsearch.Amount")%></th>
					            
					        </tr>
					    </thead>
						<%						
						
						
						com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery  scholarshipQuery = new com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery();
				     	
				     	ArrayList LoadScholarList = null;
				     		try
				     		{
				     			//out.println("board>>"+boardid);
				     			//out.println("session>"+sessionid);
				     			//out.println("instituteid>"+instituteid);
				     			
				    	  		instituteid = (String)session.getValue("instituteid");
				    	  		LoadScholarList = scholarshipQuery.ScholarshipstdDetails(instituteid,sessionid,boardid);
				    	  		//out.println("LoadScholarList>>>>>>"+LoadScholarList);
				    		   	ArrayList archivalDetails = new ArrayList();
				    	 		if(LoadScholarList!=null && LoadScholarList.size()>0)
									{
				    	 			int count1=0;	 	
				    		 			for (int i = 0, j = 1; i < LoadScholarList.size(); i++) {
											HashMap ScholarcreateListMap=(HashMap)LoadScholarList.get(i);
											String standardname       	= (String)ScholarcreateListMap.get("standardname");
											String male  	            = (String)ScholarcreateListMap.get("male");
											String female            	= (String)ScholarcreateListMap.get("female");
											String totamount		  	= (String)ScholarcreateListMap.get("totamount");
											count1+=Integer.parseInt(totamount);
									%>
									
									<tr>
						    	   	 <td valign=top width="10%"><%=j++ %></td>
						    	   	 <td valign=top width="26%"><a href="#" style="text-decoration:none;cursor:pointer;" standardid='<%=ScholarcreateListMap.get("standardid") %>' instituteid=<%=instituteid %> onClick="Loadscholarshipname(this)"><%=standardname%></a></td>
						        	 <td valign=top width="30%" align='left'><%= Integer.parseInt(male)+Integer.parseInt(female) %></td>
						        	 <td valign=top width="10%"><%=male %></td>
						        	 <td valign=top width="10%"><%=female %></td>
						        	 <td valign=top width="17%"><%=totamount %></td>
									</tr>									
									
									
									<%											
											
											
				    		 			}
				    		 			
				    		 			%>
				    		 			<tr>
				    		 				
				    		 				<td colspan='5' align='right'>Total Amount = </td>
				    		 				<td><%=count1 %></td>
				    		 			</tr>
				    		 			
				    		 			<%
				    		 			
									}else{
										%>
										<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>
										<%
									}
				     		}catch(Exception e){}
					  
						%>
					      
					    
					</table>
					
				
				</td>
			</tr>
		</table>
				

		<input type='hidden' name='sessionname' 				value=''>
		<input type='hidden' name='boardname' 					value=''>
		<input type='hidden' name='standardscheduleid' 			value=''>
		
		<input type='hidden' name='standardname' 				value=''>
		<input type='hidden' name='standardid' 				value=''>
		<input type='hidden' name='instituteid' 				value=''>
		
		
		
		
</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
<%
}
catch(Exception e){
	e.printStackTrace();
	
}
%>
<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>

</html>