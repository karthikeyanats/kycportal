<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.feesstructureloadstandard.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

function loadStandard()   
{ 
	if(check_ForParticularElements(document.scholarsip_form.academicyear,"select",document.scholarsip_form.standard_board,"select",document.scholarsip_form.scholarship,"select")){	 
	document.scholarsip_form.reqboardid.value = document.scholarsip_form.standard_board.options[document.scholarsip_form.standard_board.options.selectedIndex].value;
	document.scholarsip_form.reqboardname.value = document.scholarsip_form.standard_board.options[document.scholarsip_form.standard_board.options.selectedIndex].text;
	//alert("scholarship>>>>"+document.scholarsip_form.standard_board.options[document.scholarsip_form.standard_board.options.selectedIndex].value);
 	document.scholarsip_form.scholarshipid.value = document.scholarsip_form.scholarship.options[document.scholarsip_form.scholarship.options.selectedIndex].value;
	document.scholarsip_form.sessionid.value = document.scholarsip_form.academicyear.options[document.scholarsip_form.academicyear.options.selectedIndex].value;
	document.scholarsip_form.action="scholarshipeditallotment.jsp";
	document.scholarsip_form.submit();
	}
} 

function scholarshipallotment(){
	
	var a=0;
	for(var k=0;k<document.scholarsip_form.loadstandardamount.length;k++){
		if(document.scholarsip_form.loadstandardamount[k].value==""){
			
			
		}
		else{
			a=1;
			console.log("flag>>> else"+a);
		}
		
	} 
	console.log("flag>>>  "+a);
	if(a!=0){
		if(confirm("Are you sure want to allot?")){
			
		document.scholarsip_form.action="scholarshipeditallotment.jsp"; 
		document.scholarsip_form.submit();
		}
	}
	else{
		
		alert("Please enter amount for the standard");
	}
	
}
</script>
</head>
<body>
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

    <h2>Scholarship Allotment</h2>

<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<% 	

java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
com.iGrandee.MasterEntries.Standard.StandardQuery  standardQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();

com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
ArrayList StandardList = null;

ArrayList AcademicSec=new ArrayList();
HashMap newAcademicSec=new HashMap();
ArrayList BoardList = null;
ArrayList loadscholarshipList  =null;
String instituteid = null;     String reqboardid = null;
instituteid = (String)session.getValue("instituteid");
loadscholarshipList =  feesscheduleQuery.loadscholarship(instituteid);
AcademicSec=query_object.get_All_AcademicSessions(instituteid);
BoardList = standardQuery.listBoard(instituteid);

%>
<form name="scholarsip_form" method="post">
<%
     if(request.getParameter("reqboardid")!=null){
     %> 
     <input type="hidden" name="reqboardid" value="<%=request.getParameter("reqboardid")%>"/>
     <%
     }
     else{ 
    	%> 
    	<input type="hidden" name="reqboardid" value=""/> 
    <%	 
     }
     %>
     <%
     if(request.getParameter("scholarshipid")!=null){
     %>
     	<input type="hidden" name="scholarshipid" value="<%=request.getParameter("scholarshipid")%>"/>
     <%
     }
     else{
    	%> 
    	 
    	 <input type="hidden" name="scholarshipid" value=""/>
    	 <%
     }
     %>
     <%
     if(request.getParameter("sessionid")!=null){
     %>
		<input type="hidden" name="sessionid" value="<%=request.getParameter("sessionid")%>"/>
<%
     }
     else{
    	 %>
    	 		<input type="hidden" name="sessionid" value=""/>
    	 
    	 <%
     }
