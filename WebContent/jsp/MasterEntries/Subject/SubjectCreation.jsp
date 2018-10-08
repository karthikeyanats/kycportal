<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.subject.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function backfun()
{
		document.subjectForm.action="./SubjectStandardList.jsp";
		document.subjectForm.submit();		
}
function goLessonCreation(obj)
{
    document.subjectForm.reqsubjectid.value = obj.getAttribute("subjid");
    document.subjectForm.reqsubjectname.value = obj.getAttribute("subjname");
	document.subjectForm.action="../Lesson/LessonCreation.jsp";
	document.subjectForm.submit();
}
var validflag  =false;
var validateflag = false;
function checkfun(obj)     
{
	chkid = obj.getAttribute("chkid"); 
	var checkoption		= "no";
	var checkoption1	= "no";
	
	//alert(document.subjectForm.subjecttype[chkid].value);
	
	if(obj.checked)
	{
		//alert(chkid);
		
		if(!check_ForParticularElements(document.subjectForm.subjectname[chkid],"text",document.subjectForm.subjectcode[chkid],"text",document.subjectForm.subjecttype[chkid],"select")){
			
			document.subjectForm.subjecttype[chkid].disabled=false;
			document.subjectForm.subjectcode[chkid].disabled=false;
			document.subjectForm.subjectname[chkid].disabled=false;		
			document.subjectForm.check[chkid].checked=false;
			validateflag=false;

		}
	else{
		validateflag=true;
			//if(!numeric_Validation(document.subjectForm.credithours[chkid],"Credit Hour"))
			//{ 
			//	document.subjectForm.check[chkid].checked=false;
				
			//}	
			//else
			//{
				if(document.subjectForm.check[chkid].checked)  
				{
					
					for(var k=0;k<document.subjectForm.check.length;k++)
					{
						if(chkid!=k)
							{
								if(document.subjectForm.check[k].checked)
									{
										if(document.subjectForm.subjectname[chkid].value==document.subjectForm.subjectname[k].value)
										{ 
										 	checkoption="yes";   
										}
										if(document.subjectForm.subjectcode[chkid].value==document.subjectForm.subjectcode[k].value)
										{ 
											checkoption1="yes";   
										}
									}
							}
						}
				}  
				
			//}	
	
		}
		if(checkoption=="yes")	
		{
			alert("Same Subject Name Not Allowed");
			document.subjectForm.check[chkid].checked=false;
			document.subjectForm.subjectname[chkid].focus();
			return false;
		}
		if(checkoption1=="yes")
		{
			alert("Same Subject Code Not Allowed");
			document.subjectForm.check[chkid].checked=false;
			document.subjectForm.subjectcode[chkid].focus();
			return false;
		}
		
		if(validateflag && checkoption=="no" && checkoption1=="no")
		{
			
			checkDuplicate(document.subjectForm.subjectname[chkid].value,"duplicatesubjectname",chkid);
			validflag  =true;
		}
		}
		else
		{
			document.subjectForm.subjectname[chkid].disabled=false;	
			document.subjectForm.subjectcode[chkid].disabled =false;
			//document.subjectForm.credithours[chkid].disabled =false;		
			document.subjectForm.subjecttype[chkid].disabled =false;		
		}

}
function checkDuplicate(givenstring,flag,chkid)
{      
	   var url = "";
	   var date = new Date();

	   if(flag=="duplicatesubjectname")
	   {
	   	   url = "SubjectInfo.jsp?action=duplicatesubjectnameentry&subjectname="+givenstring+"&reqstandardid="+document.subjectForm.reqstandardid.value+"&date="+date;
	   } 
	  
	   if(flag=="duplicatesubjectcode")
	   {
 		   url = "SubjectInfo.jsp?action=duplicatesubjectcodeentry&subjectcode="+givenstring+"&reqstandardid="+document.subjectForm.reqstandardid.value+"&date="+date;
	   }
	   
	   var req =initRequest();
	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
			   if (req.status == 200)
			   {
				   if(flag=="duplicatesubjectname",chkid)
				  {
				  	parseMessages(req.responseXML,flag,chkid)  
				  }
			  	  else if(flag=="duplicatesubjectcode",chkid)
				  {
				   parseMessages(req.responseXML,flag,chkid)  
				  }
			  }
			} 
		};
	   req.open("GET", url, true);
	   req.send(null);
	}   
	   
	function parseMessages(xmlObj,flag,chkid)
	{  
		if(flag=="duplicatesubjectname")
		{			           
		
				var rootObj=xmlObj.getElementsByTagName("duplicate");
				var cNode_1=rootObj[0].childNodes.length;
		 		for(var i=0;i<parseInt(cNode_1);i++)
				{
					var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
				}
				if(temp=="true")
				{
					alert("Subject Name already exists"); 
					validflag=false;
					document.subjectForm.subjectname[chkid].focus();
					document.subjectForm.check[chkid].checked=false;
					return false;
				}
				if(document.subjectForm.subjectcode[chkid].value == "")
				{
					alert("Subject Code should not be empty");
					document.subjectForm.subjectcode[chkid].focus();
					document.subjectForm.check[chkid].checked=false;
					return false;
				}
				else
				{   validflag=true;
					checkDuplicate(document.subjectForm.subjectcode[chkid].value,"duplicatesubjectcode",chkid);
				}
			} 
		if(flag=="duplicatesubjectcode")
		{ 
			var rootObj=xmlObj.getElementsByTagName("duplicate");
			var cNode_1=rootObj[0].childNodes.length;
	 		for(var i=0;i<parseInt(cNode_1);i++)
			{
				var temp=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
			}
			  if(temp=="true")
				{
					alert("Subject Code already exists");
					validflag=false;
					document.subjectForm.subjectcode[chkid].focus();
					document.subjectForm.check[chkid].checked=false;
					return false;
				}
				else
				{
					validflag=true;
					document.subjectForm.subjectname[chkid].disabled=true;	
					document.subjectForm.subjectcode[chkid].disabled =true;
					//document.subjectForm.credithours[chkid].disabled =true;		
					document.subjectForm.subjecttype[chkid].disabled =true;
				} 
				}   
	}
	
