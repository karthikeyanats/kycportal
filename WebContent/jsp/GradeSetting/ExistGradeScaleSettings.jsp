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
function Loadscale()
{
	if(check_ForParticularElements(document.gradesettingform.oldsessionid,"select",document.gradesettingform.oldboardid,"select")){
		document.gradesettingform.submit();
	}
}

function loadboard()
{
	if(check_ForParticularElements(document.gradesettingform.oldsessionid,"select")){
		document.gradesettingform.oldscalenameid.options[0].selected=true;
		document.gradesettingform.submit();
	}
}
function loadyear()
{
document.gradesettingform.oldboardid.options[0].selected=true;
document.gradesettingform.oldscalenameid.options[0].selected=true;
document.gradesettingform.submit();
}
function backfun()
{
	document.gradesettingform.action="./GradeScaleSettings.jsp" 
	document.gradesettingform.submit();
}
function clickfun()
{
	if(parseInt(document.gradesettingform.publishcount.value)!=0)
	{
		alert("Exam Result Published So You Cannot Enter or Edit Grade Range");
		return false;
	}
		 var chklength= document.gradesettingform.gradeid.length;
			 for(var no=0;no<chklength;no++)
				 {   
				   if(parseInt(document.gradesettingform.rangeto[no].value)<parseInt(document.gradesettingform.rangefrom[no].value))
			 	    {
						var varto=document.gradesettingform.rangeto[no].value;
						var varfrom=document.gradesettingform.rangefrom[no].value; 
						document.gradesettingform.rangeto[no].value=varfrom;
						document.gradesettingform.rangefrom[no].value=varto; 
					}
				   if(document.gradesettingform.rangefrom[no].value!="" || document.gradesettingform.rangeto[no].value!="")
			   		 {
			   			if(!check_ForParticularElements(document.gradesettingform.rangefrom[no],"text",document.gradesettingform.rangeto[no],"text")){
			   		 		return false;
		 					}
			   		 }
		 		 for(var i=0;i<chklength;i++)
		 		 {
			   		 if(i!=no)
			   		 {
			   			 
			   		 	if(parseInt(document.gradesettingform.rangeto[no].value)===parseInt(document.gradesettingform.rangefrom[no].value))
					   		 		{
					   		 		alert("From  Range and To Range Are Same");
					   		 		document.gradesettingform.rangeto[no].focus();
					   		 		return false;
					   		 		}
				   		 if(document.gradesettingform.rangefrom[i].value!="" && document.gradesettingform.rangeto[i].value!="")
					   		 {		
					   		 		if(parseInt(document.gradesettingform.rangefrom[no].value)>=parseInt(document.gradesettingform.rangefrom[i].value) && parseInt(document.gradesettingform.rangefrom[no].value)<=parseInt(document.gradesettingform.rangeto[i].value))
					   		 		{
					   		 		alert("From Range Already Exist");
					   		 		document.gradesettingform.rangefrom[no].focus();
					   		 		return false;
					   		 		}
					   		 		if(parseInt(document.gradesettingform.rangeto[no].value)>=parseInt(document.gradesettingform.rangefrom[i].value) && parseInt(document.gradesettingform.rangeto[no].value)<=parseInt(document.gradesettingform.rangeto[i].value))
					   		 		{
					   		 		alert("To Range Already Exist");
					   		 		document.gradesettingform.rangeto[no].focus();
					   		 		return false;
					   		 		}
					   		 }
			   		 }
				}
			}
			 var count=0;
			 for(var no=0;no<chklength;no++)
			 { 
					if(document.gradesettingform.rangefrom[no].value=="" && document.gradesettingform.rangeto[no].value=="")
					{
						
					}
					else
					{count++;}
			 }
			 if(count>0)
				 {
				 if(confirm("Are you sure want to Save the Existing Grade Scale Setting...?"))
					{
						 for(var no=0;no<chklength;no++)
						 { 
							 if(document.gradesettingform.gradescaleid[no]=="")
							 {
								if(document.gradesettingform.rangefrom[no].value=="" && document.gradesettingform.rangeto[no].value=="")
								{
									document.gradesettingform.rangefrom[no].disabled=true;
									document.gradesettingform.rangeto[no].disabled=true;
									document.gradesettingform.gradeid[no].disabled=true;
									document.gradesettingform.gradescaleid[no].disabled=true;
								}
							 }
								
						 }
						document.gradesettingform.action="./GradeScaleSettingSubmit.jsp" 
						document.gradesettingform.submit();
					}
				 }
			 else
				 {
					 alert("Enter Any One Grade Range");
					 return false;
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

<h2><%=bundle.getString("label.gradesetting.existrootpath")%></h2>

<form name='gradesettingform' method='post'>
<input type=hidden name=req_sessionid value="<%=session.getValue("sessionid")%>">

<input type=hidden name=req_scaleid value="">
<input type=hidden name=req_boardid value="">
<input type=hidden name=sessionname value="<%=request.getParameter("sessionname") %>">
<input type=hidden name=boardname value="<%=request.getParameter("boardname") %>">
<input type=hidden name=scalename value="<%=request.getParameter("scalename") %>">


<input type=hidden name=sessionid value="<%=request.getParameter("sessionid") %>">
<input type=hidden name=boardid value="<%=request.getParameter("boardid") %>">
<input type=hidden name=scalenameid value="<%=request.getParameter("scalenameid") %>">

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
	String old_sessionid 	= "";
	String old_boardid 	= "";
	String old_scaleid 	= "";
	
	String req_sessionid 	= "";
	String req_boardid 	= "";
	String req_scaleid 	= "";
	int publishcount=0;

	if(request.getParameter("sessionid") != null)
		req_sessionid =  request.getParameter("sessionid");
	if(request.getParameter("boardid") != null)
		req_boardid =  request.getParameter("boardid");
	if(request.getParameter("scalenameid") != null)
		req_scaleid =  request.getParameter("scalenameid");
	
	if(request.getParameter("oldsessionid") != null)
		old_sessionid =  request.getParameter("oldsessionid");
	if(request.getParameter("oldboardid") != null)
		old_boardid =  request.getParameter("oldboardid");
	if(request.getParameter("oldscalenameid") != null)
		old_scaleid =  request.getParameter("oldscalenameid");
	ArrayList academicList		= gradeobj.loadAcademicYear(instituteid,"R");
	if(req_sessionid!=null && !req_sessionid.equals("0") && !req_sessionid.equals("") && req_boardid!=null && !req_boardid.equals("0") && !req_boardid.equals("") && req_scaleid!=null && !req_scaleid.equals("0") && !req_scaleid.equals(""))
	{
	//String output=gradeobj.loadMarkPuBlishedorNot(req_sessionid,req_boardid);
	String output=gradeobj.loadMarkPuBlishedorNot(req_sessionid,req_boardid,req_scaleid);
	if(output!=null)
		publishcount=Integer.parseInt(output);
	}
	%>
<input type=hidden name=publishcount value="<%=publishcount%>" >
<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.gradesetting.header_1")%> </th>
		            <th scope="col" class="rounded-q4" width="20%"></th>        
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
			<td class=tablebold width="25%"><%=bundle.getString("label.examallot.academic")%></td>
			<td class=tablebold width="2%">:</td>
			<td  width="23%">
			<%=request.getParameter("sessionname") %>
			</td>
			<td class=tablebold width="25%"><%=bundle.getString("label.boardmedium.apprsrc")%></td>
			<td class=tablebold width="2%"  >:</td>
			<td width="23%">
			<%=request.getParameter("boardname") %>
			</td>
			</tr>
			<tr>
			<td class=tablebold width="25%"><%=bundle.getString("label.gradesetting.scalename")%></td>
			<td class=tablebold width="2%">:</td>
			<td  width="23%">
			<%=request.getParameter("scalename") %>
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
		            <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.gradesetting.header")%> </th>
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
			<select name='oldsessionid'
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
									if(sessionid.equals(old_sessionid))	
										out.print("<option value='"+sessionid+"' selected=true >"+sessionname+"</option>");
									else
										out.print("<option value='"+sessionid+"'>"+sessionname+"</option>");

								}
						}
										
			%>
			</select>
					
			</td>

				<td class=tablebold><%=bundle.getString("label.examallot.board")%><font color=red> *</font></td>
				<td class=tablebold width="2%">:</td>
		<td class='tablelight' width='30%'><select name='oldboardid'
			validate='Board Name' onchange='loadboard()'>
			<option value='0'>-Select Board-</option>
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
									if(boardid.equals(old_boardid))	
										out.print("<option value='"+boardid+"' selected=true >"+boardname+"-"+mediumName+"</option>");
									else
										out.print("<option value='"+boardid+"'>"+boardname+"-"+mediumName+"</option>");
								}
						}
										
			%>
		</select></td>
		</tr>
		<tr>
			<td class=tablebold width="25%"><%=bundle.getString("label.gradesetting.scalename")%><font color=red> *</font></td>
			<td class=tablebold width="2%">:</td>
		<td class='tablelight'><select name='oldscalenameid'
			validate='Scale Name' onchange='Loadscale()'>  
			<option value='0'>-Select Scale Name-</option>
			<%
				ArrayList scalenameList		= gradeobj.loadScaleType(old_boardid);  
				
				HashMap scalenameListmap=null;
					for(int y=0;y<scalenameList.size();y++)
					{
						scalenameListmap	= (HashMap)scalenameList.get(y);
						String scalenameid = (String)scalenameListmap.get("scaleid");
						String scalename = (String)scalenameListmap.get("scalename");
						if(scalenameid.equals(old_scaleid))	
							out.print("<option value='"+scalenameid+"' selected=true >"+scalename+"</option>");
						else
							out.print("<option value='"+scalenameid+"'>"+scalename+"</option>");
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
		            <th scope="col" class="rounded" width="40%"> <%=bundle.getString("label.gradesetting.grade")%></th>   
   		            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.gradesetting.from")%></th>        
   		            <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.gradesetting.to")%></th>        
		                 
		        </tr>
		    </thead>
		    
		        <tfoot>
		    	<tr>
		        	<td class="rounded-foot-left" colspan=3><em></em></td>
		        	<td class="rounded-foot-right">&nbsp;</td>
		       </tr>
		    </tfoot>
		<tbody>
		<%
		ArrayList GradeList		= new ArrayList();
		ArrayList OldGradeList		= new ArrayList();

		if(req_sessionid!=null && !req_sessionid.equals("0") && !req_sessionid.equals("") && req_boardid!=null && !req_boardid.equals("0") && !req_boardid.equals("") && req_scaleid!=null && !req_scaleid.equals("0") && !req_scaleid.equals(""))
		{
			GradeList		= gradeobj.loadAllGrade(req_sessionid,req_boardid,req_scaleid,instituteid);  
		}
		if(old_sessionid!=null && !old_sessionid.equals("0") && !old_sessionid.equals("") && old_boardid!=null && !old_boardid.equals("0") && !old_boardid.equals("") && old_scaleid!=null && !old_scaleid.equals("0") && !old_scaleid.equals(""))
		{
			OldGradeList		= gradeobj.loadAllGrade(old_sessionid,old_boardid,old_scaleid,instituteid);
		}
		HashMap GradeListmap=null;
		HashMap OldGradeListmap=null;

		if(GradeList!=null && GradeList.size()>0)
		{
			for(int y=0;y<GradeList.size();y++)
			{
				String gradeidgradeid="";
				GradeListmap	= (HashMap)GradeList.get(y);
				String gradeid = (String)GradeListmap.get("gradeid");
				String gradename = (String)GradeListmap.get("gradename");
				if(gradename==null)
					gradename="";
				String rangefrom ="";
				String rangeto ="";
				if(OldGradeList!=null && OldGradeList.size()>0)
				{
					OldGradeListmap	= (HashMap)OldGradeList.get(y);
					gradeidgradeid = (String)OldGradeListmap.get("gradeid");
					rangefrom = (String)OldGradeListmap.get("rangefrom");
					if(rangefrom==null)
						rangefrom="";
					 rangeto = (String)OldGradeListmap.get("rangeto");
					if(rangeto==null)
						rangeto="";
					if(rangeto.equalsIgnoreCase("") && rangefrom.equalsIgnoreCase(""))
					{
						rangefrom = (String)GradeListmap.get("rangefrom");
						if(rangefrom==null)
							rangefrom="";
						 rangeto = (String)GradeListmap.get("rangeto");
						if(rangeto==null)
							rangeto="";
					}
				}
				else
				{
					 rangefrom = (String)GradeListmap.get("rangefrom");
					if(rangefrom==null)
						rangefrom="";
					 rangeto = (String)GradeListmap.get("rangeto");
					if(rangeto==null)
						rangeto="";
				}
				String gradescaleid = (String)GradeListmap.get("gradescaleid");
				if(gradescaleid==null)
					gradescaleid="";
				out.print("<tr><td>"+(y+1)+"</td><td>"+gradename+"<input type=hidden name=gradeid value='"+gradeid+"'/><input type=hidden name=gradescaleid value='"+gradescaleid+"'/></td><td><input type=text name=rangefrom value='"+rangefrom+"' size=5 maxlength=5  onkeypress='checkNumber(event)' /></td><td><input type=text name=rangeto value='"+rangeto+"' size=5 maxlength=5  onkeypress='checkNumber(event)' /></td></tr>");
			}
		}
		else
		{
			out.print("<tr><td colspan=4 align=center class=tablebold><font color=red>Data Not Found</font></td></tr>");   

		}
			%>  
			</tbody>
		</table>	
			
		
		
<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradesetting.back")%></strong><span class="bt_blue_r"></span></a>
<%
//out.print("publishcount-->"+publishcount);
if(GradeList.size()>0 && publishcount==0){ %>
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