%>     
<table id="rounded-corner" border=0  width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%" colspan=5>Allotment</th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
				<td colspan=5 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
    </tfoot>
    
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale,com.iGrandee.MasterEntries.Standard.StandardQuery"%>

    	<tr>
    	<td class=tablebold width="15%">Academic Year
    	
    	</td><td class=tablelight class='tablelight' width='34%'> 
    	
    	<select name="academicyear" validate="Academic Year">
    		<option value="">---Select Academic Year</option>
    	<%
    	String sessionid=null;
    	
    	if(AcademicSec!=null && AcademicSec.size()>0)
		{								

			for(int i=0,j=1;i<AcademicSec.size();i++,j++)
			{

				
				newAcademicSec=(HashMap)AcademicSec.get(i);
				System.out.println("whoele>>>sessionid"+newAcademicSec.get("sessionid")+"sessionname>>>>>>>>>>"+newAcademicSec.get("sessionname"));

				if(request.getParameter("sessionid")!=null){
					sessionid=request.getParameter("sessionid");
					if(sessionid.equals(newAcademicSec.get("sessionid"))){
						//System.out.println("if>>>sessionid"+newAcademicSec.get("sessionid"));
						out.println("<option value='"+newAcademicSec.get("sessionid")+"' selected>"+newAcademicSec.get("sessionname")+"</option>");
					}
					else{
						//System.out.println("else>>>sessionid"+newAcademicSec.get("sessionid"));

						out.println("<option value='"+newAcademicSec.get("sessionid")+"'>"+newAcademicSec.get("sessionname")+"</option>");
						
					}
				}
				else{ 
					out.println("<option value='"+newAcademicSec.get("sessionid")+"'>"+newAcademicSec.get("sessionname")+"</option>");
					
				}
			}
		}
    	%>  
    	</select>
    	</td>
    	<td lass=tablebold width="15%"> <%=bundle.getString("label.standard.Board") %> </td><td class='tablelight' colspan="6">
	<select name="standard_board" class=tablelight validate="Board"> <option>-Select Board-Medium- </option>
<% 
   			
        	if(BoardList!=null && BoardList.size()>0)
			{
   		 	for (int i = 0, j = 1; i < BoardList.size(); i++) {
			
				HashMap boardListMap=(HashMap)BoardList.get(i);
				String boardid     = (String)boardListMap.get("boardid");
				String boardname      = (String)boardListMap.get("boardname");
				String mediumid      = (String)boardListMap.get("mediumid");
				String mediumname      = (String)boardListMap.get("mediumname");
				if(request.getParameter("reqboardid") != null) 
		    	  {
		    	  	reqboardid = request.getParameter("reqboardid");
		    	  	if(reqboardid.equals(boardid))
		    	  	{
		          		 out.println("<option value='"+boardid+"' class=tablelight selected>"+boardname+"-"+mediumname+"</option>");
	    	  		}else
	    	  		{
		    	  	out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");
	    	  		}
		    	  	
		    	  }
				else{
       		 out.println("<option value='"+boardid+"' class=tablelight >"+boardname+"-"+mediumname+"</option>");}
   		 }
			}
   		 %></select>
</td>
    	</tr>
    	<tr>
        <td class=tablebold>Scholarsip
        
        </td><td class=tablelight colspan="6">
        <select name="scholarship" class=tablelight   validate="Scholarship">
		<option value="">-Select Scholarship Type-</option>
		<%
		HashMap hashmap =null;
		String scholarshipid=null;

				if(loadscholarshipList != null && loadscholarshipList.size()>0){
					for(int y=0;y<loadscholarshipList.size();y++){
						hashmap		= (HashMap)loadscholarshipList.get(y);	 
						//System.out.println("whoele>>>scholarshipid"+hashmap.get("scholarshipid")+"whoele>>>scholarshipname>>>>>>>>>"+hashmap.get("scholarshipname"));

						if(request.getParameter("scholarshipid")!=null){
							scholarshipid=request.getParameter("scholarshipid"); 
							 

							if(scholarshipid.equals(hashmap.get("scholarshipid"))){
								// System.out.println("in if>>scholarshipid>"+hashmap.get("scholarshipid"));
								out.println("<option value='"+hashmap.get("scholarshipid")+"' selected>"+hashmap.get("scholarshipname")+"</option>");
							}
							else{
								out.println("<option value='"+hashmap.get("scholarshipid")+"'>"+hashmap.get("scholarshipname")+"</option>");
								//System.out.println("in else>scholarshipid>>"+hashmap.get("scholarshipid"));
							}
						}
						else{
							out.println("<option value='"+hashmap.get("scholarshipid")+"'>"+hashmap.get("scholarshipname")+"</option>");
						}
					}
			}
				
		%>
		</select><input type="hidden" name="paymenttypename"/>
        
        </td>
    </tr>	 
     <tr> 
			<td colspan="3" align="center"> <a href="#" class="bt_green" onclick="loadStandard()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a></td>
			<td colspan="3"></td>
		</tr>
	
    </tbody>