function addSubjects()
{      

	if(validflag)
	{
		for(var x1=0;x1<document.subjectForm.check.length;x1++)
		{
			if(document.subjectForm.check[x1].checked)
			{
				document.subjectForm.subjectname[x1].disabled =false;
				document.subjectForm.subjectcode[x1].disabled =false;
				//document.subjectForm.credithours[x1].disabled =false;
				document.subjectForm.subjecttype[x1].disabled =false;
			}
			else
			{
				document.subjectForm.subjectname[x1].disabled =true;
				document.subjectForm.subjectcode[x1].disabled =true;
				//document.subjectForm.credithours[x1].disabled =true;
				document.subjectForm.subjecttype[x1].disabled =true;
				
			}
			
		}

		document.subjectForm.action="./SubjectSubmit.jsp";
		document.subjectForm.submit();
} 
else
{
alert("Select Any one Subject");
}

}     
function editsubject(obj)
{
if(confirm("Do you want to Update the Subject...?"))
	{
		document.subjectForm.reqsubjectid.value = obj.getAttribute("subjid");
		document.subjectForm.action="./SubjectEdit.jsp";
		document.subjectForm.submit();
	}
}

function trashsubject(obj)
{
	if(confirm("Do you want to Trash the Subject...?"))
	{
			var subjectid=obj.getAttribute("subjid"); 
			var subjectname=obj.getAttribute("subjname");
			document.subjectForm.EditStatus.value="T";
			document.subjectForm.subjectid.value=subjectid;
			document.subjectForm.reqsubjectname.value=subjectname;
			document.subjectForm.action="./SubjectLessonDetails.jsp";
			document.subjectForm.submit(); 		
	}
}   
function subjecttypechange(obj)   
{
var subjecttypeid=obj.value;
document.subjectForm.subjecttypeid.value = subjecttypeid;
//alert(document.subjectForm.subjecttypeid.value);
}  
function TrashListfun()
{
document.subjectForm.action="./SubjectTrashList.jsp";
document.subjectForm.submit();
}
function markSettingfun(obj)
{
document.subjectForm.reqsubjectid.value = obj;
document.subjectForm.action="./Marksettings.jsp";
document.subjectForm.submit(); 

}
function setmark(val)
{
//alert(val);
	if(val=="1")
	{	
		//alert(document.subjectForm.subjectname1.value);
		document.getElementById("mark1span").innerHTML="Theory - Min-25,Max-30 <br> Practical Min-20,Max-30";		
		//alert(document.getElementById("mark1span").innerHTML);
	}	
	else if(val=="2")
	{	
			alert(document.subjectForm.subjectname2.value);
	}
	else if(val=="3")
	{	
			alert(document.subjectForm.subjectname3.value);
	}
	else if(val=="4")
	{	
			alert(document.subjectForm.subjectnam4.value);
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

    <h2><%=bundle.getString("label.subject.entryrootpath") %></h2>
<form name="subjectForm" action="" method="post">
     <input type="hidden" name="EditStatus" value="">

  <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Subject.SubjectQuery"%>

     <%
     
     com.iGrandee.MasterEntries.Subject.SubjectQuery  subjectQuery = new com.iGrandee.MasterEntries.Subject.SubjectQuery();
     String instituteid = null;
     ArrayList subjecttypeList = null;
     String reqboardid = null;
     String boardname = null;
     String standardname = null;
     String standardid = null;
     String reqgroupstatus = null;
     ArrayList subjectList = null;

     
     try
     {
    	 reqboardid 		= request.getParameter("reqboardid");
    	 boardname	 		= request.getParameter("reqboardname");
    	 standardname 		= request.getParameter("reqstandardname");
    	 standardid 		= request.getParameter("reqstandardid");
    	 reqgroupstatus 	= request.getParameter("reqgroupstatus");
    	 instituteid 		= (String)session.getValue("instituteid");
	   	 subjecttypeList 	= subjectQuery.listSubjectType(instituteid);
    	 subjectList 		= subjectQuery.listSubject(standardid);
    	  
    	 // BoardList = subjectQuery.listBoard(instituteid);
    }catch(Exception e){}
    
    %>
    <table id="rounded-corner" border=0 summary="Selected List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.subject.SelectedInfo") %></th>
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
   
    <tr>
	  
	    <td colspan=2>
	    	<table border=0 width="100%">
	    		<tr>
	    			<td><a class=tablebold><%=bundle.getString("label.subject.BoardName") %></a></td><td class=tablebold>:</td><td><%=boardname %></td>
	    			<td><a class=tablebold><%=bundle.getString("label.subject.StandardName") %></a></td><td class=tablebold>:</td><td><%=standardname %></td>
	    		</tr>
	    	</table>
	    </td>
	 
  </tr>
    </tbody>
    </table>
    
    <br><br>
    <table border="0" width="100%">
    	<tr><td align=right><a href="#" onclick="markSettingfun()" class=tablebold><%=bundle.getString("label.subject.MarkSettings") %></a></td></tr>
    </table>
    
<table id="rounded-corner" border="0" summary="selectd Information" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.subject.SL.No") %></th>
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.subject.SubjectName") %></th>
        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.subject.SubjectCode") %></th>
        	<!-- <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.subject.CreditHours") %></th> -->
        	<th scope="col" class="rounded" width="20%"><%=bundle.getString("label.subject.SubjectType") %></th>  
        	<th scope="col" class="rounded" width="10%"><%=bundle.getString("label.subject.Chk") %></th>
        	  <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.subject.Edit") %></th>
        	
        	<th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.subject.Trash") %></th>
       	</tr>
    </thead>
    <tfoot>
    	<tr> 
        	<td colspan=6 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody> 
   <%
   int sno=1;
   if(subjectList!=null && subjectList.size()>0)
	{
	   ////subjectid, subjectname, , subjectypename
	 	for (int i1 = 0; i1 < subjectList.size(); i1++,sno++) {
	
		HashMap subjectListMap=(HashMap)subjectList.get(i1);
		String subjectid     = (String)subjectListMap.get("subjectid");
		String subjectname      = (String)subjectListMap.get("subjectname");
		String subjectcode      = (String)subjectListMap.get("subjectcode");
		String credithours      = (String)subjectListMap.get("credithours");
		String subjecttypeid      = (String)subjectListMap.get("subjecttypeid");
		String subjectypename      = (String)subjectListMap.get("subjectypename");
	%>
	<tr>
	<td><%=sno %></td>
	<td><a href="#"  subjname="<%=subjectname %>" subjid="<%=subjectid %>" onclick="goLessonCreation(this)"><%=subjectname %></a></td>
	<td><%=subjectcode %></td>
	<!-- <td><%=credithours %></td> -->
	<td><%=subjectypename %></td>
	<td>-</td>
	<td><a href="#"  subjname="<%=subjectname %>"  subjid="<%=subjectid %>" onclick="editsubject(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="Edit" border="0" /></a></td>
		<td><a href="#"  subjname="<%=subjectname %>"  subjid="<%=subjectid %>" onclick="trashsubject(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="Trash" border="0" /></a></td>
	
	</tr>
	<% 	
	
	 }
	}
   
   for(int x=0;x<5;x++,sno++)
   {%>
	 <tr>
	 <td><%=sno %></td>
	  <td><input type="text" name="subjectname" size="30" maxlength="50" class="tablelight" ></td>
	 <td><input type="text" name="subjectcode" size="5"  maxlength="10" class="tablelight"/></td>
	 <!-- <td><input type="text" name="credithours" size="5"  maxlength="3" class="tablelight" onkeypress='checkNumber(event)'/></td> -->
	 <td><select name="subjecttype" class="tablelight" onchange="subjecttypechange(this)"><option value="0">-Select Subject Type-</option>
	 <%   
   			
	  
        	if(subjecttypeList!=null && subjecttypeList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < subjecttypeList.size(); i++) {
			
				HashMap subjecttypeListMap=(HashMap)subjecttypeList.get(i);
				String subjecttypeid     = (String)subjecttypeListMap.get("subjecttypeid");
				String subjectypename      = (String)subjecttypeListMap.get("subjectypename");
				out.println("<option value='"+subjecttypeid+"' class=tablelight>"+subjectypename+"</option>");
	    	 }
			}
   		 %></select></td>
	 <td><input type="checkbox" name="check" chkid="<%=x%>" size="5" class="tablelight" onclick="checkfun(this)"/></td>
	 	<td>-</td>
	 	<td>-</td>
	 </tr>
   <%}   
              
   %>   
    <!--  <tr>
    <td><input type="text" name="subjectname1"  class=tablelight></td>
    <td><input type="text" name="subjectcode1"  class=tablelight></td>
    <td><input type="text" name="credithours1"  class=tablelight></td>
    <td><select name="subjecttype"  class="tablelight"><option>-Select Subject Type-</option></select></td>
      <td><a href="#" onclick="Popup.showModal('modal',null,null,{'screenColor':'#99ff99','screenOpacity':.6});setmark('1');return false;">Mark</a><span id="mark1span"></span></td>
    <td><input type="checkbox" name="subjectselect1"  class=tablelight></td>
    </tr>
    
     <tr>
    <td><input type="text" name="subjectname2"  class=tablelight></td>
    <td><input type="text" name="subjectcode2"  class=tablelight></td>
    <td><input type="text" name="credithours2"  class=tablelight></td>
    <td><select name="subjecttype"  class="tablelight"><option>-Select Subject Type-</option></select></td>
    <td><a href="#" onclick="Popup.showModal('modal',null,null,{'screenColor':'#99ff99','screenOpacity':.6});setmark('2');return false;">Mark</a></td>
    <td><input type="checkbox" name="subjectselect2"  class=tablelight></td>
    </tr>
    
     <tr>
    <td><input type="text" name="subjectname3"  class=tablelight></td>
    <td><input type="text" name="subjectcode3"  class=tablelight></td>
    <td><input type="text" name="credithours3"  class=tablelight></td>
    <td><select name="subjecttype"  class="tablelight"><option>-Select Subject Type-</option></select></td>
     <td><a href="#" onclick="Popup.showModal('modal',null,null,{'screenColor':'#99ff99','screenOpacity':.6});setmark(this);return false;">Mark</a></td>
    <td><input type="checkbox" name="subjectselect3"  class=tablelight></td>
    </tr>
    
    
     <tr>
    <td><input type="text" name="subjectname4"  class=tablelight></td>
    <td><input type="text" name="subjectcode4"  class=tablelight></td>
    <td><input type="text" name="credithours4"  class=tablelight></td>
    <td><select name="subjecttype"  class="tablelight"><option>-Select Subject Type-</option></select></td>
     <td><a href="#" onclick="Popup.showModal('modal',null,null,{'screenColor':'#99ff99','screenOpacity':.6});setmark(this);return false;">Mark</a></td>
    <td><input type="checkbox" name="subjectselect4"  class=tablelight></td>
    </tr>-->
    </tbody>
