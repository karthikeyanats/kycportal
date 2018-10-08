<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Content Upload | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
	function loadStandards()
	{	
		document.Schedule_Form.submit();
	}
	function loadStandardss()
	{
		document.Schedule_Form.submit();
	}
	function loadSubject()
	{
		document.Schedule_Form.submit();
	}
	function loadlesson()
	{
		document.Schedule_Form.lessonscheduleid.value=document.Schedule_Form.lesson.options[document.Schedule_Form.lesson.options.selectedIndex].getAttribute("lessonscheduleid");
		document.Schedule_Form.submit();
	}
	function goBack()
	{
		document.Schedule_Form.action = "contenthome.jsp";
		document.Schedule_Form.submit();
	}
	function openwindows(obj)
	{
		var id=obj.getAttribute("cmscontentid");
		window.open("<%=request.getContextPath()%>/jsp/ContentManagement/ContentView.jsp?&req_sessionname="+document.Schedule_Form.sessionname.value+"&req_boardname="+document.Schedule_Form.boardname.value+"&req_standardname="+document.Schedule_Form.standardname.value+"&req_subjectname="+document.Schedule_Form.subject.options[document.Schedule_Form.subject.options.selectedIndex].text+"&req_lessonname="+document.Schedule_Form.lesson.options[document.Schedule_Form.lesson.options.selectedIndex].text+"&contentid="+id,"Msg","top=50,left=50,help:no,center:no,status:no,width=800,height=600,scrollbars=1")
	}
	function openwindow(obj)
	{
	document.Schedule_Form.target='_new';
	document.Schedule_Form.action="ContentView.jsp"
	document.Schedule_Form.submit();
	}
	
	function viewfun()
	{
	
		if(check_ForParticularElements(document.Schedule_Form.sessionname,"select",document.Schedule_Form.board,"select",document.Schedule_Form.standard,"select",document.Schedule_Form.subject,"select"))
	{
			document.Schedule_Form.req_sessionname.value=document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text;
			//alert("Session::::"+document.Schedule_Form.req_sessionname.value);
			document.Schedule_Form.req_boardname.value=document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
			//alert("Board:::"+document.Schedule_Form.req_boardname.value);
			document.Schedule_Form.req_standardname.value=document.Schedule_Form.standard.options[document.Schedule_Form.standard.options.selectedIndex].text;
			//alert("Standard:::"+document.Schedule_Form.req_standardname.value);
			document.Schedule_Form.req_subjectname.value=document.Schedule_Form.subject.options[document.Schedule_Form.subject.options.selectedIndex].text;
			//alert("req_subjectname:::"+document.Schedule_Form.req_subjectname.value);
			//alert(document.Schedule_Form.req_subjectname.value);
			document.Schedule_Form.req_filename.value=document.Schedule_Form.subject.options[document.Schedule_Form.subject.options.selectedIndex].text;

			document.Schedule_Form.action="./View/ContentFrame.jsp";
			document.Schedule_Form.submit();
		
	}
}
	function viewfunforstaff()
	{
	
		if(check_ForParticularElements(document.Schedule_Form.board,"select",document.Schedule_Form.standard,"select",document.Schedule_Form.subject,"select"))
	{

			document.Schedule_Form.req_boardname.value=document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
			document.Schedule_Form.req_standardname.value=document.Schedule_Form.standard.options[document.Schedule_Form.standard.options.selectedIndex].text;
			document.Schedule_Form.req_subjectname.value=document.Schedule_Form.subject.options[document.Schedule_Form.subject.options.selectedIndex].text;
			document.Schedule_Form.action="./View/ContentFrame.jsp";
			document.Schedule_Form.submit();
		
	}
}
function viewfunforstudent()
{

	if(check_ForParticularElements(document.Schedule_Form.subject,"select"))
	{
		document.Schedule_Form.req_subjectname.value=document.Schedule_Form.subject.options[document.Schedule_Form.subject.options.selectedIndex].text;
		document.Schedule_Form.action="./View/ContentFrame.jsp";
		document.Schedule_Form.submit();
	
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

    <h2>Content Access / Content View</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Content.ContentQurey,com.iGrandee.Common.DateTime"%>
<form name="Schedule_Form" action="" method="post">
<%

		ContentQurey cquery			= new ContentQurey();
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList yearList			= cquery.sessionDetails(instituteid);
		ArrayList boardList			= cquery.boardDetails(instituteid);
		HashMap	hashmap				= null;
		ArrayList standardList		= null;
		ArrayList subjectList		= null;
		ArrayList lessonList        = null;
		ArrayList contentlist       = null;
		String groupstatus			= "";
		String sessionname			= "";
		String boardname			= "";
		/*String standardname			= "";
		String groupname			= "";*/
		String subjectscheduleid	= "";
		String subjectname			="";

		String req_sessionid		= request.getParameter("sessionname");
		String req_subjectid		= request.getParameter("subjectid");
		String boardid				= request.getParameter("board");

		//String req_standardscheduleid	= session.getValue("standardscheduleid")+"";
		ArrayList studentdetailList=null;
		String req_standardscheduleid	=request.getParameter("standard");
		
		int count					= 0;
		int stotal					= 0;
		int tcount					= 0;
		int datacount				= 0;
		String req_subjectscheduleid	= request.getParameter("subject");
		//out.println("req_subjectscheduleid======>>>>>"+req_subjectscheduleid);
		String req_lessonid		        = request.getParameter("lesson");
		String today					= DateTime.showTime("calendar");
		String archival					= request.getParameter("req_sessionstatus");
		String tempstandardid		= "";
		//out.println(req_subjectscheduleid+"req_subjectscheduleid");
		if(req_sessionid != null && boardid != null) {

			standardList			= cquery.standardDetails(instituteid,req_sessionid,boardid);
			

		}
		if(req_standardscheduleid != null && !req_standardscheduleid.equals("00")) {
			 subjectList			= cquery.viewSubjects(req_standardscheduleid);
		}
		if(loginusercategory != null && loginusercategory.equals("S")){
		String standardscheduleid	= (String)session.getValue("standardscheduleid");
		/*String [] nam=session.getValueNames();
		for(int i=0;i<nam.length;i++)
		{
			out.print(nam[i]);
			out.print("==========>>>>>>>>"+session.getValue(nam[i])+"<br>");
     
		}*/
		subjectList=cquery.viewSubjects(standardscheduleid);  
		}
		if(loginusercategory != null && loginusercategory.equals("T")){
			boardList = cquery.loadBoardForStaff(session.getValue("userid")+"",instituteid,session.getValue("sessionid")+"");
			standardList = cquery.loadStandardForStaff(session.getValue("userid")+"",session.getValue("sessionid")+"",boardid);
			subjectList			= cquery.loadSubjectForStaff(session.getValue("staffid")+"", req_standardscheduleid);
			//System.out.print("req_standardscheduleid==========>>>>>>>>"+req_standardscheduleid+"<br>");

			 	/*String [] nam=session.getValueNames();
						for(int i=0;i<nam.length;i++)
						{
							out.print(nam[i]);
							out.print("==========>>>>>>>>"+session.getValue(nam[i])+"<br>");
				     
						}*/
		}
%>

		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		        	
		            <th scope="col" class="rounded-company" width="98%">Academic Year and Board Details</th>
		            <th scope="col" class="rounded-q4"	width="2%"> </th>
		        </tr>
		    </thead>
			<tfoot>
			   	<tr>
			       	<td  class="rounded-foot-left"><em></em></td>
			       	<td class="rounded-foot-right">&nbsp;</td>
			    </tr>
			</tfoot>		    
		    <tr>
		    	<td colspan='2'>
					<table width='95%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold'>Academic Year<font class=mandatory>&nbsp;*</font></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%if(loginusercategory != null && loginusercategory.equals("SA")){%>
							<select name=sessionname validate='Session Name' class=tablelight onchange='loadStandards()' >
			<option value="00">-Select Academic Year-</option>
			<%
			if(yearList!=null && yearList.size()>0)
			{
				for(int s=0;s<yearList.size();s++)
				{
					HashMap map=(HashMap)yearList.get(s);
					String sessionid=(String)map.get("sessionid");
					String yearofsession=(String)map.get("sessionname");
					String session_status=(String)map.get("sessionstatus");
					if(req_sessionid != null && req_sessionid.equals(sessionid))
						out.println("<option value='"+sessionid+"' selected=true>"+yearofsession+"</option>");
					else
						out.println("<option value='"+sessionid+"'>"+yearofsession+"</option>");
				}
			}

			%>
		</select>
		<%}else
			{
							out.println(session.getValue("sessionname"));			
			}%>
							</td>
							<td width='20%' class='tablebold' align=left>Board-Medium<font class=mandatory>&nbsp;*</font></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
														<%if(loginusercategory != null && !loginusercategory.equals("S")){%>
							
								<select name='board' validate='Board Name' onchange='loadStandardss()'>
									<option value='00'>-Select Board-Medium-</option>
									<%
										if(boardList != null && boardList.size()>0)
											for(int y=0;y<boardList.size();y++){
												hashmap		= (HashMap)boardList.get(y);
												if(boardid != null && boardid.equals((String)hashmap.get("boardid")))
													out.print("<option selected=true value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
												else
													out.print("<option value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
											}
									%>
								</select>
								<%}else
			{
							out.println(session.getValue("boardname"));			
			}%>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold' >Standard<font class=mandatory>&nbsp;*</font></td>    
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' >
														<%if(loginusercategory != null && !loginusercategory.equals("S")){%>
							
							<select name=standard class=tablelight  validate="Standard" onChange="loadSubject()">
								<option value="00">-Select Standard-</option>
								<%
								if(standardList != null && standardList.size()>0){
									
									for(int y=0;y<standardList.size();y++){
										
										hashmap			= (HashMap)standardList.get(y);
										//groupstatus		= (String)hashmap.get("groupstatus");
										//String standardid		= (String)hashmap.get("standardid");
										String standardscheduleid		= (String)hashmap.get("standardscheduleid");

										String standardname		= (String)hashmap.get("standardname");
										String groupname		= (String)hashmap.get("groupname");
									/* 	if(groupstatus != null && !groupstatus.equals("No")){
											
											standardname=standardname+" -"+groupname;
										} */
										if(groupname != null  && !groupname.equals("NoGroup"))
											standardname=standardname+" -"+groupname;
										else
											standardname=standardname;
										
										if(req_standardscheduleid != null && req_standardscheduleid.equals(standardscheduleid))
											out.println("<option value='"+standardscheduleid+"' selected=true>"+standardname+"</option>");
										else
											out.println("<option value='"+standardscheduleid+"'>"+standardname+"</option>");
									}
								}
					
								%>
							</select>
							<%}else
			{
							out.println(session.getValue("standardname"));			
			}%>
							</td>
							<td width='15%' class='tablebold' align=left>Subject<font class=mandatory>&nbsp;*</font></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' width=35%>
							<select name=subject class=tablelight  validate="Subject" onchange="loadStandards()" >
								<option value="00">-Select Subject-</option>
								<%
								if(subjectList != null && subjectList.size()>0){
									
									for(int y=0;y<subjectList.size();y++){
										
										 hashmap				= (HashMap)subjectList.get(y);
						    			 subjectname		= (String)hashmap.get("subjectname");
						    			 String subjectid		= (String)hashmap.get("subjectid");
						    			 subjectscheduleid		= (String)hashmap.get("subjectscheduleid");

						    			String subjectcode		= (String)hashmap.get("subjectcode")+"";
						    			if(!subjectcode.equals("null") && !subjectcode.equals("-"))
						    				subjectname=subjectname+" -"+subjectcode;
						    			if(req_subjectscheduleid != null && req_subjectscheduleid.equals(subjectscheduleid))
											out.println("<option value='"+subjectscheduleid+"' selected=true>"+subjectname+"</option>");
										else
											out.println("<option value='"+subjectscheduleid+"'>"+subjectname+"</option>");
						    			
									}
								}
					
								%>
							</select>
							</td>
							
						</tr>
						<!--<tr>
							<td  class='tablebold'>Lesson</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan=4>
							<select name=lesson class=tablelight onchange="loadlesson()" validate="Lesson">
								<option value="00">-Select Lesson-</option> -->
								<%
								if(lessonList != null && lessonList.size()>0){
									
									for(int y=0;y<lessonList.size();y++){
										
										hashmap				= (HashMap)lessonList.get(y);
										String lessonid     = (String)hashmap.get("lessonid");
										String lessonscheduleid     = (String)hashmap.get("lessonscheduleid");

										String lessonname      = (String)hashmap.get("lessonname");
										if(req_lessonid != null && req_lessonid.equals(lessonid))
											out.println("<option value='"+lessonid+"' lessonscheduleid='"+lessonscheduleid+"' selected=true>"+lessonname+"</option>");
										else
											out.println("<option value='"+lessonid+"' lessonscheduleid='"+lessonscheduleid+"'>"+lessonname+"</option>");
									}
								}
					
								%>
							</select>
							</td>
											
						</tr>
						<%
							if(archival != null && archival.equals("R")){
						%>		
						<tr>
							<td width='20%' class='tablebold' valign=top>Archival Details</td>
							<td width='1%' class='tablebold' valign=top>:</td>
							<td class='tablelight' width='79%'>
								<h2>This is an Archived Year</h2>
							</td>
						</tr>
						<%		
							}
						%>
					</table>					    	
		    	</td>
		    </tr>
		</table>
		<br>
		<%if(loginusercategory != null && loginusercategory.equals("SA")){%>
		<a href="#" id="viewbut"  class="bt_green" onclick='viewfun()'><span class="bt_green_lft"></span><strong>View Content</strong><span class="bt_green_r"></span></a>
		<%}else if(loginusercategory != null && loginusercategory.equals("S")){%>
				<a href="#" id="viewbut"  class="bt_green" onclick='viewfunforstudent()'><span class="bt_green_lft"></span><strong>View Content</strong><span class="bt_green_r"></span></a>
		<%}else if(loginusercategory != null && loginusercategory.equals("T")){%>
				<a href="#" id="viewbut"  class="bt_green" onclick='viewfunforstaff()'><span class="bt_green_lft"></span><strong>View Content</strong><span class="bt_green_r"></span></a>
		<%} %>
		
<!-- <table width='100%' align='center' border='0' >
			<tr>
				<td width='100%' class='tablebold'>
				
					<table width='100%' id="rounded-corner" align='center' border='0' >
								
								<thead>
								<tr>
												<th scope="col" class="rounded-company" width="1%" ></th>
									        	<th scope="col" class="rounded" width="5%"  >SL.No</th>
									        	<th scope="col" class="rounded" width="40%" >File Name</th>
									        	<th scope="col" class="rounded" width="30%" >Notes</th>
									        	<th scope="col" class="rounded" width="15%" >Date</th>
									        	<th scope="col" class="rounded-q4"	width="1%"></th>
									        	</tr>	
									   </thead>
										<tfoot> 
										   	<tr>
										       	<td colspan="5" class="rounded-foot-left"><em></em></td>
										       	<td class="rounded-foot-right">&nbsp;</td>
										    </tr>
										</tfoot>	
									<tbody> -->		
						<%
						try{
							if(contentlist!=null && contentlist.size()>0)
							{								
								for(int y=0,sno=1;y<contentlist.size();y++)
								{
											HashMap map=(HashMap)contentlist.get(y);
										    String cmscontentid=map.get("cmscontentid")+"";
										    String filepath=map.get("filepath")+"";
										    String filename=map.get("filename")+"";
										    String contentnotes=map.get("contentnotes")+"";
										    String uploadeddate=map.get("uploadeddate")+"";
										    String ordervalue=map.get("ordervalue")+"";
										    out.print("<tr>");
											out.print("<td></td>");
											out.print("<td>"+sno +"</td>");
											out.print("<td><a href='#' atta='"+filepath+"'  cmscontentid='"+cmscontentid+"' onclick='openwindows(this)'>"+filename+"</a></td>");
											out.print("<td>"+contentnotes+"</td>");
											out.print("<td>"+uploadeddate+"</td>");
											out.print("<td></td>");
											out.print("</tr>");
											sno++;
								}
							}
							else
							{
								//out.print("<tr>");
								//out.print("<td colspan=7 align=center>Data Not Found</td>");
								//out.print("</tr>");
							}
						}catch(Exception e){
							e.printStackTrace(); 
						}
						%>
									
					        </tbody>
					        
					</table>
				</td>
			</tr> 
		</table>
		
		<%if(loginusercategory != null && loginusercategory.equals("SA")){%>
		<input type='hidden' name='req_sessionname' 			value=''>
		<input type='hidden' name='req_boardname' 			value=''>
		<input type='hidden' name='req_standardname' 			value=''>
		<%}else if(loginusercategory != null && loginusercategory.equals("T")){%>
		<input type='hidden' name='req_boardname' 			value=''>
		<input type='hidden' name='req_standardname' 			value=''>
		<%}%>
		
		<input type='hidden' name='req_subjectid' 			value=''>
		<input type="hidden" name="lessonscheduleid" value="">
		<input type='hidden' name='cmscontentid' value=''>
		<input type='hidden' name=req_subjectscheduleid value="<%=req_subjectscheduleid %>">
		<input type='hidden' name=req_subjectname value="" >
		<input type='hidden' name=req_filename >
		
		</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>