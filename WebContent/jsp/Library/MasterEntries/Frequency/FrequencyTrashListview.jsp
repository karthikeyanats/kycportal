<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Frequency.FrequencyEntry" />
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.frequency.trashlisttitle") %> </title>

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
document.MainForm.action= "FrequencyList.jsp";
document.MainForm.submit();
}
        
function editByClickFun(obj,status)
{
	if(confirm("Do you want to "+status+" the Frequency Details...?"))
	{
		document.MainForm.frequencyid.value			= obj.getAttribute("frequencyid");
		if(status=="Delete")
		{
		document.MainForm.flage.value="Delete";
		}else if(status=="Restore")
		{
		document.MainForm.flage.value="Restore";
		}
		document.MainForm.action= "FrequencyStatusUpdate.jsp";
		document.MainForm.submit();
	}

}



</script>
</head>

<body>


<div id="main_container">

	<div class="header">
	
<%@ include file="../../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2><%=bundle.getString("label.frequency.trashlistrootpath") %></h2>
     
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	String roleids		= "";
	String createdby 	= session.getValue("userid")+"";
	String instituteid 	= session.getValue("instituteid")+"";
	ArrayList RackList		= query_object.get_All_Frequency(instituteid,"T");
%>
<form name="MainForm" method="post">
<input type="hidden" name="frequencyid">
<input type="hidden" name="flage">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=5
	cellpadding=5>  
	<tr><td valign="top">

		<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.frequency.slno") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.frequency.frequencyname") %> </th>
  	        	<th scope="col" class="rounded" width="35%"><%=bundle.getString("label.frequency.description") %> </th>
  	        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.frequency.dateofcreation") %> </th>
  	        	<th scope="col" class="rounded" width="5%"><%=bundle.getString("label.frequency.delete") %> </th>
  	        	<th scope="col" class="rounded-q4" width="5%"><%=bundle.getString("label.frequency.restore") %> </th>
        	
            
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
				{	String []count=null;
					String newdescription="";
					HashMap FrequencyListHash=new HashMap();
				if(RackList!=null && RackList.size()>0)
				{	String as=request.getContextPath();					

					for(int i=0,j=1;i<RackList.size();i++,j++)
					{
						out.print("<tr  valign='top'>");
						FrequencyListHash=(HashMap)RackList.get(i); 
						String description=FrequencyListHash.get("description")+"";
						out.print("<td class='tablelight' width='5%'>"+j+"</td>");
						out.print("<td class='tablelight'>"+FrequencyListHash.get("frequencyname")+"</td>");
						if(description == null || description.equals("") || description.equals("-") || description.equalsIgnoreCase("null"))
						{  
						out.print("<td class='tablelight'>-</td>");
						}  
						else
						{
							   String des_temp=FrequencyListHash.get("description")+"";
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
								<%=(FrequencyListHash.get("description")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+FrequencyListHash.get("description")+"</td>");

								}
						}   
						out.print("<td class='tablelight'>"+FrequencyListHash.get("newdates")+"</td>");
						out.print("<td class='tablelight'><a href='#'    frequencyid='"+FrequencyListHash.get("frequencyid")+"'  onclick=editByClickFun(this,'Delete')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='delete' title='Delete' border='0' /></a></td>");
						out.print("<td class='tablelight'><a href='#'   frequencyid='"+FrequencyListHash.get("frequencyid")+"'   onclick=editByClickFun(this,'Restore')><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='restore' title='Restore' border='0' /></a></td>");
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
		
		   <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.frequency.back") %> </strong><span class="bt_blue_r"></span></a>
	
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
    
<%@ include file="../../../include/footer.jsp" %>

</div>

</body>
</html>