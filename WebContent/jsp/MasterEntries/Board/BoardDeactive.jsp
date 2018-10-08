<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Board.BoardBean" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.board.deactivelistlisttitle") %></title>

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
document.MainForm.action= "BoardList.jsp";
document.MainForm.submit();
}



function RestoreFun(obj)
{
if(confirm("Do you want to Activate the Medium...?"))
{
document.MainForm.boardid.value=obj.getAttribute("boardid");
document.MainForm.boardname.value=obj.getAttribute("boardname");
document.MainForm.description.value=obj.getAttribute("description");
document.MainForm.action= "BoardActive.jsp";
document.MainForm.submit();

}

}
</script>
</head>

<body>
<form name="MainForm" method="post" action="">
<input type="hidden" name="boardid" value="">
<input type="hidden" name="boardname" value="">
<input type="hidden" name="description" value="">
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
         <h2><%=bundle.getString("label.board.deactivelistrootpath") %></h2>
<%@ page import="java.util.*"%>

<%
ArrayList Board=new ArrayList();
HashMap newBoard=new HashMap();
String mediumid=request.getParameter("mediumidaaa");
String mediumname=request.getParameter("mediumname");
String instituteid=(String)session.getValue("instituteid");
Board=query_object.get_All_boardDeactivateList(mediumid,instituteid);
%>
<form name="MainForm" method="post" action="">
<input type="hidden" name="mediumname" value="<%=mediumname %>">

<input type="hidden" name="mediumidaaa" value="<%=mediumid %>">

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
    <br><br>
    
    
    
    
		<tr><td valign="top">

		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.board.slno") %></th>
        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.board.boardname") %> </th>
  	        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.board.description") %> </th>
  	        	<th scope="col" class="rounded-q4" width="10%" align="center" ><%=bundle.getString("label.board.active") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				<%  String []count=null;
				if(Board!=null && Board.size()>0)
				{
				for(int i=0,j=1;i<Board.size();i++,j++)
				{					newBoard=(HashMap)Board.get(i);
					String newdescription=(String)newBoard.get("description");
					out.print("<tr>");
					out.print("<td class='tablelight' width='5%'>"+j+"</td>");
					out.print("<td class='tablelight'>"+newBoard.get("boardname")+"</td>");
					if(newdescription == null || newdescription.equals("") || newdescription.equals("-") || newdescription.equalsIgnoreCase("null"))
					{
						out.print("<td class='tablelight'>-</td>");

					}
					else
					{

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

							}	
					}
					out.print("<td class='tablelight'><a href='#' onclick='RestoreFun(this)' boardid='"+newBoard.get("boardid")+"' boardname='"+newBoard.get("boardname")+"' description='"+newBoard.get("description")+"'>"+bundle.getString("hlink.board.active")+"</td>");

					out.print("</tr>");

				}
				}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr >");
					//out.print("<td colspan='4' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");
	
				}
				%>
			
			
		</table>
		  <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.board.back") %> </strong><span class="bt_blue_r"></span></a>

		</td>
	</tr>

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