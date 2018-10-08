<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.workdoneregister.viewtitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
	
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script>

	function changeStandard(obj){
		
		if(check_ForParticularElements(document.wprkallotment.board,"select",document.wprkallotment.standard,"select"))
		{
	   
	    
	    document.wprkallotment.standardname.value=obj.getAttribute("standardname");
			document.wprkallotment.submit();
		}
	}	
	function changeSection(obj){
		
		if(check_ForParticularElements(document.wprkallotment.board,"select",document.wprkallotment.standard,"select",document.wprkallotment.newsection,"select"))
		{
	   
	    
	    document.wprkallotment.standardname.value=obj.getAttribute("standardname");
			document.wprkallotment.submit();
		}
	}
	var splitedresult="";
	function changeSubject(obj){
		
		if(check_ForParticularElements(document.wprkallotment.board,"select",document.wprkallotment.standard,"select",document.wprkallotment.newsection,"select",document.wprkallotment.newSubject,"select"))
		{
		if(document.wprkallotment.newSubject.value!="0")
		{
		splitedresult=document.wprkallotment.newSubject.options[document.wprkallotment.newSubject.selectedIndex].text.split("-");
	 document.wprkallotment.splitedresult.value=splitedresult[1];
	  document.wprkallotment.submit();  
	  }
		}
	}
	

function clicklession(obj)
{				var sunjnam=obj.getAttribute("sunjnam");
			var userids=obj.getAttribute("userids");

			document.wprkallotment.standardname.value	= document.wprkallotment.standard.options[document.wprkallotment.standard.options.selectedIndex].text;
			document.wprkallotment.subjectcode.value	= obj.getAttribute("subjectcode");
			document.wprkallotment.lessonname.value		= obj.getAttribute("lesnam");
			document.wprkallotment.lessonscheduleid.value=obj.getAttribute("lessonscheduleid");
			 
			document.wprkallotment.staffname.value=obj.getAttribute("staffname");
						document.wprkallotment.newsection_temp.value	= document.wprkallotment.newsection.options[document.wprkallotment.newsection.options.selectedIndex].text;
			
							document.wprkallotment.subjectname.value=sunjnam;
							document.wprkallotment.userids.value=userids;
							
			
document.wprkallotment.action = "WorkDoneList.jsp";
document.wprkallotment.submit();
}	 
function loadcombo()
{
if(check_ForParticularElements(document.wprkallotment.board,"select"))
		
{
document.wprkallotment.submit();
}
 
}
function printpdf()
{
	document.wprkallotment.standard_pdf.value=document.wprkallotment.standard.options[document.wprkallotment.standard.selectedIndex].text;
	document.wprkallotment.board_pdf.value=document.wprkallotment.board.options[document.wprkallotment.board.selectedIndex].text;
	document.wprkallotment.newsection_pdf.value=document.wprkallotment.newsection.options[document.wprkallotment.newsection.selectedIndex].text;

document.wprkallotment.submit();

}
</script>

</head>
<body>
<div id="main_container">

<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content">

<%@ include file="../include/header.jsp" %>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

    <h2><%=bundle.getString("label.workdoneregister.viewrootpath") %></h2>
