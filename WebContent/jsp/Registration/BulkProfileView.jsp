<%@ page 		language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<jsp:useBean 	id="validate" 	scope="page" class="com.iGrandee.Common.CommonDataAccess" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Student Profile Entry</title> 

<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>


<script language="JavaScript">

	function submitfun(){
	
	
		for(var t=0;t<document.MainForm.applicationno.length-1;t++){
		
			if(document.MainForm.vstatus[t].value == "No"){
			
				document.MainForm.applicationno[t].disabled			= true;
				document.MainForm.prefix[t].disabled				= true;
				document.MainForm.firstname[t].disabled				= true;
				document.MainForm.middlename[t].disabled			= true;
				document.MainForm.lastname[t].disabled				= true;
				document.MainForm.dateofbirth[t].disabled			= true;
				document.MainForm.gender[t].disabled				= true;
				document.MainForm.fathername[t].disabled			= true;
				document.MainForm.mothername[t].disabled			= true;
				document.MainForm.nationality[t].disabled			= true;
				document.MainForm.language[t].disabled				= true;
				document.MainForm.bloodgroup[t].disabled			= true;
				document.MainForm.street1[t].disabled				= true;
				document.MainForm.street2[t].disabled				= true;
				document.MainForm.country[t].disabled				= true;
				document.MainForm.state[t].disabled					= true;
				document.MainForm.city[t].disabled					= true;
				document.MainForm.pincode[t].disabled				= true;
				document.MainForm.landlineno[t].disabled			= true;
				document.MainForm.mobileno[t].disabled				= true;
				document.MainForm.email[t].disabled					= true;
				document.MainForm.smscontact[t].disabled			= true;
				document.MainForm.guardianname[t].disabled			= true;
				document.MainForm.guardianrelation[t].disabled		= true;
				document.MainForm.selfemployed[t].disabled			= true;
				document.MainForm.organizationname[t].disabled		= true;
				document.MainForm.income[t].disabled				= true;
				document.MainForm.position[t].disabled				= true;
				document.MainForm.physicallychallenged[t].disabled	= true;
				document.MainForm.childofexserviceman[t].disabled	= true;
				document.MainForm.personalphysicalmarks[t].disabled	= true;
				document.MainForm.studentapprovalid[t].disabled		= true;
				document.MainForm.vstatus[t].disabled				= true;
				document.MainForm.existingstudentrollno[t].disabled	= true;


			}
		
		}
	
	
		document.MainForm.action= "./BulkProfileSubmit.jsp";
		document.MainForm.submit();			

	}
	
	function backfun()
	{
		document.MainForm.action= "./BulkProfileEntry.jsp";
		document.MainForm.submit();			
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
    <h2>Enrollment / Student Enrollment / Student Profile Entry [ Bulk ] / Profile View</h2>
     
	<%@ page import="java.util.*,com.iGrandee.Registration.StudentRegistrationQuery,com.iGrandee.Registration.ProfileUpload,com.iGrandee.Common.DateTime"%>
	<%@ page language="java" import="java.io.FileInputStream,java.io.InputStream,java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.Registration.ExcelParser"%>
	<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
	<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
	<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
	<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
	
	<form name="MainForm" method="post" action="" >
	
		<%
			    
	    	DateTime datetime			= new DateTime();
    		ProfileUpload	upload		= new ProfileUpload(request);
    		StudentRegistrationQuery qry= new StudentRegistrationQuery();
    		upload.startProcess();
    		ResourceBundle rbundle		= ResourceBundle.getBundle("resources.serversetup");
	    	HashMap	hashmap				= null;
	    	String storagepath			= rbundle.getString("storagepath");
	    	String sessionname			= upload.getParameter("sessionname");
	    	String boardname			= upload.getParameter("boardname");
	    	String standardname			= upload.getParameter("standardname");
	    	String standardid			= upload.getParameter("standard");
	    	storagepath					+= upload.getFileNames()[0];
	    %>
			

	<table id="rounded-corner" border=0  width="100%">
	    <thead>
	    	<tr>
	        	<th scope="col" class="rounded-company" width="90%" >Selected Information</th>
	        	<th scope="col" class="rounded-q4" width="10%" ></th>
	        </tr>
	    </thead>
	    
	    <tfoot>
	    	<tr>
	        	<td   class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       </tr>
	    </tfoot>
	    
		<tbody>
			<tr>
		    	<td colspan=2>
		     		<table  border=0 summary="Department List" width="100%">
			   			<tr>
							<td class="tablebold" width="25%">Academic Year</td>
							<td class=tablebold>:</td>
							<td><%=sessionname%></td>
							<td class="tablebold" align=right>Board</td>
							<td class=tablebold>:</td>
							<td><%=boardname%></td>
						</tr>
						<tr>
							<td class="tablebold" align=left width="25%">Standard Name</td>
							<td class=tablebold>:</td>
							<td><%=standardname%></td>
						</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
	<br> 
	
	
	
	
		<div class='myScrollingDiv'>
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
			    <thead>
			    	<tr>
			        	<th scope="col" class="rounded-company">Sl.No</th>
			        	<th scope="col" class="rounded">Application No</th>
			        	<th scope="col" class="rounded">Profile Status</th>		        	
			        	<th scope="col" class="rounded">Prefix</th>
			        	<th scope="col" class="rounded">FirstName</th>
			        	<th scope="col" class="rounded">MiddleName</th>
			        	<th scope="col" class="rounded">LastName</th>
			        	<th scope="col" class="rounded">Date of Birth</th>
			        	<th scope="col" class="rounded">Gender</th>
			        	<th scope="col" class="rounded">Father Name</th>
			        	<th scope="col" class="rounded">Mother Name</th>
			        	<th scope="col" class="rounded">Nationality</th>
			        	<th scope="col" class="rounded">Language</th>
			        	<th scope="col" class="rounded">Blood Group</th>
			        	<th scope="col" class="rounded">Street1</th>
			        	<th scope="col" class="rounded">Street2</th>	
			        	<th scope="col" class="rounded">Country</th>
			        	<th scope="col" class="rounded">State</th>
			        	<th scope="col" class="rounded">City</th>
			        	<th scope="col" class="rounded">Pin Code</th>
			        	<th scope="col" class="rounded">Land Line No</th>
			        	<th scope="col" class="rounded">Mobile No</th>	
			        	<th scope="col" class="rounded">EMail</th>
			        	<th scope="col" class="rounded">SMS Contact</th>
			        	<th scope="col" class="rounded">Guardian Name</th>
			        	<th scope="col" class="rounded">Guardian Relation</th>
			        	<th scope="col" class="rounded">Self Employed</th>
			        	<th scope="col" class="rounded">Organization Name</th>	
			        	<th scope="col" class="rounded">Income</th>
			        	<th scope="col" class="rounded">Position</th>
			        	<th scope="col" class="rounded">Physically Challenged</th>
			        	<th scope="col" class="rounded">Child of Ex-service Man</th>		        	
			        	<th scope="col" class="rounded">Personal Physical Marks</th>		 
			        	<th scope="col" class="rounded-q4">Existing Student Roll No</th>
			        </tr>
			    </thead>
			    <%
			    
				    String applicationno			= null;
			    	String prefix1					= null; 
			    	String firstname				= null; 
			    	String middlename				= null;
			    	String lastname					= null;
			    	String dateofbirth				= null;
			    	String gender					= null;
			    	String fathername				= null;
			    	String mothername				= null;
			    	String nationality				= null;
			    	String language					= null;
			    	String bloodgroup				= null;
			    	String street1					= null;
			    	String street2					= null;
			    	String country					= null;
			    	String state					= null;
			    	String city 					= null;
			    	String pincode					= null;
			    	String landlineno				= null;
			    	String mobileno					= null;
			    	String email					= null;
			    	String smscontact				= null;
			    	String guardianname				= null;
			    	String guardianrelation			= null;
			    	String selfemployed				= null;
			    	String organizationname			= null;
			    	String income					= null;
			    	String position					= null;
			    	String physicallychallenged 	= null;	
			    	String childofexserviceman		= null;
			    	String personalphysicalmarks	= null;
			    	String existingstudentrollno	= null;
			    	ArrayList checkingList			= null;
			    	
					HSSFWorkbook workBook 			= ExcelParser.getWorkBook(new FileInputStream(storagepath));
					HSSFSheet sheet 				= workBook.getSheetAt(0);
					int rows 						= sheet.getPhysicalNumberOfRows();
					ArrayList duplicateList			= new ArrayList();
					
					String tstandardscheduleid		= "";
					String tapprovalid				= "";
					String tstatus					= "";
					int totalcount					= 0;
					
					try {

						for(int j=0;j<rows;j++)
						{
							
							HSSFRow row 			= sheet.getRow(j);
							int cells 				= row.getPhysicalNumberOfCells();
							tstandardscheduleid		= "";
							tapprovalid				= "";
							tstatus					= "";

	
							if(cells == 32)
							{
								if(j>0)
								{
									
									totalcount++;
									
									out.print("<tr class=tablelight>");
									out.print("<td valign='top'>"+j+".</td>");
	
									HSSFCell cell0 		= row.getCell((short)0);
									applicationno		= (String)ExcelParser.getValueOfCell(cell0,"CHAR");
	
									out.print("<td><input type='hidden' name='applicationno' value='"+applicationno+"'>"+applicationno+"</td>");
	
									
									if(duplicateList.contains(applicationno)){
										
										out.print("<td><input type='hidden' name='vstatus' value='No'><input type='hidden' name='studentapprovalid' value='"+tapprovalid+"'><a class='nodata'>Duplicate Application No</a></td>");
									}
									else{
										
										duplicateList.add(applicationno);
										
										checkingList		= qry.checkStudentDetails(applicationno);
										
										if(checkingList == null || checkingList.size() ==0){
											
											out.print("<td><input type='hidden' name='vstatus' value='No'><input type='hidden' name='studentapprovalid' value='"+tapprovalid+"'><a class='nodata'>Application No is not Valid</a></td>");
											
										}
										else{
											
											hashmap				= (HashMap)checkingList.get(0);
											tstandardscheduleid	= (String)hashmap.get("standardscheduleid");
											tstatus				= (String)hashmap.get("status");
											tapprovalid			= (String)hashmap.get("studentapprovalid");
											
											
											if(!tstandardscheduleid.equals(standardid)){
												
												out.print("<td><input type='hidden' name='vstatus' value='No'><input type='hidden' name='studentapprovalid' value='"+tapprovalid+"'><a class='nodata'>Application No is not From this Standard</a></td>");
											}
											else if(tstatus.equals("Entered")){
												
												out.print("<td><input type='hidden' name='vstatus' value='No'><input type='hidden' name='studentapprovalid' value='"+tapprovalid+"'><a class='nodata'>Profile already entered for this Application No</a></td>");
												
											}
											else{
												
												out.print("<td><input type='hidden' name='vstatus' value='Yes'><input type='hidden' name='studentapprovalid' value='"+tapprovalid+"'>Application No is valid</td>");
											}
										}
									}
																		
									
	
									HSSFCell cell1 		= row.getCell((short)1);
									prefix1	 			= (String)ExcelParser.getValueOfCell(cell1,"CHAR");
									out.print("<td><input type='hidden' name='prefix' value='"+prefix1+"'>"+prefix1+"</td>");
	
									
									HSSFCell cell2 		= row.getCell((short)2);
									firstname			= (String)ExcelParser.getValueOfCell(cell2,"CHAR");
									out.print("<td><input type='hidden' name='firstname' value='"+firstname+"'>"+firstname+"</td>");
	
									HSSFCell cell3 		= row.getCell((short)3);
									middlename 					= (String)ExcelParser.getValueOfCell(cell3,"CHAR");
									out.print("<td><input type='hidden' name='middlename' value='"+middlename+"'>"+middlename+"</td>");
	
									HSSFCell cell4 		= row.getCell((short)4);
									lastname			= (String)ExcelParser.getValueOfCell(cell4,"CHAR");
									out.print("<td><input type='hidden' name='lastname' value='"+lastname+"'>"+lastname+"</td>");
	
									HSSFCell cell5 		= row.getCell((short)5);
									dateofbirth			= (String)ExcelParser.getValueOfCell(cell5,"CHAR");
									out.print("<td><input type='hidden' name='dateofbirth' value='"+dateofbirth+"'>"+dateofbirth+"</td>");
	
									HSSFCell cell6 		= row.getCell((short)6);
									gender				= (String)ExcelParser.getValueOfCell(cell6,"CHAR");
									
									if(gender != null && gender.equalsIgnoreCase("Male"))
										gender	= "M";
									else
										gender	= "F";
									out.print("<td><input type='hidden' name='gender' value='"+gender+"'>"+gender+"</td>");
	
									HSSFCell cell7 		= row.getCell((short)7);
									fathername			= (String)ExcelParser.getValueOfCell(cell7,"CHAR");
									out.print("<td><input type='hidden' name='fathername' value='"+fathername+"'>"+fathername+"</td>");
	
									HSSFCell cell8 		= row.getCell((short)8);
									mothername			= (String)ExcelParser.getValueOfCell(cell8,"CHAR");
									out.print("<td><input type='hidden' name='mothername' value='"+mothername+"'>"+mothername+"</td>");
	
									HSSFCell cell9 		= row.getCell((short)9);
									nationality			= (String)ExcelParser.getValueOfCell(cell9,"CHAR");
									out.print("<td><input type='hidden' name='nationality' value='"+nationality+"'>"+nationality+"</td>");
	
									HSSFCell cell10 	= row.getCell((short)10);
									language 			= (String)ExcelParser.getValueOfCell(cell10,"CHAR");
									out.print("<td><input type='hidden' name='language' value='"+language+"'>"+language+"</td>");
									
									HSSFCell cell11 		= row.getCell((short)11);
									bloodgroup 			= (String)ExcelParser.getValueOfCell(cell11,"CHAR");
									out.print("<td><input type='hidden' name='bloodgroup' value='"+bloodgroup+"'>"+bloodgroup+"</td>");
	
									HSSFCell cell12 		= row.getCell((short)12);
									street1		 			= (String)ExcelParser.getValueOfCell(cell12,"CHAR");
									out.print("<td><input type='hidden' name='street1' value='"+street1+"'>"+street1+"</td>");
	
									HSSFCell cell13 		= row.getCell((short)13);
									street2 					= (String)ExcelParser.getValueOfCell(cell13,"CHAR");
									out.print("<td><input type='hidden' name='street2' value='"+street2+"'>"+street2+"</td>");
	
									HSSFCell cell14 		= row.getCell((short)14);
									country 					= (String)ExcelParser.getValueOfCell(cell14,"CHAR");
									out.print("<td><input type='hidden' name='country' value='"+country+"'>"+country+"</td>");
	
									HSSFCell cell15 		= row.getCell((short)15);
									state 					= (String)ExcelParser.getValueOfCell(cell15,"CHAR");
									out.print("<td><input type='hidden' name='state' value='"+state+"'>"+state+"</td>");
	
									HSSFCell cell16 		= row.getCell((short)16);
									city 					= (String)ExcelParser.getValueOfCell(cell16,"CHAR");
									out.print("<td><input type='hidden' name='city' value='"+city+"'>"+city+"</td>");
	
									HSSFCell cell17 		= row.getCell((short)17);
									pincode 					= (String)ExcelParser.getValueOfCell(cell17,"CHAR");
									out.print("<td><input type='hidden' name='pincode' value='"+pincode+"'>"+pincode+"</td>");
	
									HSSFCell cell18 		= row.getCell((short)18);
									landlineno				= (String)ExcelParser.getValueOfCell(cell18,"CHAR");
									out.print("<td><input type='hidden' name='landlineno' value='"+landlineno+"'>"+landlineno+"</td>");
	
									HSSFCell cell19 		= row.getCell((short)19);
									mobileno 				= (String)ExcelParser.getValueOfCell(cell19,"CHAR");
									out.print("<td><input type='hidden' name='mobileno' value='"+mobileno+"'>"+mobileno+"</td>");
	
									HSSFCell cell20 		= row.getCell((short)20);
									email 					= (String)ExcelParser.getValueOfCell(cell20,"CHAR");
									out.print("<td><input type='hidden' name='email' value='"+email+"'>"+email+"</td>");
	
									HSSFCell cell121 		= row.getCell((short)21);
									smscontact 				= (String)ExcelParser.getValueOfCell(cell121,"CHAR");
									out.print("<td><input type='hidden' name='smscontact' value='"+smscontact+"'>"+smscontact+"</td>");
									
									HSSFCell cell22 		= row.getCell((short)22);
									guardianname 			= (String)ExcelParser.getValueOfCell(cell22,"CHAR");
									out.print("<td><input type='hidden' name='guardianname' value='"+guardianname+"'>"+guardianname+"</td>");
	
									HSSFCell cell23 	= row.getCell((short)23);
									guardianrelation	= (String)ExcelParser.getValueOfCell(cell23,"CHAR");
									out.print("<td><input type='hidden' name='guardianrelation' value='"+guardianrelation+"'>"+guardianrelation+"</td>");
	
									HSSFCell cell24 	= row.getCell((short)24);
									selfemployed		= (String)ExcelParser.getValueOfCell(cell24,"CHAR");
	
									if(selfemployed != null && selfemployed.equalsIgnoreCase("Yes"))
										selfemployed 	= "Yes";
									else
										selfemployed	= "No";
									out.print("<td><input type='hidden' name='selfemployed' value='"+selfemployed+"'>"+selfemployed+"</td>");
									
	
									HSSFCell cell25 	= row.getCell((short)25);
									organizationname	= (String)ExcelParser.getValueOfCell(cell25,"CHAR");
									out.print("<td><input type='hidden' name='organizationname' value='"+organizationname+"'>"+organizationname+"</td>");
	
									HSSFCell cell26 	= row.getCell((short)26);
									income				= (String)ExcelParser.getValueOfCell(cell26,"CHAR");
									out.print("<td><input type='hidden' name='income' value='"+income+"'>"+income+"</td>");
	
									HSSFCell cell27 	= row.getCell((short)27);
									position			= (String)ExcelParser.getValueOfCell(cell27,"CHAR");
									out.print("<td><input type='hidden' name='position' value='"+position+"'>"+position+"</td>");
	
									HSSFCell cell28 	= row.getCell((short)28);
									physicallychallenged= (String)ExcelParser.getValueOfCell(cell28,"CHAR");
									
									if(physicallychallenged != null && physicallychallenged.equalsIgnoreCase("Yes"))
										physicallychallenged 	= "Yes";
									else
										physicallychallenged	= "No";
									
									out.print("<td><input type='hidden' name='physicallychallenged' value='"+physicallychallenged+"'>"+physicallychallenged+"</td>");
	
									HSSFCell cell29 	= row.getCell((short)29);
									childofexserviceman	= (String)ExcelParser.getValueOfCell(cell29,"CHAR");
									
									if(childofexserviceman != null && childofexserviceman.equalsIgnoreCase("Yes"))
										childofexserviceman 	= "Yes";
									else
										childofexserviceman	= "No";
									
									out.print("<td><input type='hidden' name='childofexserviceman' value='"+childofexserviceman+"'>"+childofexserviceman+"</td>");
	
									HSSFCell cell30 	= row.getCell((short)30);
									personalphysicalmarks= (String)ExcelParser.getValueOfCell(cell30,"CHAR");
									out.print("<td><input type='hidden' name='personalphysicalmarks' value='"+personalphysicalmarks+"'>"+personalphysicalmarks+"</td>");
	


									HSSFCell cell31 	= row.getCell((short)31);
									existingstudentrollno= (String)ExcelParser.getValueOfCell(cell31,"CHAR");
									out.print("<td><input type='hidden' name='existingstudentrollno' value='"+existingstudentrollno+"'>"+existingstudentrollno+"</td></tr>");
	
							
								}
							}
						}
					}
					catch(Exception e){
						
						e.printStackTrace();
					}
			    %>
			    
			    
			    <tfoot>
			    	<tr>
			        	<td  colspan='33' class="rounded-foot-left"><em></em></td>
			        	<td class="rounded-foot-right">&nbsp;</td>
			       </tr>
			    </tfoot>
			</table>
		</div>
		
		<br>
		
		<table>
			<tr>
				<td rowspan='5' valign='top' width='20%'><a class='tablebold'><font color='red'>Note :-</font></a></td>
				<td><a class='tablebold'>The following profiles will not be updated.</td>
			</tr>
			<tr>
				<td>1) Duplicate Application No</td>
			</tr>
			<tr>
				<td> 2) Profile already updated students.</td>
			</tr>
			<tr>
				<td>3) Application No from other Standard</td>
			</tr>
			<tr>
				<td>4) Wrong Application No</td>
			</tr>
			
		</table>
		
		
		<a href="#" onclick="backfun()"  class="bt_blue" align=center><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a> 
		
		<% if(totalcount>0){ %>
			<a href="#" onclick="submitfun()"  class="bt_green" align=center><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a> 
 		<%}%>
 		
 		<input type='hidden' name='standardid' value='<%=standardid%>'> 
 		
 		<%
	
			out.print("<input type='hidden' name='applicationno' 			disabled>");
			out.print("<input type='hidden' name='prefix' 					disabled>");
			out.print("<input type='hidden' name='firstname' 				disabled>");
			out.print("<input type='hidden' name='middlename' 				disabled>");
			out.print("<input type='hidden' name='lastname' 				disabled>");
			out.print("<input type='hidden' name='dateofbirth' 				disabled>");
			out.print("<input type='hidden' name='gender' 					disabled>");
			out.print("<input type='hidden' name='fathername' 				disabled>");
			out.print("<input type='hidden' name='mothername' 				disabled>");
			out.print("<input type='hidden' name='nationality' 				disabled>");
			out.print("<input type='hidden' name='language' 				disabled>");
			out.print("<input type='hidden' name='bloodgroup' 				disabled>");
			out.print("<input type='hidden' name='street1' 					disabled>");
			out.print("<input type='hidden' name='street2' 					disabled>");
			out.print("<input type='hidden' name='country' 					disabled>");
			out.print("<input type='hidden' name='state' 					disabled>");
			out.print("<input type='hidden' name='city' 					disabled>");
			out.print("<input type='hidden' name='pincode' 					disabled>");
			out.print("<input type='hidden' name='landlineno' 				disabled>");
			out.print("<input type='hidden' name='mobileno' 				disabled>");
			out.print("<input type='hidden' name='email' 					disabled>");
			out.print("<input type='hidden' name='smscontact' 				disabled>");
			out.print("<input type='hidden' name='guardianname' 			disabled>");
			out.print("<input type='hidden' name='guardianrelation' 		disabled>");
			out.print("<input type='hidden' name='selfemployed' 			disabled>");
			out.print("<input type='hidden' name='organizationname' 		disabled>");
			out.print("<input type='hidden' name='income' 					disabled>");
			out.print("<input type='hidden' name='position' 				disabled>");
			out.print("<input type='hidden' name='physicallychallenged' 	disabled>");
			out.print("<input type='hidden' name='childofexserviceman' 		disabled>");
			out.print("<input type='hidden' name='personalphysicalmarks' 	disabled>");
			out.print("<input type='hidden' name='vstatus' 					disabled>");
			out.print("<input type='hidden' name='studentapprovalid' 		disabled>");
			out.print("<input type='hidden' name='existingstudentrollno' 	disabled>");
				

		%>
 		
 		
 		
 
 	</form>

</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../include/footer.jsp" %>

</div>

   
	
</body>
</html>