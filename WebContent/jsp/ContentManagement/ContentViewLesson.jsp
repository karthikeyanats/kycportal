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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquerymenufun.js"></script>
<link rel=stylesheet href="<%=request.getContextPath() %>/css/jquerystyle.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>

<script type="text/javascript">
	function loadStandards()
	{
		document.Content_Form.submit();
	}
	function contenttrash(obj)
	{
	    var row=obj.getAttribute("rwno");
	    if(document.Content_Form.deploystatus.length!=undefined)
	    {
			if(document.Content_Form.deploystatus[row].value=="deployed")
				{
					document.getElementById("warningdiv").style.display='block';
					window.setTimeout("displayfun();",5000);
				}
			else
			{
				if(confirm("You Want To Trash The Content"))
					{
						document.Content_Form.editstatus.value="T";
						var cmscontentid=obj.getAttribute("cmscontentid");
					    document.Content_Form.cmscontentid.value=cmscontentid;
						document.Content_Form.action = "./LessonContentTrashSubmit.jsp";
						document.Content_Form.submit();
					}
			}
		}
		else
		{	
			if(document.Content_Form.deploystatus.value=="deployed")
				{
					document.getElementById("warningdiv").style.display='block';
					window.setTimeout("displayfun();",5000);
				}
			else
			{
				if(confirm("You Want To Trash The Content"))
					{
						document.Content_Form.editstatus.value="T";
						var cmscontentid=obj.getAttribute("cmscontentid");
					    document.Content_Form.cmscontentid.value=cmscontentid;
						document.Content_Form.action = "./LessonContentTrashSubmit.jsp";
						document.Content_Form.submit();
					}
			}
		
		}
	}
	
	function Trashfun()
	{
		document.Content_Form.action = "./TrashedContentViewLesson.jsp";
		document.Content_Form.submit();
	}
	function displayfun()
	{
		document.getElementById('warningdiv').style.display='none'
	}
	function goBack()
	{
		document.Content_Form.action = "./contenthome.jsp";
		document.Content_Form.submit();
	}
	function contentedit(obj)
	{
		var cmscontentid=obj.getAttribute("cmscontentid");
		document.Content_Form.cmscontentid.value=cmscontentid;
		document.Content_Form.action = "./EditContentForLesson.jsp";
		document.Content_Form.submit(); 
	}
	function previousfun()
	{
		document.Content_Form.action = "./ContentViewPrevioussession.jsp";
		document.Content_Form.submit(); 
	}
	function win(obj)
	{
	var attachment=obj.getAttribute("atta");
	window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachment+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300,scrollbars=1;")
	}
	function allocatefun()
	{
			var status="no";

			if(document.Content_Form.chkstatus.value=="chk")
				{
					if(document.Content_Form.chk.length!=undefined)
						{
						for(var i=0;i<document.Content_Form.chk.length;i++)
							{
								if(document.Content_Form.chk[i].checked)
								{
									status="yes";
								}
							}
						}
					else
						{
							if(document.Content_Form.chk.checked)
								{
									status="yes";
								}
						}
		if(confirm("You Want To Deploy The Content"))
		{
		if(status=="yes")
		{	
		if(document.Content_Form.chk.length!=undefined)
			{
				for(var i=0;i<document.Content_Form.chk.length;i++)
					{
						if(document.Content_Form.chk[i].checked)
						{
							document.Content_Form.dep_cmscontentid[i].disabled=false;
						}
						else
						{
							document.Content_Form.dep_cmscontentid[i].disabled=true;
						}
					}
			}
		document.Content_Form.action = "./LessonContentDeploySubmit.jsp";
		document.Content_Form.submit();
		}
		else
		{
			alert("Select Any One File");
		}
		}
		}
		else
		{
					alert("Already Deployed");
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

    <h2>Content Management / Standard Subject View / Existing Content</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Content.ContentQurey,com.iGrandee.Common.DateTime"%>
<form name="Content_Form"  method="post" action="" >
<%
ContentQurey query =new ContentQurey();
String instituteid=(String)session.getValue("instituteid");
String req_sessionname=request.getParameter("req_sessionname")+"";
String req_boardname=request.getParameter("req_boardname")+"";
String req_standardname=request.getParameter("req_standardname")+"";
String req_subjectname=request.getParameter("req_subjectname")+"";
String req_lessonname=request.getParameter("req_lessonname")+"";
String req_subjectid=request.getParameter("req_subjectid")+"";
String req_lessonid=request.getParameter("req_lessonid")+"";
String sessionid=request.getParameter("sessionname")+"";
String standardscheduleid=request.getParameter("standard")+"";
ArrayList contentlist=query.LoadExistContentLesson(sessionid,req_lessonid,"A"); 
%>
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="1%"></th>
		            <th scope="col" class="rounded" 		width="98%">Selected Details</th>
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
							<%=req_sessionname %>
							</td>
							<td width='20%' class='tablebold' align=right>Board</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=req_boardname %>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>Standard</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' >
														<%=req_standardname %>
							
							</td>
							<td width='20%' class='tablebold' align=right>Subject</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' >
														<%=req_subjectname %>
							
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>Lesson</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan=4>
														<%=req_lessonname %>
							
							</td>
							
						</tr>
						
						<%
							if(false){
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
					<input type="hidden" name="instituteid" value="<%=instituteid %>">
					<input type='hidden' name='req_subjectid' 		value='<%=req_subjectid %>'>
					<input type='hidden' name='req_lessonid' 			value='<%=req_lessonid %>'>
					<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid %>'>
					<input type='hidden' name='sessionid' 			value='<%=sessionid %>'>
					<input type='hidden' name='standard' 	        value='<%=standardscheduleid %>'>
					<input type='hidden' name='cmscontentid' 	    value=''>
					<input type='hidden' name='sessionname' 			value='<%=sessionid %>'>
					<input type='hidden' name=board 					value='<%=request.getParameter("board")%>'>	
					<input type='hidden' name='req_sessionname' 		value='<%=req_sessionname %>'>
					<input type='hidden' name=req_boardname 			value='<%=req_boardname %>'>				    	
					<input type='hidden' name='req_standardname' 		value='<%=req_standardname %>'>
					<input type='hidden' name='req_subjectname' 		value='<%=req_subjectname %>'>
					<input type='hidden' name=req_lessonname 			value='<%=req_lessonname%>'>
					<input type='hidden' name=editstatus 			value=''>
					<input type='hidden' name='lessonscheduleid' value="<%=request.getParameter("lessonscheduleid") %>">
					<input type='hidden' name='contentstaus' value="current">
					
						  			    	
				</td>
		    </tr>
		</table>
		<br>
		<div class="warning_box" style="display:none" id="warningdiv">The Selected Content is Deployed for Current Academic Year so can't Trash</div>
		<br>	
		<table width='100%' id="rounded-corner" align='center' border='0' >
								
								<thead>
								<tr>
												<th scope="col" class="rounded-company" width="1%" ></th>
									        	<th scope="col" class="rounded" width="5%" >Sl.No</th>
									        	<th scope="col" class="rounded" width="30%"  >File Name</th>
									        	<th scope="col" class="rounded" width="20%" >Notes</th>
									        	<th scope="col" class="rounded" width="15%" >Edit</th>
									        	<th scope="col" class="rounded" width="15%" >Trash</th>
									        	<th scope="col" class="rounded" width="15%" >Check</th>
									        	<th scope="col" class="rounded-q4"	width="1%"></th>
									        	</tr>	
									   </thead>
									   <tfoot>
									   	<tr>
									       	<td colspan="7" class="rounded-foot-left"><em></em></td>
									       	<td class="rounded-foot-right">&nbsp;</td>
									    </tr>
									</tfoot>	
									<tbody>
						<%
						int x=0;
						try{
							if(contentlist.size()>0)
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
													out.print("<td><a href='#' atta='"+filepath+"' onclick='win(this)'>"+filename+"</a></td>");
													out.print("<td>"+contentnotes+"</td>");
													out.print("<td><a href='#' cmscontentid='"+cmscontentid+"' onclick='contentedit(this)' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_edit.png' alt='EDIT' title='EDIT' border=0 /></a></td>");
													out.print("<td><a href='#' rwno='"+y+"' cmscontentid='"+cmscontentid+"' onclick='contenttrash(this)' ><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='Trash' title='Trash' border=0 /></a></td>");
													int i=query.checkcontentalreadyalloted(request.getParameter("lessonscheduleid"),cmscontentid);
													if(i==0)
													{
														x++;
														out.print("<td><input type='checkbox' name='chk'  value=''><input type='hidden' name='dep_cmscontentid' value='"+cmscontentid+"'><input type='hidden' name='deploystatus' value='undeployed'></td>");
													}
													else
													{
														out.print("<td>Deployed<input type='hidden' name='deploystatus' value='deployed'>");
														out.print("</td>");

													}	
													out.print("<td></td>");
													out.print("</tr>");
													sno++;
								}
										
							}
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
							    //out.print("<tr>");
							    //out.print("<td align=center colspan=8>Data Not Found");
							    //out.print("</tr>");

								
							}
						}catch(Exception e){
							e.printStackTrace(); 
						}
						%>
									
					        </tbody>
					        
					</table>
					<%if(x==0)
						out.print("<input type='hidden' name='chkstatus'  value='nochk'>"); 
					else
						out.print("<input type='hidden' name='chkstatus'  value='chk'>"); 
 
						%>
			<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
			<a href="#" class="bt_red" onclick='Trashfun()'><span class="bt_red_lft"></span><strong>Trashed Content</strong><span class="bt_red_r"></span></a>
			<a href="#" class="bt_green" onclick='previousfun()'><span class="bt_green_lft"></span><strong>Previous Session Content</strong><span class="bt_green_r"></span></a>
			<a href="#" class="bt_green" onclick='allocatefun()'><span class="bt_green_lft"></span><strong>Deploy</strong><span class="bt_green_r"></span></a>
			
			
</form>		


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
</div>
</body>
</html>