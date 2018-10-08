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
<title><%=bundle.getString("label.board.alllisttitle") %></title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>
<script language="JavaScript">





function goback()
{
document.MainForm.action= "BoardEntry.jsp";
document.MainForm.submit();
}
function trashFun(obj)
{     

if(confirm("Do you want to Trash the Board...?"))
{
document.MainForm.boardid.value=obj.getAttribute("boardid");
document.MainForm.boardname.value=obj.getAttribute("boardname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "BoardTrashPriview.jsp";
document.MainForm.submit();
}
else
{}
}
function editByClickFun(obj)
{

if(confirm("Do you want to Update the Board...?"))
{
document.MainForm.boardid.value=obj.getAttribute("boardid");
document.MainForm.boardname.value=obj.getAttribute("boardname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "BoardUpdateByClick.jsp";
document.MainForm.submit();
}
else
{}
}
function DeactiveFun()
{


	document.MainForm.action= "BoardDeactive.jsp";
	document.MainForm.submit();


}
function TrashListview()
{

document.MainForm.action= "BoardTrashListview.jsp";
document.MainForm.submit();

}
function BoardDeactiveView(obj)
{
if(confirm("Do you want to Deactivate the Board...?"))
{
	var newdates=obj.getAttribute("newdates");
	document.MainForm.boardid.value=obj.getAttribute("boardid");
	document.MainForm.boardname.value=obj.getAttribute("boardname");
	document.MainForm.description.value=obj.getAttribute("description");
	document.MainForm.action= "BoardDeactiveView.jsp?newdates="+newdates;
	document.MainForm.submit();
}
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
         <h2><%=bundle.getString("label.board.alllistrootpath") %></h2>
     
<%@ page import="java.io.*,java.util.*"%>

<%
ArrayList Board=new ArrayList();
HashMap newBoard=new HashMap();
String roleids="";
String mediumname=request.getParameter("mediumname");
String mediumid=request.getParameter("mediumidaaa");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");

Board=query_object.get_All_boards(mediumid,instituteid);
%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="mediumidaaa" value="<%=mediumid %>">
<input type="hidden" name="mediumname" value="<%=mediumname %>">

<input type="hidden" name="boardid" value="">
<input type="hidden" name="boardname" value="">
<input type="hidden" name="description" value="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
	
	<tr>
	<td>
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
        	<th scope="col" class="rounded-company" width="10"><%= bundle.getString("label.board.slno")%></th>
        	<th scope="col" class="rounded" width="25%"><%= bundle.getString("label.board.boardname")%> </th>
  	        	<th scope="col" class="rounded" width="30%"><%= bundle.getString("label.board.description")%> </th>
  	        	<th scope="col" class="rounded" width="20%"><%= bundle.getString("label.board.dateofcreation")%> </th>
  	        	<th scope="col" class="rounded" width="5%"><%= bundle.getString("label.board.edit")%> </th>
  	        	<th scope="col" class="rounded" width="5%"><%= bundle.getString("label.board.trash")%> </th>
  	        	<th scope="col" class="rounded-q4" width="5%" align="center"><%= bundle.getString("label.board.deactive")%> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=6  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
			
				<% String []count=null;
				if(Board!=null && Board.size()>0)
				{	String as=request.getContextPath();							

					for(int i=0,j=1;i<Board.size();i++,j++)
					{
						out.println("<tr valign='top'>");
						newBoard=(HashMap)Board.get(i);
						out.println("<td class='tablelight'>"+j+"</td>");
						out.println("<td class='tablelight'>"+newBoard.get("boardname")+"</td>");
						if(newBoard.get("description").equals(""))
						{
						out.println("<td class='tablelight'>-</td>");
						}
						else{
							 String des_temp=newBoard.get("description")+"";
							   count=des_temp.split(" ");
								if((count.length-1)>15)
								{
									out.print("<td class='tablelight' ");
									String des_tempnew="";
									for(int s=0;s<15;s++)
									{
										des_tempnew+=count[s]+" ";
									}%>
									<div>
									<%=des_tempnew%><a href="index.htm" onclick="return hs.htmlExpand(this)">
								[<font color="red">More..</font>]
							</a>  
							<div class="highslide-maincontent">
								<h3></h3>
								<%=(newBoard.get("description")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+newBoard.get("description")+"</td>");

								}						}
						out.println("<td class='tablelight'>"+newBoard.get("newdates")+"</td>");

						
						out.println("<td class='tablelight'><a href='#'  id='check' rowpos='"+i+"' boardid='"+newBoard.get("boardid")+"' boardname='"+newBoard.get("boardname")+"' description='"+newBoard.get("description")+"' incvalue='"+i+"' tablename='maintab' class='tablelight' onclick='editByClickFun(this)'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='Edit' title='"+bundle.getString("hlink.board.edit")+"' border=0 /></a></td>");
						out.println("<td class='tablelight'><a href='#'  class='tablelight' onclick='trashFun(this)' boardid='"+newBoard.get("boardid")+"' boardname='"+newBoard.get("boardname")+"' description='"+newBoard.get("description")+"'><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.board.trash")+"' border=0 /></a></td>");
						out.println("<td class='tablelight'><a href='#' class='tablelight' onclick='BoardDeactiveView(this)' boardid='"+newBoard.get("boardid")+"' boardname='"+newBoard.get("boardname")+"' description='"+newBoard.get("description")+"' newdates='"+newBoard.get("newdates")+"'>"+bundle.getString("hlink.board.deactive")+"</td>");
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
			
			
		</table>
	
	
	
	
	 <a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%= bundle.getString("button.board.addnewitem")%></strong><span class="bt_green_r"></span></a>
		
		    				  <a href="#" onclick="DeactiveFun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%= bundle.getString("button.board.deactivelist")%> </strong><span class="bt_blue_r"></span></a>
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%= bundle.getString("button.board.trashlist")%> </strong><span class="bt_red_r"></span></a>
	
	
	
		</td>
	</tr>
	<tr><td>
			<input type='hidden' name='sessiontype' value="ExistSession">
			<input type="hidden" name="roleids" value="<%=roleids%>">
			
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