<jsp:useBean id="community_query_object" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityQuery" />
<jsp:useBean id="communityBean" scope="page"
	class="com.iGrandee.MasterEntries.Community.CommunityBean" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html>
<head>
<title><%=bundle.getString("label.community.trashlisttitle") %> </title>

<LINK rel=stylesheet href="../../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>

<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>

<script language="JavaScript">

function resetfun()
{
document.CommunityTrashedform.deptname.value="";
document.CommunityTrashedform.descryption.value="";

}
function trashFun(obj)
{
	var Deptid=obj.getAttribute("Deptid");
	var departmentname=obj.getAttribute("departmentname");
	var description=obj.getAttribute("description");
	document.CommunityTrashedform.action= "DepartmentTrashPriview.jsp?Deptid="+Deptid+"&departmentname="+departmentname+"&description="+description;
	document.CommunityTrashedform.submit();
}
function TrashListview()
{
document.CommunityTrashedform.action= "DepartmantTrashListview.jsp";
document.CommunityTrashedform.submit();
}
function deleteFun(obj)
{
if(confirm("Do you want to Delete the Community...?"))
{
	document.CommunityTrashedform.communityid_hidden.value = obj.getAttribute("communityid");
	//alert("CommunityID>>>>>>"+document.CommunityTrashedform.communityid_hidden.value);
	document.CommunityTrashedform.communityname_hidden.value=obj.getAttribute("communityname");
	document.CommunityTrashedform.communitydescription_hidden.value=obj.getAttribute("communitydescription");
	document.CommunityTrashedform.action= "CommunityDelete.jsp";
	document.CommunityTrashedform.submit();

}
else
{}
}
function restoreFun(obj)
{
if(confirm("Do you want to Restore the Community...?"))
{
	document.CommunityTrashedform.communityid_hidden.value = obj.getAttribute("communityid");
	//alert("CommunityID>>>>>>"+document.CommunityTrashedform.communityid_hidden.value);
	document.CommunityTrashedform.communityname_hidden.value=obj.getAttribute("communityname");
	document.CommunityTrashedform.communitydescription_hidden.value=obj.getAttribute("communitydescription");
	document.CommunityTrashedform.action= "CommunityRestore.jsp";
	document.CommunityTrashedform.submit();

}
else
{}
}
</script>
</head>

<body>
<form name="CommunityTrashedform" method="post" action="">

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
         <h2><%=bundle.getString("label.community.trashlistrootpath") %></h2>
     
<%@ page import="java.io.*,java.util.*"%>

<form name="CommunityTrashedform" method="post" action="">

	<input type=hidden name=communityid_hidden>
	<input type=hidden name=communityname_hidden>
	<input type=hidden name=communitydescription_hidden>
	

<table id="rounded-corner" border=0 summary="Community List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.community.slno") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.community.communityname") %></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.community.description") %></th>
            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.community.dateofcreation") %></th>
            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.community.delete") %></th>
            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.community.restore") %></th>
            
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityQuery"%>
		<%
			com.iGrandee.MasterEntries.Community.CommunityQuery  communityEntry = new com.iGrandee.MasterEntries.Community.CommunityQuery();
     		String instituteid = null;
     		ArrayList CommunityTrashedList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  CommunityTrashedList=communityEntry.get_All_CommunitynameTrashList(instituteid);
    	  

    	ArrayList archivalDetails = new ArrayList();
    	 if(CommunityTrashedList!=null && CommunityTrashedList.size()>0)
			{
    		 for (int i = 0, j = 1; i < CommunityTrashedList.size(); i++) {

				HashMap CommunityTrashedListMap=(HashMap)CommunityTrashedList.get(i);

				String communityid       	= (String)CommunityTrashedListMap.get("communityid");
				String communityname 		  	= (String)CommunityTrashedListMap.get("communityname");
				String communitydescription  	= (String)CommunityTrashedListMap.get("communitydescription");
				String dateofcreation      	= (String)CommunityTrashedListMap.get("dateofcreation");
				String commstatus      		= (String)CommunityTrashedListMap.get("commstatus");

				%>
				<tr>
				    	 <td valign=top><%=j++ %></td>
				            <td valign=top><%=communityname %></td>
            <%
				if(communitydescription.equals(""))
				{
					//communitydescription = "-";
				out.print("<td class='tablelight'>-</td>");
				}
				else{
						String []count=null;
					  String des_temp=communitydescription+"";
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
						<%=(communitydescription+"").replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
					</div>
						</div>
						<% }
						else
						{
							out.print("<td class='tablelight' valign=top>"+communitydescription+"</td>");

						}
						}
				%>     				            
				            <td valign=top><%=dateofcreation %></td>
				            <td valign=top><a href="#" ahrefname="communityhref=<%=i%>" communityid="<%=communityid%>" communityname="<%=communityname %>" communitydescription="<%=communitydescription %>"  onclick="deleteFun(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_logout.png" alt="delete" title="" border="0" /></a></td>
				            <td valign=top><a href="#" ahrefname="communityhref=<%=i%>" communityid="<%=communityid%>" communityname="<%=communityname %>" communitydescription="<%=communitydescription %>"  onclick="restoreFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/16-undo1.png" alt="restore" title="" border="0" /></a></td>

				        </tr>
								<%
				    		 }
							}
				    	 	else{
				    	 		out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>Data Not Found</font></td></tr>");
				    	 	}
				     }catch(Exception e){}

     %>			
			
	   </tbody>
</table>
<a href="./CommunityCreation.jsp" class="bt_green"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.community.addnewitem") %></strong><span class="bt_green_r"></span></a>
     <a href="./CommunityView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.community.viewallcommunity") %> </strong><span class="bt_blue_r"></span></a>
     
	
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>