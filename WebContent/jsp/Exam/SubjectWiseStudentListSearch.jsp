<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.topperweaker.rangeheader")%> | Powered by i-Grandee</title>
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>        

<script type="text/javascript">
	

	function changeSession(){
		if(check_ForParticularElements(document.subjectSearch_Form.sessionname,"select")){
			document.subjectSearch_Form.boardname.selectedIndex 	= 0;
			document.subjectSearch_Form.examname.selectedIndex 	= 0;
			document.subjectSearch_Form.course.selectedIndex 		= 0;
			document.subjectSearch_Form.submit();
		}	
	}	
	
	function loadExam(){

		if(check_ForParticularElements(document.subjectSearch_Form.sessionname,"select",document.subjectSearch_Form.boardname,"select")){
			document.subjectSearch_Form.examname.selectedIndex 	= 0;
			document.subjectSearch_Form.course.selectedIndex 		= 0;
			document.subjectSearch_Form.submit();
		}	
	}

	function loadStandard()
	{
		if(check_ForParticularElements(document.subjectSearch_Form.sessionname,"select",document.subjectSearch_Form.boardname,"select",document.subjectSearch_Form.examname,"select")){
			document.subjectSearch_Form.course.selectedIndex 	= 0;
			document.subjectSearch_Form.submit();
		}	
	}

	
	function changeStandard(){
	
		if(check_ForParticularElements(document.subjectSearch_Form.sessionname,"select",document.subjectSearch_Form.boardname,"select",document.subjectSearch_Form.examname,"select",document.subjectSearch_Form.course,"select")){
			document.subjectSearch_Form.submit();
		}	
	}
	function maxmark(){
	
		if(check_ForParticularElements(document.subjectSearch_Form.sessionname,"select",document.subjectSearch_Form.boardname,"select",document.subjectSearch_Form.examname,"select",document.subjectSearch_Form.course,"select")){
			document.subjectSearch_Form.maxmarkvar.value=document.subjectSearch_Form.subject.options[document.subjectSearch_Form.subject.options.selectedIndex].getAttribute("maxmark");
			document.subjectSearch_Form.submit();
		}	
	}
	
	function publishStandard()
	{
		
		if(check_ForParticularElements(document.subjectSearch_Form.sessionname,"select",document.subjectSearch_Form.boardname,"select",document.subjectSearch_Form.examname,"select",document.subjectSearch_Form.course,"select",document.subjectSearch_Form.subject,"select"))
		{
		
		document.subjectSearch_Form.req_sessionname.value=document.subjectSearch_Form.sessionname.options[document.subjectSearch_Form.sessionname.options.selectedIndex].text;
		document.subjectSearch_Form.req_sessionvalue.value=document.subjectSearch_Form.sessionname.options[document.subjectSearch_Form.sessionname.options.selectedIndex].value;
		document.subjectSearch_Form.req_boardname.value=document.subjectSearch_Form.boardname.options[document.subjectSearch_Form.boardname.options.selectedIndex].text;
		document.subjectSearch_Form.req_boardvalue.value=document.subjectSearch_Form.boardname.options[document.subjectSearch_Form.boardname.options.selectedIndex].value;
		document.subjectSearch_Form.req_examname.value=document.subjectSearch_Form.examname.options[document.subjectSearch_Form.examname.options.selectedIndex].text;
		document.subjectSearch_Form.req_examvalue.value=document.subjectSearch_Form.examname.options[document.subjectSearch_Form.examname.options.selectedIndex].value;
		document.subjectSearch_Form.req_coursename.value=document.subjectSearch_Form.course.options[document.subjectSearch_Form.course.options.selectedIndex].text;
		document.subjectSearch_Form.subjectname.value=document.subjectSearch_Form.subject.options[document.subjectSearch_Form.subject.options.selectedIndex].text;
		document.subjectSearch_Form.req_coursevalue.value=document.subjectSearch_Form.course.options[document.subjectSearch_Form.course.options.selectedIndex].value;
		var rangecount=0;
	    for(var i=0;i<document.subjectSearch_Form.chk.length;i++)
				{
					if(document.subjectSearch_Form.chk[i].checked==true)
						rangecount++;
				}
			if(!rangecount>0)
			{
				alert("Select Any One Range Details");
				document.subjectSearch_Form.chk[0].focus();
				return false;
			}
			 for(var i=0;i<document.subjectSearch_Form.chk.length;i++)
				{
					if(document.subjectSearch_Form.chk[i].checked==true)
					{
						document.subjectSearch_Form.fromrange[i].disabled=false;  
   	    				document.subjectSearch_Form.torange[i].disabled=false;
					}
					else
					{
						document.subjectSearch_Form.fromrange[i].disabled=true;  
   	   					document.subjectSearch_Form.torange[i].disabled=true;
					}
				}
		
		document.subjectSearch_Form.action="SubjectWiseStudentListView.jsp";
	    document.subjectSearch_Form.submit();
	
	}
	}
	