</table>
<br/><br/>
	
	<table id="rounded-corner" border=0 summary="selectd Information" width="100%">
    	<thead>
        	<th scope="col" class="rounded-company">S.NO</th>
        	<th scope="col" class="rounded" >Standard Name</th>
        	<th scope="col" class="rounded-q4" >Amount </th>
        	
    	</thead>
    	<tfoot>
        	<td colspan=2 class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
    	</tfoot>
     <tbody>
 <%
 try
 {
	//  instituteid = (String)session.getValue("instituteid");
	String loadstandardamount=null;String standardscheduleid=null;
	
	  if(request.getParameter("sessionid") != null && request.getParameter("scholarshipid") != null)
	  {
	  	reqboardid = request.getParameter("reqboardid");
		//out.println("reqboardid"+reqboardid);
	  	StandardList = standardQuery.geteditStandards(scholarshipid,sessionid);
		

	  }
	 
	//standardid, standardname, boardid, boardname, mediumname, mediumid
	 if(StandardList!=null && StandardList.size()>0)
		{
		 for (int i = 0, j = 1; i < StandardList.size(); i++) {
		
			HashMap StandardListMap=(HashMap)StandardList.get(i);

			String standardid       = (String)StandardListMap.get("standardid");
			String standardname      = (String)StandardListMap.get("standardname");
			String description     = (String)StandardListMap.get("description");
			if(description == null || description == "")
				description = "-";
			String groupname      = (String)StandardListMap.get("groupname");
			String stdcreateddate      = (String)StandardListMap.get("dateofcreation");
			loadstandardamount=(String)StandardListMap.get("amount");
			standardscheduleid=(String)StandardListMap.get("standardscheduleid");
			
			%> 
			
			<tr valign=top> 
    	 <td>
    	 	<%=j++ %>
    	 </td>
        <td><%
        if(groupname!=null)
        out.println(standardname+","+groupname);
        else
        	out.println(standardname);
        %></td>
        <td>
        <%
       
        if(loadstandardamount!=null && loadstandardamount!=""){
        %>
    
       <%= loadstandardamount%>
       
        <%
        }
        else{  
        %>
      
        	<input name="loadstandardamount" type="text" value=""/>
        <%	
        } 
        %>
         
        </td>
      
       		 <input type="hidden" name="standardscheduleid" value="<%=standardscheduleid%>"/>
       		  
    </tr>
			<%
		 }
		%> 
		 
		 <tr>
			<td colspan="3" align="center"> <a href="#" class="bt_green" onclick="scholarshipallotment()"><span class="bt_green_lft"></span><strong>Allotment</strong><span class="bt_green_r"></span></a></td>
		</tr>
		<% 
		}
 }
 catch(Exception e){
	 e.printStackTrace();
	 
 }
 %>
 
	

	
   </tbody>
   </table>
   
 		 <input type="hidden" name="reqboardname"/>
 		
 		
</form>
     </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
  
<%@ include file="../include/footer.jsp" %>
     

</div>


</body>
</html>
