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
	function loadStandards()
	{
		document.Schedule_Form.submit();
	}
	function checkfilesize(id,flag)
	{
	   var url = "";
	   if(flag=="filesize")
	   {
		   url = "./getLContentInfo.jsp?action=filesize&id="+id;
	   }
	   else
	   {
		   alert("The Key does not match with any value,URL is Empty, Please contact Administrator/Programmer");
	   }
	   var req =initRequest();
	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
			   if (req.status == 200)
			   {
				   if(flag=="filesize")
				  {
					 parseMessages(req.responseXML,flag);
				  }
			   }
			}
	   };
	   req.open("GET", url, true);
	   req.send(null);
	}
	function parseMessages(parseXML,flag)
	{
		if(flag=="filesize") 
		{
			var rootObj=parseXML.getElementsByTagName("filesize");
			var cNode_1=rootObj[0].childNodes.length;
			
			if(cNode_1>0)
			{
			
			for(var i=0;i<parseInt(cNode_1);i++)
			{
				var size=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				alert(size);
				if(temp=="true")
				{
					alert("File Size More than 10 MB");
					return false;
				}
			
			}
				/*document.f1.hiddenuser_id.value=document.f1.user_id.value;
				document.f1.rolename.value=document.f1.user_role.options[document.f1.user_role.selectedIndex].text;
				document.f1.departname.value=document.f1.user_department.options[document.f1.user_department.selectedIndex].text;
				document.f1.action= "./StaffProfilePreView.jsp";
				document.f1.submit();*/ 
			}
		}
	}
	function checkfun(obj)
	{
	
	var rownum=obj.getAttribute("rowno");
	   if(obj.checked)
		{
			if(eval("document.Schedule_Form.uploadedfile"+rownum+".value==''"))
			{
				   alert("Empty File is Allowed ")
				   obj.checked=false;
				   return false;
			}
			/*else if(eval("document.Schedule_Form.uploadedfile"+rownum+".value!=''"))
			{
				   checkfilesize(eval("document.Schedule_Form.uploadedfile"+rownum+".value"),"filesize")	
				   obj.checked=false;
				   return false;
			}*/
			if(!check_ForParticularElements(document.Schedule_Form.notes[rownum],"textarea",document.Schedule_Form.slidename[rownum],"text"))
				{
				   obj.checked=false;
				   return false;   
				}
			eval("document.Schedule_Form.uploadedfile"+rownum+".disabled=true");
			document.Schedule_Form.notes[rownum].disabled=true;
			document.Schedule_Form.slidename[rownum].disabled=true;
		}
		else 
		{
		eval("document.Schedule_Form.uploadedfile"+rownum+".disabled=false");
		document.Schedule_Form.notes[rownum].disabled=false;
		document.Schedule_Form.slidename[rownum].disabled=false;
		}
	}
	function uploadcontent()
	{
	var status="no";
		for(var i=0;i<document.Schedule_Form.chk.length;i++)
			{
				if(document.Schedule_Form.chk[i].checked)
				{
					status="yes";
				}
				
			}
			if(status=="yes")
			{
				for(var i=0;i<document.Schedule_Form.chk.length;i++)
				{
					if(document.Schedule_Form.chk[i].checked)
					{
						eval("document.Schedule_Form.uploadedfile"+i+".disabled=false");
						document.Schedule_Form.notes[i].disabled=false;
						document.Schedule_Form.slidename[i].disabled=false;
						document.Schedule_Form.title[i].disabled=false;
						document.Schedule_Form.source[i].disabled=false;
						document.Schedule_Form.presentername[i].disabled=false;
						document.Schedule_Form.institutename[i].disabled=false;
						document.Schedule_Form.referenceurl[i].disabled=false;
						document.Schedule_Form.licensedby[i].disabled=false;
						document.Schedule_Form.description[i].disabled=false;
					}
					else
					{
						eval("document.Schedule_Form.uploadedfile"+i+".disabled=true");
						document.Schedule_Form.notes[i].disabled=true;
						document.Schedule_Form.slidename[i].disabled=true;
						document.Schedule_Form.title[i].disabled=true;
						document.Schedule_Form.source[i].disabled=true;
						document.Schedule_Form.presentername[i].disabled=true;
						document.Schedule_Form.institutename[i].disabled=true;
						document.Schedule_Form.referenceurl[i].disabled=true;
						document.Schedule_Form.licensedby[i].disabled=true;
						document.Schedule_Form.description[i].disabled=true;
					}
				}
				document.Schedule_Form.action = "./LessonContentSubmit.jsp";
				document.Schedule_Form.submit();
			}
			else
			{
				alert("Select Any One Option");
			}
	}
	function uploadcontent_old()
	{
	var status="no";
		for(var i=0;i<document.Schedule_Form.chk.length;i++)
			{
				if(document.Schedule_Form.chk[i].checked)
				{
					status="yes";
				}
				
			}
			if(status=="yes")
			{
				for(var i=0;i<document.Schedule_Form.chk.length;i++)
				{
					if(document.Schedule_Form.chk[i].checked)
					{
						eval("document.Schedule_Form.uploadedfile"+i+".disabled=false");
						document.Schedule_Form.notes[i].disabled=false;
						document.Schedule_Form.slidename[i].disabled=false;
					}
					else
					{
						eval("document.Schedule_Form.uploadedfile"+i+".disabled=true");
						document.Schedule_Form.notes[i].disabled=true;
						document.Schedule_Form.slidename[i].disabled=true;
					}
				}
				document.Schedule_Form.action = "./LessonContentSubmit.jsp";
				document.Schedule_Form.submit();
			}
			else
			{
				alert("Select Any One File");
			}
	}
	function goBack()
	{
		document.backform.action = "./contenthome.jsp";
		document.backform.submit();
	}
