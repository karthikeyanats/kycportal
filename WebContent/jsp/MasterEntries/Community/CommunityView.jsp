<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.community.alllisttitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>

<script type="text/javascript">
function editCommunity(obj)
{
	if(confirm("Do you want to Update the Community ..?"))
		{
			document.commviewform.communityid_hidden.value = obj.getAttribute("communityid");
			document.commviewform.communityname_hidden.value=obj.getAttribute("communityname");
			document.commviewform.communitydescription_hidden.value=obj.getAttribute("communitydesc");
			document.commviewform.action="CommunityUpdate.jsp";
			document.commviewform.submit();
		}
}
function trashFun(obj)
{
				url = "../../StudentPromotion/getAction.jsp?Action=getCommunity&communityid="+obj.getAttribute("communityid");
	
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
												alert("Students registered under this Community. You cant Trash")
											}
											else
											{
													if(confirm("Do you want to trash the Community ..?"))
													{
														document.commviewform.communityid_hidden.value = obj.getAttribute("communityid");
														//alert("communityid:::>>>"+document.commviewform.communityid_hidden.value);
														document.commviewform.communityname_hidden.value=obj.getAttribute("communityname");
														document.commviewform.communitydescription_hidden.value=obj.getAttribute("communitydesc");
														document.commviewform.action= "CommunityTrash.jsp";
														document.commviewform.submit();
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
function deactiveFun(obj)
{
				url = "../../StudentPromotion/getAction.jsp?Action=getCommunity&communityid="+obj.getAttribute("communityid");
	
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
												alert("Students registered under this Community. You cant Deactivate")
											}
											else
											{
												if(confirm("Do you want to Deactivate the Community ..?"))
												{
													document.commviewform.communityid_hidden.value = obj.getAttribute("communityid");
													//alert("communityid:::>>>"+document.commviewform.communityid_hidden.value);
													document.commviewform.communityname_hidden.value=obj.getAttribute("communityname");
													document.commviewform.communitydescription_hidden.value=obj.getAttribute("communitydesc");
													document.commviewform.action= "CommunityDeactivateList.jsp";
													document.commviewform.submit();
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

    <h2><%=bundle.getString("label.community.alllistrootpath") %></h2>

<form name="commviewform" action="" method="post">
<input type=hidden name=communityid_hidden>
<input type=hidden name=communityname_hidden>
<input type=hidden name=communitydescription_hidden>

<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
   <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.community.slno") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.community.communityname") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.community.description") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.community.dateofcreation") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.community.edit") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.community.deactive") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.community.trash") %></th>
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityQuery"%>

     <%
     com.iGrandee.MasterEntries.Community.CommunityQuery  communityQuery = new com.iGrandee.MasterEntries.Community.CommunityQuery();
     String instituteid = null;
     ArrayList CommunityList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	 CommunityList = communityQuery.loadCommunityList(instituteid);
    	
    	//scholarshipcategoryid,categoryname
    	ArrayList archivalDetails = new ArrayList();
    	 if(CommunityList!=null && CommunityList.size()>0)
			{
    		 for (int i = 0, j = 1; i < CommunityList.size(); i++) {
			
				HashMap CommunityListMap=(HashMap)CommunityList.get(i);
				String communityid      = (String)CommunityListMap.get("communityid");
				String communityname      = (String)CommunityListMap.get("communityname");
				String communitydesc      = (String)CommunityListMap.get("communitydescription");
				String dateofcreation      = (String)CommunityListMap.get("dateofcreation");
				
				%>
				
				<tr>
        	 <td valign=top><%=j++ %></td>
            <td valign=top><%=communityname %></td>
            <%
				if(communitydesc.equals(""))
				{
					//communitydesc = "-";
				out.print("<td class='tablelight'>-</td>");
				}
				else{
						String []count=null;
					  String des_temp=communitydesc+"";
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
						<%=(communitydesc+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
					</div>
						</div>
						<% }
						else
						{
							out.print("<td class='tablelight' valign=top>"+communitydesc+"</td>");

						}
						}
				%>            
            <td valign=top><%=dateofcreation %> </td>
            <td valign=top><a href="#" ahrefname="communityhref=<%=i%>" communityid="<%=communityid%>" communityname="<%=communityname %>" communitydesc="<%=communitydesc %>" onclick="editCommunity(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="" border="0" /></a></td>
            <td valign=top><a href="#" ahrefname="communityhref=<%=i%>" communityid="<%=communityid%>" communityname="<%=communityname %>" communitydesc="<%=communitydesc %>" onclick="deactiveFun(this)" class="ask"><%=bundle.getString("hlink.community.deactive") %></a></td>
            <td valign=top><a href="#" ahrefname="communityhref=<%=i%>" communityid="<%=communityid%>" communityname="<%=communityname %>" communitydesc="<%=communitydesc %>" onclick="trashFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="" border="0" /></a></td>
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
    	 	}
     }catch(Exception e){}
          
     %>
    	
    </tbody>
</table>



	<a href="./CommunityCreation.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.community.addnewitem") %></strong><span class="bt_green_r"></span></a>
     <a href="./CommunityDeactivatedViewList.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.community.deactivelist") %></strong><span class="bt_blue_r"></span></a>
     <a href="./CommunityTrashedView.jsp" class="bt_red"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.community.trashlist") %></strong><span class="bt_red_r"></span></a>

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>