<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumEntry" />
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.board.entrytitle") %></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>

<script language="JavaScript">

function submitfun()
{

	if(check_ForParticularElements(document.MainForm.boardname,"text",document.MainForm.medium,"select"))
	{
			document.MainForm.action= "BoardSubmit.jsp";
			document.MainForm.submit();
		
	}
	
		

}
function resetfun()
{
document.MainForm.reset();
document.getElementById("labelid").innerHTML	= "2000";

}

function submitfuncombo(obj)
{
var mediumid=obj.value;
document.MainForm.mediumidaaa.value=mediumid;
document.MainForm.mediumname.value = document.MainForm.medium.options[document.MainForm.medium.options.selectedIndex].text;
} 

function boardlist()
{
 if(document.MainForm.medium.value=="0")
{
alert("Select Medium Name");
return false;
}
document.MainForm.action= "BoardList.jsp";
document.MainForm.submit();
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
      <h2><%=bundle.getString("label.board.entryrootpath") %></h2>

<%@ page import="java.util.*"%>

<%

String mediumid="";


ArrayList BoardName=new ArrayList();
HashMap BoardNames=new HashMap();
String instituteid = (String)session.getValue("instituteid");

BoardName=query_object.getAllMediumNames(instituteid);
%>

<form name="MainForm" method="post" action="">
<input type="hidden" name="mediumidaaa" value="">
<input type="hidden" name="mediumid" value="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
           	 <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.board.entrytableheading") %></th>      
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.board.mandatoryfields") %></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td> 
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>				
		<tr>
	<td class="tablebold"><%=bundle.getString("label.medium.mediumname") %></td>
		<td class=tablebold>:</td><td>
		<select name="medium" validate="Medium" onchange=submitfuncombo(this)>
		<option value="0" >--Select Medium Name--</option>
		<%
		for(int i=0;i<BoardName.size();i++)
		{
		BoardNames=(HashMap)BoardName.get(i);
		mediumid=(String)BoardNames.get("mediumid");
		String mediumname=(String)BoardNames.get("mediumname");
		out.println("<option value="+mediumid+" >"+mediumname+"</option>");
		

		}
		%>
		</select>
		</td>
		</tr>
			<tr valign="top">
				<td class="tablebold"><%=bundle.getString("label.board.boardname") %> <font color=red>*</font></td>
				<td class=tablebold>:</td><td class="tablelight"><input type="text" name="boardname"
					validate="Board Name" class=tablelight size="50" value=""
					maxlength=45></td>
			</tr>
			<tr valign="top">
				<td class="tablebold"><%=bundle.getString("label.board.description") %></td>
				<td class=tablebold>:</td><td class="tablelight">
					<textarea validate="Description" class="tablelight" cols=75 rows=2 name="descryption" onkeydown="textCounter_label(document.MainForm.descryption,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.MainForm.descryption,document.getElementById('labelid'),2000)"></textarea>&nbsp;<br><br> <i><font color="red"><label id="labelid" ><%=bundle.getString("label.board.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.board.charactersleft") %></font></i>
					</td>
			</tr>
			
				
			</thead>
		</table>
	 <a href="#" onclick="resetfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.board.reset") %></strong><span class="bt_blue_r"></span></a>

     <a href="#" onclick="boardlist()"   class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.board.viewallboard") %> </strong><span class="bt_blue_r"></span></a>
		
     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.board.submit") %></strong><span class="bt_green_r"></span></a>

	
	<input type="hidden" name="mediumname" value"">
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