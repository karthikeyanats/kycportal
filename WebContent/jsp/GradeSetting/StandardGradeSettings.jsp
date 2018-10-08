<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page language="java" import="java.util.ResourceBundle,com.iGrandee.GradeSetting.GradeScaleQuery"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>  

<head>  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.gradesetting.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />  
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
function loadboard()
{
	if(check_ForParticularElements(document.gradesettingform.sessionid,"select")){
		document.gradesettingform.submit();
	}
}
function loadyear()
{
document.gradesettingform.boardid.options[0].selected=true;
document.gradesettingform.submit();
}

function clickfun()
{
			
					var flag =false;
					var len=document.gradesettingform.standardscheduleid.length;
					if(len!=undefined)
					{
						for (var i=0;i<len;i++)
							{
								if(document.gradesettingform.scalenameid[i].value!="" && document.gradesettingform.scalenameid[i].value!="0" && document.gradesettingform.scalenameid[i].value!=" " && document.gradesettingform.scalenameid[i].options.selectedIndex!="0")
									{
										flag =true;
									}
							}
					}
					else
						{
							if(document.gradesettingform.scalenameid.value!="" && document.gradesettingform.scalenameid.value!="0" && document.gradesettingform.scalenameid.value!=" " && document.gradesettingform.scalenameid.options.selectedIndex!="0")
							{
										flag =true;
							}
						}
					if(flag)
						{
						if(confirm("Are you sure want to Save the Standard Grade Setting...?"))
						{
							if(len!=undefined)
								{
									for (var i=0;i<len;i++)
										{
											if(document.gradesettingform.scalenameid[i].value=="" || document.gradesettingform.scalenameid[i].value=="0" || document.gradesettingform.scalenameid[i].value==" " || document.gradesettingform.scalenameid[i].options.selectedIndex=="0")
												{
													document.gradesettingform.standardscheduleid[i].disabled=true;
													document.gradesettingform.scalenameid[i].disabled=true;
												}
										}
								}
							else
								{
									if(document.gradesettingform.scalenameid.value=="" || document.gradesettingform.scalenameid.value=="0" || document.gradesettingform.scalenameid.value==" " || document.gradesettingform.scalenameid.options.selectedIndex=="0")
									{
										document.gradesettingform.standardscheduleid[i].disabled=true;
										document.gradesettingform.scalenameid[i].disabled=true;
									}
								}
							
							document.gradesettingform.action="./StandardGradeSettingSubmit.jsp" 
							document.gradesettingform.submit();
						}
						}

					else
						{
						alert("Select Scale for Atleast  One Standard");
						}
}
function checkNumber(e) {
	var code;
	if (!e) var e = window.event;
	if (e.keyCode) code = e.keyCode;
	else if (e.which) code = e.which;
	var character = String.fromCharCode(code);
	if(code!=9 && code!=46 && code!=8)
	{
	if (code==47||code<46||code>57)
	{
		code=0;
		alert("Enter  Number only")

	if(window.event != null)
	{
		window.event.keyCode 	= 505;
		event.cancelBubble		= true;
		event.returnValue		= false;
	}
	else
	{
		e.preventDefault();
	}
		 return false;
	}
	}
	}
</script>
</head>
<body>
<div id="main_container">
<div class="header"><%@ include
	file="../include/userheader.jsp"%></div>

<div class="main_content"><%@ include
	file="../include/header.jsp"%>

<div class="center_content">

<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.gradesetting.standardrootpath")%></h2>

<form name='gradesettingform' method='post'>
<input type=hidden name=sessionname value="">
<input type=hidden name=boardname value="">
<input type=hidden name=req_sessionid value="<%=session.getValue("sessionid")%>">

<input type=hidden name=req_scaleid value="">
<input type=hidden name=req_boardid value="">

<input type=hidden name=scalename value="">

<%@ page
	language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>

