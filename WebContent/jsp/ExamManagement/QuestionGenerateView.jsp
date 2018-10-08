<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
	ResourceBundle bundle=ResourceBundle.getBundle("resources.ApplicationResources");
%>

<title><%=bundle.getString("label.product.name") %> - Generated Question View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
	
	function updateQuestion(){
			
		document.question_form.action		= "QuestionModify.jsp";
		document.question_form.submit();
	}
	
	function generateDoc(str){
	
		document.question_form.typetogen.value		= str;
		document.question_form.action				= "DocumentView.jsp";
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

<%@ include file="../include/examheader.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.ExamManagement.QuestionPreparation"%>

    <h2><%=bundle.getString("label.exam.templategenerateviewroot")%></h2>
    <%
		String instituteid			= (String)session.getValue("instituteid");
		String userid				= (String)session.getValue("userid");
    	QuestionPreparation prepare	= new QuestionPreparation(); 
    	HashMap	hashmap				= null;
    	
    	String examname				= request.getParameter("examname");
    	String yearname				= request.getParameter("yearname");
    	String standardname			= request.getParameter("standardname");
    	String subjectname			= request.getParameter("subjectname");
    	String templatename			= request.getParameter("templatename");
    	String templateid			= request.getParameter("template");
    	String boardname			= request.getParameter("boardname");
    	String instruction			= request.getParameter("instruction");
    	String restartingduration	= request.getParameter("restartingduration");
    	String attempt				= request.getParameter("attempts");
    	String examtypename			= request.getParameter("examtypename");
    	String duration				= request.getParameter("duration");
    	ArrayList questionlist		= prepare.loadGeneratedQuestions(templateid);
    %>
    
    <form name="question_form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.exam.questiongenerateddetails")%></th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
						
					<table width='100%' align='center' border='0' cellpadding='5'>
						<tr>
							<td width='15%' class='tablebold'><%=bundle.getString("label.exam.academicyear")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
								<%=yearname%>
							</td>
						</tr>			
						<tr>
							<td width='15%' class='tablebold'><%=bundle.getString("label.common.boardmediumname")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=boardname%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'><%=bundle.getString("label.exam.standardname")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							<%=standardname%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'><%=bundle.getString("label.exam.subjectname")%> - <%=bundle.getString("label.common.subjectcode")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=subjectname%>
							</td>
						</tr>
						<tr>
							<td width='15%' class='tablebold'><%=bundle.getString("label.exam.templatename")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' colspan='4'>
							<%=templatename%>
							</td>
						</tr>	
						<tr >
							<td class=tablebold ><%=bundle.getString("label.exam.examtype")%></td>
							<td class=tablebold>:</td>
							<td class='tablelight'><%=examtypename%></td>
						</tr>
						<tr>
							<td class=tablebold valign='top'><%=bundle.getString("label.exam.instructions")%></td>
							<td class=tablebold align="left" valign='top'>:</td>
							<td class='tablelight'><%=instruction%></td>
						</tr>
							
					</table>
				</td>
			</tr>
		</table>
		<br>
		
		<table id="rounded-corner" cellspacing=0  class=tablelight width="100%">
			  <thead>
			  	<tr>
					<th scope="col"  class="rounded-company" width='7%'><%=bundle.getString("label.exam.slno")%></th>
					<th scope="col"  class="rounded" width='33%'><%=bundle.getString("label.exam.question")%></th>
					<th scope="col"  class="rounded" width='30%'><%=bundle.getString("label.exam.answer")%></th>
					<th scope="col"  class="rounded" width='5%'><%=bundle.getString("label.exam.time")%></th>
					<th scope="col"  class="rounded" width='5%'><%=bundle.getString("label.exam.mark")%></th>
					<th scope="col"  class="rounded-q4" width='20%'><%=bundle.getString("label.exam.image")%></th>
				</tr>
			  </thead>
			<%
				String file				= "";
 				String questionArr[]	= null; 
 				String question			= null;
 				String questiontype		= "";
 				
				if(questionlist != null && questionlist.size()>0){
					for(int y=0;y<questionlist.size();y++){
						
						hashmap			= (HashMap)questionlist.get(y);
						questiontype	= (String)hashmap.get("type");
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
					
						out.print("<td valign='top'>"+hashmap.get("timelimit")+"</td><td valign='top'>"+hashmap.get("mark")+"</td>");
						
						if(file == null || file.equals("-"))
							out.print("<td valign='top'>-</td>");
						else
							out.print("<td valign='top'><img src='"+request.getContextPath()+"/OpenFile?r1=storagepath&r2="+file+"' alt='Question Image' width='50' height='60'></td>");
						out.print("</tr>");
					
					}
				}
				else
					out.print("<tr><td colspan='9' align='center'>"+bundle.getString("label.exam.datanotfound")+"</td></tr>");
			%>
		</table>
			
		<a href="#" class="bt_blue" onclick='document.location.replace("QuestionGeneration.jsp")'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.exam.back")%></strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" onclick='generateDoc("PDF")'><span class="bt_green_lft"></span><strong>Generate PDF</strong><span class="bt_green_r"></span></a>
		<a href="#" class="bt_green" onclick='generateDoc("RTF")'><span class="bt_green_lft"></span><strong>Generate RTF</strong><span class="bt_green_r"></span></a>
 			
		  			
	
	<input type='hidden' name='typetogen' 		value=''>
	<input type='hidden' name='examname' 		value='<%=examname%>'>
	<input type='hidden' name='yearname' 		value='<%=yearname%>'>
	<input type='hidden' name='standardname' 	value='<%=standardname%>'>
	<input type='hidden' name='templatename' 	value='<%=templatename%>'>
	<input type='hidden' name='subjectname' 	value='<%=subjectname%>'>
	<input type='hidden' name='template' 		value='<%=templateid%>'>
	<input type='hidden' name='boardname' 		value='<%=boardname%>'>
	<input type='hidden' name='examtypename' 	value='<%=examtypename%>'>
	<input type='hidden' name='instruction' 	value='<%=instruction%>'>
	<input type='hidden' name='duration' 		value='<%=duration%>'>
	
	
	
	</form>		
    
    


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>