function checkrangefun(obj)
	{
	var no = obj.value;
	if(obj.checked)
	{
	if(check_ForParticularElements(document.subjectSearch_Form.fromrange[no],"text",document.subjectSearch_Form.torange[no],"text"))
	{
   	    if(parseInt(document.subjectSearch_Form.torange[no].value)<parseInt(document.subjectSearch_Form.fromrange[no].value))
   	    {
			var varto=document.subjectSearch_Form.torange[no].value;
			var varfrom=document.subjectSearch_Form.fromrange[no].value; 
			document.subjectSearch_Form.torange[no].value=varfrom;
			document.subjectSearch_Form.fromrange[no].value=varto; 
		}
		if(parseInt(document.subjectSearch_Form.torange[no].value)===parseInt(document.subjectSearch_Form.fromrange[no].value))
			   		 		{
			   		 		alert("From  Range and To Range Are Same");
			   		 		document.subjectSearch_Form.torange[no].focus();
			   		 		obj.checked=false;
			   		 		return false;
			   		 		}
   		 var chklength= document.subjectSearch_Form.chk.length;
   		 for(var i=0;i<chklength;i++)
   		 {
	   		 if(i!=no)
	   		 {
	   		 	 if(document.subjectSearch_Form.fromrange[i].value!="" && document.subjectSearch_Form.torange[i].value!="")
			   		 {		
			   		 		if((parseInt(document.subjectSearch_Form.fromrange[no].value)==parseInt(document.subjectSearch_Form.fromrange[i].value)) && (parseInt(document.subjectSearch_Form.torange[no].value)==parseInt(document.subjectSearch_Form.torange[i].value)))
			   		 		{
				   		 		alert("From Range And To Already Exist");
				   		 		document.subjectSearch_Form.fromrange[no].focus();
				   		 		obj.checked=false;
				   		 		return false;
			   		 		}
			   		 }
	   		 }
   		 }
   	    document.subjectSearch_Form.fromrange[no].disabled=true;  
   	    document.subjectSearch_Form.torange[no].disabled=true;
	}
	else
	{
	obj.checked=false;
	}
	}
	else
	{
   	    document.subjectSearch_Form.fromrange[no].disabled=false;  
   	    document.subjectSearch_Form.torange[no].disabled=false;  
	}
	}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="./../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="./../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
	<% if(loginusercategory.equals("SA"))
	{%>
    <h2><%=bundle.getString("label.topperweaker.rangerootpath")%></h2>
    <% }
    else
    {%>
    <h2><%=bundle.getString("label.topperweaker.rangeprincirootpath")%> </h2>
    <%} %>
		<form name="subjectSearch_Form" action="" method="post">
		
		    <table id="rounded-corner" border=0 width="100%">
		    	<thead>
  				<tr>
        	 <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.topperweaker.rangeheader")%></th>      
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.common.mandatory") %></th> 
        </tr>
    </thead>
       
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

