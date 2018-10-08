<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
		<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.board.trashpreviewlisttitle") %></title>

<LINK REL=stylesheet HREF="../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="../jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>


<script language="javascript" type="text/javascript" src="niceforms.js"></script>

<script language="JavaScript">

	

function goToBack()
{
	document.MainForm.action= "BoardList.jsp";
document.MainForm.submit();
}

function goToTrash()
{
if(confirm("Do you want to Trash the Board ...?"))
{
	document.MainForm.action= "BoardTrash.jsp";
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
         <h2><%=bundle.getString("label.board.trashpreviewlistrootpath") %></h2>
	
<%@ page language="java" import="java.util.*"%>
<%
	String curstatus = "T";
String mediumname=request.getParameter("mediumname");
String mediumid=request.getParameter("mediumidaaa");
	String boardid = request.getParameter("boardid");
	String instituteid = (String)session.getValue("instituteid");

	
	String noofdept="";

	String noofdesp="";
	String boardcount="";

	HashMap as1=new HashMap();
	instituteBean.setboardid(boardid); 
	
	String as=query_object.checkTrashBoards(instituteid);  
	
	if(noofdept.equals(""))
	{
		noofdept="-";
	}
	
	if(noofdesp.equals(""))
	{
		noofdesp="-";
	}
	
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

<TABLE align="center" width="100%" height="100%" BORDER=0 CELLSPACING=0
	CELLPADDING=0>
	
<tr>
	<td>
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.board.selectedinformation") %></th>
  	        <th scope="col" class="rounded" width="20%" align="center"> </th>
  	         <th scope="col" class="rounded" width="20%" align="center"> </th>
  	         <th scope="col" class="rounded-q4" width="40%"align="center"> </th>
        	
            
        </tr>
         <tr>
				<td class="tablebold" width="20%"><%=bundle.getString("label.medium.mediumname") %></td><td class="tablebold" width="1%">:</td>
				<td class="tablelight"  width="20%" colspan=2><%= mediumname%></td>
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
        	
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.board.trashpreviewtableheading") %> </th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
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
			<tr bordercolor=white>
		
				<td  class="tablebold" width="30%"><%=bundle.getString("label.board.boardname") %></td><td width="1% class="tablebold">:</td><td class="tablelight"><%=boardname %></td>
			</tr>
			<tr bordercolor=white>
				<td  class="tablebold" width="30%"><%=bundle.getString("label.board.description") %> </td><td width="1% class="tablebold">:</td><td class="tablelight"><%=description %></td>
			</tr>
			
			
			
			<tr bordercolor=white>
				<td  class="tablebold" width="30%"><%=bundle.getString("label.board.trashpreviewerrormessage") %></td><td width="1% class="tablebold">:</td><td class="tablelight"><%=as%></td>
			</tr>
		</table>
		<br>
		<a href="#" onclick="goToBack()"class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.board.back") %> </strong><span class="bt_blue_r"></span></a>
			 <%
			if(as.equals("0") )
			{%>
     <a href="#" class="bt_green" onClick="goToTrash()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.board.trash") %></strong><span class="bt_green_r"></span></a>
	 <%}
	 else
	 { out.println("<div class='warning_box'>");
	 	out.println("<a align=center class='tablebold'>"+bundle.getString("label.board.trashpreviewerrormessagedetails") +" </a>");
	 	 out.println("</div>");
	 }%>
	 
		
	
	<input type="hidden" name="boardid" value="<%=boardid %>">
	
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