<form name="wprkallotment" method="post" action=""> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry"%>
<%
String subjectname1="";

	WorkDoneRegisterEntry wallot 		= new WorkDoneRegisterEntry();
	String instituteid 		= (String)session.getValue("instituteid");
	String userid 			= (String)session.getValue("userid");
	
	ArrayList academicList	= wallot.loadSessionForHM(instituteid);
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String sectionid		= "";
	String standardid		= request.getParameter("standard");
	String lessonid			= request.getParameter("lesson");
	String subjectid		= request.getParameter("subjectsss");

	String subjectname		= request.getParameter("subjectname");

	ArrayList sectionList	= null;
	ArrayList subjectList	= null;
	ArrayList lessonList	= null;
	ArrayList subjectarray	= null;
	ArrayList subjectListFinal	= null;
	String standardname=request.getParameter("standardname");
	String subjectcode=request.getParameter("subjectcode");

	String newsessionid =(String)session.getValue("sessionid");
	String sessionname=(String)session.getValue("sessionname");
	String standardscheduleid=request.getParameter("standard")+"";
	String sectionscheduleid=request.getParameter("newsection")+"";
	String subjectscheduleid=request.getParameter("newSubject")+"";
	String boardid=request.getParameter("board")+"";
	String splitedresult=request.getParameter("splitedresult")+"";
	
	String standard_pdf =request.getParameter("standard_pdf");
	String board_pdf =request.getParameter("board_pdf");
	String newsection_pdf =request.getParameter("newsection_pdf");
	
	ArrayList BoardList			= wallot.loadboard(instituteid);
	
			ArrayList standList=wallot.loadstandard(boardid,newsessionid,instituteid); 

			 sectionList=wallot.loadSectionForHM(standardscheduleid,instituteid); 

		subjectList		= wallot.loadSubjectForHM(userid,standardscheduleid,subjectid,sectionscheduleid);
		subjectListFinal		= wallot.loadSubjectForHMFinal(userid,standardscheduleid,subjectscheduleid,sectionscheduleid);
		
