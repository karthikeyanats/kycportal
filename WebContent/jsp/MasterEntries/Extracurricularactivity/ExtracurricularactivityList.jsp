<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.extracurricularactivity.alllisttitle") %> </title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language="JavaScript">


function goback()
{
	document.MainForm.action= "ExtracurricularactivityEntry.jsp";
	document.MainForm.submit();
}
function trashFun(obj)
{
	if(confirm("Do you want to Trash the Extra Curricular Activity...?"))
	{
		document.MainForm.extracurricularactivityid.value			= obj.getAttribute("extracurricularactivityid");
		
		document.MainForm.action				= "ExtracurricularactivityTrashPriview.jsp";
		document.MainForm.submit();
	}
}         
function editByClickFun(obj)
{
	if(confirm("Do you want to Update the Extra Curricular Activity...?"))
	{
		document.MainForm.extracurricularactivityid.value			= obj.getAttribute("extracurricularactivityid");
		
		document.MainForm.action= "ExtracurricularactivityUpdateByClick.jsp";
		document.MainForm.submit();
	}

}

function TrashListview()
{

document.MainForm.action= "ExtracurricularactivityTrashListview.jsp";
document.MainForm.submit();

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
         <h2><%=bundle.getString("label.extracurricularactivity.alllistrootpath") %></h2>
     
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	String roleids		= "";
	String createdby 	= session.getValue("userid")+"";
	String instituteid 	= session.getValue("instituteid")+"";   
	ArrayList ExtracurricularactivityList		= query_object.get_All_Extracurricularactivity("A",createdby,instituteid);
	
%>
<form name="MainForm" method="post">   
<input type="hidden" name="extracurricularactivityid">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>  
	
	
		<tr><td valign="top">

		<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.extracurricularactivity.slno") %></th>
        	<th scope="col" class="rounded" width="25%"><%=bundle.getString("label.extracurricularactivity.extracurricularname") %> </th>
  	        	<th scope="col" class="rounded" width="35%"><%=bundle.getString("label.extracurricularactivity.description") %> </th>
  	        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.extracurricularactivity.dateofcreation") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.extracurricularactivity.edit") %> </th>
  	        	<th scope="col" class="rounded-q4" width="5%"><%=bundle.getString("label.extracurricularactivity.trash") %> </th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
		
				<%
				try
				{	
					String []count=null;
					String newdescription="";
					HashMap ExtracurricularactivityListHash=new HashMap();
				if(ExtracurricularactivityList!=null && ExtracurricularactivityList.size()>0)
				{	String as=request.getContextPath();					

					for(int i=0,j=1;i<ExtracurricularactivityList.size();i++,j++)
					{
						out.print("<tr  valign='top'>");
						ExtracurricularactivityListHash=(HashMap)ExtracurricularactivityList.get(i); 
						String description=ExtracurricularactivityListHash.get("description")+"";
						out.print("<td class='tablelight' width='5%'>"+j+"</td>");
						out.print("<td class='tablelight'>"+ExtracurricularactivityListHash.get("extracurricularname")+"</td>");
						if(description == null || description.equals("") || description.equals("-") || description.equalsIgnoreCase("null"))
						{  
						out.print("<td class='tablelight'>-</td>");
						}  
						else
						{
							   String des_temp=ExtracurricularactivityListHash.get("description")+"";
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
								[<font color="red"> More..</font>]
							</a>  
							<div class="highslide-maincontent">
								<h3></h3>
								<%=(ExtracurricularactivityListHash.get("description")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+ExtracurricularactivityListHash.get("description")+"</td>");

								}
						}  
						out.print("<td class='tablelight'>"+ExtracurricularactivityListHash.get("newdates")+"</td>");
						out.print("<td class='tablelight'><a href='#'    extracurricularactivityid='"+ExtracurricularactivityListHash.get("extracurricularactivityid")+"'  onclick=editByClickFun(this)><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.extracurricularactivity.edit")+"' border=0 /></a></td>");
						out.print("<td class='tablelight'><a href='#'   extracurricularactivityid='"+ExtracurricularactivityListHash.get("extracurricularactivityid")+"'   onclick=trashFun(this)><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("hlink.extracurricularactivity.trash")+"' border=0 /></a></td>");
						out.print("</tr>");
								
					}

				}
				
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr>");
					//out.print("<td colspan='6' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");

				}
				}catch(Exception e){
					System.out.println(e);
				}

				%>
			
			
		</table>
		     <a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.extracurricularactivity.addnewitem") %> </strong><span class="bt_green_r"></span></a>
		
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.extracurricularactivity.trashlist") %></strong><span class="bt_red_r"></span></a>
	
		</td>
	</tr>
	<tr><td>
			
			
</td></tr>	

</TABLE>   
</form> 
 </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

</body>
</html>