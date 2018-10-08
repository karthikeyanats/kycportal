<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	ResourceBundle bundle=ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name") %> - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
	
	function updateQuestion(){
			
		document.question_form.action		= "QuestionModify.jsp";
		document.question_form.submit();
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
	<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,java.util.ResourceBundle,com.iGrandee.ExamManagement.QuestionEntry"%>

    <h2>Exam Management System / Question View</h2>
    <%
		String instituteid			= (String)session.getValue("instituteid");
		String userid				= (String)session.getValue("userid");
    	QuestionEntry equestion		= new QuestionEntry(); 
    	HashMap	hashmap				= null;
    	String questiontype			= request.getParameter("questiontype");
    	String difficultyfactor		= request.getParameter("difficultyfactor");
    	String examtype				= request.getParameter("examtype");
    	String lesson				= request.getParameter("lesson");
    	
    	String boardname			= request.getParameter("boardname");
    	String standardname			= request.getParameter("standardname");
    	String subjectname			= request.getParameter("subjectname");
    	String lessonname			= request.getParameter("lessonname");
    	String examtypename			= request.getParameter("examtypename");
   		ArrayList questionlist		= equestion.loadQuestion(questiontype,difficultyfactor,examtype,lesson);
   		
    %>
    
    <form name="question_form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%">Question Entry Details</th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
					<table width='100%' align='center' border='0' cellpadding='5'>
						<tr>
							<td width='15%' class='tablebold'>Board - Medium Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
								<%=boardname%>
							</td>
						</tr>			
						<tr>
							<td width='15%' class='tablebold'>Standard Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=standardname%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Subject Name - Subject Code</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=subjectname%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Lesson Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=lessonname%>
							</td>
						</tr>		
						<tr>
							<td width='15%' class='tablebold'>Exam Type</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=examtypename%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'>Question Type</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=questiontype%>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'>Difficulty Factor</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=difficultyfactor%>
							</td>

						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		
		<table id="rounded-corner" cellspacing=0  class=tablelight width="100%">
			  <thead>
			  	<tr>
					<th scope="col"  class="rounded-company" width='5%'>Sl.No.</th>
					<th scope="col"  class="rounded" width='20%'>Question</th>
					<th scope="col"  class="rounded" width='20%'>Answer</th>
					<th scope="col"  class="rounded" width='12%'>Start Date</th>
					<th scope="col"  class="rounded" width='12%'>End Date</th>
					<th scope="col"  class="rounded" width='10%'>Occurrence</th>
					<th scope="col"  class="rounded" width='5%'>Time</th>
					<th scope="col"  class="rounded" width='5%'>Mark</th>
					<th scope="col"  class="rounded-q4" width='11%'>Image</th>
				</tr>
			  </thead>
			<%
				String file			= "";
 				String questionArr[]= null; 
 				String question		= null;
				if(questionlist != null && questionlist.size()>0){
					for(int y=0;y<questionlist.size();y++){
						
						hashmap			= (HashMap)questionlist.get(y);
						file			= (String)hashmap.get("image");
						
						out.print("<tr><td valign='top'>"+(y+1)+".</td>");
						
						if(questiontype != null && questiontype.equals("Objectives")){
							
							out.print("<td valign='top'>"+hashmap.get("question")+"</td><td><table width='100%'><tr><td valign='top'>A.&nbsp;"+hashmap.get("A")+".</td></tr><tr><td valign='top'>B.&nbsp;"+hashmap.get("B")+".</td></tr>");
								if(hashmap.get("C") != null)
									out.print("<tr><td valign='top'>C.&nbsp;"+hashmap.get("C")+".</td></tr>");
								if(hashmap.get("D") != null)
									out.print("<tr><td valign='top'>D.&nbsp;"+hashmap.get("D")+".</td></tr>");
								if(hashmap.get("E") != null)
									out.print("<tr><td valign='top'>E.&nbsp;"+hashmap.get("E")+".</td></tr>");
								if(hashmap.get("F") != null)
									out.print("<tr><td valign='top'>F.&nbsp;"+hashmap.get("F")+".</td></tr>");
								if(hashmap.get("G") != null)
									out.print("<tr><td valign='top'>G.&nbsp;"+hashmap.get("G")+".</td></tr>");
							out.print("</table></td>");
							
						}else if(questiontype != null && questiontype.equals("Matching")){
							question		= (String)hashmap.get("question");
							if(question != null)
								questionArr	= question.split("\333");
							
							out.print("<td valign='top'><table width='100%'>");

							if(questionArr != null && questionArr.length>0)
								for(int u=0;u<questionArr.length;u++){
									out.print("<tr><td valign='top'>"+(u+1)+".&nbsp;"+questionArr[u]+".</td></tr>");
								}
							
							out.print("</table></td>");
							out.print("<td valign='top'><table width='100%'><tr><td valign='top'>A.&nbsp;"+hashmap.get("A")+".</td></tr><tr><td valign='top'>B.&nbsp;"+hashmap.get("B")+".</td></tr>");
							if(hashmap.get("C") != null)
								out.print("<tr><td valign='top'>C.&nbsp;"+hashmap.get("C")+".</td></tr>");
							if(hashmap.get("D") != null)
								out.print("<tr><td valign='top'>D.&nbsp;"+hashmap.get("D")+".</td></tr>");
							if(hashmap.get("E") != null)
								out.print("<tr><td valign='top'>E.&nbsp;"+hashmap.get("E")+".</td></tr>");
							if(hashmap.get("F") != null)
								out.print("<tr><td valign='top'>F.&nbsp;"+hashmap.get("F")+".</td></tr>");
							if(hashmap.get("G") != null)
								out.print("<tr><td valign='top'>G.&nbsp;"+hashmap.get("G")+".</td></tr>");
						
							out.print("</table></td>");							
							
						}
						else{
							
							out.print("<td  valign='top'>"+hashmap.get("question")+"</td><td>"+hashmap.get("correctans")+"</td>");
						}
					
					
						out.print("<td valign='top'>"+hashmap.get("fromdate")+"</td><td valign='top'>"+hashmap.get("todate")+"</td><td valign='top'>"+hashmap.get("occurance")+"</td><td valign='top'>"+hashmap.get("timelimit")+"</td><td valign='top'>"+hashmap.get("mark")+"</td>");
						
						if(file == null || file.equals("-"))
							out.print("<td valign='top'>-</td>");
						else
							out.print("<td valign='top'><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+file+"' alt='Question Image' width='50' height='60'></td>");
						out.print("</tr>");
					
					
					}
				}
				else
					out.print("<tr><td colspan='9' align='center'>Data Not Found</td></tr>");
			%>
		</table>
			

		<a href="#" class="bt_blue" onclick='document.location.replace("ExamHome.jsp")''><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_blue" onclick='updateQuestion()'><span class="bt_blue_lft"></span><strong>Go To Update</strong><span class="bt_blue_r"></span></a>
 			
		  			
		<input type='hidden' name='examtype' 			value='<%=examtype%>'>
		<input type='hidden' name='lesson' 				value='<%=lesson%>'>
		<input type='hidden' name='difficultyfactor' 	value='<%=difficultyfactor%>'>
		<input type='hidden' name='questiontype' 		value='<%=questiontype%>'>		
		<input type='hidden' name='boardname' 			value='<%=boardname%>'>		
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>		
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>		
		<input type='hidden' name='lessonname' 			value='<%=lessonname%>'>		
		<input type='hidden' name='examtypename' 		value='<%=examtypename%>'>	
		<input type='hidden' name='startsat' 			value='0'>		
			
		
</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>