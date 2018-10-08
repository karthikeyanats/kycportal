<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.net.URLEncoder"%>
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
	function goBack()
	{
	window.close();
	}
	function downloadfun(obj)
	{
	    var file=obj.getAttribute("atta");
		document.getElementById("downloadid").src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+file+"&r3=download";
	}
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
  
    </div>

    <div class="main_content">




    <div class="center_content">



    <div class="left_content">
    <h2 style="color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Content View  </h2>

    </div>

    <div class="right_content">

<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Content.ContentQurey"%>
<%
String filepath="";
String req_sessionname=request.getParameter("req_sessionname")+"";
String req_boardname=request.getParameter("req_boardname")+"";
String req_standardname=request.getParameter("req_standardname")+"";
String req_subjectname=request.getParameter("req_subjectname")+"";
String req_lessonname=request.getParameter("req_lessonname")+"";
		ContentQurey cquery			= new ContentQurey();
		ArrayList contentlist=null;
		String contentid=request.getParameter("contentid");
		if(contentid != null && !contentid.equals("") ) {
			 contentlist=cquery.LoadContentDetails(contentid);
		}
%>
<form name="Schedule_Form" action="" method="post">
		
		<table width='100%' align='center' border='0' id=rounded-corner>
		<thead>
		<tr>
			<th scope="col" class="rounded-company" width="1%" ></th>
        	<th scope="col" class="rounded" width="100%"  >Selected Details</th>
        	<th scope="col" class="rounded-q4"	width="1%"></th>
       	</tr>	
	</thead>
	<tfoot> 
	   	<tr>
	       	<td colspan="2" class="rounded-foot-left"><em></em></td>
	       	<td class="rounded-foot-right">&nbsp;</td>
	    </tr>
	</tfoot>	
	<tbody>
			<tr>
			<td></td>
				<td width='100%' class='tablebold'>
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
						
						
						</tbody>
					</table>
					<td></td>
					</tr>
					</table>
					<br>
					<table width='100%' id="rounded-corner" align='center' border='0' >
								
										<thead>
											<tr>
												<th scope="col" class="rounded-company" width="1%" ></th>
									        	<th scope="col" class="rounded" width="100%"  colspan=6>File Details</th>
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
						try{
							if(contentlist!=null && contentlist.size()>0)
							{								
								for(int y=0,sno=1;y<contentlist.size();y++)
								{
											HashMap map=(HashMap)contentlist.get(y);
										    String cmscontentid=map.get("cmscontentid")+"";
										     filepath=map.get("filepath")+"";
										    String filename=map.get("filename")+"";
										    String contentnotes=map.get("contentnotes")+"";
										    String uploadeddate=map.get("uploadeddate")+"";
										    String ordervalue=map.get("ordervalue")+"";
											out.print("<tr>");
											out.print("<td></td>");
											out.print("<td>File Name </td><td width='1%'>:</td><td>"+filename+"</td>");
											out.print("<td>Date </td><td width='1%'>:</td><td>"+uploadeddate+"</td>");
											out.print("<td></td>");

											out.print("</tr>");
											out.print("<tr>");
											out.print("<td></td>");
											out.print("<td> Notes </td><td width='1%'>:</td><td colspan=5>"+contentnotes+"</td>");
											out.print("</tr>");
											out.print("</td>");
											out.print("<td colspan='8' height='100%'>");
											if(filename.toLowerCase().endsWith("flv") )
											 {
												 out.print("=======>>>>>>"+filepath);
													out.print("<iframe align=center src="+request.getContextPath()+"/jsp/ContentManagement/flvplayer/flvplay.jsp?txtval="+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+filepath+"\" width='100%' height='500px'></iframe>");
											 %>
											  <object id="Video" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="350" height="300" border="0">
								 			   <param name="movie" value="<%=request.getContextPath()%>/jsp/ContentManagement/gddflvplayer.swf"/>
								 			    <param name="flashvars" value="vdo=<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=filepath%>" />
									            </object>
											 <%
											 }else  if(filename.toLowerCase().endsWith("mpg") || filename.toLowerCase().endsWith("mpeg") || filename.toLowerCase().endsWith("mp4") || filename.toLowerCase().endsWith("mkv") || filename.toLowerCase().endsWith("avi") || filename.toLowerCase().endsWith("wma")|| filename.toLowerCase().endsWith("mp3"))
											{
											    out.print("<OBJECT id='VIDEO' CLASSID='CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6' type='application/x-oleobject' width='800' height='500'>"); 
											    out.print("<PARAM NAME='URL' VALUE='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(filepath)+"'>");
												out.print("<PARAM NAME='enabled' VALUE='True'><PARAM NAME='AutoStart' VALUE='true'><PARAM name='PlayCount' VALUE='3'><PARAM name='Volume' VALUE='50'><PARAM NAME='balance' VALUE='0'><PARAM NAME='Rate' VALUE='1.0'><PARAM NAME='Mute' VALUE='False'>");												
												out.print("<PARAM NAME='fullScreen' VALUE='False'><PARAM name='uiMode' VALUE='full'>");
												out.print("<embed src='<%='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(filepath)+"' width='100%' height='100%'></embed></OBJECT>");
											}
											else
											{
											out.print("<iframe align=center src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(filepath)+"' width='100%' height='500px'></iframe>");
											}
											///out.print("<embed src='/kycportal/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(filepath)+"' width='100%' height='500px'/>");
											
												out.print("</td>");
												out.print("</tr>");
											}
							          }
							else
							{
								out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
								//out.print("<tr>");
								//out.print("<td colspan=8 align=center>Data Not Found</td>");
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
																	<iframe id=downloadid  style="visibility:hidden" width=0 height=0></iframe>
		<input type="hidden" name="lessonscheduleid" value="">
			<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Close</strong><span class="bt_blue_r"></span></a>
			<a href="#" atta="<%=java.net.URLEncoder.encode(filepath)%>" class="bt_green"  onclick="downloadfun(this)"><span class="bt_green_lft"></span><strong>Download</strong><span class="bt_green_r"></span></a>
		</form>		

    </div><!-- end of right content-->
  

  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>