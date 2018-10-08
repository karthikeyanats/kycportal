<!DOCTYPE =html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<title><%=bundle.getString("label.product.name")%> - Grade Edit | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function loadfun()
{
	document.Grade_Form.submit();
} 
function TrashList()
{
	if(check_ForParticularElements(document.Grade_Form.sessionname,"select"))
	 	{
		document.Grade_Form.academicname.value=document.Grade_Form.sessionname.options[document.Grade_Form.sessionname.options.selectedIndex].text;
		document.Grade_Form.action="./GradeTrashList.jsp";
		document.Grade_Form.submit();
		}
}
function Trashfun(obj)
	{
		if(confirm("Do You Want To trash the Grade...?"))
		 	{
		 	document.Grade_Form.Gradeid.value=obj.getAttribute("gradesystemid");
			document.Grade_Form.editstatus.value="T";
			document.Grade_Form.action="./GradeEditSubmit.jsp";
			document.Grade_Form.submit();
			}
	}
function Editfun(obj)
{
	if(confirm("Do you want to Edit the Grade...?"))
	 	{
	 	document.Grade_Form.Gradeid.value=obj.getAttribute("gradesystemid");
		document.Grade_Form.action="./GradeEdit.jsp";
		document.Grade_Form.submit();
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
function EditGrade()
{
	if(check_ForParticularElements(document.Grade_Form.GradeName,'text',document.Grade_Form.Rangefrom,'text',document.Grade_Form.Rangeto,'text'))
		{
		 		checkDuplicate("duplicategradename");
		}
}
function backfun()
{
document.Grade_Form.action="./GradeView.jsp";
document.Grade_Form.submit();
}

function checkDuplicate(flag)
{
	var url = "";
	var date = new Date();
   	    if(parseInt(document.Grade_Form.Rangeto.value)<parseInt(document.Grade_Form.Rangefrom.value))
   	    {
		var varto=document.Grade_Form.Rangeto.value;
		var varfrom=document.Grade_Form.Rangefrom.value; 
		document.Grade_Form.Rangeto.value=varfrom;
		document.Grade_Form.Rangefrom.value=varto; 
		}
	if(flag=="duplicategradename")
	{
	 		url = "GradeInfo.jsp?action=duplicategradename&gradename="+document.Grade_Form.GradeName.value.replace('+','&#43;')+"&reqgradeid="+document.Grade_Form.Gradeid.value+"&reqsessionid="+document.Grade_Form.sessionname.value+"&date="+date;
	}
	if(flag=="duplicaterange")
	{
	 		url = "GradeInfo.jsp?action=duplicaterange&rangefrom="+document.Grade_Form.Rangefrom.value+"&rangeto="+document.Grade_Form.Rangeto.value+"&reqgradeid="+document.Grade_Form.Gradeid.value+"&reqsessionid="+document.Grade_Form.sessionname.value+"&date="+date;
	}
	var req =initRequest();
	req.onreadystatechange = function()
	{
	
		if (req.readyState == 4)
		{
			if (req.status == 200)
			{
			
				if(flag=="duplicategradename")
				{
				 	parseMessages(req.responseXML,flag);
			  	}
			  	if(flag=="duplicaterange")
				{
				 	parseMessages(req.responseXML,flag);
			  	}
			}
		}
	};
	req.open("GET", url, true);
	req.send(null);
}

function parseMessages(xmlObj,flag)
	{
       var fromarray=new Array();
       var toarray=new Array();
		if(flag=="duplicategradename")
		{
			var rootObj=xmlObj.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
					if(temp=="true")
						{
							alert("Grade Name already exists");
							document.Grade_Form.GradeName.focus();
							return false;
						}
					else
						{
							checkDuplicate("duplicaterange");
						}
				}
		else if(flag=="duplicaterange")
		{
			var stat="no";
			var rootObj=xmlObj.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
			var Rangefrom=document.Grade_Form.Rangefrom.value;
			var Rangeto=document.Grade_Form.Rangeto.value;
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
							var from=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
							var to=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
							fromarray[fromarray.length]=from;
							toarray[toarray.length]=to;
			}
			for(var i=0;i<fromarray.length;i++)
			{
								if(parseInt(Rangefrom)===parseInt(Rangeto))
					   		 		{
						   		 		alert("From  Range and To Range Are Same");
						   		 		stat="yes";
						   		 		document.Grade_Form.Rangeto.focus();
						   		 		return false;
					   		 		}
				   		 		if(Rangefrom!="" && Rangeto!="")
					   			 	{	
						   			 	if(parseInt(Rangefrom)>=parseInt(fromarray[i]) && parseInt(Rangefrom)<=parseInt(toarray[i]))
							   		 		{
								   		 		alert("From Range Already Exist");
								   		 		stat="yes";
								   		 		document.Grade_Form.Rangefrom.focus();
								   		 		return false;
							   		 		}
						   		 		if(parseInt(Rangeto)>=parseInt(fromarray[i]) && parseInt(Rangeto)<=parseInt(toarray[i]))
							   		 		{
								   		 		alert("To Range Already Exist");
								   		 		stat="yes";
								   		 		document.Grade_Form.Rangeto.focus();
								   		 		return false;
							   		 		}
					   		 		}
				}
		
					if(stat=="yes")
						{
							alert("Grade Name already exists");
							document.Grade_Form.GradeName.focus();
							return false;
						}
					else
						{
							document.Grade_Form.editstatus.value="E";
							document.Grade_Form.action="./GradeEditSubmit.jsp";
							document.Grade_Form.submit();	
						}
		}
}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>
    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.gradesystem.rootpathedit")%></h2>
	<form name="Grade_Form" action="" method="post">
    <input type=hidden name=examId />
    <input type=hidden name=examname />
    <input type=hidden name=academicname />
      <input type=hidden name="editstatus" value="E"/>
       
      
    
    	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    	<thead>
    		<tr>
        		<th scope="col" class="rounded-company" width="80%" colspan='2'><%=bundle.getString("label.gradesystem.selectinfo")%></th>
            	<th scope="col" class="rounded-q4" width="20%" ></th>
        	</tr>
    	</thead>
        <tfoot>
    			<tr>
        			<td colspan="2" class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery,com.iGrandee.Common.DateTime"%>

<%
		com.iGrandee.Exam.ExamnameEntry  examQuery = new com.iGrandee.Exam.ExamnameEntry();
		String instituteid = null;
		ArrayList GradeList=new ArrayList();
		instituteid			= (String)session.getValue("instituteid");
		HashMap	hashmap				= null;
		String AcademicYear="";
		String reg_sessionid 	= null;
		String reg_gradeid 	= null;

		//out.println("==============>>>>>>>>>"+request.getParameter("sessionname"));
	try{
	
		 if(request.getParameter("sessionname") != null )		
		 {
			 reg_sessionid=request.getParameter("sessionname");
			 reg_gradeid=request.getParameter("Gradeid");
			 GradeList=examQuery.LoadGradeForgradeId(reg_sessionid,reg_gradeid);
			 AcademicYear=request.getParameter("academicname");
		}
		
		
}catch(Exception e){}
			
%>
			
<tbody>	
<tr height='23'>
		<td class=tablebold width='20%'><%=bundle.getString("label.gradesystem.academic")%></td>
		<td class=tablebold width="2%">:</td>
		<td width='80%'>
		<%=AcademicYear %>
				</td>
</tr>
	</tbody>
</table>
   <input type=hidden name=Gradeid value='<%=reg_gradeid %>'/>
   <input type=hidden name=sessionname value='<%=reg_sessionid %>'/>
   
  <br>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='100%' class='tablebold' colspan=2>
				
					<table id="rounded-corner1"  border=0 width="100%" cellspacing='3' cellpadding='5'>
					    <thead>
					    	<tr class='tableheading'>
					        	<th scope="col" class="rounded 	width="20%" colspan=6 align=left>Grade Details</th>
					        </tr>
					    </thead>
					    <tfoot>
    			<tr>
        			<td colspan="5" class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    	</tfoot>
    	<tbody>
					   	<%
					   	int j = 1;
					   	if(GradeList.size()>0 && GradeList!=null)
					   	{
					   		for (int i = 0; i < GradeList.size(); i++,j++) 
		  		 			{	
					   			hashmap=(HashMap)GradeList.get(i);
								out.println("<tr  align='center'>");
								out.println("<td>"+bundle.getString("label.gradesystem.gradename")+" :</td><td class=tablelight ><input type='Text' name='GradeName'  validate='Grade Name' size='50' maxlength='50' value='"+hashmap.get("gradename")+"'/></td>");
								out.println(" <td>Range :</td><td class=tablelight align='right'><input type='Text' name='Rangefrom' value='"+hashmap.get("rangefrom")+"' validate='Range From' size='10' maxlength='5' onkeypress='checkNumber(event)'></td><td><font color=red >To</font></td><td align='left'><input type='Text' name='Rangeto' value='"+hashmap.get("rangeto")+"' validate='Range To' size='10' maxlength='5' onkeypress='checkNumber(event)'></td>");
								out.println("</tr>");
							}
					 	}
					   	else
					   	{
					   		out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
							//out.println("<tr align='center' ><td colspan='7'>Data Not Found</td><tr>");
					   	}
						%>
						</tbody>
		</table>
		</td>
		</tr>
	</table>
		<a href="#sub1" name="sub1" class="bt_green" onclick='EditGrade()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.gradesystem.submit")%></strong><span class="bt_green_r"></span></a>
	    <a href="#sub" name="sub" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.gradesystem.back")%></strong><span class="bt_blue_r"></span></a>
</form>	
    </div><!-- end of right content-->
	</div>   <!--end of center content -->

   <div class="clear"></div>
   </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
</div>
</body>
</html>