</table>
<div id="modal" style="border:1px solid black; background-color:#9999ff;  display:none;">

	<table border="1" cellpadding="4" cellpspacing=0 width="100%">
	<tr class=tablebold><td><%=bundle.getString("label.subject.Mode") %></td><td><%=bundle.getString("label.subject.MaxMarks") %></td><td><%=bundle.getString("label.subject.MinMark") %></td></tr>
	<tr class=tablebold><td><%=bundle.getString("label.subject.Theory") %></td><td><input type=text name="throymax" size="3" class="tablelight"></td><td><input type=text name="throymax" size="3" class=tablelight></td></tr>
	<tr class=tablebold><td><%=bundle.getString("label.subject.Practical") %></td><td><input type=text name="throymax" size="3"  class=tablelight></td><td><input type=text name="throymax" size="3" class=tablelight></td></tr>
	<tr class=tablebold><td><%=bundle.getString("label.subject.Project") %></td><td><input type=text name="throymax" size="3" class=tablelight></td><td><input type=text name="throymax" size="3" class=tablelight></td></tr>
	</table>
<br><br>
	<center><input type="button" value="OK" class=tablelight onclick="Popup.hide('modal');"/></center>
</div>
     <a href="#back" name="back" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subject.BackToStandardList") %> </strong><span class="bt_blue_r"></span></a>
          <a href="#trashli" name="trashli" class="bt_blue" onclick="TrashListfun()" ><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.subject.TrashList") %> </strong><span class="bt_blue_r"></span></a>
     
          <a href="#" class="bt_green" onclick="addSubjects()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.subject.Submit") %></strong><span class="bt_green_r"></span></a>
          
     
     <input type="hidden" name="reqstandardid" value="<%=standardid %>">
     <input type="hidden" name="reqstandardname" value="<%=standardname %>">
     <input type="hidden" name="reqboardid" value="<%=reqboardid %>">
     <input type="hidden" name="reqboardname" value="<%=boardname %>">
     <input type="hidden" name="reqgroupstatus" value="<%=reqgroupstatus %>">
     <input type="hidden" name="reqsubjectname" >
     <input type="hidden" name="reqsubjectid" >
     <input type="hidden" name="subjecttypeid" > 
     <input type="hidden" name="subjectid" value="">
    
     </form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->
   



    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>