function getSize()
{
	var myFSO = new ActiveXObject("Scripting.FileSystemObject");
	
	var thefile = myFSO.getFile(filepath);
	var size = thefile.size;
	alert(size + " bytes");
}
function  displaydiv(id)
{
	
	
	//alert(screen.width+'x'+screen.height);
	document.getElementById('backgrounddiv').style.visibility='visible';
	var flag=false;
	for(var i=0;i<5;i++)
		{
		if(i!=id)
			{
			if(eval("document.getElementById('meta"+i+"').style.display==''"))
				flag=true;
			}
		}
	if(!flag)
		{
		if(eval("document.getElementById('meta"+id+"').style.display==''"))
			eval("document.getElementById('meta"+id+"').style.display='none';");
		else
			eval("document.getElementById('meta"+id+"').style.display='';");
		
		document.Schedule_Form.title[id].disabled=false;
		document.Schedule_Form.source[id].disabled=false;
		document.Schedule_Form.presentername[id].disabled=false;
		document.Schedule_Form.institutename[id].disabled=false;
		document.Schedule_Form.referenceurl[id].disabled=false;
		document.Schedule_Form.licensedby[id].disabled=false;
		document.Schedule_Form.description[id].disabled=false;
		}
	else
		{
		alert("Please Close Already Opened Window");
		}
}
function  closefun(id)
{
	if(confirm("Do You Want to Close the Meta Data Window...?"))
		{
			document.Schedule_Form.title[id].value="";
			document.Schedule_Form.source[id].value="";
			document.Schedule_Form.presentername[id].value="";
			document.Schedule_Form.institutename[id].value="";
			document.Schedule_Form.referenceurl[id].value="";
			document.Schedule_Form.licensedby[id].value="";
			document.Schedule_Form.description[id].value="";
			document.Schedule_Form.title[id].disabled=false;
			document.Schedule_Form.source[id].disabled=false;
			document.Schedule_Form.presentername[id].disabled=false;
			document.Schedule_Form.institutename[id].disabled=false;
			document.Schedule_Form.referenceurl[id].disabled=false;
			document.Schedule_Form.licensedby[id].disabled=false;
			document.Schedule_Form.description[id].disabled=false;
			eval("document.getElementById('labelid"+id+"').innerHTML='500'");
			eval("document.getElementById('meta"+id+"').style.display='none';");
			document.getElementById('backgrounddiv').style.visibility='hidden';
		}
}
function  Submitmetafun(id)
{
	if(confirm("Do You Want to Save the MetaData...?"))
	{
		document.Schedule_Form.title[id].disabled=true;
		document.Schedule_Form.source[id].disabled=true;
		document.Schedule_Form.presentername[id].disabled=true;
		document.Schedule_Form.institutename[id].disabled=true;
		document.Schedule_Form.referenceurl[id].disabled=true;
		document.Schedule_Form.licensedby[id].disabled=true;
		document.Schedule_Form.description[id].disabled=true;
		eval("document.getElementById('meta"+id+"').style.display='none';");
		document.getElementById('backgrounddiv').style.visibility='hidden';
	}

}
function  cancelfun(id)
{
	if(confirm("Do You Want to Reset The Field Value...?"))
		{
			document.Schedule_Form.title[id].value="";
			document.Schedule_Form.source[id].value="";
			document.Schedule_Form.presentername[id].value="";
			document.Schedule_Form.institutename[id].value="";
			document.Schedule_Form.referenceurl[id].value="";
			document.Schedule_Form.licensedby[id].value="";
			document.Schedule_Form.description[id].value="";
			document.Schedule_Form.title[id].disabled=false;
			document.Schedule_Form.source[id].disabled=false;
			document.Schedule_Form.presentername[id].disabled=false;
			document.Schedule_Form.institutename[id].disabled=false;
			document.Schedule_Form.referenceurl[id].disabled=false;
			document.Schedule_Form.licensedby[id].disabled=false;
			document.Schedule_Form.description[id].disabled=false;
			eval("document.getElementById('labelid"+id+"').innerHTML='500'");
		}
}
</script>
</head>
<body>
<div id="backgrounddiv" style='visibility:hidden;position:fixed;width:1000px;left:0px;top:0px;height:800px;margin:0px 0px;background-color:#000000;border:1px solid black;-moz-opacity:0.2;-khtml-opacity: 0.2;filter:alpha(opacity=20);opacity:.20;'></div>     
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

    <h2>Content Management / Standard Subject View / Content Upload</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Content.ContentQurey,com.iGrandee.Common.DateTime"%>