%>
<input type="hidden" name="standard_pdf">
<input type="hidden" name="board_pdf">
<input type="hidden" name="newsection_pdf">
<input type="hidden" name="newsection_temp">

	
		<table border=0 id="rounded-corner" width="100%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.workdoneregister.selectinformation") %></th>
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
				<td colspan='2'>							
					<table  border=0 bordercolor='blue' align="center" width="100%"  cellspacing=0 cellpadding=0>
						<tr height='23'>
							<td  class='tablebold' ><%=bundle.getString("label.workdoneregister.academicyear") %></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' ><%=sessionname %></td>
							<td  class='tablebold'><%=bundle.getString("label.workdoneregister.board") %></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' >
								<select name='board' id='board' validate='Board Name' style="width:150px" onchange="loadcombo()">
									<option value='0'>-Select Board-</option>
								<%
									if(BoardList != null && BoardList.size()>0)
										for(int y=0;y<BoardList.size();y++){
											hashmap		= (HashMap)BoardList.get(y);
											String boardname=hashmap.get("boardname")+"";
											String boardids=(String)hashmap.get("boardid");
											String mediumname=hashmap.get("mediumname")+"";
											//if(!mediumname.equals("null"))
											boardname=boardname+" -"+mediumname;
											//System.out.print("*boardids**"+boardids);
									if(!boardid.equals("") && boardid != null && boardid.equals(boardids))
									
										out.print("<option value='"+hashmap.get("boardid")+"' selected >"+boardname+"</option>");
								
									else   
									
										out.print("<option value='"+hashmap.get("boardid")+"'  >"+boardname+"</option>");

									}
								%>
					</select>
				</td>
			</tr>
			<tr>
				<td  class='tablebold' ><%=bundle.getString("label.workdoneregister.standard") %></td>
				<td  class='tablebold' width='1'>:</td>
				<td  class='tablelight' >
					<select name='standard' validate='Standard' onchange='changeStandard(this)'>
						<option value='0'>-Select Standard-</option>
							<%
								String standardscheduleid1="";
								if(standList != null && standList.size()>0){
									for(int b=0;b<standList.size();b++){
										hashmap		= (HashMap)standList.get(b);
										standardscheduleid1=(String)hashmap.get("standardscheduleid");
										String standardname_temp="";
										String groupname=(String)hashmap.get("groupname");
										if(!groupname.equals("NoGroup"))
										{												
											standardname_temp = hashmap.get("standardname")+" - "+groupname; 
										}
										else
										{
											standardname_temp=hashmap.get("standardname")+"";
										}
										
										if(!standardscheduleid.equals("null") && standardscheduleid.equals(standardscheduleid1))
										{
											out.print("<option  value='"+hashmap.get("standardscheduleid")+"' standardname='"+hashmap.get("standardscheduleid")+"' selected=true >"+standardname_temp+"</option>");
										} 
											else    
											{
											out.print("<option value='"+hashmap.get("standardscheduleid")+"' standardname='"+hashmap.get("standardscheduleid")+"'>"+standardname_temp+"</option>");
									}
										}
									}
								%>											
						</select>
						</td>
						<td  class='tablebold' ><%=bundle.getString("label.workdoneregister.section") %></td>
						<td  class='tablebold' width='1'>:</td>
						<td  class='tablelight' >
								<select name='newsection' validate='Section' onchange='changeSection(this)'>
										<option value='0'>-Select Section-</option>
											<%
													String sectionid1="";
													if(sectionList != null && sectionList.size()>0){
															for(int c=0;c<sectionList.size();c++){
																hashmap		= (HashMap)sectionList.get(c);
																sectionid1=(String)hashmap.get("sectionscheduleid");
																
																
																if(!sectionscheduleid.equals("null") && sectionscheduleid.equals(sectionid1))
																{  
																	out.print("<option  value='"+hashmap.get("sectionscheduleid")+"' sectionname='"+hashmap.get("sectionname")+"' selected=true >"+hashmap.get("sectionname")+"</option>");
																}   
																	else    
																	{
																	out.print("<option value='"+hashmap.get("sectionscheduleid")+"' sectionname='"+hashmap.get("sectionname")+"'>"+hashmap.get("sectionname")+"</option>");
															}
																}
														}
														%>											
														</select>
													</td>
												</tr>
												<tr>
											<td  class='tablebold' ><%=bundle.getString("label.workdoneregister.subject") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='newSubject' validate='Subject' onchange='changeSubject(this)'>
														<option value='0'>-Select Subject-</option>
														<%
														String subjectscheduleid1="";
														if(subjectList != null && subjectList.size()>0){
															out.print(subjectList);
															for(int b=0;b<subjectList.size();b++){
																hashmap		= (HashMap)subjectList.get(b);
																subjectscheduleid1=(String)hashmap.get("subjectscheduleid");
																
																if(!subjectscheduleid.equals("null") && subjectscheduleid.equals(subjectscheduleid1))
																{
																	out.print("<option  value='"+hashmap.get("subjectscheduleid")+"'  selected=true >"+hashmap.get("subjectname")+"-"+hashmap.get("subjectcode")+"</option>");
																} 
																	else    
																	{
																	out.print("<option value='"+hashmap.get("subjectscheduleid")+"' >"+hashmap.get("subjectname")+"-"+hashmap.get("subjectcode")+"</option>");
															}
																}
														}
														%>											
														</select>
													</td>
													<td  class='tablebold' ><%=bundle.getString("label.workdoneregister.subjectcode") %></td>
													<td  class='tablebold' width='1'>:</td>
													<%
													if(splitedresult != null && !splitedresult.equals("") && !splitedresult.equalsIgnoreCase("null"))
													{
													%>
													<td  class='tablelight' ><%=splitedresult %></td>
													<%
													}  
													else
													{     
													%>
													<td  class='tablelight' >-</td>
													<%
													}
													%>
												</tr>