<%

		String instituteid				= (String)session.getValue("instituteid");
		ExamAllotmentQuery  examQuery 	= new ExamAllotmentQuery();
		ArrayList BoardList				= null;
		ArrayList academicList 			= examQuery.loadAcademicYearMarkPublished(instituteid);
		HashMap	hashmap					= null;
		ArrayList ExamList				= null;
		ArrayList standardList			= null;
		String reg_sessionid 			= request.getParameter("sessionname");
		String reg_boardid 				= request.getParameter("boardname");
		String reg_examid 				= request.getParameter("examname");
		String standardid 				= request.getParameter("course");
		String subjectid 				= request.getParameter("subject")+"";
		String maxmark 				    = request.getParameter("maxmarkvar")+"";
		if(maxmark.equals("null") || maxmark.equals(""))
			maxmark="0";
		int max =Integer.parseInt(maxmark);
		ArrayList subjecttList			= null;

		
		if(request.getParameter("sessionname") != null ){
			BoardList				= examQuery.loadBoardListMarkPublished(instituteid,reg_sessionid);		}
		
		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  )
			ExamList			= examQuery.loadExamNameMarkPublished(reg_sessionid,reg_boardid);

		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null)
			standardList 		= examQuery.listStandardMarkPublished(reg_sessionid,reg_boardid,reg_examid);
		
		if(request.getParameter("sessionname") != null && request.getParameter("boardname") != null  && request.getParameter("examname") != null && request.getParameter("course") != null)
			subjecttList			= examQuery.subjectsScheduled(standardid);