<form name="Schedule_Form"  method="post" action="" enctype="multipart/form-data">
<% 
String instituteid=(String)session.getValue("instituteid");
String req_sessionname=request.getParameter("req_sessionname")+"";
String req_boardname=request.getParameter("req_boardname")+"";
String req_standardname=request.getParameter("req_standardname")+"";
String req_subjectname=request.getParameter("req_subjectname")+"";
String req_subjectid=request.getParameter("req_subjectid")+"";
String req_lessonname=request.getParameter("req_lessonname")+"";
String req_lessonid=request.getParameter("req_lessonid")+"";
String sessionid=request.getParameter("sessionname")+"";
String standardscheduleid=request.getParameter("standard")+"";
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
					<input type='hidden' name='standard' 	value='<%=standardscheduleid %>'>
					<input type='hidden' name='sessionname' value='<%=sessionid %>'>
					<input type='hidden' name='board' value='<%=request.getParameter("board") %>'>	  			    	
						
		    	</td>
		    </tr>
		</table>

		<br>
		<table width='100%' id="rounded-corner" align='center' border='0' >
								
								<thead>
								<tr>
												<th scope="col" class="rounded-company" width="1%" ></th>
									        	<th scope="col" class="rounded" width="5%" >Sl.No</th>
									        	<th scope="col" class="rounded" width="20%"  >File Name</th>
									        	<th scope="col" class="rounded" width="30%" >Notes</th>
									        	<th scope="col" class="rounded" width="15%" >Slide Name</th>
									        	<th scope="col" class="rounded" width="15%" >Meta Data</th>
									        	<th scope="col" class="rounded" width="5%" >Check</th>
									        	<th scope="col" class="rounded-q4"		 width="1%"></th>
									        	</tr>	
									   </thead>
									        	
									<tbody>
						<%
						try{
							
								for(int y=0,sno=1;y<10;y++)
								{
													out.print("<tr>");
													out.print("<td ></td>");
													out.print("<td>"+sno +"</td>");
													out.print("<td><input  type ='file'  name='uploadedfile"+y+"' value=''></td>");
													out.print("<td><textarea rows=4 cols=20 name=notes validate='Notes'  maxlength=1000   onkeydown=textCounter_label(document.Schedule_Form.notes["+y+"],document.getElementById('notesid"+y+"'),1000) onkeyup=textCounter(document.Schedule_Form.notes["+y+"],document.getElementById('notesid"+y+"'),1000)></textarea><br><i><font color='red'><label id='notesid"+y+"' >1000</label>&nbsp;&nbsp;Characters Only</font></i></td>");
													out.print("<td><input type=text name='slidename' value=''  validate='Slide Name' maxlength=20></td>");
													out.print("<td><a href='#meta"+y+"' onclick='displaydiv("+y+");'>MetaData</a>");
													out.print("<div id='meta"+y+"' style='position:fixed;left:300px;top:0px;display:none;width:500px;' ><br><table width='100%'  align='center' border='0' cellspacing=0 cellpadding=0  >");   
													out.print("<tr><td  style='background-color:#eeeeee;'   width='100%' colspan=2  class=tablebold >Meta Data <a href='#' onclick='closefun("+y+")' style='float:right;' title='Close'><img id='img_MenuOP' name='img_MenuOP'   border='0' src='../homepage/images/button_grey_close.png' width=25px height=25px alt='close'></a></td></tr>");
													//out.print("<tfoot><tr><td class='rounded-foot-left'><em></em></td><td class='rounded-foot-right'>&nbsp;</td></tr></tfoot>");
													out.print("<tr><td width='25%' class=tablebold   style='background-color:#ffffff;'>Title</td><td   style='background-color:#ffffff;' ><input type='text' name='title' Validate='Title' value='' size=40 maxlength='45'></td></tr>");
													out.print("<tr><td  class=tablebold  style='background-color:#ffffff;'>Source</td><td   style='background-color:#ffffff;'><input type='text' name='source' Validate='Source' value='' size=40 maxlength='45'></td></tr>");
													out.print("<tr><td  class=tablebold  style='background-color:#ffffff;'>Presenter Name</td><td   style='background-color:#ffffff;'><input type='text' name='presentername' Validate='Presenter Name' value='' size=40 maxlength='45'></td></tr>");
													out.print("<tr><td  class=tablebold  style='background-color:#ffffff;'>Institute Name</td><td   style='background-color:#ffffff;'><input type='text' name='institutename' Validate='Institute Name' value='' size=40 maxlength='45'></td></tr>");
													out.print("<tr><td  class=tablebold  style='background-color:#ffffff;'>Reference URL</td><td   style='background-color:#ffffff;'><input type='text' name='referenceurl' Validate='Reference URL' value='' size=40 maxlength='45'></td></tr>");
													out.print("<tr><td  class=tablebold  style='background-color:#ffffff;'>Licensed By</td><td   style='background-color:#ffffff;'><input type='text' name='licensedby' Validate='Licensed By' value='' size=40 maxlength='45'></td></tr>");
													out.print("<tr><td  class=tablebold valign=top  style='background-color:#ffffff;'>Description </td><td   style='background-color:#ffffff;'><textarea rows=4 cols=46 name=description validate='Description'   onkeydown=textCounter_label(document.Schedule_Form.description["+y+"],document.getElementById('labelid"+y+"'),500) onkeyup=textCounter(document.Schedule_Form.description["+y+"],document.getElementById('labelid"+y+"'),500)></textarea><br><i><font color='red'><label id='labelid"+y+"' >500</label>&nbsp;&nbsp;Characters Only</font></i></td></tr>");
													out.print("<tr><td colspan=2  style='background-color:#ffffff;'><a href='#' id='savebut'  class='bt_red' onclick='cancelfun("+y+")'><span class='bt_red_lft'></span><strong>Reset</strong><span class='bt_red_r'></span></a><a href='#' id='savebut'  class='bt_green' onclick='Submitmetafun("+y+")'><span class='bt_green_lft'></span><strong>Save</strong><span class='bt_green_r'></span></a></td></tr>");
													out.print("</table><br></div></td>");
													out.print("<td ><input type=checkbox name='chk' rowno='"+y+"' onclick='checkfun(this)'></td>");
													out.print("<td width=1px></td>");
													out.print("</tr>");
													sno++;
								}
										
							
						}catch(Exception e){
							e.printStackTrace(); 
						}
						%>
									
					        </tbody>
					        
					</table>
					<a class=tablelight >
			<font color=black>
			<table border=0 width=100% >
			<tr>
			<td colspan=3 align=left class=tablebold><font color=red>Note :                  </font>The Following Content Type(s) Only Allowed</font></td>
			</tr>
			<tr>
			<td width="20%"  align=left class=tablebold>Presentation Content</td><td>:</td><td >*.txt,*.jpeg,*.jpg,*.gif,*.png,*.bmp,*.doc,*.docx,*.ppt,*.pptx,*.swf,*.pdf</td>
			</tr>
			<tr>
			<td width="20%"  align=left class=tablebold>Audio Content</td><td>:</td><td >*.wav,*.mp3,*.wma</td>
			</tr>
			<tr>
			<td width="20%"  align=left class=tablebold>Video Content</td><td>:</td><td >*.flv,*.mpeg,*.mp4,*.wmv,*.avi,*.3gp</td>
			</tr>
			</table>
			</font></a>
			<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
			<a href="#" class="bt_green" onclick='uploadcontent()'><span class="bt_green_lft"></span><strong>Upload Content</strong><span class="bt_green_r"></span></a>
			<!-- <a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
			<a href="#" class="bt_green" onclick='uploadcontent()'><span class="bt_green_lft"></span><strong>Upload Content</strong><span class="bt_green_r"></span></a> -->
		
		  
		
		
</form>		
<form name=backform method=post action="">
<input type="hidden" name="instituteid" value="<%=instituteid %>">
					<input type='hidden' name='req_subjectid' 		value='<%=req_subjectid %>'>
					<input type='hidden' name='req_lessonid' 			value='<%=req_lessonid %>'>
					<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid %>'>
					<input type='hidden' name='sessionid' 			value='<%=sessionid %>'>
					<input type='hidden' name='standard' 	value='<%=standardscheduleid %>'>
					<input type='hidden' name='sessionname' value='<%=sessionid %>'>
					<input type='hidden' name='board' value='<%=request.getParameter("board") %>'>
</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>
