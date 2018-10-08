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
<script type="text/javascript">
	function updatecontent()
	{
			if(document.Content_Form.uploadedfile.value=="")
			{
				if(document.Content_Form.filepath.value=="")
				{
				   alert("Empty File is Allowed ")
				   obj.checked=false;
				   return false;
				 }
			}
			if(!check_ForParticularElements(document.Content_Form.notes,"textarea"))
			{
			   obj.checked=false;
			   return false;   
			}
			document.Content_Form.action = "./LessonContentEditSubmit.jsp";
			document.Content_Form.submit();
		
	}
	function uploadcontent()
	{
	var status="no";
		for(var i=0;i<document.Content_Form.chk.length;i++)
			{
				if(document.Content_Form.chk[i].checked)
				{
					status="yes";
				}
				
			}
			if(status=="yes")
			{
				for(var i=0;i<document.Content_Form.chk.length;i++)
				{
					if(document.Content_Form.chk[i].checked)
					{
						eval("document.Content_Form.uploadedfile"+i+".disabled=false");
						document.Content_Form.notes[i].disabled=false;
						document.Content_Form.slidename[i].disabled=false;
					}
					else
					{
						eval("document.Content_Form.uploadedfile"+i+".disabled=true");
						document.Content_Form.notes[i].disabled=true;
						document.Content_Form.slidename[i].disabled=true;
					}
				}
				document.Content_Form.action = "./LessonContentSubmit.jsp";
				document.Content_Form.submit();
			}
			else
			{
				alert("Select Any One File");
			}
	}
	function goBack()
	{
		document.backform.action = "./ContentViewLesson.jsp";
		document.backform.submit();
	}
	function contentedit(obj)
	{
		var cmscontentid=obj.getAttribute("cmscontentid");
		document.Content_Form.cmscontentid.value=cmscontentid;
		document.Content_Form.action = "./EditContentForLesson.jsp";
		document.Content_Form.submit(); 
	}
	function win(obj)
	{
	var attachment=obj.getAttribute("atta");
	window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachment+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300,scrollbars=1;")
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

    <h2>Content Management / Standard Subject View / Existing Content / Edit Content</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Content.ContentQurey,com.iGrandee.Common.DateTime"%>
<form name="Content_Form"  method="post" action="" enctype="multipart/form-data">
<%
ContentQurey query =new ContentQurey();
String instituteid=(String)session.getValue("instituteid");
String req_sessionname=request.getParameter("req_sessionname")+"";
String req_boardname=request.getParameter("req_boardname")+"";
String req_standardname=request.getParameter("req_standardname")+"";
String req_subjectname=request.getParameter("req_subjectname")+"";
String req_subjectid=request.getParameter("req_subjectid")+"";
String req_lessonname=request.getParameter("req_lessonname")+"";
String req_lessonid=request.getParameter("req_lessonid")+"";
String req_lessonscheduleid=request.getParameter("lessonscheduleid")+"";

String sessionid=request.getParameter("sessionid")+"";
String standardscheduleid=request.getParameter("standardscheduleid")+"";
String cmscontentid=request.getParameter("cmscontentid")+"";
ArrayList contentlist=query.LoadLessonContent(sessionid,req_lessonid,cmscontentid);
/*
out.println(req_lessonscheduleid);
out.println(cmscontentid);*/

int i=query.checkcontentalreadyalloted(req_lessonscheduleid,cmscontentid);

%>
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		   	    	<th scope="col" class="rounded-company" width="90%">Selected Information</th>
		            <th scope="col" class="rounded-q4" 		width="10%"></th>
		        </tr>
		    </thead>
			<tfoot>
			   	<tr>
			       	<td class="rounded-foot-left"><em></em></td>
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
							if(i==1){
						%>		
						<tr>
							<td class='tablelight' colspan=6>
								<div class="warning_box">This Content is Deployed for Current Academic Year so can't Delete or Edit</div>
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
					<input type='hidden' name=cmscontentid 			value='<%=cmscontentid%>'>				    	
					<input type='hidden' name='standard' 	value='<%=standardscheduleid %>'>
					<input type='hidden' name='sessionname' 			value='<%=sessionid %>'>
					<input type='hidden' name=board 			value='<%=request.getParameter("board")%>'>
					<input type='hidden' name='req_sessionname' 		value='<%=req_sessionname %>'>
					<input type='hidden' name=req_boardname 			value='<%=req_boardname %>'>				    	
					<input type='hidden' name='req_standardname' 		value='<%=req_standardname %>'>
					<input type='hidden' name='req_subjectname' 		value='<%=req_subjectname %>'>
					<input type='hidden' name=req_lessonname 			value='<%=req_lessonname%>'>
					<input type='hidden' name=lessonscheduleid 			value='<%=req_lessonscheduleid%>'>
					
					
									    	
		    	</td>
		    </tr>
		</table>
		<br>
<table width='100%'  border=0 bordercolor=white cellpadding=0 cellspacing=0>
<tr valign=top>
<td width='50%'>
		<table width='100%' id="rounded-corner_home"  height="100%"  align='center' border='0' >
								
								<thead>
									<tr  height="20px" >
										<th scope="col" class="rounded-company" width="99%" colspan=2>Update Content</th>
							        	<th scope="col" class="rounded-q4"	width="1%"></th>
							       	</tr>	
						 	   </thead>
							   <tfoot>
								   	<tr  height="20px" >
								       	<td class="rounded-foot-left" colspan=2 ><em></em></td>
								       	<td class="rounded-foot-right">&nbsp;</td>
								    </tr>
							  </tfoot>	
							  <tbody>
									<%
									try{
										if(contentlist.size()>0)
										{
											for(int y=0,sno=1;y<contentlist.size();y++)
											{
													HashMap map=(HashMap)contentlist.get(y);
												    String filepath=map.get("filepath")+"";
												    String filename=map.get("filename")+"";
												    String contentnotes=map.get("contentnotes")+"";
												    String uploadeddate=map.get("uploadeddate")+"";
												    String ordervalue=map.get("ordervalue")+"";
												    String title=map.get("contenttitle")+"";
												    String cmsmetainfoid=map.get("cmsmetainfoid")+"";
												    String source=map.get("source")+"";
												    String presentername=map.get("presentername")+"";
												    String metainstitutename=map.get("institutionname")+"";
												    String referenceurl=map.get("referenceurl")+"";
												    String licensedby=map.get("licensedby")+"";
												    String description=map.get("description")+"";
												    if(description.equalsIgnoreCase("null"))
												    	description="";
												    if(licensedby.equalsIgnoreCase("null"))
												    	licensedby="";
												    if(metainstitutename.equalsIgnoreCase("null"))
													    metainstitutename="";
												    if(referenceurl.equalsIgnoreCase("null"))
												    	referenceurl="";
												    if(presentername.equalsIgnoreCase("null"))
												    	presentername="";
												    if(source.equalsIgnoreCase("null"))
												    	source="";
												    if(title.equalsIgnoreCase("null"))
												    	title="";
												    
												    out.print("<tr  valign=top><td width='60%'  colspan=3><table border=0>");
													out.print("<tr><td>Existing Content</td><td> <a href='#' atta='"+filepath+"' onclick='win(this)'>"+filename+"</a></td>");
													out.print("</tr>");
													out.print("<tr><td>File</td><td><input  type ='file'  name='uploadedfile' value=''><input  type ='hidden'  name='filepath' value='"+filepath+"'><input  type ='hidden'  name='filename' value='"+filename.replaceAll("'","&#039;")+"'></td>");
													out.print("</tr>");
													out.print("<tr valign=top>");
													out.print("<td>Notes</td><td><textarea rows=5 cols=35 name=notes validate='Notes'  onkeydown=textCounter_label(document.Content_Form.notes,document.getElementById('labelid'),1000) onkeyup=textCounter(document.Content_Form.notes,document.getElementById('labelid'),1000)>"+contentnotes+"</textarea></td>");
													out.print("</tr>");
													out.print("<tr>");
													out.print("<td colspan=2 align=left><i><font color='red'><label id='labelid' >1000</label>&nbsp;&nbsp;Characters Only</font></i><input type=hidden name=cmsmetainfoid value='"+cmsmetainfoid+"'></td></tr></table></td>");
													%>
													</tr>
													</tbody>
													</table>
													</td>
													<td>
													&nbsp;
													</td>
													<td width='40%'  height="100%" >
													<table width='100%' height="100%" id="rounded-corner_home" align='center' border='0' >
															<thead>
																<tr>
																	<th scope="col" class="rounded-company" width="99%" colspan=2>Update MetaData</th>
														        	<th scope="col" class="rounded-q4"	width="1%"></th>
													        	</tr>	
														   </thead>
														    <tfoot>
															   	<tr>
															       	<td class="rounded-foot-left" colspan=2><em></em></td>
															       	<td class="rounded-foot-right">&nbsp;</td>
															    </tr>
															</tfoot>	
														<tbody>
													<%
													out.print("<td  colspan=2><table width='100%'  border='0' >");
													out.print("<tr><td >Title</td><td ><input type='text' name='title' Validate='Title' value='"+title+"'></td></tr>");
													out.print("<tr><td >Source</td><td ><input type='text' name='source' Validate='Source' value='"+source+"'></td></tr>");
													out.print("<tr><td >Presenter Name</td><td ><input type='text' name='presentername' Validate='Presenter Name' value='"+presentername+"'></td></tr>");
													out.print("<tr><td >Institute Name</td><td ><input type='text' name='institutename' Validate='Institute Name' value='"+metainstitutename+"'></td></tr>");
													out.print("<tr><td >Reference URL</td><td ><input type='text' name='referenceurl' Validate='Reference URL' value='"+referenceurl+"'></td></tr>");
													out.print("<tr><td >Licensed By</td><td ><input type='text' name='licensedby' Validate='Licensed By' value='"+licensedby+"'></td></tr>");
													out.print("<tr><td colspan=2>Description </td></tr>");
													out.print("<tr><td  colspan=2><textarea rows=4 cols=45 name=description validate='Description'   onkeydown=textCounter_label(document.Content_Form.description,document.getElementById('seclabelid'),500) onkeyup=textCounter(document.Content_Form.description,document.getElementById('seclabelid'),500)>"+description+"</textarea></td></tr><tr><td colspan=2 align=left><i><font color='red'><label id='seclabelid' >500</label>&nbsp;&nbsp;Characters Only</font></i></td></tr>");
													out.print("</table></td><td></td></tr>");
											}
													
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
			<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

						<%
							if(i!=1){
						%>		
			<a href="#" class="bt_green" onclick='updatecontent()'><span class="bt_green_lft"></span><strong>Update Content</strong><span class="bt_green_r"></span></a>
						<%		
							}  
						%>			

		
</form>		
<form name=backform method=post action="">
<input type="hidden" name="instituteid" value="<%=instituteid %>">
<input type='hidden' name='req_subjectid' 		value='<%=req_subjectid %>'>
<input type='hidden' name='req_lessonid' 			value='<%=req_lessonid %>'>
<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid %>'>
<input type='hidden' name='sessionid' 			value='<%=sessionid %>'>
<input type='hidden' name=cmscontentid 			value='<%=cmscontentid%>'>				    	
<input type='hidden' name='standard' 	value='<%=standardscheduleid %>'>
<input type='hidden' name='sessionname' 			value='<%=sessionid %>'>
<input type='hidden' name=board 			value='<%=request.getParameter("board")%>'>
<input type='hidden' name='req_sessionname' 		value='<%=req_sessionname %>'>
<input type='hidden' name=req_boardname 			value='<%=req_boardname %>'>				    	
<input type='hidden' name='req_standardname' 		value='<%=req_standardname %>'>
<input type='hidden' name='req_subjectname' 		value='<%=req_subjectname %>'>
<input type='hidden' name=req_lessonname 			value='<%=req_lessonname%>'>
<input type='hidden' name=lessonscheduleid 			value='<%=req_lessonscheduleid%>'>
<input type='hidden' name=editstatus 			value=''>
</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>