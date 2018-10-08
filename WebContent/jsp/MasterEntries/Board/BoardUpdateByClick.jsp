
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.board.updatelistlisttitle") %></title>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>

<script language="JavaScript">

function goToBack()
{
	document.MainForm.action= "BoardList.jsp?mediumidaaa="+document.MainForm.mediumidaaa.value;;
document.MainForm.submit();
}
function goToUpdate()
{
if(check_ForParticularElements(document.MainForm.boardname,"text"))
	{
		
if(confirm("Do you want to Update the Board...?"))
{

	document.MainForm.action= "BoardEditUpdate.jsp";
document.MainForm.submit();

}
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
         <h2><%=bundle.getString("label.board.updatelistrootpath") %></h2>
     
<%@ page language="java" import="java.util.*"%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<%
String mediumid=request.getParameter("mediumidaaa");
String mediumname=request.getParameter("mediumname");

	String boardid = request.getParameter("boardid");
	String mediumidaaa=request.getParameter("mediumidaaa");

	ArrayList getDetailsForuadate=query_object.getDetailsForuadate(boardid);   
	HashMap DetailsForuadate=null;
	String boardname=null;
	String description=null;
	for(int k=0;k<getDetailsForuadate.size();k++)
	{
		DetailsForuadate=(HashMap)getDetailsForuadate.get(k);
		boardname=(String)DetailsForuadate.get("boardname");
		 description=(String)DetailsForuadate.get("description");

	}
	if(description.equals(""))
	{
	description="-";
	}
	
%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="mediumidaaa" value="<%=mediumid %>">
<input type="hidden" name="mediumname" value="<%=mediumname %>">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	<tr valign="top">
	<td valign="top">     
	<table id="rounded-corner" border=0   summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="15%"><%=bundle.getString("label.board.selectedinformation") %></th>
  	        <th scope="col" class="rounded" width="1%" align="center"> </th>
  	         <th scope="col" class="rounded" width="25%" align="center"> </th>
  	         <th scope="col" class="rounded-q4" width="60%"align="center"> </th>
        	
            
        </tr>
         <tr>
				<td class="tablebold" width="20%"><%=bundle.getString("label.medium.mediumname") %></td><td class="tablebold" width="1%">:</td>
				<td class="tablelight"  width="80%" colspan=2 align=left><%= mediumname%></td>
			</tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    </table>
    </td>
    </tr>
    </table>
        <br><br>
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
                	<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.board.updatetableheading") %></th>
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font>&nbsp;<%=bundle.getString("label.board.mandatoryfields") %></th>
            
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
		<table id="rounded-corner" border=0 width="100%">


    <thead>

		
			<tr bordercolor=white valign="top">
				<td  class="tablebold"><%=bundle.getString("label.board.boardname") %>  <font color=red>*</font></td>
				<td class=tablebold>:</td><td colspan="2"><input type="text" name="boardname" size=50 validate="Board Name" maxlength=45 value="<%=boardname.replaceAll("\"","&quot")%>"></td>
			</tr>
			<tr bordercolor=white valign="top">
				<td  class="tablebold"><%=bundle.getString("label.board.description") %> </td>
				<td class=tablebold>:</td><td>
								<textarea validate="Description" class="tablelight" cols=75 rows=2 name="deptdescription" onkeydown="textCounter_label(document.MainForm.deptdescription,document.getElementById('labelid'),2000)" onkeyup="textCounter(document.MainForm.deptdescription,document.getElementById('labelid'),2000)"><%=description %></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.board.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.board.charactersleft") %></font></i>
				</td>	
				
				</tr>
			
		
		</table>
</td>
</tr>
   <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>

    
		</table>
     		  <a href="#"  onclick="goToBack()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.board.back") %> </strong><span class="bt_blue_r"></span></a>		
		 <a href="#" class="bt_green" onclick="goToUpdate()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.board.update") %></strong><span class="bt_green_r"></span></a>
			
	
<tr>	
		<td><input type="hidden" name="boardid" value="<%=boardid %>"></td></tr>
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