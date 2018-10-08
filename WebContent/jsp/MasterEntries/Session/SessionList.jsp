<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Session.SessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Session.SessionBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Session</title>

<LINK rel=stylesheet href="../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="../jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>
<script type="text/javascript" src="../jsp/jconfirmaction.jquery.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script language="javascript" type="text/javascript" src="niceforms.js"></script>

<script language="JavaScript">

	$(document).ready(function() {
		$('.ask').jConfirmAction();
	});


ddaccordion.init({
	headerclass: "submenuheader", //Shared CSS class name of headers group
	contentclass: "submenu", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
	onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", ""], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["suffix", "<img src='images/plus.gif' class='statusicon' />", "<img src='images/minus.gif' class='statusicon' />"], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing
	}
})





function goback()
{
document.MainForm.action= "SessionEntry.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{
if(confirm("Do you want to trash the Details"))
{

var sessionname=obj.getAttribute("sessionname");
var sessionid=obj.getAttribute("sessionid");
var description=obj.getAttribute("description");

document.MainForm.sessionname.value=sessionname;
document.MainForm.sessionid.value=sessionid;
document.MainForm.description.value=description;


document.MainForm.action= "SessionTrashPriview.jsp";
document.MainForm.submit();
}
else
{}
}
function editByClickFun(obj)
{
if(confirm("Do you want to Update the Details"))
{
var sessionname=obj.getAttribute("sessionname");
var sessionid=obj.getAttribute("sessionid");
var description=obj.getAttribute("description");


document.MainForm.sessionname.value=sessionname;
document.MainForm.sessionid.value=sessionid;
document.MainForm.description.value=description;

document.MainForm.action= "SessionUpdateByClick.jsp";
document.MainForm.submit();
}
else
{}
}
function DeactiveFun(obj)
{


document.MainForm.action= "SessionDeactiveList.jsp";
document.MainForm.submit();

}
function TrashListview()
{

document.MainForm.action= "SessionTrashListview.jsp";
document.MainForm.submit();

}
function BoardDeactiveView(obj)
{
if(confirm("Do you want to Update the Details"))
{

var newdates=obj.getAttribute("newdates");


var sessionname=obj.getAttribute("sessionname");
var sessionid=obj.getAttribute("sessionid");
var description=obj.getAttribute("description");


document.MainForm.sessionname.value=sessionname;
document.MainForm.sessionid.value=sessionid;
document.MainForm.description.value=description;
document.MainForm.newdates.value=newdates;


document.MainForm.action= "SessionDeactiveView.jsp";
document.MainForm.submit();
}
else{}
}

</script>
</head>

<body>
<form name="MainForm" method="post" action="">

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
         <h2>Master Entries /Year Of Session List</h2>
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList dept=new ArrayList();
HashMap newdept=new HashMap();
String roleids="";

dept=query_object.get_All_Sessions();
%>
<form name="MainForm" method="post" action="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td align="right"><a href="#" onclick="TrashListview()" class='tablelight'>Trash List</a>&nbsp;&nbsp;
		<a href="#" onclick="DeactiveFun()" class='tablelight'>Deative List</a>&nbsp;&nbsp;
		<a href="#" onclick="goback()" class='tablelight'>Back</a>
		</td>
		</tr>
		<tr><td valign="top">

		
<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%">Sl.No</th>
            <th scope="col" class="rounded" width="30%">Session Name</th>
            <th scope="col" class="rounded" width="40%">Session Description</th>
            <th scope="col" class="rounded-q4" width="25%">Date of creation</th>
           <th scope="col" class="rounded-q4" width="25%" colspan="3">Action</th> 
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <% 
				if(dept!=null && dept.size()>0)
				{						

					for(int i=0,j=1;i<dept.size();i++,j++)
					{
						out.println("<tr>");
						newdept=(HashMap)dept.get(i);
						
						out.println("<td class='tablelight'>"+j+"</td>");
						out.println("<td class='tablelight'>"+newdept.get("sessionname")+"</td>");
						String a1=newdept.get("description")+"";
						if(a1.equals("") || a1.equals("null"))
						{
						out.println("<td class='tablelight'>-</td>");
						}
						else{
						out.println("<td class='tablelight'>"+newdept.get("description")+"</td>");
						}
						out.println("<td class='tablelight'>"+newdept.get("newdates")+"</td>");
						out.println("<td class='tablelight'><a href='#'  id='check' rowpos='"+i+"' sessionid='"+newdept.get("sessionid")+"' sessionname='"+newdept.get("sessionname")+"' description='"+newdept.get("description")+"' incvalue='"+i+"' tablename='maintab' class='tablelight' onclick='editByClickFun(this)'>Edit</td>");

						out.println("<td class='tablelight'><a href='#' class='tablelight' onclick='trashFun(this)' sessionname='"+newdept.get("sessionname")+"' sessionid='"+newdept.get("sessionid")+"' description='"+newdept.get("description")+"'>Trash</td>");
						out.println("<td class='tablelight'><a href='#' class='tablelight' onclick='BoardDeactiveView(this)' sessionname='"+newdept.get("sessionname")+"' sessionid='"+newdept.get("sessionid")+"' description='"+newdept.get("description")+"' newdates='"+newdept.get("newdates")+"'>Deactivate</td>");

						out.println("</tr>");
						
			
					}

				}
				
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr>");
					//out.println("<td colspan='7' align='center'class='tablelight'>Data Not Found</td>");
					//out.println("</tr>");

				}
				

				%>	
    </tbody>
</table>
</td>
</tr>

				
			
			
		</table>

		</td>
	</tr>
	<tr><td>
			<input type='hidden' name='sessiontype' value="ExistSession">
			<input type="hidden" name="roleids" value="<%=roleids%>">
						<input type="hidden" name="sessionname" value="">
						<input type="hidden" name="sessionid" value="">
						<input type="hidden" name="description" value="">
						
					<input type="hidden" name="newdates" value="">
			
			
</td></tr>	

</TABLE>
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>