</table>
				</tbody>
			</table>
			<br>
		
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="30%" ><%=bundle.getString("label.workdoneregister.viewtableheading") %></th>
					<th scope="col" class="rounded" width="20%" ></th>
					<th scope="col" class="rounded-q4" width="40%" ></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=2 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody> 
			<tr>
			<td colspan=3>  
			
			
			 <%
												     String username1="";
													      String username2="";
													      String subjectnamee1="";
													      String subjectnamee2="";
													      try      
													      {            
													     if(subjectListFinal != null && subjectListFinal.size()>0)
													      { 
														
																			 out.print("<table align='center' width='100%'border=0 cellspacing=5 cellpadding=0>");
																	    	  out.print("<tr>");
																	    		out.print("<td colspan=1 class='tablebold'>"+bundle.getString("label.workdoneregister.slno")+"</td>" );
																				out.print("<td colspan=1 class='tablebold'>"+bundle.getString("label.workdoneregister.staffname")+" </td>" );
																				out.print("<td colspan=1 class='tablebold'>"+bundle.getString("label.workdoneregister.lessonname")+"</td>" );
																				out.print("</tr>");
																for(int c=0,l=1;c<subjectListFinal.size();c++)
																{
																	
																hashmap		= (HashMap)subjectListFinal.get(c);
																username1=(String)hashmap.get("username");
																out.print("<tr>");
																
																if(!username1.equals(username2))
																{
																out.print("<td class='tablelight'  >"+l+"</td>");
															 	out.print("<td class='tablelight' >"+hashmap.get("username")+"</td>" );
															 	username2=(String)hashmap.get("username");
															 	l++;
																}
																else  
																{
											    	   				out.print("<td class='tablelight'></td><td class='tablelight'></td>" );
																} 
																subjectnamee1=(String)hashmap.get("subjectname");
															/*	if(!subjectnamee1.equals(subjectnamee2) && username1.equals(username2))
																{  
																out.print("<td class='tablelight' colspan='1' >"+hashmap.get("subjectname")+"</td>");
																out.print("<td class='tablelight' colspan='1' >"+hashmap.get("subjectcode")+"</td>");
																//subjectnamee2=(String)hashmap.get("subjectname");
																username2=(String)hashmap.get("username");
																}  
																else
																{
											    	   				out.print("<td class='tablelight'></td><td></td>" );

																}*/ 
																out.print("<td class='tablelight' colspan='1' ><a href='#subject' subjectcode='"+hashmap.get("subjectcode")+"' sunjnam='"+hashmap.get("subjectname")+"' name='subject' lesnam='"+hashmap.get("lessonname")+"' lessonscheduleid='"+hashmap.get("lessonscheduleid")+"' userids='"+hashmap.get("userid")+"' staffname='"+hashmap.get("username")+"' onclick=clicklession(this)>"+hashmap.get("lessonname")+"</a></td>");
													    	  	out.print("</tr>");
														    	 }
													    	  }    
													     else
													     {
													    	 out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
													    	//out.print("<tr>");
													    	//out.println("<td align='center' colspan='3' >Data not Found</td>") ;
												    	  	//out.print("</tr>");

													     }     
													     }          
													      catch(Exception e)
													      {
													    	  //System.out.println(e);
													      }
															out.print("</table>");
															
															%>	  
			</td>
			</tr>
			
			</tbody>	
			
			
			
			</table>
			
		
<!--  
				<a href="#" class="bt_green"
					onclick="printpdf()"><span class="bt_green_lft"></span><strong>Print Pdf</strong><span
					class="bt_green_r"></span></a>	-->				
				<input type='hidden' name='subjectsss' 	value=''>
		
		<input type='hidden' name='standardname' 	value='<%=standardname %>'>
		<input type='hidden' name='sectionname'		value=''>
		<input type='hidden' name='sessionname' 	value='<%=sessionname %>'>
		<input type='hidden' name='lessonname' 		value=''>
		<input type='hidden' name='subjectname' 	value='<%=subjectname1 %>'> 
		<input type='hidden' name='lessonscheduleid' value=''>
		<input type='hidden' name='userids'	value=''> 
		<input type='hidden' name='boardid' 		value=''>
				<input type='hidden' name='standardscheduleid' 		value=''>
						<input type='hidden' name='staffname' 		value=''>
								<input type='hidden' name='subjectcode' 		value='<%=subjectcode %>'>
								<input type='hidden' name='splitedresult' 		value=''>
		
	
</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->
<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>