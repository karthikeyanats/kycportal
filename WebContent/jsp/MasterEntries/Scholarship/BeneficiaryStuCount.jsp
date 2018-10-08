<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.scholarship.alllisttitle") %> | Powered by i-Grandee</title>
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
function editFun(obj)
{
if(confirm("Do you want to Update the Scholarship...?"))
	{
	document.scholarviewform.scholarid_hidden.value = obj.getAttribute("scholarshipid");
	document.scholarviewform.scholarname_hidden.value=obj.getAttribute("scholarshipname");
	document.scholarviewform.scholardesc_hidden.value=obj.getAttribute("scholardesc");
	document.scholarviewform.action="ScholarUpdate.jsp";
	document.scholarviewform.submit();
	}
}
function trashFun(obj)
{
				url = "../../StudentPromotion/getAction.jsp?Action=getScholarship&scholarshipid="+obj.getAttribute("scholarshipid");
	
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
												alert("Fees collected under this Scholarship. You cant Trash")
											}
											else
											{
													if(confirm("Do you want to Trash the Scholarship...?"))
													{
														document.scholarviewform.scholarid_hidden.value = obj.getAttribute("scholarshipid");
														//alert("scholarshipid:::>>>"+document.scholarviewform.scholarid_hidden.value);
														document.scholarviewform.scholarname_hidden.value=obj.getAttribute("scholarshipname");
														document.scholarviewform.scholardesc_hidden.value=obj.getAttribute("scholardesc");
														document.scholarviewform.action= "ScholarTrash.jsp";
														document.scholarviewform.submit();
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
				url = "../../StudentPromotion/getAction.jsp?Action=getScholarship&scholarshipid="+obj.getAttribute("scholarshipid");
	
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
												alert("Fees collected under this Scholarship. You cant Deactivate")
											}
											else
											{
												if(confirm("Do you want to Deactivate the Scholarship...?"))
												{
													document.scholarviewform.scholarid_hidden.value = obj.getAttribute("scholarshipid");
													//alert("scholarshipid:::>>>"+document.scholarviewform.scholarid_hidden.value);
													document.scholarviewform.scholarname_hidden.value=obj.getAttribute("scholarshipname");
													document.scholarviewform.scholardesc_hidden.value=obj.getAttribute("scholardesc");
													document.scholarviewform.action= "ScholarDeactivateList.jsp";
													document.scholarviewform.submit();
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


function backfun()
{
document.scholarviewform.action="./ScholarshipBeneficiaryStudents.jsp";
document.scholarviewform.submit();
}


</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
    </div>
<%
HashMap ScholarcreateListMap=null;
%>
<div class="main_content">

<%@ include file="../../include/header.jsp" %>
    <div class="center_content">
    <div class="left_content">
    </div>
	<div class="right_content">
    <h2>Master Entries / Beneficiary Scholarship List / Scholarship Name List</h2>
<form name="scholarviewform" action="" method="post">
<input type=hidden name=scholarid_hidden />
<input type=hidden name=scholarname_hidden />
<input type=hidden name=scholardesc_hidden />

<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.scholarship.slno") %></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.scholarship.scholarshipname") %></th>
            <th scope="col" class="rounded-q4" width="30%" colspan='2' align="center">No.of.Students</th>
           
       </tr>
       <tr>
       		<th scope="col" width="10%"></th>
            <th scope="col" class="rounded" width="30%"></th>
            <th scope="col" class="rounded" width="30%">Male</th>
            <th scope="col" width="30%">Female</th>
       </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
<jsp:useBean id="scholarshipQuery" class="com.iGrandee.MasterEntries.Scholarship.ScholarshipQuery"/>
     <%
    
		String standardid=request.getParameter("standardid");
    	 String instituteid=request.getParameter("instituteid");
		String sessionid			= request.getParameter("session");
		String boardid				= request.getParameter("board");
		
		/*  out.println("standardidstandardid>>"+standardid);
			out.println("session>"+sessionid);
			out.println("boardid>"+boardid);
			out.println("instituteid>"+instituteid); */
     
     	
     	ArrayList LoadScholarList = null;
     		try
     		{ 
    	  		instituteid = (String)session.getValue("instituteid");
    	  		LoadScholarList = scholarshipQuery.ScholarshipnameList(instituteid,sessionid,boardid,standardid);
    			//out.println("LoadScholarListLoadScholarListLoadScholarList===>>>"+LoadScholarList.size());
    		   	ArrayList archivalDetails = new ArrayList();
    	 		if(LoadScholarList!=null && LoadScholarList.size()>0)
					{
    	 			for (int i = 0, j = 1; i < LoadScholarList.size(); i++) {
							 ScholarcreateListMap=(HashMap)LoadScholarList.get(i);
							String scholarshipname  	= (String)ScholarcreateListMap.get("scholarshipname");
							String male      	        = (String)ScholarcreateListMap.get("male");
							String female		  	    = (String)ScholarcreateListMap.get("female");
							
							%>
							
							<tr>
								<td>
									<%=j++ %>
								</td>
								<td>
									<%=scholarshipname %>
								</td>
								<td>
									<%=male %>
								</td>
								<td>
									<%=female %>
								</td>
								
							</tr>
						
							
						<%	
					

    		 			}
					}else
					{
						out.println("<tr><td colspan='4' align='center'><font color='red'><b>Data not found</b></font></td><tr>");
					}
     		}catch(Exception e){
     			e.printStackTrace();
     			
     		}
	  %>
		
        </tbody>
</table>
	<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>

     	</div><!-- end of right content-->
	 </div>   <!--end of center content -->
   <div class="clear"></div>
 </div> <!--end of main content-->
<%@ include file="../../include/footer.jsp" %>
    
</div>
</body>
</html> 