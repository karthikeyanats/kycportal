  <div class="menu">
 <%
 
	 String loginusercategory 		= null;
	 String headerinstituteid 		= null;
	 java.util.ArrayList hflahList 	= null;
	 java.util.ResourceBundle rbx=null;
 try{
	 
 	if(session.getValue("userid") == null)
 	{
 		out.println("<script>location.replace("+request.getContextPath()+"/kycsessionexpire.jsp)</script>");
 	}
 	else
 	{
 		com.iGrandee.FlashNews.FlashNewsEntry flashquery = new com.iGrandee.FlashNews.FlashNewsEntry();
 		loginusercategory 	= (String)session.getValue("usercategory");
 		headerinstituteid 	= (String)session.getValue("instituteid");
 		hflahList 			= flashquery.loadActiveFlashNews(headerinstituteid);
 		rbx=java.util.ResourceBundle.getBundle("resources.serversetup");

 	}
 %>
 <%
 if(loginusercategory != null && loginusercategory.equals("MA"))
 {
 %>
 <ul>
 <li><a href="<%=request.getContextPath()%>/jsp/SuperAdmin/SuperAdminPage.jsp" title="">Admin Home</a></li>
 </ul>
 
 <%
 } else if(loginusercategory != null && loginusercategory.equals("SA")) 
 {
 %>

                    <ul>
                    <li><a class="current" href="<%=request.getContextPath()%>/jsp/kycpanel/Homepage.jsp">Admin Home</a></li>
                    <li><a href="#">Master Entries<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
                        <li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/Department/DepartmentList.jsp" title="">Department</a></li>
                        
                         <li><a href="<%=request.getContextPath() %>/jsp/Staff/staffcategorycreation.jsp" title="">StaffCategory</a></li>
                        <li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/Role/RoleList.jsp" title="">Role</a></li>
                        <li><a class="sub1" href="#nogo">Standard<!--[if IE 7]><!--></a><!--<![endif]-->
                            <ul>
                            	<li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/Medium/MediumList.jsp" title="">Medium</a></li>
                               	<li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/Board/BoardEntry.jsp" title="">Board</a></li>
                       		 	<li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/Group/GroupList.jsp" title="">Group</a></li>
                        		<li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/Section/SectionList.jsp" title="">Section</a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/Standard/StandardList.jsp" title="">Standard Entry</a></li>
                        	 </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                         </li>
                         
                         <li><a class="sub1" href="#nogo">Subject<!--[if IE 7]><!--></a><!--<![endif]-->
                            <ul>
                               <li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/SubjectType/SubjectTypeList.jsp" title="">Subject Type</a></li>
                       		 	<!--<li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/SubjectMode/SubjectModeEntry.jsp" title="">Subject Mode</a></li>  -->
                        		<li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/Subject/SubjectStandardList.jsp" title="">Subject Name</a></li>
                        	</ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                         </li>
                       	<li><a href="<%=request.getContextPath()%>/jsp/MasterEntries/AcademicSession/AcademicSessionList.jsp" title="">Academic Session</a></li>
                        	<% if(rbx.getString("communityflag").equals("yes")){ %>
                        <li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/Community/CommunityView.jsp" title="">Community</a></li>
                        <%} %>
									<% if(rbx.getString("religionflag").equals("yes")){ %>
                        <li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/Religion/ReligionView.jsp" title="">Religion</a></li>
                        <%} %>
                        <!-- extra curricular event creation started by rams -->
                         <li><a class="sub1" href="#nogo" >Extra Curricular Activity<!--[if IE 7]><!--></a><!--<![endif]--> 
                        <ul>
                        		<li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/Extracurricularactivity/ExtracurricularactivityList.jsp" title="Extra Curricular Activity">Extra Curricular Activity</a></li>
                               <!--  <li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/ExtraCurricular/ExtraCurricularCategoryEntry.jsp" title="">Extra Curricular Category</a></li>-->
                       		 	<li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/ExtraCurricular/CurricularEventEntry.jsp" title="">Curricular Event Creation</a></li>
                       		 	<li><a href="<%=request.getContextPath() %>/jsp/PhotoGallery/PhotoGalleryEvent.jsp" title="PhotoGallery">PhotoGallery</a></li>
                       		 	<li><a href="<%=request.getContextPath() %>/jsp/PhotoGallery/ViewPhotoGallery.jsp" title="PhotoGallery">ViewGallery</a></li>                       		 	
                        </ul>
                       
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                    
                   
                    
                        <!-- extra curricular event creation ended by rams -->
                        
                        <!-- Scholarship created by surya begins here -->
                        <li><a class="sub1" href="#nogo" >Scholarship<!--[if IE 7]><!--></a><!--<![endif]-->
                        <ul>
                               <li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/Scholarship/ScholarshipList.jsp" title="">Scholarship List</a></li>
                              <li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/Scholarship/ScholarshipBeneficiaryStudents.jsp" title="">Beneficiary Students List</a></li>
                        </ul>
                        <!-- Scholarship created by surya end here -->
                        </ul>
<%--                                                    <li><a href="<%=request.getContextPath() %>/jsp/Staff/staffcategorycreation.jsp" title="">StaffCategory</a></li>
 --%>                        
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    
                    </li>
                    
                   
                    <li><a href="#">Enrollment<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
                        
                       
                        <li><a class="sub1" href="#" title="">Staff Enrollment<!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                                 <li><a href="<%=request.getContextPath()%>/jsp/Registration/Staff_registration.jsp" title="">Staff Registration</a></li>
                                <li><a href="<%=request.getContextPath()%>/jsp/Registration/Staff_List.jsp" title="">Staff List</a></li>
                                <li><a href="<%=request.getContextPath()%>/jsp/Registration/Staff_Promotion.jsp" title="">Staff Promotion</a></li>

                            </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                         </li>
                         <li><a class="sub1" href="#" title="">Student Enrollment<!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                                <li><a href="<%= request.getContextPath()%>/jsp/ApplicationForm/ApplicationIssue_Pre1.jsp" title="">Application Issue</a></li>
                                <li><a href="<%= request.getContextPath()%>/jsp/ApplicationForm/RegistrationProcessList_Pre.jsp" title="">Admission</a></li>
                                <li><a href="<%= request.getContextPath()%>/jsp/ApplicationForm/StudentApproval.jsp" title="">Approval</a></li>
                                <li><a href="<%= request.getContextPath()%>/jsp/Registration/StudentApplicationSearch.jsp" title="">Profile Entry</a></li>
                                <!-- <li><a href="<%= request.getContextPath()%>/jsp/Registration/BulkProfileEntry.jsp" title="">Profile Entry [ Bulk ]</a></li> -->
                                <li><a href="<%= request.getContextPath()%>/jsp/Registration/BulkProfileEntryAut.jsp" title="">Profile Entry [ Bulk ]</a></li>
                                <li><a href="<%= request.getContextPath()%>/jsp/ApplicationForm/StudentAllocation.jsp" title="">Allocation</a></li>
                                <li><a href="<%= request.getContextPath()%>/jsp/RollNumberGeneration/RollNoGenSelect.jsp" title="">Roll No. Generation</a></li>
                                <li><a href="<%= request.getContextPath()%>/jsp/StudentPromotion/StudPromoSelect.jsp" title="">Student Promotion</a></li>
                                <li><a href="<%= request.getContextPath()%>/jsp/StudentPromotion/PromotedStudentAllocation.jsp" title="">PromotedStudent Allocation</a></li>
                                <li><a href="<%= request.getContextPath()%>/jsp/Registration/StudentReport.jsp" title="">Student Profile View</a></li>
                                <li><a href="<%= request.getContextPath()%>/jsp/Registration/StudentSection.jsp" title="">Student Section Change</a></li>
                            </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                         </li>        
                       
                        </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]--> 
                    </li>
                     <li><a href="#">Schedule<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
                        
                        <!-- it is modified by kumaran -->
                        <li><a href="<%=request.getContextPath() %>/jsp/Schedule/StandardSchedule.jsp" title="">Standard schedule</a></li>
                        <!-- <li><a href="" title="">Section Schedule</a></li>
                        <li><a href="" title="">Subject Schedule</a></li> -->
                        
                        <li><a class="sub1" href="#" title="">Staff schedule<!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                        		<li><a href="<%=request.getContextPath() %>/jsp/TimeTable/PeriodTime.jsp" title="">Period Settings</a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/TimeTable/WorkAllotment.jsp" title="">Work allotment</a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/TimeTable/SubjectAllotment.jsp" title="">Staff Allotment</a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/TimeTable/ClassTeacher.jsp" title="">Set Class Teacher</a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/TimeTable/ScheduleSelect.jsp" title="">TimeTable</a></li>
                            </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                         </li>
                         <li><a  href="#" title="" class="sub1">Attendance<!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                        		<li><a href="<%=request.getContextPath() %>/jsp/Attendance/AttendanceEntry.jsp" title="">Attendance Entry</a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/Attendance/AttendanceViewSearch.jsp" title="">Attendance View</a></li>
                        		<!--  <li><a href="<%=request.getContextPath() %>/jsp/TimeTable/SubjectAllotment.jsp" title="">Staff Allotment</a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/TimeTable/ScheduleSelect.jsp" title="">TimeTable</a></li>-->
                            </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                         </li>
                         <li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/ExtraCurricular/CurricularEventAllocation.jsp" title="">ExtraCurricular Allocation</a></li>
                        	
                        </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                    <%-- <li><a href="#">Fees<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
	                        <li><a href="<%=request.getContextPath()%>/jsp/Fees/FeesHead.jsp" title="">Fees Head</a></li>
	                        <li><a href="<%=request.getContextPath()%>/jsp/Fees/FeesTerm.jsp" title="">Fees Term</a></li>
	                        <li><a href="<%=request.getContextPath()%>/jsp/Fees/FeesStructureLoadSession.jsp" title="">Fees Structure</a></li>
	                        <li><a href="<%=request.getContextPath()%>/jsp/Fees/scholarshipallotment.jsp" title="">Scholarship Allotment</a></li> 
	                        <li><a href="<%=request.getContextPath()%>/jsp/Fees/FeesCollection_pre.jsp" title="">Fees Collection</a></li>
	                        <li><a href="<%=request.getContextPath()%>/jsp/Fees/PendingList_pre.jsp" title="">Fees Report</a></li>
                         </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li> --%>
                    
                    <li><a href="#">Exam<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
                        
                        <li><a href="<%=request.getContextPath()%>/jsp/Exam/ExamnameEntry.jsp" title="">Exam name</a></li>
                        <li><a href="<%=request.getContextPath()%>/jsp/Exam/Examallotment/Examallotment.jsp" title="">Exam Allotment</a></li>
                        <li><a href="<%=request.getContextPath()%>/jsp/Exam/ExamSchedule/ExamScheduleCreate.jsp" title="">Exam Schedule</a></li>
                        <li><a href="<%=request.getContextPath()%>/jsp/Principal/ExamMarkSearch.jsp" title="">Exam Mark </a></li>
                      <!--    <li><a href="" title="">Progress Report</a></li> -->
                          <li><a class="sub1" href="#nogo" >Topper / Weaker List<!--[if IE 7]><!--></a><!--<![endif]-->
	                        <ul>
	                               <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/markTopperlist.jsp" title="">Standardwise Toppers List</a></li>
	                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/markweakerlist.jsp" title="">Standardwise Weakers List</a></li>
	                       		 	<!--  <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/subjectmarktopperlist.jsp" title="">Subjectwise Toppers List</a></li>
	                       		 	  <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/subjectmarktopperlist.jsp" title="">Subjectwise Toppers List</a></li>
	                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/Multisubjecttopper.jsp" title="">Subjectwise Topper/Weaker List</a></li>-->
	                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Principal/GradeWiseStudentSearch.jsp" title="">Gradewise List</a></li>
	                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Principal/SubjectWiseStudentListSearch.jsp" title="">Rangewise List</a></li>
	                       		 	
	                        </ul>
                      	</li>
                         <li><a   title="" href="#" class="sub1">Grade Setting<!--[if IE 7]><!--></a><!--<![endif]-->
                        <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                        		<!-- <li><a href="<%=request.getContextPath() %>/jsp/GradeSetting/GradeEntry.jsp" title="">Grade Entry</a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/GradeSetting/ScaleEntry.jsp" title="">Scale Entry </a></li>-->
                        		<li><a href="<%=request.getContextPath() %>/jsp/GradeSetting/Scale/ScaleList.jsp" title="">Grade Scale Entry </a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/GradeSetting/GradeScaleSettings.jsp" title="">Grade Scale Setting </a></li>
                        		<li><a href="<%=request.getContextPath() %>/jsp/GradeSetting/StandardGradeSettings.jsp" title="">Standard Grade Setting</a></li>
                            </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                         </li>
                        <li><a href="<%=request.getContextPath()%>/jsp/Exam/Facultyremarkstatus/FacultyremarksstatusEntry.jsp" title="">Faculty Remarks Status Entry</a></li>
                         
                        <!--  <li><a title="" href="#" class="sub1">Send SMS--><!--[if IE 7]><!--</a><!--<![endif]-->
                        <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <!--<ul>
                        		<li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/markSendSMS.jsp" title="">Mark</a></li>
                        		<li><a href="#" title="">Attendance</a></li>                        		
                            </ul>-->
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                         <!--</li>-->                         
                          </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                 
				
<li><a href="#">Certificate<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
                        
                        <li><a href="<%= request.getContextPath()%>/jsp/StudentTC/TCGenSelect.jsp" title="">Transfer Certificate</a></li>
                        <!--<a href="" title="">Conduct Certificate</a></li>  --><li>
                        <li><a href="<%= request.getContextPath()%>/jsp/StudentAlumini/aluminiSelect.jsp" title="">Alumni Students</a></li>
                          </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>

					<!-- <li><a href="#">Content Access --><!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--<ul>
                    <li><a href="<%=request.getContextPath() %>/jsp/ContentManagement/ContentList.jsp" title="">Content View </a></li>
                    </ul>
                    </li>-->
                    
				 	<li><a href="#">Search<!--[if IE 7]><!--></a><!--<![endif]-->
	                    <!--[if lte IE 6]><table><tr><td><![endif]-->
	                            <ul>
	                                <!-- <li><a href="<%=request.getContextPath() %>/jsp/Student/StudentProfileView.jsp" title="">View Profile</a></li> -->
	                           
	                           
                                <li><a href="<%=request.getContextPath() %>/jsp/StudentSearch/StudentSearch.jsp" title="">Roll No Search</a></li>
                                <li><a href="<%=request.getContextPath() %>/jsp/StudentSearch/StudentSearchNameDob.jsp" title="">Student Search</a></li>
                            </ul>
	                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                </li>
						                    
                    <li><a href="#">Reports<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
                        
                        <li><a href="<%=request.getContextPath() %>/jsp/Reports/ReportIndex.jsp" title="">Session wise Report</a></li>
                        <%-- <li><a href="<%=request.getContextPath() %>/jsp/Reports/AmountCollection.jsp" title="">Financial Report</a></li> --%>
                        <li><a href="<%=request.getContextPath() %>/jsp/Reports/Reportanalysis.jsp" title="">Result Analysis</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/PDFReports/PDFReportIndex.jsp" title="">Archival Report</a></li>
                        <!--  <li><a href="<%=request.getContextPath() %>/jsp/Reports/StudentAttendanceViewList.jsp" title="">Attendance Report</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/Reports/YearwiseStaffList.jsp" title="">Subject Allotment Report</a></li>-->
                        <li><a href="<%=request.getContextPath() %>/jsp/Reports/Consolidated_pre.jsp" title="">Scheduled Report</a></li>                        
                        <li><a href="<%=request.getContextPath() %>/jsp/Registration/ForgotPasswordRequestList.jsp" title="">ForgotPassword Req.List</a></li>
                        
                        </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                     
                    
                     
                    <li><a href="#">General<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
                        
                        <li><a href="<%=request.getContextPath() %>/jsp/SchoolCalender/SchoolCalenderEntry.jsp" title="">School Calendar</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/Announcement/announcement.jsp" title="">Announcement</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/FlashNews/FlashNews.jsp" title="">FlashNews</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/Circular/CircularEntry.jsp" title="">Circular</a></li>
                         <!-- <li><a href="<%=request.getContextPath() %>/jsp/MasterEntries/SMSTemplate/SMSTemplate.jsp" title="">SMS Template</a></li>-->
                        <li><a href="<%=request.getContextPath() %>/jsp/Registration/ProfileInfo.jsp" title="">Institute Info</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/Staff/adminchangepasswd.jsp" title="">Change Password</a></li>
                         <li><a href="<%= request.getContextPath()%>/jsp/Registration/StudentIDCardIssue.jsp" title="">ID Card Issue</a></li>     
                  		<!--  <li><a href="<=request.getContextPath() %>/jsp/General/SendMail.jsp" title="">Send Mail</a></li> -->
                  		<li><a href="<%=request.getContextPath() %>/jsp/General/SendMailEditor.jsp" title="">Send Mail</a></li> 

                        </ul>    
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                   <!--  <li><a href="">Help</a></li>-->
                    </ul>
                  
				<%}else if(loginusercategory != null && loginusercategory.equals("T"))
				{%>
	                <ul>
                    <li><a class="current" href="<%=request.getContextPath()%>/jsp/Staff/StaffHomepage.jsp">Faculty Home</a></li>
                    <li><a href="#">Activities<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                                  <li><a href="<%=request.getContextPath() %>/jsp/Dairy/DairyCreation.jsp" title="">Student Diary</a></li>
  
                               
                                <li><a class="sub1" href="#nogo" >Assignment<!--[if IE 7]><!--></a><!--<![endif]-->
                        	<ul>
                               <li><a href="<%=request.getContextPath() %>/jsp/Assignment/AssignmentCreation.jsp" title="">Assignment Topic Creation</a></li>
                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Assignment/Allocation.jsp" title="">Assignment Allocation</a></li>
                      		  </ul>
                        	  <li><a href="<%=request.getContextPath() %>/jsp/WorkDoneRegister/WorkDoneRegister.jsp" title="">Work Done Register</a></li>
                             </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    
					</li>
					<li><a href="#">Tracking<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                                <li><a href="<%=request.getContextPath() %>/jsp/Staff/MyStudentSelect.jsp" title="">My Students</a></li>
                                <li><a href="<%=request.getContextPath() %>/jsp/Dairy/DiaryEvaluation.jsp" title="">Diary Evaluation</a></li>
                                <li><a href="<%=request.getContextPath() %>/jsp/Assignment/AssignmentEvaluation.jsp" title="">Assignment Evaluation</a></li>
                                <li><a href="<%=request.getContextPath() %>/jsp/Staff/changepasswd.jsp" title="">Change Password</a></li>
                             </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                    <li><a href="#">Exam<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                                <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamnameList.jsp" title="">Exam Schedule</a></li>
                               <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/MarkEntryStaffSelect.jsp" title="">Mark Entry</a></li>
                                <!--  <li><a href="" title="">Progress Report</a></li>
                                <li><a href="" title="">Internal Mark</a></li> -->
							
								<li><a href="#">Exam Mark List<!--[if IE 7]><!--></a><!--<![endif]-->
			                    <!--[if lte IE 6]><table><tr><td><![endif]-->
			                            <ul>
			                                <li><a href="<%=request.getContextPath() %>/jsp/Staff/SubjectTopperList.jsp" title="">Subjectwise Toppers List</a></li>
			                                <li><a href="<%=request.getContextPath() %>/jsp/Staff/SubjectWeakerList.jsp" title="">Subjectwise Weakers List</a></li>
			                             </ul>
			                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
			                    </li>
                                
                             </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                    <li><a href="#">Attendance<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                                <!-- <li><a href="" title="">Attendance Entry</a></li> -->
                        		<li><a href="<%=request.getContextPath() %>/jsp/Attendance/AttendanceEntryForStaff.jsp" title="">Attendance Entry</a></li>
                                <li><a href="<%=request.getContextPath() %>/jsp/Attendance/AttendanceViewForStaff.jsp" title="">Attendance View</a></li>
                                
                            </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                    <li><a href="#">General <!-- [if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                           <ul>
                           		<!--  <li><a href="<=request.getContextPath() %>/jsp/General/SendMail.jsp" title="">Send Mail</a></li> -->
                           		<li><a href="<%=request.getContextPath() %>/jsp/General/SendMailEditor.jsp" title="">Send Mail</a></li> 
                                <li><a href="<%=request.getContextPath() %>/jsp/Staff/Calendarview.jsp" title="">Academic Calendar View</a></li>
                            </ul> 
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                        </li>
	                    <li><a href="#">Content Access<!--[if IE 7]><!--></a><!--<![endif]-->
		                    <ul>
			                    <li><a href="<%=request.getContextPath() %>/jsp/ContentManagement/ContentList.jsp" title="">Content View </a></li>
		                    </ul>
		                </li>
					</ul>
					
	<%}else if(loginusercategory != null && loginusercategory.equals("F")) 
	{%>     
    <ul>
    	<%-- <li><a href="<%=request.getContextPath()%>/jsp/Fees/scholarshipallotment.jsp" title="">Scholarship Allotment</a></li> --%>
    	<li><a href="<%=request.getContextPath()%>/jsp/Fees/newallottment1.jsp" title="">Scholarship Allotment</a></li>
    	
          <li><a href="#">Academic Fees<!--[if IE 7]><!--></a><!--<![endif]-->
		           <ul> 
		              <li><a href="<%=request.getContextPath() %>/jsp/Fees/FeesHead.jsp" title="">Fees Head</a></li>
		              <li><a href="<%=request.getContextPath() %>/jsp/Fees/FeesTerm.jsp" title="">Fees Term</a></li>
		               <li><a href="<%=request.getContextPath() %>/jsp/Fees/FeesStructureLoadSession.jsp" title="">Fees Structure</a></li>
		              <li><a href="<%=request.getContextPath() %>/jsp/Fees/FeesCollection_pre.jsp" title="">Fees Collection</a></li>
		           </ul>
		   </li>
		          
          <li><a href="#">Transport Fees<!--[if IE 7]><!--></a><!--<![endif]-->
		           <ul> 
			        <li><a href="<%=request.getContextPath() %>/jsp/TransportFees/transportroute.jsp" title="">Route Creation </a></li>
			       	 <li><a href="<%=request.getContextPath() %>/jsp/TransportFees/Stageno.jsp" title="">Stage Creation </a></li>  
			       	  <li><a href="<%=request.getContextPath() %>/jsp/TransportFees/Transportyearview.jsp" title="">Type Selection</a></li>
			       	  
			       	  <li><a href="<%=request.getContextPath()%>/jsp/TransportFees/TransportFeesHead.jsp" title="">Transport Fees Head</a></li>
			       	  
			       	  <li>
			       	  		<a href="<%=request.getContextPath() %>/jsp/TransportFees/Amountyearview.jsp" title="">Stage Amount Allocation</a>
					    </li>   	  		                  		                       
                       
			       	  <li><a href="<%=request.getContextPath() %>/jsp/TransportFees/Stagestusearch.jsp" title="">Student Stage Allocation</a></li> 
			       	  <li><a href="<%=request.getContextPath() %>/jsp/TransportFees/FeesCollection/Feescollectionrollnumber.jsp" title="">Fees Collection</a></li>
			       	  <li><a href="<%=request.getContextPath() %>/jsp/TransportFees/ReportRoute.jsp" title="">Route Report </a></li>
			       	   <li><a href="<%=request.getContextPath() %>/jsp/TransportFees/ReportStage.jsp" title="">Stage Report </a></li>
			       	   <li><a href="<%=request.getContextPath() %>/jsp/TransportFees/Paidreport.jsp" title="">Transport Report </a></li>
<%-- 			       	  <li><a href="<%=request.getContextPath() %>/jsp/TransportFees/TravelAttendance/TravelCategoryView.jsp" title="">Travel Attendance</a></li>
 --%>		           </ul>
		  </li>
		   
		   <li><a href="#">Discount<!--[if IE 7]><!--></a><!--<![endif]--> 
		           <ul>
			       	 <li><a href="<%=request.getContextPath() %>/jsp/Discount/Discountlist.jsp" title="">Discount Category </a></li> 
			       	 <li><a href="<%=request.getContextPath() %>/jsp/Discount/Discountcategory.jsp" title="">Discount Category Session Wise </a></li>
			       	<li><a href="<%=request.getContextPath() %>/jsp/Discount/Discountallocation.jsp" title="">Discount Category Allocation </a></li>
			        <li><a href="<%=request.getContextPath() %>/jsp/Discount/ReportDiscount.jsp" title="">Discount Category Report </a></li>
			       	
		           </ul>
		  </li>    
		  
          <li>
          
          <a href="<%=request.getContextPath() %>/jsp/Fees/PendingList_pre.jsp" title="">Academic Fees Report</a></li> 
          
           <li>
          
         	 <a href="#" title="">Reports</a>
         	 <ul>
         	 	<li><a href="<%=request.getContextPath()%>/jsp/Reports/FinanciarReportIndex.jsp" title="">Session Wise Report</a></li>
         	 	<li><a href="<%=request.getContextPath() %>/jsp/Reports/AmountCollection.jsp" title="">Financial Report</a></li>
         	 	<%-- <li><a href="<%=request.getContextPath() %>/jsp/PDFReports/FinancialPDFReportIndex.jsp" title="">Archival Report</a></li> --%>
         	 </ul>
          
          </li> 
          
	</ul>
	 
<%}else if(loginusercategory != null && loginusercategory.equals("S")){
	%>
		<ul>
                    <li><a class="current" href="<%=request.getContextPath()%>/jsp/Student/StudentHome.jsp">Student Home</a></li>
      				<li><a href="#">Activities<!--[if IE 7]><!--></a><!--<![endif]-->
	                      <!--[if lte IE 6]><table><tr><td><![endif]-->
	                          <ul>

	                          <li><a href="<%=request.getContextPath() %>/jsp/Student/Dairyview.jsp" title="">My Diary</a></li>
	         				  <li><a href="<%=request.getContextPath() %>/jsp/Student/AssignmentView.jsp" title="">Assignment</a></li>

	                  		  <li><a href="<%=request.getContextPath() %>/jsp/SchoolCalender/CalenderView.jsp" title="">Calender View</a></li>

	                          <li><a class="sub1" href="#" title="">Attendance<!--[if IE 7]><!--></a><!--<![endif]-->
	  	                               <!--[if lte IE 6]><table><tr><td><![endif]-->
	  	                          <ul>
	  	       							<li><a href="<%=request.getContextPath() %>/jsp/Student/StudentAttendanceView.jsp" title="">Attendance Weekly</a></li>
	                          			<li><a href="<%=request.getContextPath() %>/jsp/Student/StudentAttendanceMonthly.jsp" title="">Attendance Monthly</a></li>
	  	                          </ul>
	  	                               <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                          </li>
	                          </ul>
	                      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
       <!-- exam menu started -->

			         <li><a href="#">Exam<!--[if IE 7]><!--></a><!--<![endif]-->
				   	                           <!--[if lte IE 6]><table><tr><td><![endif]-->
                               <ul>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamSchedule/ExamScheduleListStudent.jsp" title="">Exam Schedule</a></li>
				                  <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/ExammarkforStudent.jsp" title="">Mark</a></li>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/StudentProgressReport.jsp" title="">Progress Report</a></li>
	                              <li><a href="<%=request.getContextPath()%>/jsp/Student/OnlineExam.jsp">Online Exam</a></li>
                               </ul>
				   	                           <!--[if lte IE 6]></td></tr></table></a><![endif]-->
			         </li>

       <!-- exam menu ended --->
	<li><a href="#">Fees<!--[if IE 7]><!--></a><!--<![endif]-->
											   	                           <!--[if lte IE 6]><table><tr><td><![endif]-->
							                               <ul>
								                              	  								<li><a href="<%=request.getContextPath() %>/jsp/Fees/FeesCollectionParentView.jsp" title="">Fees Information</a></li>

							                               </ul>
											   	                           <!--[if lte IE 6]></td></tr></table></a><![endif]-->
							</li>
							
							<li><a href="#">Student Profile<!--[if IE 7]><!--></a><!--<![endif]-->
	  		    	                           <!--[if lte IE 6]><table><tr><td><![endif]-->
	  		    	           <ul>
	  		    	                <li><a href="<%=request.getContextPath() %>/jsp/Student/StudentProfileView.jsp" title="">View Profile</a></li>
	  				                <li><a href="<%=request.getContextPath() %>/jsp/Student/classmatesView.jsp" title="">Classmates</a></li>
	                                <li><a href="<%=request.getContextPath() %>/jsp/Student/changepasswd.jsp" title="">Change Password</a></li>
	  		    	           </ul>
	  		    	                          <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                 </li> 
	                 
	                 
	                 <li><a href="#">Staff<!--[if IE 7]><!--></a><!--<![endif]-->
	    		    	     <!--[if lte IE 6]><table><tr><td><![endif]-->
	    		    	      <ul>
	    		    	       <li><a href="<%=request.getContextPath() %>/jsp/StaffList/StaffListForstudLogin.jsp" title="">Staff List</a></li>
	    		    	      </ul>
	    		    	      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                 </li>
	                 <li><a href="#">Content Access<!--[if IE 7]><!--></a><!--<![endif]-->
                    <ul>
                    <li><a href="<%=request.getContextPath() %>/jsp/ContentManagement/ContentList.jsp" title="">Content View </a></li>
                    
                    </ul>
                    </li>
	                   <li><a href="#">Syllabus<!--[if IE 7]><!--></a><!--<![endif]-->
	      		    	     <!--[if lte IE 6]><table><tr><td><![endif]-->
	      		    	      <ul>
	      		    	       <li><a href="<%=request.getContextPath() %>/jsp/StaffList/StudentSyllabus.jsp" title="">View Syllabus</a></li>
	      		    	      </ul>
	      		    	      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                          </li>
	                          
	                           <li><a href="#">ExtraCurricular Activities<!--[if IE 7]><!--></a><!--<![endif]-->
	        		    	     <!--[if lte IE 6]><table><tr><td><![endif]-->
	        		    	      <ul>
	        		    	     <li><a href="<%=request.getContextPath() %>/jsp/Student/StudentExtracurricularView.jsp" title="">ExtraCurricular Activity View </a></li>
	        		    	      </ul>
	        		    	      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                            </li> 
                         
      </ul>
		
	<% }
	else if(loginusercategory != null && loginusercategory.equals("P")){
	%>
		 <ul>
                 <li><a class="current" href="<%=request.getContextPath()%>/jsp/Parent/ParentHome.jsp">Parent Home</a></li>
                 <li><a href="#">Activities<!--[if IE 7]><!--></a><!--<![endif]-->
                 <!--[if lte IE 6]><table><tr><td><![endif]-->
                      <ul>
                          <li><a href="<%=request.getContextPath() %>/jsp/Parent/Dairy.jsp" title="">My Child Diary</a></li>
                          <li><a href="<%=request.getContextPath() %>/jsp/Parent/Assignment.jsp" title="">Assignment</a></li>
                          <li><a href="<%=request.getContextPath() %>/jsp/SchoolCalender/CalenderView.jsp" title="">Calender View</a></li>
                          <li><a href="<%=request.getContextPath() %>/jsp/Parent/ParentAttendanceView.jsp" title="">Attendance</a></li>
                       </ul>
                  <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                  
			</li>
			 <li><a href="#">Exam<!--[if IE 7]><!--></a><!--<![endif]-->
                  <!--[if lte IE 6]><table><tr><td><![endif]-->
                          <ul>
                              <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamSchedule/ExamScheduleListStudent.jsp" title="">Exam Schedule</a></li>
                              <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/ExammarkforStudent.jsp" title="">Mark</a></li>
                              <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamSchedule/ProgressReport.jsp" title="">Progress Report</a></li>
                             <!--   <li><a href="<%=request.getContextPath() %>/jsp/Exam/MarkComparison.jsp" title="">Mark Comparison</a></li>-->
                         </ul>
                      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                  
			</li>
			 <li><a href="#">Fees<!--[if IE 7]><!--></a><!--<![endif]-->
                  <!--[if lte IE 6]><table><tr><td><![endif]-->
                          <ul>
                              <li><a href="<%=request.getContextPath() %>/jsp/Parent/FeesStructure.jsp" title="Fees Details">Fees Structure</a></li>
                              <li><a href="<%=request.getContextPath() %>/jsp/Fees/FeesCollectionParentView.jsp" title="Fees Details">Fees Paid Details</a></li>
                              <li><a href="<%=request.getContextPath() %>/jsp/Fees/FeesCollectionFromParent.jsp" title="Online Payment">Online Payment</a></li>
                         
                          </ul>
                      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                  
			</li>
			 <li><a href="#">Student Profile<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                                <li><a href="<%=request.getContextPath() %>/jsp/Student/StudentProfileView.jsp" title="">View Profile</a></li> 
                                <li><a href="<%=request.getContextPath() %>/jsp/Student/classmatesView.jsp" title="">Classmates</a></li>
                            </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    
					</li>
					 <li><a href="#">Staff<!--[if IE 7]><!--></a><!--<![endif]-->
                        <ul>
                               <li><a href="<%=request.getContextPath() %>/jsp/StaffList/StaffListForParentLogin.jsp" title="">Staff List</a></li>
                        </ul>
                       
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                     <li><a href="#">Syllabus<!--[if IE 7]><!--></a><!--<![endif]-->
                    
                        <ul>
                               <li><a href="<%=request.getContextPath() %>/jsp/StaffList/StudentSyllabus.jsp" title="">Syllabus List</a></li>
                        </ul>
                       
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
					<li><a href="#">ExtraCurricular Activities<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                            <ul>
                                <li><a href="<%=request.getContextPath() %>/jsp/Parent/ParentExtracurricularView.jsp" title="">ExtraCurricular Activity View </a></li>
                            </ul>
                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
					</li>
					
					</ul>	
				<%}
				else if(loginusercategory != null && loginusercategory.equals("HM")){
					%>
						 <ul>
	                  <li><a class="current" href="<%=request.getContextPath()%>/jsp/Principal/PrincipalHomepage.jsp">Principal Home</a></li>
	                  <li><a href="#">Standard<!--[if IE 7]><!--></a><!--<![endif]-->
	                  <!--[if lte IE 6]><table><tr><td><![endif]-->
	                          <ul>
	                              <li><a href="<%=request.getContextPath()%>/jsp/Principal/StandardView.jsp" title="">Standard List</a></li>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Principal/SyllbusView.jsp" title="">Syllabus</a></li>
	                           </ul>
	                          
	                      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                  
				</li>
				<li><a href="#">Student <!--[if IE 7]><!--></a><!--<![endif]-->
	                    <!--[if lte IE 6]><table><tr><td><![endif]-->
	                            <ul>
	                                <li><a href="<%=request.getContextPath() %>/jsp/Principal/StudentReport.jsp" title="">Student List</a></li>
	                                <li><a href="<%=request.getContextPath() %>/jsp/Principal/StudentAttendanceView.jsp" title="">Student Attendance View</a></li>
	                            </ul>
	                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                    
						</li>
						<li><a href="#">Staff<!--[if IE 7]><!--></a><!--<![endif]-->
	                    <!--[if lte IE 6]><table><tr><td><![endif]-->
	                            <ul>
	                                <li><a href="<%=request.getContextPath() %>/jsp/Principal/StaffList.jsp" title="">Staff List</a></li>
	                                <li><a href="<%=request.getContextPath() %>/jsp/Principal/YearWiseStaffList.jsp" title="">Subject Allotment List</a></li>
	                                <li><a href="<%=request.getContextPath() %>/jsp/Principal/TimeTableSearch.jsp" title="">TimeTable -Standard</a></li>
	                            	<li><a href="<%=request.getContextPath() %>/jsp/Principal/TimeTableForStaff.jsp" title="">TimeTable -Staff</a></li>
	                          		<li><a href="<%=request.getContextPath() %>/jsp/Principal/FreePoolStaff.jsp" title="">FreePool -Staff</a></li>
	                            	<li><a href="<%=request.getContextPath() %>/jsp/Principal/ClassTeacherList.jsp" title="">Class Teacher List</a></li>
	                            </ul>
	                            
	                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
						</li>
				 <li><a href="#">Exam<!--[if IE 7]><!--></a><!--<![endif]-->
	                  <!--[if lte IE 6]><table><tr><td><![endif]-->
	                          <ul>
	                              <li><a href="<%=request.getContextPath()%>/jsp/Principal/ExamSchedulePublishView.jsp" title="">Exam Publish</a></li>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Principal/ExamView.jsp" title="">Exam Schedule</a></li>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/MarkEntryStaffSelect.jsp" title="">Mark Entry</a></li>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Principal/ExamResultPublish.jsp" title="">Result Publish</a></li>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Principal/ExamMarkSearch.jsp" title="">Exam Mark</a></li>                            
		                          <li><a class="sub1" href="#nogo" >Exam Mark List<!--[if IE 7]><!--></a><!--<![endif]-->
			                        <ul>
			                               <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/markTopperlist.jsp" title="">Standardwise Toppers List</a></li>
			                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/markweakerlist.jsp" title="">Standardwise Weakers List</a></li>
			                       		 	<!--  <li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/Multisubjecttopper.jsp" title="">Subjectwise Topper/Wearker List</a></li>-->
			                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/subjectmarktopperlist.jsp" title="">Subjectwise Toppers List</a></li>
			                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamMark/subjectmarkweakerlist.jsp" title="">Subjectwise Weakers List</a></li>
			                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Principal/GradeWiseStudentSearch.jsp" title="">Gradewise List</a></li>
			                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Principal/SubjectWiseStudentListSearch.jsp" title="">Subject Mark Rangewise List</a></li>
		                       		 		<li><a href="<%=request.getContextPath() %>/jsp/Principal/TotalMarkRangeStudentListSearch.jsp" title="">Total Mark Rangewise List</a></li>
		                       		 	
			                        </ul>
		                      	</li>
		                      	<li><a class="sub1" href="#nogo"> Exam Pass List <!--[if IE 7]><!--></a><!--<![endif]-->
		                      	<ul>
		    	                  	<li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamPass/standardpasslist.jsp" title="">Standwardwise Pass List</a></li>
		        	              	<li><a href="<%=request.getContextPath() %>/jsp/Exam/ExamPass/sectionpasslist.jsp" title="">Sectionwise Pass List</a></li>
                               </ul></li>
                               <li><a href="<%=request.getContextPath() %>/jsp/Principal/ExamChartView.jsp" title="">Comparison Chart</a></li>
                               
	                         </ul>
	                         
	                      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
				</li>
				
				 <li><a href="#">Fees<!--[if IE 7]><!--></a><!--<![endif]-->
	                  <!--[if lte IE 6]><table><tr><td><![endif]-->
	                          <ul>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Principal/FeesStructureSelect.jsp" title="Fees Details">Fees Structure</a></li>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Fees/PendingList_pre.jsp" title="Fees Details">Fees Report</a></li>
	                          </ul>
	                      <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                  
				</li>
				 <li><a href="#">Search<!--[if IE 7]><!--></a><!--<![endif]-->
	                    <!--[if lte IE 6]><table><tr><td><![endif]-->
	                            <ul>
	                                <!-- <li><a href="<%=request.getContextPath() %>/jsp/Student/StudentProfileView.jsp" title="">View Profile</a></li> -->
	                           
	                           
                                <li><a href="<%=request.getContextPath() %>/jsp/StudentSearch/StudentSearch.jsp" title="">Roll No Search</a></li>
                                <li><a href="<%=request.getContextPath() %>/jsp/StudentSearch/StudentSearchNameDob.jsp" title="">Student Search</a></li>
                            </ul>
	                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
	                    
						</li>
						<li><a href="#"> Activities<!--[if IE 7]><!--></a><!--<![endif]-->
	                    <!--[if lte IE 6]><table><tr><td><![endif]-->
	                            <ul>
 
                      		  
							<li><a class="sub1" href="#nogo" >Student Diary<!--[if IE 7]><!--></a><!--<![endif]-->
							<ul>
								<li><a href="<%=request.getContextPath() %>/jsp/Dairy/DairyCreation.jsp" title="">Diary Creation</a></li>
								<li><a href="<%=request.getContextPath() %>/jsp/Dairy/DiaryEvaluation.jsp" title="">Diary Evaluation</a></li>									 	
							  </ul>
							</li>
							<li><a class="sub1" href="#nogo"> Assignment <!--[if IE 7]><!--></a><!--<![endif]-->
							<ul>
                               <li><a href="<%=request.getContextPath() %>/jsp/Assignment/AssignmentCreation.jsp" title="">Assignment Topic Creation</a></li>
                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Assignment/Allocation.jsp" title="">Assignment Allocation</a></li>
                       		 	<li><a href="<%=request.getContextPath() %>/jsp/Assignment/AssignmentEvaluation.jsp" title="">Assignment Evaluation</a></li>
							</ul></li>
	                                <li><a href="<%=request.getContextPath() %>/jsp/WorkDoneRegister/WorkDoneRegisterView.jsp" title="">Work Done Register View</a></li>
	                              <li><a href="<%=request.getContextPath() %>/jsp/Principal/CurricularEventList.jsp" title="">ExtraCurricular Activity View </a></li>
	                              <li><a href="<%=request.getContextPath() %>/jsp/PhotoGallery/PhotoGalleryhmview.jsp" title="">View Gallery </a></li>
	                      		</ul>
	                        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
						</li>
						
                    <li><a href="#">Reports<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
                        
                       <!--   <li><a href="<%=request.getContextPath() %>/jsp/Reports/ReportIndex.jsp" title="">Reports</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/Reports/Reportanalysis.jsp" title="">Report Analysis</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/PDFReports/PDFReportIndex.jsp" title="">Archival Report</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/Reports/StudentAttendanceViewList.jsp" title="">Attendance Report</a></li>
                        <li><a href="<%=request.getContextPath() %>/jsp/Reports/YearwiseStaffList.jsp" title="">Subject Allotment Report</a></li>-->
                        <li><a href="<%=request.getContextPath() %>/jsp/Reports/Consolidated_pre.jsp" title="">Scheduled Report</a></li>
                        
                        
                        </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
                    						
						 <li><a href="#">General<!--[if IE 7]><!--></a><!--<![endif]-->
                    <!--[if lte IE 6]><table><tr><td><![endif]-->
                        <ul>
                         <li><a href="<%=request.getContextPath() %>/jsp/Circular/CircularEntry.jsp" title="">Circular</a></li>
                         <li><a href="<%=request.getContextPath() %>/jsp/Principal/Instituteinfo.jsp" title="">Institute Info</a></li>
                         <li><a href="<%=request.getContextPath() %>/jsp/Staff/hmchangepasswd.jsp" title="">Change Password</a></li>
                         <li><a href="<%=request.getContextPath() %>/jsp/Staff/Calendarview.jsp" title="">School Calendar</a></li>
                         </ul>
                    <!--[if lte IE 6]></td></tr></table></a><![endif]-->
                    </li>
						
			</ul>	
		<%}
		else if(loginusercategory != null && loginusercategory.equals("LA")){
		%>
		<ul>
        <li><a class="current" href="<%=request.getContextPath() %>/jsp/Library/LibraryHome.jsp" >Library Admin Home</a></li>
        <li><a href="#">Master Entries<!--[if IE 7]><!--></a><!--<![endif]-->
        <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
            <li><a href="<%=request.getContextPath() %>/jsp/Library/MasterEntries/Rack/RackEntry.jsp" title="">Rack Entry</a></li>
            <li><a href="<%=request.getContextPath() %>/jsp/Library/MasterEntries/Frequency/FrequencyEntry.jsp" title="">Frequency Entry</a></li>
            <li><a href="<%=request.getContextPath() %>/jsp/Library/MasterEntries/Access/AccessEntry.jsp" title="">Role wise Access</a></li>
            <li><a href="<%=request.getContextPath() %>/jsp/Library/MasterEntries/BookpurchaseType/BookTypeEntry.jsp" title="">Book Purchase Type</a></li>  
           </ul>
        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
        
<li><a href="#">Book / Journal<!--[if IE 7]><!--></a><!--<![endif]-->
        <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
            <li><a href="<%=request.getContextPath() %>/jsp/Library/BooksorJournal/ReceivedBook.jsp" title="">Received Books</a></li>
            <li><a href="<%=request.getContextPath() %>/jsp/Library/BooksorJournal/RackWiseSearch.jsp" title="">Rack wise Books</a></li>
            <li><a href="<%=request.getContextPath() %>/jsp/Library/BooksorJournal/NewArrivalBook.jsp" title="">New Arrival</a></li>
            <li><a href="<%=request.getContextPath() %>/jsp/Library/BooksorJournal/DateWiseBooks.jsp" title="">Date wise Book / Journal</a></li>
           
            </ul>    
        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
        <!-- - 
<li><a href="#">Book Transaction- --><!--[if IE 7]><!--></a><!--<![endif]-->
        <!--[if lte IE 6]><table><tr><td><![endif]-->
            <!-- -<ul>
            <li><a href="" title="">Book /Journal </a></li>
            <li><a href="" title="">Renewal / Return</a></li>
            <li><a href="" title="">Reservation/Cancellation</a></li>
           </ul> - -->
        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        <!-- - </li> - -->
                        
<li><a href="#">Search<!--[if IE 7]><!--></a><!--<![endif]-->
        <!--[if lte IE 6]><table><tr><td><![endif]-->
            <ul>
        <li><a href="<%=request.getContextPath() %>/jsp/Library/Search/SimpleSearch.jsp" title="">Simple Search</a></li>
         <li><a href="<%=request.getContextPath() %>/jsp/Library/Search/AdvancedSearch.jsp" title="">Advanced Search</a></li>
         <li><a href="<%=request.getContextPath() %>/jsp/Library/Search/KeywordSearch.jsp" title="">Keyword Search</a></li>
 
 <!--  <li><a href="" title="">Book Process Search</a></li>
 <li><a href="" title="">User Process Search</a></li>
 <li><a href="" title="">Book Reservation List</a></li>
 <li><a href="" title="">Students Not Utilizing Library Reports</a></li>
 <li><a href="" title="">Books Not Utilized View</a></li>
 <li><a href="" title="">Total Library Reports View</a></li>-->
     </ul>
        <!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
   <li><a href="#">Route</a></li>
<li><a href="#">Report<!--[if IE 7]><!--></a><!--<![endif]-->
	<!--[if lte IE 6]><table><tr><td><![endif]-->
    <ul>
    <li><a href="<%=request.getContextPath() %>/jsp/Library/Report/CardIssue.jsp" title="">Card Issue</a></li>
     <li><a href="<%=request.getContextPath() %>/jsp/Library/Report/BookIssue.jsp" title="">Book Issue</a></li>
      <li><a href="<%=request.getContextPath() %>/jsp/Library/Report/BookRenewal.jsp" title="">Book Renewal </a></li>
     <li><a href="<%=request.getContextPath() %>/jsp/Library/Report/BookReturn.jsp" title="">Book Return</a></li>
     <li><a href="<%=request.getContextPath() %>/jsp/Library/Report/BookReserveCancel.jsp" title="">Book Reservation/Cancellation</a></li>
     <li><a href="<%=request.getContextPath() %>/jsp/Library/Report/BookToBeReturn.jsp" title="">Books to be Returned</a></li> 
	 <li><a class="sub1" href="#nogo" >Due Date Exceeded<!--[if IE 7]><!--></a><!--<![endif]-->
	 	<ul>
			<li><a href="<%=request.getContextPath() %>/jsp/Library/Report/BookExceedDuedate.jsp" title="">Books exceeded Due Date</a></li>
			<li><a href="<%=request.getContextPath() %>/jsp/Library/Report/StdwiseBookExceedDue.jsp" title="">Standard wise Due Date Exceeded</a></li>
			<li><a href="<%=request.getContextPath() %>/jsp/Library/Report/DeptwiseBookExceedDue.jsp" title="">Department wise Due Date Exceeded</a></li>	                       		 	
		</ul>
	</li>
	<li><a class="sub1" href="#nogo" >Most / Least Access Books<!--[if IE 7]><!--></a><!--<![endif]-->
		<ul>
		<li><a href="<%=request.getContextPath() %>/jsp/Library/Report/MostAccessBooks.jsp" title="">Most Access Books</a></li>
		<li><a href="<%=request.getContextPath() %>/jsp/Library/Report/LeastAccessBooks.jsp" title="">Least Access Books</a></li>        		 	
		</ul>
	</li>
	 <li><a href="<%=request.getContextPath() %>/jsp/Library/Report/BookNotUtilize.jsp" title="">Not utilized Books</a></li>
	 <li><a href="<%=request.getContextPath() %>/jsp/Library/Report/UserNotUtil.jsp" title="">Not utilized Users</a></li>     
     </ul>
	<!--[if lte IE 6]></td></tr></table></a><![endif]-->
        </li>
         </ul>
        
         
	<%}
 }catch(Exception e){}  
	
  %></div>
  <div>
  
  <MARQUEE width=100% BEHAVIOR=SCROLL BGColor="gray" scrollamount=2 scrolldelay='2' class=tablelight onmouseover="this.stop();" onmouseout="this.start();"><font color=white>
  
  <%
  
  StringBuffer strbuf=new StringBuffer();
  	if(hflahList!=null && hflahList.size()>0)
	 	for (int i = 0; i < hflahList.size(); i++) {
 		
			java.util.HashMap hflahListMap=(java.util.HashMap)hflahList.get(i);
			strbuf.append(hflahListMap.get("flashmessage"));
		
	 	}
  out.print(strbuf.toString());
  %>
 </font></MARQUEE>
  </div>
  