%>
			<%
	%>	
	<input type="hidden" name="req_sessionname" value="">
	<input type="hidden" name="req_sessionvalue" value="">
	<input type="hidden" name="req_boardname" value="">
	<input type="hidden" name="req_boardvalue" value="">
	<input type="hidden" name="req_examname" value="">
	<input type="hidden" name="req_examvalue" value="">
	<input type="hidden" name="req_coursename" value="">
	<input type="hidden" name="req_coursevalue" value="">
	<input type="hidden" name="subjectname" value="">
	<input type="hidden" name="req_subjectvalue" value="">
	<input type="hidden" name="req_students" value="">  
	<input type="hidden" name="maxmarkvar" value="">  
	
	
		
		<table width='100%' align='center' id="rounded-corner1" border='0' cellpadding='5' cellspacing='0' >
			<tr >
				<td class=tablebold width='15%'><%=bundle.getString("label.topperweaker.AcademicYear")%><font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td>
					<select name=sessionname validate="Academic Year" class=tablelight onchange='changeSession()'>
						<option value="00">-Select Academic-</option>
						<%
							if(academicList != null && academicList.size()>0)
							for(int s=0;s<academicList.size();s++)
							{
								hashmap		= (HashMap)academicList.get(s);
								if(reg_sessionid != null && reg_sessionid.equals((String)hashmap.get("sessionid")))
									out.println("<option selected value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
								else
									out.println("<option value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
								
							}
						%>
					</select>
				</td>
			

				<td class=tablebold width='10%'><%=bundle.getString("label.topperweaker.Board")%> <font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td>
					<select name=boardname validate="Board " class=tablelight onchange=loadExam()>
						<option value="00">-Select Board-</option>
						<%
					      	if(BoardList!=null && BoardList.size()>0)
		  		 			for (int i = 0;i < BoardList.size(); i++) 
		  		 			{
		  		 				hashmap				=(HashMap)BoardList.get(i);
								if(reg_boardid != null && reg_boardid.equals((String)hashmap.get("boardid")))
									out.println("<option selected value='"+hashmap.get("boardid")+"' class=tablelight >"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
								else
									out.println("<option value='"+hashmap.get("boardid")+"' class=tablelight >"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
					  		 }
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td class=tablebold><%=bundle.getString("label.topperweaker.ExamName")%> <font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td>
					<select name=examname validate="Exam "class=tablelight onchange=loadStandard() >
						<option value="00">-Select Exam Name-</option>
						<%
					      	if(ExamList!=null && ExamList.size()>0)
		  		 			for (int i = 0; i < ExamList.size(); i++) 
		  		 			{
		  		 				hashmap				=(HashMap)ExamList.get(i);
								if(reg_examid != null && reg_examid.equals((String)hashmap.get("examnameid")))
									out.println("<option selected value='"+hashmap.get("examnameid")+"' class=tablelight >"+hashmap.get("examname")+"</option>");
								else
									out.println("<option value='"+hashmap.get("examnameid")+"' class=tablelight >"+hashmap.get("examname")+"</option>");
					  		 }

						%>
					</select>
				</td>
		
				<td class=tablebold><%=bundle.getString("label.topperweaker.Standard")%> <font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td><select name=course validate="Standard " class=tablelight onchange='changeStandard()' >
					<option value="00">-Select Standard-</option>
					<%
					if(standardList !=null && standardList.size() >0)
						for(int s1=0;s1<standardList.size();s1++)
						{
							hashmap			=(HashMap)standardList.get(s1);
							if(standardid != null && standardid.equals((String)hashmap.get("standardscheduleid")))
								out.print("<option selected value='"+hashmap.get("standardscheduleid")+"' class=tablelight >"+hashmap.get("standardname")+"</option>");
							else
								out.print("<option value='"+hashmap.get("standardscheduleid")+"' class=tablelight >"+hashmap.get("standardname")+"</option>");
						}
					%>
					</select>
				</td>
			</tr>
			<tr >
				<td class=tablebold>Subject <font color="red">*</font></td>
				<td class=tablebold width="2%">:</td>
				<td colspan=3><select name=subject validate="Subject " class=tablelight onchange="maxmark()" >
					<option value="00">-Select Subject-</option>
					<%
						if(subjecttList !=null && subjecttList.size() >0)
							for(int s1=0;s1<subjecttList.size();s1++)
							{
								hashmap			=(HashMap)subjecttList.get(s1);
								if(subjectid != null && subjectid.equals((String)hashmap.get("subjectscheduleid")))
									out.println("<option selected value='"+hashmap.get("subjectscheduleid")+"' class=tablelight >"+hashmap.get("subjectname")+"</option>");
								
								else
									out.println("<option value='"+hashmap.get("subjectscheduleid")+"' class=tablelight  maxmark='"+hashmap.get("theoryexternalmax")+"' >"+hashmap.get("subjectname")+"</option>");
							}
					%>
					</select>
				</td>
				</tr>
				<tfoot>
	    	<tr>
	        	<td colspan="2" class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       	</tr>
    	</tfoot>
		</table><br>
		<h3>Range Setting</h3>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">  
		    	<thead>
		    		<tr>
		        		<th scope="col" class="rounded-company" width="10"></th>
		            	<th scope="col" class="rounded" width="10%"><%=bundle.getString("label.topperweaker.slno")%></th>
		            	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.topperweaker.from")%></th>
		            	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.topperweaker.to")%></th>
		            	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.topperweaker.check")%></th>
		            	<th scope="col" class="rounded-q4" width="10"></th>        
		        	</tr>
		    	</thead>
		    	<tbody>
		    	<tr><td></td><td>1</td>
		    	<td>
		    	<select name=fromrange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    	<td>
		    	<select name=torange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    	<td><input type="checkbox" name="chk" value="0" onclick="checkrangefun(this)"></td><td></td>
		    	</tr>
		    	<tr><td></td><td>2</td>
		    	<td>
		    	<select name=fromrange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    	<td>
		    	<select name=torange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    			    	<td><input type="checkbox" name="chk" value="1" onclick="checkrangefun(this)"></td><td></td>
		    	
		    	</tr>
		    	<tr><td></td><td>3</td>
		    	<td>
		    	<select name=fromrange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    	<td>
		    	<select name=torange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    			    	<td><input type="checkbox" name="chk" value="2" onclick="checkrangefun(this)"></td><td></td>
		    	
		    	</tr>
		    	<tr><td></td><td>4</td>
		    	<td>
		    	<select name=fromrange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    	<td>
		    	<select name=torange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    			    	<td><input type="checkbox" name="chk" value="3" onclick="checkrangefun(this)"></td><td></td>
		    	
		    	</tr>
		    		<tr><td></td><td>5</td>
		    	<td>
		    	<select name=fromrange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    	<td>
		    	<select name=torange >
		    	<%
		    	for(int i=0;i<=max;i++)
		    	{
					out.print("<option value='"+i+"' class=tablelight >"+i+"</option>");
		    	}
		    	%>
		    	</select>
		    	</td>
		    			    	<td><input type="checkbox" name="chk" value="4" onclick="checkrangefun(this)"></td><td></td>
		    	
		    	</tr>
		    		
		    	</tbody>
		<tfoot>
	    	<tr>
	        	<td colspan="5" class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       	</tr>
    	</tfoot>
    	</table>
    	<br>
				<a href="#" class="bt_blue" onclick='publishStandard()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.topperweaker.view")%></strong><span class="bt_blue_r"></span></a>
		</table>
	</table>
	
	
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="./../include/footer.jsp" %>
</div>
</body>
</html>