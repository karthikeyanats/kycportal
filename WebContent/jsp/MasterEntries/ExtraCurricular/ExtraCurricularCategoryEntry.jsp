<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.curricularcategory.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function addExtraCurricular()
{
if(validflag)
{


	var a=document.extracurricularcategoryform.curricularcategory.length;
	var flag=false;

	for(var i=0;i<a;i++)
	{
		if(document.extracurricularcategoryform.curricularcategory[i].value != "")
		if(check_ForParticularElements(document.extracurricularcategoryform.curricularcategory[i],"text"))
		{
			flag=true;
		}
	}
	if(flag==true)
	{
	
	for(var i=0;i<a;i++)
	{
	if(document.extracurricularcategoryform.check[i].checked)
	{
		document.extracurricularcategoryform.curricularcategory[i].disabled=false;
	}
	else
	{
	document.extracurricularcategoryform.curricularcategory[i].disabled=true;
	}
	}
	}
	
if(flag)
{
}
else
{
		alert("Insert atleast one Extracurricular Category Name");
		document.extracurricularcategoryform.curricularcategory[0].focus();
		validflag=false;
		return false;
}

	if(flag && validflag)
	{
		document.extracurricularcategoryform.action="ExtraCurricularCategorySubmit.jsp";
		document.extracurricularcategoryform.submit();
	}
	else
	{
		alert("Insert atleast one Extracurricular Category Name");
		document.extracurricularcategoryform.curricularcategory[0].focus();
		validflag=false;
		return false;
		
	}       
	
	
	
	} 
	else
	{
	alert("Select any one option");
	validflag=false;
	} 
	} 
	
	
var validflag  =false;
function checkfun(obj)
{

	chkid = obj.getAttribute("chkid");
	
	
	if(obj.checked)
	{

	 	var checkoption="no";
	 	var checkoption1="no";
	 	
		if(document.extracurricularcategoryform.check[chkid].checked)
		{
			for(var k=0;k<document.extracurricularcategoryform.check.length;k++)
			{
					if(chkid!=k)
					{
					if(document.extracurricularcategoryform.check[k].checked)
						{
							if(document.extracurricularcategoryform.curricularcategory[chkid].value==document.extracurricularcategoryform.curricularcategory[k].value)
								{  
									checkoption="yes";
								}
						}
					}
			}
		}  
		
		if(checkoption=="yes")
			{
				alert("Same curricular category Not Allowed");
				document.extracurricularcategoryform.check[chkid].checked=false;
				document.extracurricularcategoryform.curricularcategory[chkid].focus();
				return false;
			}
	if(document.extracurricularcategoryform.curricularcategory[chkid].value == "")
	{
	alert("Extra Curricular should not be Empty");
	document.extracurricularcategoryform.curricularcategory[chkid].focus();
	document.extracurricularcategoryform.check[chkid].checked=false;
	return false;
	}
	
	/*if(document.extracurricularcategoryform.curricularcategory[chkid].value != "" )
	{
  	   	  url = "checkDuplicate.jsp?tabname=extracurricularcategory&fieldname1="+document.extracurricularcategoryform.curricularcategory[chkid].value;
 
 	   var req =initRequest();
 	   req.onreadystatechange = function()
 	   {
 		   if (req.readyState == 4)
 		   {   

 			   if (req.status == 200)
 			   {

  				  parseMessages1(req.responseXML,"LoadReply",chkid);

 			   }
 			   else if (req.status == 204)
 			   {

 			   }
 		   }
 	   };
 	   req.open("GET", url, true);
 	   req.send(null);
		}*/
			validflag  =true;
			document.extracurricularcategoryform.curricularcategory[chkid].disabled=true;
	}
	else
	{
		document.extracurricularcategoryform.curricularcategory[chkid].disabled=false;
			document.extracurricularcategoryform.check[chkid].checked=false;
		validflag=false;
	}
}

function parseMessages1(parseXML,check_var,chkid)
{
	   var rootobj=parseXML.getElementsByTagName("complaintdetails");
		var clength=rootobj[0].childNodes.length;
		var ask=rootobj[0].childNodes.item(0).childNodes.item(0).firstChild.nodeValue;
		
		if(ask=="true")
		{
		alert("Extra Curricular entry already Exist");
		document.extracurricularcategoryform.curricularcategory[chkid].value="";
		document.extracurricularcategoryform.check[chkid].checked=false;
		validflag=false;
		}
		else
		{
			document.extracurricularcategoryform.curricularcategory[chkid].disabled=true;
		}
		
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

    <h2><%=bundle.getString("label.curricularcategory.entryrootpath") %></h2>
<form name="extracurricularcategoryform" action="" method="post">
<table border=0 id="rounded-corner2" cellpadding=0 cellspacing=0 width="50%">
<tr><td width="20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>
<table id="rounded-corner" border=0 summary="selectd Information" align=center>
    <thead>  
    	<tr>  
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.curricularcategory.SL.No") %></th>
        	<th scope="col" class="rounded" width='40%'><%=bundle.getString("label.curricularcategory.CurricularCategoryName") %></th>
        	       <th scope="col" class="rounded"  width='10%'><%=bundle.getString("label.curricularcategory.Chk") %></th>
        	
        	<th scope="col" class="rounded-q4" width='40%'></th>
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=3 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>

 <%
 for(int i=1,x=1,j=0;i<4;i++,j++)
	{  
 %> <tr>
 	<td width="10%"><%=x++ %></td>
	 <td><input type="text" name="curricularcategory"  maxlength="100" class="tablelight"/></td>
	
	 	  <td colspan=2><input type="checkbox" name="check" chkid="<%=j%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 
	 </tr>
	 <%} %>
	 </tbody>
	 </table>
</td><td width="30%">&nbsp;</td></tr></table>	 
	      <a href="./ExtraCurricularCategoryView.jsp" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.curricularcategory.ViewExtraCurricularCategory") %></strong><span class="bt_blue_r"></span></a>
     <a href="#" class="bt_green" onclick="addExtraCurricular()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.curricularcategory.Submit") %></strong><span class="bt_green_r"></span></a>
     <input type=hidden name="feesheadoperation" value="insert"/>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>