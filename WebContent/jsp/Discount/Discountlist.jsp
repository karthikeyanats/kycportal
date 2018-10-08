<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Discount.DiscountAction" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Discount List</title>

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language="JavaScript">

function DeactiveView()
{
document.routeform.action= "transportroutedeactiveview.jsp";
document.routeform.submit();

}


function goback()
{
document.routeform.action= "Discount.jsp";
document.routeform.submit();
}
function trashFun(obj)
{
	
	
					url = "../StudentPromotion/getAction.jsp?Action=checkdiscount&discountcategoryid="+obj.getAttribute("discountcategoryid");
		
					var req=null;
				
					try
					  {
					  // Firefox, Opera 8.0+, Safari
					  req=new XMLHttpRequest();
					  }
					catch (e)
					  {
					  // Internet Explorer
					  try
					    {
					    req=new ActiveXObject("Msxml2.XMLHTTP");
					    }
					  catch (e)
					    {
					    req=new ActiveXObject("Microsoft.XMLHTTP");
					    }
					  }
					  //alert(req)
					
							req.onreadystatechange = function()
							{
							//	alert(req.readyState)
								if (req.readyState == 4)
								   {
									//   alert(req.status)
								  		 if(req.status == 200)
										 {
						              			var parseXML=req.responseXML;
					
												var rootObj=parseXML.getElementsByTagName("checkNumber");
												var cNode_1=rootObj[0].childNodes.length;
												var username=null;
												var finalValue=rootObj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
												//var finalValue=rootObj[0].childNodes[0].selectSingleNode("finalValue").text;

												if(finalValue=="1")
												{
													alert("This Discount Category had been allocated. You cant Trash")
												}
												else
												{
													if(confirm("Do you want To Trash the Discount Category...?"))
													{
												
													
													document.routeform.discountcategoryid.value=obj.getAttribute("discountcategoryid");
													document.routeform.discountcategoryname.value=obj.getAttribute("discountcategoryname");
													document.routeform.discountcategorydescription.value=obj.getAttribute("discountcategorydescription");
													document.routeform.action= "DiscountTrashPriview.jsp";
													document.routeform.submit();
													}
												}
				
										  }
									   	 else if (req.status == 204)
									     {
										 }
								   	}
						   };
						req.open("GET",url,true);
						req.send(null);
	
}

function editByClickFun(obj) 
{      
if(confirm("Do you want to Update the Discount Category...?"))
{
	document.routeform.discountcategoryid.value=obj.getAttribute("discountcategoryid");
	document.routeform.discountcategoryname.value=obj.getAttribute("discountcategoryname");
	document.routeform.discountcategorydescription.value=obj.getAttribute("discountcategorydescription");            
	document.routeform.action= "Discountcatedit.jsp";
	document.routeform.submit();
}

}
function DeactiveFun(obj)
{
if(confirm("Do you want to Deactivate the Discount Category...?"))
{
document.routeform.discountcategoryid.value=obj.getAttribute("discountcategoryid");
document.routeform.discountcategoryname.value=obj.getAttribute("discountcategoryname");
document.routeform.discountcategorydescription.value=obj.getAttribute("discountcategorydescription");
document.routeform.action= "RoleDeactivatePreview.jsp";
document.routeform.submit();
}
else
{}
}
function TrashListview()
{

document.routeform.action= "DiscountTrashListview.jsp";
document.routeform.submit();

}



</script>
</head>

<body>
<form name="routeform" method="post" action="">

<div id="main_container">

	<div class="header">
	
<%@ include file="../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
         <h2>Discount  / Discount Category / Discount Category List</h2>
<%@ page import="java.util.*"%>

<%
try
{
ArrayList Discount=new ArrayList();
HashMap newRoute=new HashMap();
String roleids="";
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
Discount=query_object.discountlist(instituteid);
%>
<form name="routeform" method="post" action="">
<input type="hidden" name="discountcategoryid" value="">
<input type="hidden" name="discountcategoryname" value="">
<input type="hidden" name="discountcategorydescription" value="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10">Sl.No</th>
        	<th scope="col" class="rounded" width="25%">Discount Category Name  </th>
  	        	<th scope="col" class="rounded" width="30%">Description</th>
  	        	<th scope="col" class="rounded" width="20%">Date of creation</th>
				<th scope="col" class="rounded" width="5%">Edit </th>
  	        	<th scope="col" class="rounded-q4" width="10%">Trash </th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
				<% 
				String []count=null;
				if(Discount!=null && Discount.size()>0)
				{	String as=request.getContextPath();						

					for(int i=0;i<Discount.size();i++)
					{
						out.print("<tr valign='top'>");
						newRoute=(HashMap)Discount.get(i);
						out.print("<td class='tablelight' valign='top'>"+(i+1)+"</td>");
						out.print("<td class='tablelight' valign='top'>"+newRoute.get("discountcategoryname")+"</td>");
						String a1=newRoute.get("discountcategorydescription")+"";
						if(a1 == null || a1.equals("") || a1.equals("null"))	
						{
						out.print("<td class='tablelight' valign='top'>-</td>");
						}
						else
						{
							String des_temp=newRoute.get("discountcategorydescription")+"";
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
								<%=(newRoute.get("discountcategorydescription")+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+newRoute.get("discountcategorydescription")+"</td>");

								}
						}
						out.print("<td class='tablelight' valign='top'>"+newRoute.get("newdates")+"</td>");


						out.print("<td class='tablelight' valign='top'><a href='#'  id='check' rowpos='"+i+"' discountcategoryid='"+newRoute.get("discountcategoryid")+"'   incvalue='"+i+"' tablename='maintab' class='tablelight' onclick='editByClickFun(this)'><img src='"+as+"/jsp/kycpanel/images/user_edit.png' alt='' title='"+bundle.getString("hlink.role.edit")+"' border=0 /></a></td>");
						out.print("<td class='tablelight' valign='top'><a href='#' class='tablelight' onclick='trashFun(this)' discountcategoryid='"+newRoute.get("discountcategoryid")+"' discountcategoryname='"+newRoute.get("discountcategoryname")+"' discountcategorydescription='"+newRoute.get("discountcategorydescription")+"'><img src='"+as+"/jsp/kycpanel/images/trash.png' alt='' title='"+bundle.getString("label.role.trash")+"' border=0 /></a></td>");
						out.print("</tr>");
						
			
					}

				}
				
				else
				{ 
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr>");
					//out.print("<td colspan='7' align='center'class='tablelight'>Data Not Found</td>");
					//out.print("</tr>");

				} 
				
}catch(Exception e){e.printStackTrace();}
				%>
			
			
		</table>
				
	
	
	
	
		  <a href="#" class="bt_green" onclick="goback()"><span class="bt_green_lft"></span><strong>Add New Discount</strong><span class="bt_green_r"></span></a>
		  <a href="#" onclick="TrashListview()" class="bt_red"><span class="bt_red_lft"></span><strong>Trash List </strong><span class="bt_red_r"></span></a>
		  
		  
		  
		  	
	<tr><td>
			<input type='hidden' name='sessiontype' value="ExistSession">
			
</td></tr>	

</TABLE>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
     
<%@ include file="../include/footer.jsp" %>

</div>
 
    </form>
	
</body>
</html>