<%

	GradeScaleQuery gradeobj	= new GradeScaleQuery(); 
	boolean flag=false;
	String instituteid			= "";
	instituteid			= (String)session.getValue("instituteid").toString();
	String req_sessionid 	= "";
	String req_boardid 	= "";
	String req_scaleid 	= "";

	if(request.getParameter("sessionid") != null)
		req_sessionid =  request.getParameter("sessionid");
	if(request.getParameter("boardid") != null)
		req_boardid =  request.getParameter("boardid");
	if(request.getParameter("scalenameid") != null)
		req_scaleid =  request.getParameter("scalenameid");
	
	ArrayList academicList		= gradeobj.loadAcademicYear(instituteid,"A");
		
		
		
	%>

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.gradesetting.standardheader")%> </th>
		            <th scope="col" class="rounded-q4" width="20%"><font color=red>*</font> <%=bundle.getString("label.examallot.mandatory")%></th>        
		        </tr>
		    </thead>
		    
		        <tfoot>
		    	<tr>
		        	<td class="rounded-foot-left"><em></em></td>
		        	<td class="rounded-foot-right">&nbsp;</td>
		       </tr>
		    </tfoot>
		<tbody>
			<tr>
			<td colspan="2">
			<table border=0 align=center id="rounded-corner1" width="100%">
			<tr>
			<td class=tablebold width="25%"><%=bundle.getString("label.examallot.academic")%><font color=red> *</font></td>
			<td class=tablebold width="2%">:</td>
			<td>
			<select name='sessionid'
			validate='Session Name' onchange='loadyear()'>
			<option value='0'>-Select Academic Year-</option>
			<%
				HashMap academicListmap=null;
					if(academicList != null && academicList.size()>0)
						{
							for(int z=0;z<academicList.size();z++)
								{
									academicListmap		= (HashMap)academicList.get(z);
									String sessionid = (String)academicListmap.get("sessionid");
									String sessionname = (String)academicListmap.get("sessionname");
									if(sessionid.equals(req_sessionid))	
										out.print("<option value='"+sessionid+"' selected=true >"+sessionname+"</option>");
									else
										out.print("<option value='"+sessionid+"'>"+sessionname+"</option>");

								}
						}
										
			%>
			</select>
					
			</td>

				<td class=tablebold><%=bundle.getString("label.boardmedium.apprsrc")%><font color=red> *</font></td>
				<td class=tablebold width="2%">:</td>
		<td class='tablelight' width='30%'><select name='boardid'
			validate='Board Name' onchange='loadboard()'>
			<option value='0'>-Select Board-Medium -</option>
			<%
				ArrayList boardnameList		= gradeobj.LoadBoardList(instituteid);
				HashMap boardmap=null;
					if(boardnameList != null && boardnameList.size()>0)
						{
							for(int z=0;z<boardnameList.size();z++)
								{
									boardmap		= (HashMap)boardnameList.get(z);
									String boardid = (String)boardmap.get("boardid");
									String boardname = (String)boardmap.get("boardname");
									String mediumId      = (String)boardmap.get("mediumid");
									String mediumName      = (String)boardmap.get("mediumname");
									if(boardid.equals(req_boardid))	
										out.print("<option value='"+boardid+"' selected=true >"+boardname+"-"+mediumName+"</option>");
									else
										out.print("<option value='"+boardid+"'>"+boardname+"-"+mediumName+"</option>");
								}
						}
										
			%>
		</select></td>
		</tr>
		</table>
		</td></tr>
		</tbody>
		</table>
	<br>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.gradesetting.slno")%> </th>
		            <th scope="col" class="rounded" width="40%"> <%=bundle.getString("label.gradesetting.standard")%></th>   
   		            <th scope="col" class="rounded-q4" width="50%"><%=bundle.getString("label.gradesetting.scalename")%></th>        
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
		ArrayList StandardList		= new ArrayList();
		if(req_sessionid!=null && !req_sessionid.equals("0") && !req_sessionid.equals("") && req_boardid!=null && !req_boardid.equals("0") && !req_boardid.equals("") )
		{
			StandardList		= gradeobj.loadstandard(req_boardid,req_sessionid,instituteid);  
		}
		HashMap StandardListmap=null;
		if(StandardList!=null && StandardList.size()>0)
		{
			for(int y=0;y<StandardList.size();y++)
			{
				StandardListmap	= (HashMap)StandardList.get(y);
				String standardid = (String)StandardListmap.get("standardid");
				String standardscheduleid = (String)StandardListmap.get("standardscheduleid");
				
				String groupname = (String)StandardListmap.get("groupname");
				String scaleid = (String)StandardListmap.get("scaleid");

				
				String standardname = (String)StandardListmap.get("standardname");
				if(groupname!=null)
					standardname=standardname+" -"+groupname;
				
				out.print("<tr><td>"+(y+1)+"</td><td>"+standardname+"<input type=hidden name=standardscheduleid value='"+standardscheduleid+"'/></td><td><select name='scalenameid'	validate='Scale Name'> <option value='0'>-Select Scale Name-</option>");
				ArrayList scalenameList		= gradeobj.loadScaleType(req_boardid);
				
				HashMap scalenameListmap=null;
					for(int k=0;k<scalenameList.size();k++)
					{
						scalenameListmap	= (HashMap)scalenameList.get(k);
						String scalenameid = (String)scalenameListmap.get("scaleid");
						String scalename = (String)scalenameListmap.get("scalename");
						if(scaleid!=null && scaleid.equals(scalenameid))
							out.print("<option value='"+scalenameid+"' selected=true>"+scalename+"</option>");
						else
							out.print("<option value='"+scalenameid+"'>"+scalename+"</option>");

					}
				out.println("</select></td></tr>");
			}
		}
		else
		{
			out.print("<tr><td colspan=3 align=center class=tablebold><font color=red>Data Not Found</font></td></tr>");   

		}
			%>
			</tbody>
		</table>	
			
		
<%if(StandardList.size()>0){ %>
<a href="#" class="bt_green" onclick='clickfun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.gradesetting.save")%></strong><span class="bt_green_r"></span></a>
<%} %>
</form>

</table>

<!-- end of right content--></div>
<!--end of center content --></div>
<div class="clear"></div>
</div>
<!--end of main content--> 
<%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>