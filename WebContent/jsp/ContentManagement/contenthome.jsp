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
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<link rel=stylesheet href="<%=request.getContextPath() %>/css/jquerystyle.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquerymenufun.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<script type="text/javascript">
ddaccordion.init({
	headerclass: "submenuheader", //Shared CSS class name of headers group
	contentclass: "submenu", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
	onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", ""], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["prefix", "<img src='<%=request.getContextPath()%>/jsp/kycpanel/images/plus.gif' class='statusicon' />", "<img src='<%=request.getContextPath()%>/jsp/kycpanel/images/minus.gif' class='statusicon' />"], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing
	}
})
</script>
<script type="text/javascript">
	function loadStandards()
	{
		document.Schedule_Form.submit();
	}
	function loadStandardss()
	{
		document.Schedule_Form.submit();
	}
	function UploadContent(obj)
	{
		document.Schedule_Form.req_sessionname.value=document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text;
		document.Schedule_Form.req_boardname.value=document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.req_standardname.value=document.Schedule_Form.standard.options[document.Schedule_Form.standard.options.selectedIndex].text;
		document.Schedule_Form.req_subjectname.value=obj.getAttribute("subjectname");
		document.Schedule_Form.req_subjectid.value=obj.getAttribute("subjectid");
		document.Schedule_Form.req_lessonname.value=obj.getAttribute("lessonname");
		document.Schedule_Form.req_lessonid.value=obj.getAttribute("lessonid");
		document.Schedule_Form.action = "./ContentForLesson.jsp";
		document.Schedule_Form.submit();
	}
	function existContent(obj)
	{

		document.Schedule_Form.req_sessionname.value=document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text;
		document.Schedule_Form.req_boardname.value=document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.req_standardname.value=document.Schedule_Form.standard.options[document.Schedule_Form.standard.options.selectedIndex].text;
		document.Schedule_Form.req_subjectname.value=obj.getAttribute("subjectname");
		document.Schedule_Form.req_subjectid.value=obj.getAttribute("subjectid");
		document.Schedule_Form.req_lessonname.value=obj.getAttribute("lessonname");
		document.Schedule_Form.req_lessonid.value=obj.getAttribute("lessonid");
		document.Schedule_Form.lessonscheduleid.value=obj.getAttribute("lessonscheduleid");
		document.Schedule_Form.action = "./ContentViewLesson.jsp";
		document.Schedule_Form.submit();
	}
		function DeployedContent(obj)
	{
		document.Schedule_Form.req_sessionname.value=document.Schedule_Form.sessionname.options[document.Schedule_Form.sessionname.options.selectedIndex].text;
		document.Schedule_Form.req_boardname.value=document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.req_standardname.value=document.Schedule_Form.standard.options[document.Schedule_Form.standard.options.selectedIndex].text;
		document.Schedule_Form.req_subjectname.value=obj.getAttribute("subjectname");
		document.Schedule_Form.req_subjectid.value=obj.getAttribute("subjectid");
		document.Schedule_Form.req_lessonname.value=obj.getAttribute("lessonname");
		document.Schedule_Form.req_lessonid.value=obj.getAttribute("lessonid");
		document.Schedule_Form.lessonscheduleid.value=obj.getAttribute("lessonscheduleid");
		document.Schedule_Form.action = "./DeployedContentViewLesson.jsp";
		document.Schedule_Form.submit();
	}


	function printfun()
	{
		//var attachment=obj.getAttribute("atta");
		document.Schedule_Form.boardname.value		= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		window.open("PrintPreviewStandardSchedule.jsp?boardname="+document.Schedule_Form.boardname.value+"&req_sessionname="+document.Schedule_Form.req_sessionname.value+"&req_sessionid="+document.Schedule_Form.req_sessionid.value+"&board="+document.Schedule_Form.board.value+"&req_sessionname="+document.Schedule_Form.req_sessionname.value+"&req_sessionid="+document.Schedule_Form.req_sessionid.value+"&board="+document.Schedule_Form.board.value+"&req_sessionstatus="+document.Schedule_Form.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
		//document.Schedule_Form.action = "PrintPreviewStandardSchedule.jsp";
		//document.Schedule_Form.submit();
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

    <h2>Content Management / Standard Subject View</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Content.ContentQurey,com.iGrandee.Common.DateTime"%>
<%

		ContentQurey cquery			= new ContentQurey();
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList yearList			= cquery.sessionDetails(instituteid);
		ArrayList boardList			= cquery.boardDetails(instituteid);
		HashMap	hashmap				= null;
		ArrayList standardList		= null;
		ArrayList subjectList		= null;
		String groupstatus			= "";
		String req_standardscheduleid	=  request.getParameter("standard");
		int count					= 0;
		int stotal					= 0;
		int tcount					= 0;
		int datacount				= 0;
		String req_sessionid		= request.getParameter("sessionname");
		String boardid				= request.getParameter("board");


		String today				= DateTime.showTime("calendar");
		String archival				= request.getParameter("req_sessionstatus");
		String tempstandardid		= "";
		out.println();
		if(req_sessionid != null && boardid != null) {
			standardList			= cquery.standardDetails(instituteid,req_sessionid,boardid);
		}
		if(req_sessionid != null && !req_sessionid.equals("00") &&  boardid != null && !boardid.equals("00") && req_standardscheduleid != null && !req_standardscheduleid.equals("00") ) {
			subjectList			= cquery.viewSubjects(req_standardscheduleid);
		}
		//out.println("req_standardscheduleid"+req_standardscheduleid);
%>
<form name="Schedule_Form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="1%"></th>
		            <th scope="col" class="rounded" 		width="100%">Academic Year and Board Details</th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
			<tfoot>
			   	<tr>
			       	<td colspan="2" class="rounded-foot-left"><em></em></td>
			       	<td class="rounded-foot-right">&nbsp;</td>
			    </tr>
			</tfoot>
		    <tr>
		    	<td colspan='3'>
					<table width='80%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold'>Academic Year</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<select name=sessionname class=tablelight onchange=loadStandards()>
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
							</td>
							<td width='20%' class='tablebold' align=right>Board</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='board' validate='Board Name' onchange='loadStandardss()'>
									<option value='00'>-Select Board-</option>
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
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>Standard</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan=4>
							<select name=standard class=tablelight onchange=loadStandards() validate="Standard">
								<option value="00">-Select Standard-</option>
								<%
								if(standardList != null && standardList.size()>0){

									for(int y=0;y<standardList.size();y++){

										hashmap			= (HashMap)standardList.get(y);
										groupstatus		= (String)hashmap.get("groupstatus");
										//String standardid		= (String)hashmap.get("standardid");
										String standardscheduleid		= (String)hashmap.get("standardscheduleid");

										String standardname		= (String)hashmap.get("standardname");
										String groupname		= (String)hashmap.get("groupname");
										if(groupstatus != null && !groupstatus.equals("No")){

											standardname=standardname+" -"+groupname;
										}
										if(req_standardscheduleid != null && req_standardscheduleid.equals(standardscheduleid))
											out.println("<option value='"+standardscheduleid+"' selected=true>"+standardname+"</option>");
										else
											out.println("<option value='"+standardscheduleid+"'>"+standardname+"</option>");
									}
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
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='100%' class='tablebold'>

					<table border=0  width="100%" align=left>
								<tbody>
									<tr>
									<td colspan=3 width='100%' class=tablebold align=left>

					<div class="sidebarmenu" align=left width='100%'>
						<%
						try{
							int x=0;
							if(subjectList != null && subjectList.size()>0){
								//out.println(subjectList);
								for(int y=0;y<subjectList.size();y++){
									hashmap				= (HashMap)subjectList.get(y);
					    			String status		= (String)hashmap.get("status");
					    			String subjectname		= (String)hashmap.get("subjectname");
					    			String subjectid		= (String)hashmap.get("subjectid");
					    			String subjectscheduleid		= (String)hashmap.get("subjectscheduleid");
					    			String subjectcode		= (String)hashmap.get("subjectcode");
					    			if(status.equals("Yes"))
					    			{


											out.print("<a class='menuitem submenuheader'   align=left href='' style='width:800px;background-color:#60c8f2;background-image:none;'>"+subjectname +"  ( "+subjectcode+" )</a>");
											out.print("<div class='submenu' style='width:810px' >");
											   ArrayList lessonList			= cquery.listLesson(subjectscheduleid);
												out.print("<table style='width:810px;'  id='rounded-corner1'  align=center>");
												%>
												<tr style='background-color:#85E0FF;height:30px'>

									        	<th scope="col" class="rounded" width="5%" >Sl.No</th>
									        	<th scope="col" class="rounded" width="20%"  >Lesson Name</th>
									        	<th scope="col" class="rounded" width="70%" colspan=3>Content Management</th>

									        	</tr>
									        	<%
												if( lessonList !=null && lessonList.size()>0)
												{
													for(int y1=0,sno=1;y1<lessonList.size();y1++)
													{

														hashmap				= (HashMap)lessonList.get(y1);
														String lessonid     = (String)hashmap.get("lessonid");
														String lessonname      = (String)hashmap.get("lessonname");
														String lessonscheduleid      = (String)hashmap.get("lessonscheduleid");
														/*out.println("req_standardscheduleid"+req_standardscheduleid);
									    				out.println("subjectscheduleid"+subjectscheduleid);
									    				out.println("lessonscheduleid"+lessonscheduleid);*/
														out.print("<tr>");
														out.print("<td>"+sno +"</td>");
														out.print("<td>"+lessonname +"</td>");
														out.print("<td><a href='#' subjectid='"+subjectid+"' subjectname='"+subjectname+"' lessonname='"+lessonname+"' lessonid='"+lessonid+"' onclick='UploadContent(this)'><font color='#000080'>"+"Upload Content</font></a></td>");
														out.print("<td><a href='#' subjectid='"+subjectid+"' subjectname='"+subjectname+"' lessonname='"+lessonname+"' lessonid='"+lessonid+"' lessonscheduleid='"+lessonscheduleid+"' onclick='DeployedContent(this)'><font color='#000080'>Deployed Content</font></a></td>");
														out.print("<td><a href='#' subjectid='"+subjectid+"' subjectname='"+subjectname+"' lessonname='"+lessonname+"' lessonid='"+lessonid+"' lessonscheduleid='"+lessonscheduleid+"' onclick='existContent(this)'><font color='#000080'>Existing Content</font></a></td>");
														out.print("</tr>");
														sno++;
													}
											    }
												else
												{
													out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
													//out.print("<tr>");
													//out.print("<td colspan=5 align=center>Data Not Found</td>");
													//out.print("</tr>");
                     							}
												out.print("</table>");
									        out.print("</div>");
									        x++;

					    			}

							}
								if(x==0)
								{
									%>
							<table id="rounded-corner" border=0 summary="Department List" width="80%">
							    <thead>
							    	<tr>
							        	<th scope="col" class="rounded-company" width="1%"></th>
							            <th scope="col" class="rounded" 		width="98%">Subject Details</th>
							            <th scope="col" class="rounded-q4" 		width="1%"></th>
							        </tr>
							    </thead>
								<tfoot>
								   	<tr>
								       	<td colspan="2" class="rounded-foot-left"><em></em></td>
								       	<td class="rounded-foot-right">&nbsp;</td>
								    </tr>
								</tfoot>
								<tbody>
								<tr><td colspan='3' align='center'>Data Not Found</td></tr>
								</tbody>
								</table>
								<%
								}
							}
							else
							{
								%>
						<table id="rounded-corner" border=0 summary="Department List" width="80%">
						    <thead>
						    	<tr>
						        	<th scope="col" class="rounded-company" width="1%"></th>
						            <th scope="col" class="rounded" 		width="98%">Subject Details</th>
						            <th scope="col" class="rounded-q4" 		width="1%"></th>
						        </tr>
						    </thead>
							<tfoot>
							   	<tr>
							       	<td colspan="2" class="rounded-foot-left"><em></em></td>
							       	<td class="rounded-foot-right">&nbsp;</td>
							    </tr>
							</tfoot>
							<tbody>
							<tr><td colspan='3' align='center'>Data Not Found</td></tr>
							</tbody>
							</table>
							<%
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

		<input type='hidden' name='req_sessionname' 			value=''>
		<input type='hidden' name='req_boardname' 			value=''>
		<input type='hidden' name='req_standardname' 			value=''>
		<input type='hidden' name='req_lessonname' 			value=''>
		<input type='hidden' name='req_subjectname' 			value=''>
		<input type='hidden' name='req_subjectid' 			value=''>
		<input type='hidden' name='req_lessonid' 			value=''>
		<input type='hidden' name='lessonscheduleid' 			value=''>

</form>

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>


</div>
</body>

</html>