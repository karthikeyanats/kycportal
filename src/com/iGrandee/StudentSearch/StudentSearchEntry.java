package com.iGrandee.StudentSearch;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.WorkDoneRegister.WorkDoneRegisterBean;

public class StudentSearchEntry {
	static Logger log = Logger.getLogger(StudentSearchEntry.class);

	public StudentSearchEntry() {

		common_data_object = new CommonDataAccess();
		insert_query = null;
		select_query = null;
		return_value = 0;
		connection = null;
		datetime = new DateTime();
	}

	public ArrayList SearchStudentProfile(String rollnom) {
		ArrayList periodsList = null;
		try {
			log
					.info("invoking search roll no from com.iGrandee.StudentSearch.StudentSearchEntry");

			select_query = "SELECT a.studentallocationid,a.candidateregisterid,a.sectionscheduleid,a.rollno,b.subject,b.workdetails,DATE_FORMAT(b.studentdiarycreateiondate, '%d-%b-%Y') as newdates FROM studentallocation a,studentdiary b where rollno='"
					+ rollnom
					+ "' and a.sectionscheduleid=b.sectionscheduleid order by b.studentdiarycreateiondate desc";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}

	public int insertwrokdonedetails(WorkDoneRegisterBean instituteBean)
			throws SQLException {
		int result = 0;

		PreparedStatement settingsprepared = null;

		try

		{
			log
					.info("invoking insert work done from com.iGrandee.StudentSearch.StudentSearchEntry");
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);

			long l = common_data_object
					.fmaxId("select max(wrokdoneregisterid)from wrokdoneregister");

			String query = "insert into wrokdoneregister (wrokdoneregisterid,lessonscheduleid,workdonedetails,dateofcreation,createdby,workdonestatus) values(?,?,?,?,?,?)";
			settingsprepared = connection.prepareStatement(query);

			settingsprepared.setLong(1, l);
			settingsprepared.setString(2, instituteBean.getLessonscheduleid());
			settingsprepared.setString(3, instituteBean.getWorkdonedetails());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5, instituteBean.getCreatedby());
			settingsprepared.setString(6, instituteBean.getWorkdonestatus());
			result = settingsprepared.executeUpdate();
			connection.commit();

		} catch (Exception exception) {

			log.error(exception);

		}

		finally {
			if (settingsprepared != null)
				settingsprepared.close();

			ConnectionManager.closeConnection(connection);

		}
		return result;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentProfileView.jsp Get
	 * getpersonidvisepersonid for HM - prasanth
	 * 
	 * @param rollnom
	 *            that can be used to get student profile details and it can be
	 *            printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public String getpersonidvisepersonid(String rollnom, String instituteid) {
		String result = "";
		try {
			log
					.info("invoking get person id from com.iGrandee.StudentSearch.StudentSearchEntry");
			result = common_data_object
					.getString("select b1.personid from studentallocation a,candidateregister b1,login b,personmaster c,institution d where a.rollno='"
							+ rollnom
							+ "' and a.studentallocationstatus='A'  and b1.candidateregisterstatus='A' and a.candidateregisterid=b1.candidateregisterid and  a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"
							+ instituteid
							+ "' and c.instituteid=d.instituteid and d.status='A'");
			// result = common_data_object.getString("select b.personid from
			// studentallocation a,candidateregister b where
			// a.rollno='"+rollnom+"' and a.studentallocationstatus='A' and
			// b.candidateregisterstatus='A' and
			// a.candidateregisterid=b.candidateregisterid");
		} catch (Exception exception) {
			log.error(exception);

		}
		return result;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentProfileView.jsp Get
	 * Studentcontactdetails for HM - prasanth
	 * 
	 * @param personid
	 *            that can be used to get student Studentcontactdetails details
	 *            and it can be printed on the screen by personid wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList Studentcontactdetails(String personid) {
		ArrayList arraylist = null;

		try {
			log
					.info("invoking student contact details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "SELECT  communicationstreet1, communicationstate, communicationcountry, communicationcity, communicationpin, permanentstreet1,permanentstate, permanentcountry, permanentcity, permanentpin,smscontactno FROM personaddress p where p.personid='"
					+ personid + "' and p.peraddstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentProfileView.jsp Get
	 * Studentguardiandetails for HM - prasanth
	 * 
	 * @param personid
	 *            that can be used to get Studentguardiandetails details and it
	 *            can be printed on the screen ]
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 * 
	 */
	public ArrayList Studentguardiandetails(String personid) {
		ArrayList arraylist = null;

		try {
			log
					.info("invoking student gurdiant details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "SELECT  guardianname, relation, self, nameoforganization, annualincome, position FROM studentguardian s where s.personid='"
					+ personid + "' and s.studentguardianstatus='A'";
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentProfileView.jsp Get
	 * Studentregisterdetails for HM - prasanth
	 * 
	 * @param personid
	 *            that can be used to get Studentregisterdetails details and it
	 *            can be printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList Studentregisterdetails(String personid) {
		ArrayList arraylist = null;

		try {
			log
					.info("invoking student registeration details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "SELECT physicallyfit, exserviceman, physicalmark, previousschoolname, previousschooladdress, mediumstudied, tc, cc, splcategory, medicalcertificate, marksheet, sportscertificate,studextracurricular,previousschoolhistory,sec.sectionname,s.standardname,ys.sessionname FROM candidateregister c,standardschedule ss,standard s,yearofsession ys,sectionschedule secs,studentallocation sa,section sec where c.personid='"
					+ personid
					+ "' and s.standardid=ss.standardid and candidateregisterstatus='A'  and  ss.standardscheduleid=c.standardscheduleid and ss.sessionid=ys.sessionid and ss.stdschedulestatus='A' and s.standardstatus='A' and ys.sessionstatus='A' and sa.candidateregisterid=c.candidateregisterid and secs.sectionscheduleid=sa.sectionscheduleid and sec.sectionid=secs.sectionid and sec.status='A' and secs.sectionschedulestatus='A' and sa.studentallocationstatus='A'";

			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentProfileView.jsp Get Student
	 * qualification details for HM - prasanth
	 * 
	 * @param personid
	 *            that can be used to get Student qualification details and it
	 *            can be printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList Studentqualificationdetails(String personid) {
		ArrayList arraylist = null;

		try {
			log
					.info("invoking student qualification details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "SELECT subject, monthandyear, registrationno, marksscored, maxmarks FROM studentqualification s where s.userid='"
					+ personid + "' and  s.studqualificationstatus='A'";
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentProfileView.jsp Get
	 * Studentaccountdetails for HM - prasanth
	 * 
	 * @param personid
	 *            that can be used to get Studentaccountdetails details and it
	 *            can be printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList Studentaccountdetails(String personid) {
		ArrayList arraylist = null;

		try {
			log
					.info("invoking student account details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "SELECT username FROM kycportal.login l where userid='"
					+ personid + "' and loginstatus='A'";
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentProfileView.jsp Get
	 * Studentpersondetails for student - prasanth
	 * 
	 * @param personid
	 *            that can be used to get Studentpersondetails details and it
	 *            can be printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList Studentpersondetails(String personid) {
		ArrayList arraylist = null;
		try {
			log
					.info("invoking student personal details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "SELECT prefix,mobilenumber,case when middlename='-' or middlename='' or middlename  is null then concat(prefix,firstname,' ',lastname) else concat(prefix,firstname,' ',middlename,' ',lastname) end as uname,firstname,middlename,lastname, fathername, mothername,DATE_FORMAT(p.dob,'%d-%b-%Y') as dob,age,sex,landlinenumber, emailid, imagepath,nationality,case when (select r.religionname from  religion r  where  r.religionid=p.religion) is null then '-' else (select r.religionname from  religion r  where  r.religionid=p.religion) end as religion,case when (select c.communityname from community c  where c.communityid=p.community) is null then '-' else  (select c.communityname from community c  where c.communityid=p.community) end as community,language,bloodgroup FROM personmaster p where personid='"
					+ personid + "' and  p.status='A'";
			arraylist = common_data_object.getListMap(select_query);
			System.out.print("select_query-->" + select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/checkRollNo.jsp
	 * This method accessed by all JSP files in kycportal/jsp/StudentSearch/ Get
	 * Student Details - prasanth
	 * 
	 * @param rollno
	 *            that can be used to get Studentpersondetails details and it
	 *            can be printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList Studentpersonminidetails(String rollno) {
		ArrayList arraylist = null;
		try {
			log
					.info("invoking student promation details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select  a.studentallocationid,h.sessionname,h.sessionid,c.standardscheduleid,b.personid,case when middlename='-' or middlename='' or middlename  is null then concat(prefix,firstname,' ',lastname) else concat(prefix,firstname,' ',middlename,' ',lastname) end as uname,c.standardid , e.sectionscheduleid,d.sectionname,f.standardname from studentallocation a,candidateregister b,standardschedule c,section d, sectionschedule e,standard f,personmaster g,yearofsession h where a.rollno='"
					+ rollno
					+ "' and a.sectionscheduleid=e.sectionscheduleid and d.sectionid=e.sectionid and e.standardscheduleid=c.standardscheduleid and c.standardid=f.standardid and b.personid=g.personid and  c.sessionid=h.sessionid and a.studentallocationstatus='A'  and b.candidateregisterstatus='A' and c.stdschedulestatus='A' and a.candidateregisterid=b.candidateregisterid and d.status='A' and e.sectionschedulestatus='A' and f.standardstatus='A' and g.status='A' and h.sessionstatus='A'";
			/*
			 * select_query = "select
			 * a.studentallocationid,h.sessionname,h.sessionid,c.standardscheduleid,b.personid,case
			 * when middlename='-' or middlename='' or middlename is null then
			 * concat(prefix,firstname,' ',lastname) else
			 * concat(prefix,firstname,' ',middlename,' ',lastname) end as
			 * uname,c.standardid ,
			 * e.sectionscheduleid,d.sectionname,f.standardname from
			 * studentallocation a,candidateregister b,standardschedule
			 * c,section d, sectionschedule e,standard f,personmaster
			 * g,yearofsession h,login b1,personmaster c1,institution d1 where
			 * a.rollno='" + rollno + "' and
			 * a.sectionscheduleid=e.sectionscheduleid and
			 * d.sectionid=e.sectionid and
			 * e.standardscheduleid=c.standardscheduleid and
			 * c.standardid=f.standardid and b.personid=g.personid and
			 * c.sessionid=h.sessionid and a.studentallocationstatus='A' and
			 * b.candidateregisterstatus='A' and c.stdschedulestatus='A' and
			 * a.candidateregisterid=b.candidateregisterid and d.status='A' and
			 * e.sectionschedulestatus='A' and f.standardstatus='A' and
			 * g.status='A' and h.sessionstatus='A'and a.createdby=b1.userid and
			 * b1.loginstatus='A' and b1.personid=c1.personid and c1.status='A'
			 * and c1.instituteid='1' and c1.instituteid=d1.instituteid and
			 * d1.status='A'";
			 */

			log.info(select_query);
			// System.out.print("select_query-->" + select_query);
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	public ArrayList Studentpersonminidetails(String rollno, String sessionid) {
		ArrayList arraylist = null;
		try {
			log
					.info("invoking student promation details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select  a.studentallocationid,h.sessionname,h.sessionid,c.standardscheduleid,b.personid,case when middlename='-' or middlename='' or middlename  is null then concat(prefix,firstname,' ',lastname) else concat(prefix,firstname,' ',middlename,' ',lastname) end as uname,c.standardid , e.sectionscheduleid,d.sectionname,f.standardname,(select groupname from standardgroup x where x.groupid=c.groupid and x.groupstatus='A') as groupname  from studentallocation a,candidateregister b,standardschedule c,section d, sectionschedule e,standard f,personmaster g,yearofsession h where a.rollno='"
					+ rollno
					+ "' and a.sectionscheduleid=e.sectionscheduleid and d.sectionid=e.sectionid and e.standardscheduleid=c.standardscheduleid and c.standardid=f.standardid and b.personid=g.personid and  c.sessionid=h.sessionid and a.studentallocationstatus='A'  and b.candidateregisterstatus='A' and c.stdschedulestatus='A' and a.candidateregisterid=b.candidateregisterid and d.status='A' and e.sectionschedulestatus='A' and f.standardstatus='A' and g.status='A' and h.sessionstatus='A' and h.sessionid='"
					+ sessionid + "'";
			// System.out.print("select_query-->"+select_query);
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/HomePage.jsp
	 * This method accessed by all JSP files in kycportal/jsp/StudentSearch/ Get
	 * standardscheduleid roleno wise - prasanth
	 * 
	 * @param rollno
	 *            that can be used to get getstandardscheduleid details and it
	 *            can be printed on the screen by rollno wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList getstandardscheduleid(String rollno) {
		ArrayList result = null;
		try {
			log
					.info("invoking Get standardscheduleid  roleno wise from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select a.standardscheduleid,c.sessionid from sectionschedule a,studentallocation b,standardschedule c where a.sectionscheduleid=b.sectionscheduleid and b.rollno='"
					+ rollno
					+ "' and a.sectionschedulestatus='A' and b.studentallocationstatus='A' and c.standardscheduleid=a.standardscheduleid";
			result = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);

		}
		return result;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/HomePage.jsp
	 * This method accessed by all JSP files in kycportal/jsp/StudentSearch/ Get
	 * sectionname Name Details - prasanth
	 * 
	 * @param sectionid
	 *            that can be used to get getsectionname details and it can be
	 *            printed on the screen by sectionid wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList getsectionname(String sectionid) {
		ArrayList arraylist = null;
		try {
			log
					.info("invoking student session name details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select sectionname from section where sectionid='"
					+ sectionid + "'";
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/HomePage.jsp
	 * This method accessed by all JSP files in kycportal/jsp/StudentSearch/ Get
	 * Standard Name Details - prasanth
	 * 
	 * @param standardid
	 *            that can be used to get getstandatdname details and it can be
	 *            printed on the screen by standardid wise
	 * 
	 * return ArrayList by which result can be printed on the screen
	 */
	public ArrayList getstandatdname(String standardid) {
		ArrayList arraylist = null;
		try {
			log
					.info("invoking standard name details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select standardname from standard where standardid='"
					+ standardid + "'";
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/StudentDiary.jsp
	 * Get NoofAlloteddiary for student - prasanth
	 * 
	 * @param studentid
	 *            that can be used to get NoofAlloteddiary details and it can be
	 *            printed on the screen by studentid wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList NoofAlloteddiary(String studentid) {
		ArrayList arraylist = null;
		try {
			log
					.info("invoking no alloted diarydetails from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select case when  (date_format(a.dairysubmissiondate,'%d-%m-%Y') <date_format(b.studentreplydate,'%d-%m-%Y')) then 'delayed' when b.studentreplydate is null then 'delayed'  else   'ontime' end as diarystate, a.dairysubmissiondate, b.studentreplydate,b.studentdiaryremarks from studentdiary a,diaryreply b where b.studentid='"
					+ studentid
					+ "' and a.studentdiaryid=b.studentdiaryid and a.studentdiarystatus='A'group by a.studentdiaryid";
			System.out.println("NoofAlloteddiary>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/ListDiary.jsp
	 * This method accessed by all JSP files in kycportal/jsp/StudentSearch/ Get
	 * getStudentId - prasanth
	 * 
	 * @param getStudentId
	 *            that can be used to get NoofAlloteddiary details and it can be
	 *            printed on the screen by rollno wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList getStudentId(String rollno) {
		ArrayList arraylist = null;
		try {
			log
					.info("invoking get student id  from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select distinct b.studentid from studentallocation a,diaryreply b where a.rollno='"
					+ rollno
					+ "' and a.studentallocationid=b.studentid and a.studentallocationstatus='A' and b.dairyreplystatus='A'";
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}

	public ArrayList loadScheduledStandardSubjectsforexammark(
			String standardscheduleid) {
		log
				.info("Invoking loadScheduledStandardSubjects() for Load the Scheduled Subjects based on standard scheduleid from com.iGrandee.StudentSearch.StudentSearchEntry");
		ArrayList periodsList = null;
		try {
			select_query = "select b.subjectname,a.subjectscheduleid,a.subjectid,c.examscheduleid from subjectschedule a,subject b,examschedule c where a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and a.subjectscheduleid=c.subjectscheduleid and a.standardscheduleid='"
					+ standardscheduleid + "'";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}

	public ArrayList loadScheduledStandardSubjectsforexam(
			String standardscheduleid, String examnameid) {
		log
				.info("Invoking loadScheduledStandardSubjectsexam() for Load the Scheduled Subjects based on standard scheduleid from com.iGrandee.StudentSearch.StudentSearchEntry");
		ArrayList periodsList = null;
		try {

			select_query = "select a.subjectscheduleid as examsubscheduleid,c.subjectscheduleid,d.subjectname,d.subjectid,d.standardid,date_format(examdate,'%d-%b-%Y') as examdate,a.examtimein,a.examtimeout,b.examallotmentid from examallotment b,examschedule a right outer join subjectschedule c on c.subjectscheduleid=a.subjectscheduleid join subject d where c.subjectid=d.subjectid  and b.standardscheduleid='"
					+ standardscheduleid
					+ "' and examnameid='"
					+ examnameid
					+ "' and  b.standardscheduleid=c.standardscheduleid and d.subjectstatus='A'   and c.status='A' and b.examallotmentstatus='A'";
			log.info(select_query);
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}

	public ArrayList LoadExamnameList(String sessionid) {
		ArrayList boardList = new ArrayList();
		try {
			log
					.info("invokingexam list details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select a.examnameid,a.examname,b.sessionid from examname a, yearofsession b where a.sessionid=b.sessionid and a.instituteid=b.instituteid and  a.sessionid='"
					+ sessionid
					+ "' and a.examnamestatus='A' and b.sessionstatus='A'";
			boardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/studentprogressReport.jsp Get student
	 * listmark for HM - prasanth
	 * 
	 * @param standardscheduleid,instituteid,rollno
	 *            that can be used to get listmark details and it can be printed
	 *            on the screen by standardscheduleid,instituteid,rollno wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList listmark(String standardscheduleid, String rollno,
			String studentallocationid) {
		ArrayList arraylist = null;

		try {

			/*
			 * select_query = "SELECT distinct * FROM examname en" +" join
			 * examallotment ea on en.examnameid=ea.examnameid and
			 * ea.standardscheduleid='"+standardscheduleid+"'" +" and
			 * ea.examallotmentstatus='A'" +" join subjectschedule ss on
			 * ea.standardscheduleid=ss.standardscheduleid and ss.status='A'" +"
			 * join subject sub on sub.subjectid=ss.subjectid and
			 * sub.subjectstatus='A'" +" left outer join examschedule es on
			 * es.subjectscheduleid=ss.subjectscheduleid" +" and
			 * es.examallotmentid=ea.examallotmentid and es.exampublishstatus
			 * ='R'" +" and es.markpublishstatus ='R' and es.examschedulestatus
			 * ='R'" +" right outer join exammark e on
			 * e.examscheduleid=es.examscheduleid and
			 * e.studentallocationid='"+studentallocationid+"'";
			 */

			select_query = "SELECT distinct en.examnameid,en.examname,ss.subjectscheduleid,e.marktaken,ss.theoryexternalmin FROM examname en"

					+ " join examallotment ea on  en.examnameid=ea.examnameid and ea.standardscheduleid='"
					+ standardscheduleid
					+ "'"
					+ " and ea.examallotmentstatus='A'"
					+ " join subjectschedule ss  on ea.standardscheduleid=ss.standardscheduleid and ss.status='A'"
					+ " join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'"
					+ " left outer join examschedule es on  es.subjectscheduleid=ss.subjectscheduleid"
					+ " and es.examallotmentid=ea.examallotmentid and es.exampublishstatus ='R'"
					+ " and  es.markpublishstatus ='R'  and es.examschedulestatus ='R'"
					+ " right outer join  exammark e on e.examscheduleid=es.examscheduleid and e.studentallocationid='"
					+ studentallocationid + "'";

			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/studentprogressReport.jsp Get grade for
	 * student - prasanth
	 * 
	 * @param sessionid
	 *            that can be used to get grrade details and it can be printed
	 *            on the screen by sessionid wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList LoadGradeList(String sessionid) {
		log.info("Invoking LoadScheduledExamList() based on the staff");
		ArrayList academicList = null;
		try {
			select_query = "select gradesystemid, gradename, cast(rangefrom as signed) as rangefrom, rangeto FROM gradesystem where gradesystemstatus='A' and sessionid='"
					+ sessionid + "' order by rangefrom asc";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/studentprogressReport.jsp Get student student
	 * subject schedule ID for HM - prasanth
	 * 
	 * @param standardscheduleid
	 *            that can be used to get subjectname details and it can be
	 *            printed on the screen by standardscheduleid wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList newStandardSubjectSchedule(String standardscheduleid) {
		ArrayList boardList = new ArrayList();
		try {
			log
					.info("invoking student subject schedule details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select a.subjectscheduleid,b.subjectname from subjectschedule a,subject b where a.standardscheduleid='"
					+ standardscheduleid
					+ "' and a.subjectid=b.subjectid and b.subjectstatus='A' and a.status='A' order by subjectscheduleid asc;";
			boardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	public ArrayList LoadExamnMarkList(String examnameid,
			String subjectscheduleid, String rollno) {
		ArrayList boardList = new ArrayList();
		try {
			log
					.info("invoking student exam mark list details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select a.marktaken from exammark a,examallotment b,examschedule c,studentallocation d where b.examnameid='"
					+ examnameid
					+ "' and c.subjectscheduleid='"
					+ subjectscheduleid
					+ "' and a.examscheduleid=c.examscheduleid and b.examallotmentid=c.examallotmentid and d.studentallocationid=a.studentallocationid and d.rollno='"
					+ rollno + "'";
			boardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/ListDiary.jsp
	 * Get getAlldiary - prasanth
	 * 
	 * @param studentid
	 *            that can be used to get getAllalloteddiary details and it can
	 *            be printed on the screen by studentid wise
	 * 
	 * @param flag
	 *            that can be used to get getAllalloteddiary details and it can
	 *            be printed on the screen by studentid wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	
	
	public ArrayList getAllalloteddiarynew(String studentid,String sectionscheduleid, String flag) {
		ArrayList arraylist = null;
		try {
			log
					.info("invoking student  diary details from com.iGrandee.StudentSearch.StudentSearchEntry");
			if (flag.equals("alloted")) {
							
			//	select_query = "select a.studentdiaryid,a.subject,b.studentdiaryremarks,DATE_FORMAT(b.studentreplydate, '%d-%b-%Y') as stureplydate,b.staffdiaryremarks,DATE_FORMAT(b.staffdiaryreplydate, '%d-%b-%Y') as stafreplydate,b.parentremarks,DATE_FORMAT(b.parentdate, '%d-%b-%Y') as parentreplydate,b.replythrough,b.notificationstatus from studentdiary a left outer join  diaryreply b on a.studentdiaryid=b.studentdiaryid  and b.studentid='"+studentid+"' where a.sectionscheduleid='"+sectionscheduleid+"'";
				select_query = "select 	(select concat(c1.prefix,' ',c1.firstname,' ',case when c1.middlename is null or c1.middlename='' then '' else c1.middlename end,c1.lastname) from login a1,  staffmaster b1,personmaster c1 where a1.userid=a.createdby and a1.userid=b1.userid and c1.personid=a1.personid) as staffname,a.createdby, d.subjectname,c.subjectid,a.subjectscheduleid,a.createdby,a.studentdiaryid,a.subject,b.studentdiaryremarks,DATE_FORMAT(b.studentreplydate, '%d-%b-%Y') as stureplydate,b.staffdiaryremarks,DATE_FORMAT(b.staffdiaryreplydate, '%d-%b-%Y') as stafreplydate,b.parentremarks,DATE_FORMAT(b.parentdate, '%d-%b-%Y') as parentreplydate,b.replythrough,b.notificationstatus  from  subject d,subjectschedule c,studentdiary a left outer join  diaryreply b on a.studentdiaryid=b.studentdiaryid   and b.studentid='"+studentid+"' where  a.sectionscheduleid='"+sectionscheduleid+"' and a.studentdiarystatus='A' and c.subjectscheduleid=a.subjectscheduleid and c.status='A' and c.subjectid=d.subjectid and d.subjectstatus='A' order by a.subjectscheduleid,a.createdby";

			} else if (flag.equals("ontime")) {
			
				select_query = "select c.subjectscheduleid,d.subjectname,a.subject,a.workdetails,b.studentdiaryremarks,DATE_FORMAT(b.studentreplydate, '%d-%b-%Y') as stureplydate,b.staffdiaryremarks,DATE_FORMAT(b.staffdiaryreplydate, '%d-%b-%Y') as stafreplydate,b.parentremarks,DATE_FORMAT(b.parentdate, '%d-%b-%Y') as parentreplydate,b.parentremarks,(select concat(c1.prefix,' ',c1.firstname,' ',case when c1.middlename is null or c1.middlename='' then '' else c1.middlename end,c1.lastname) from login a1, staffmaster b1,personmaster c1 where a1.userid=a.createdby and a1.userid=b1.userid and c1.personid=a1.personid) as staffname,a.createdby from studentdiary a,diaryreply b,subjectschedule c,subject d where b.studentid='"
						+ studentid
						+ "' and (date_format(a.dairysubmissiondate,'%d-%m-%Y') >= date_format(b.studentreplydate,'%d-%m-%Y')) and b.studentdiaryid=a.studentdiaryid and a.subjectscheduleid=c.subjectscheduleid and c.subjectid=d.subjectid and a.studentdiarystatus='A' and b.dairyreplystatus='A' order by c.subjectscheduleid,a.createdby";
			} else {
				
				select_query = "select c.subjectscheduleid,d.subjectname,a.subject,a.workdetails,b.studentdiaryremarks,DATE_FORMAT(b.studentreplydate, '%d-%b-%Y') as stureplydate, b.staffdiaryremarks,DATE_FORMAT(b.staffdiaryreplydate, '%d-%b-%Y') as stafreplydate,b.parentremarks,DATE_FORMAT(b.parentdate, '%d-%b-%Y') as parentreplydate,b.parentremarks,(select concat(c1.prefix,' ',c1.firstname,' ',case when c1.middlename is null or c1.middlename='' then '' else c1.middlename end,c1.lastname) from login a1, staffmaster b1,personmaster c1 where a1.userid=a.createdby and a1.userid=b1.userid and c1.personid=a1.personid) as staffname,a.createdby from studentdiary a,diaryreply b,subjectschedule c,subject d where b.studentid='"
						+ studentid
						+ "' and 'delayed'=(select case when  (date_format(a.dairysubmissiondate,'%d-%m-%Y') < date_format(b.studentreplydate,'%d-%m-%Y')) then 'delayed' when b.studentreplydate is null then 'delayed'  else   'ontime' end) and b.studentdiaryid=a.studentdiaryid  and a.subjectscheduleid=c.subjectscheduleid and c.subjectid=d.subjectid and a.studentdiarystatus='A' and b.dairyreplystatus='A' order by c.subjectscheduleid,a.createdby";
			}
			 System.out.print("Newselect_query-->"+select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	
	
	public ArrayList getAllalloteddiary(String studentid, String flag) {
		ArrayList arraylist = null;
		try {
			log
					.info("invoking student  diary details from com.iGrandee.StudentSearch.StudentSearchEntry");
			if (flag.equals("alloted")) {
				// select_query = " select
				// a.subject,a.workdetails,c.studentdiaryremarks,DATE_FORMAT(c.studentreplydate,
				// '%d-%b-%Y') as
				// stureplydate,c.staffdiaryremarks,DATE_FORMAT(c.staffdiaryreplydate,
				// '%d-%b-%Y') as stafreplydate,c.parentremarks,
				// DATE_FORMAT(c.parentdate, '%d-%b-%Y') as
				// parentreplydate,c.parentremarks from studentdiary
				// a,diaryreply c where c.studentid='"+studentid+"' and
				// c.studentdiaryid=a.studentdiaryid and
				// a.studentdiarystatus='A'";
				select_query = "select c.subjectscheduleid,d.subjectname,a.subject,a.workdetails,b.studentdiaryremarks,DATE_FORMAT(b.studentreplydate, '%d-%b-%Y') as stureplydate,b.staffdiaryremarks,DATE_FORMAT(b.staffdiaryreplydate, '%d-%b-%Y') as stafreplydate,b.parentremarks,DATE_FORMAT(b.parentdate, '%d-%b-%Y') as parentreplydate,b.parentremarks,(select concat(c1.prefix,' ',c1.firstname,' ',case when c1.middlename is null or c1.middlename='' then '' else c1.middlename end,c1.lastname) from login a1, staffmaster b1,personmaster c1 where a1.userid=a.createdby and a1.userid=b1.userid and c1.personid=a1.personid) as staffname,a.createdby from studentdiary a,diaryreply b,subjectschedule c,subject d where b.studentid='"
						+ studentid
						+ "' and  b.studentdiaryid=a.studentdiaryid and a.subjectscheduleid=c.subjectscheduleid and c.subjectid=d.subjectid and a.studentdiarystatus='A' and b.dairyreplystatus='A' order by c.subjectscheduleid,a.createdby";
				
				//select_query = "select a.studentdiaryid,a.subject,b.studentdiaryremarks,DATE_FORMAT(b.studentreplydate, '%d-%b-%Y') as stureplydate,b.staffdiaryremarks,DATE_FORMAT(b.staffdiaryreplydate, '%d-%b-%Y') as stafreplydate,b.parentremarks,DATE_FORMAT(b.parentdate, '%d-%b-%Y') as parentreplydate,b.replythrough,b.notificationstatus from studentdiary a left outer join  diaryreply b on a.studentdiaryid=b.studentdiaryid  and b.studentid='"+studentid+"' where a.sectionscheduleid='"+sectionscheduleid+"'";

			} else if (flag.equals("ontime")) {
				// select_query = " select
				// a.subject,a.workdetails,c.studentdiaryremarks,DATE_FORMAT(c.studentreplydate,
				// '%d-%b-%Y') as
				// stureplydate,c.staffdiaryremarks,DATE_FORMAT(c.staffdiaryreplydate,
				// '%d-%b-%Y') as stafreplydate,c.parentremarks,
				// DATE_FORMAT(c.parentdate, '%d-%b-%Y') as
				// parentreplydate,c.parentremarks from studentdiary
				// a,diaryreply c where c.studentid='"+studentid+"' and
				// (date_format(a.dairysubmissiondate,'%d-%m-%Y')
				// =date_format(c.studentreplydate,'%d-%m-%Y')) and
				// c.studentdiaryid=a.studentdiaryid and
				// a.studentdiarystatus='A'";
				select_query = "select c.subjectscheduleid,d.subjectname,a.subject,a.workdetails,b.studentdiaryremarks,DATE_FORMAT(b.studentreplydate, '%d-%b-%Y') as stureplydate,b.staffdiaryremarks,DATE_FORMAT(b.staffdiaryreplydate, '%d-%b-%Y') as stafreplydate,b.parentremarks,DATE_FORMAT(b.parentdate, '%d-%b-%Y') as parentreplydate,b.parentremarks,(select concat(c1.prefix,' ',c1.firstname,' ',case when c1.middlename is null or c1.middlename='' then '' else c1.middlename end,c1.lastname) from login a1, staffmaster b1,personmaster c1 where a1.userid=a.createdby and a1.userid=b1.userid and c1.personid=a1.personid) as staffname,a.createdby from studentdiary a,diaryreply b,subjectschedule c,subject d where b.studentid='"
						+ studentid
						+ "' and (date_format(a.dairysubmissiondate,'%d-%m-%Y') >= date_format(b.studentreplydate,'%d-%m-%Y')) and b.studentdiaryid=a.studentdiaryid and a.subjectscheduleid=c.subjectscheduleid and c.subjectid=d.subjectid and a.studentdiarystatus='A' and b.dairyreplystatus='A' order by c.subjectscheduleid,a.createdby";
			} else {
				// select_query = " select
				// a.subject,a.workdetails,c.studentdiaryremarks,DATE_FORMAT(c.studentreplydate,
				// '%d-%b-%Y') as stureplydate,
				// c.staffdiaryremarks,DATE_FORMAT(c.staffdiaryreplydate,
				// '%d-%b-%Y') as stafreplydate,c.parentremarks,
				// DATE_FORMAT(c.parentdate, '%d-%b-%Y') as
				// parentreplydate,c.parentremarks from studentdiary
				// a,diaryreply c where c.studentid='"+studentid+"' and
				// 'delayed'=(select case when
				// (date_format(a.dairysubmissiondate,'%d-%m-%Y')
				// <date_format(c.studentreplydate,'%d-%m-%Y')) then 'delayed'
				// when c.studentreplydate is null then 'delayed' else 'ontime'
				// end) and c.studentdiaryid=a.studentdiaryid and
				// a.studentdiarystatus='A'";
				select_query = "select c.subjectscheduleid,d.subjectname,a.subject,a.workdetails,b.studentdiaryremarks,DATE_FORMAT(b.studentreplydate, '%d-%b-%Y') as stureplydate, b.staffdiaryremarks,DATE_FORMAT(b.staffdiaryreplydate, '%d-%b-%Y') as stafreplydate,b.parentremarks,DATE_FORMAT(b.parentdate, '%d-%b-%Y') as parentreplydate,b.parentremarks,(select concat(c1.prefix,' ',c1.firstname,' ',case when c1.middlename is null or c1.middlename='' then '' else c1.middlename end,c1.lastname) from login a1, staffmaster b1,personmaster c1 where a1.userid=a.createdby and a1.userid=b1.userid and c1.personid=a1.personid) as staffname,a.createdby from studentdiary a,diaryreply b,subjectschedule c,subject d where b.studentid='"
						+ studentid
						+ "' and 'delayed'=(select case when  (date_format(a.dairysubmissiondate,'%d-%m-%Y') < date_format(b.studentreplydate,'%d-%m-%Y')) then 'delayed' when b.studentreplydate is null then 'delayed'  else   'ontime' end) and b.studentdiaryid=a.studentdiaryid  and a.subjectscheduleid=c.subjectscheduleid and c.subjectid=d.subjectid and a.studentdiarystatus='A' and b.dairyreplystatus='A' order by c.subjectscheduleid,a.createdby";
			}
			 System.out.print("select_query-->"+select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/studentFees.jsp
	 * Get checkandLoadStudent - prasanth
	 * 
	 * @param rollnumber
	 *            that can be used to check and LoadStudent fees details and it
	 *            can be printed on the screen
	 * 
	 * @param instituteid
	 *            that can be used to check and LoadStudent fees details and it
	 *            can be printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList checkandLoadStudent(String rollnumber, String instituteid) {
		ArrayList arraylist = new ArrayList();
		try {
			log
					.info("invoking check load student  details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid and x.instituteid='"
					+ instituteid
					+ "') as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"
					+ rollnumber
					+ "' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A'  AND f.instituteid='"
					+ instituteid + "' and f.instituteid=g.instituteid";
			log.info(select_query);
			System.out.print("select_query-->" + select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/studentFees.jsp
	 * Get paidTermFeesDetails for student - prasanth
	 * 
	 * @param termfeesid,
	 *            that can be used to get student paidTermFeesDetails details
	 *            and it can be printed on the screen
	 * 
	 * @param studentapprovalid
	 *            that can be used to get student paidTermFeesDetails details
	 *            and it can be printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public String paidTermFeesDetails(String termfeesid,
			String studentapprovalid) {
		String returnStr = null;
		try {
			log
					.info("invoking student paid fees term details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select sum(collectionamount) as paidamount from feescollection where termfeesid='"
					+ termfeesid
					+ "' and studentapprovalid='"
					+ studentapprovalid + "' and feescollectionstatus='A'";
			log.info(select_query);
			returnStr = common_data_object.getString(select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return returnStr;
	}

	public ArrayList loadscholarship(String instituteid) {
		ArrayList arraylist = new ArrayList();
		try {
			log
					.info("invoking student scholarship details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "SELECT scholarshipid, scholarshipname, scholarshipdescription FROM scholarship where scholarshipstatus='A' and instituteid='"
					+ instituteid + "';";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/studentFees.jsp
	 * Get loadTermFeesDetails for student - prasanth
	 * 
	 * @param standardscheduleid
	 *            that can be used to get student loadTermFeesDetails details
	 *            and it can be printed on the screen by standardscheduleid wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList loadTermFeesDetails(String standardscheduleid) {
		ArrayList arraylist = new ArrayList();
		try {
			log
					.info("invoking student fees term details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select b.termname,b.termid,a.termfeesid,a.termfeesamount from termfees a,feestermname b where a.termid=b.termid and a.standardscheduleid='"
					+ standardscheduleid + "' and termfeesstatus='A'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/studentFees.jsp
	 * Get studentFeesCollectionDetails for student - prasanth
	 * 
	 * @param standardscheduleid
	 *            that can be used to get student loadTermFeesDetails details
	 *            and it can be printed on the screen
	 * 
	 * @param instituteid
	 *            that can be used to get student loadTermFeesDetails details
	 *            and it can be printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList studentFeesCollectionDetails(String studentallocationid,
			String instituteid) {
		ArrayList arraylist = new ArrayList();
		try {
			log
					.info("invoking student fees collection details from com.iGrandee.StudentSearch.StudentSearchEntry");

			// select_query="select
			// a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%m-%Y')
			// as
			// dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%m-%Y
			// %r') as
			// feescollectiondate,a.feescollectionstatus,d.scholarshipname,a.paymenttype
			// from feescollection a,termfees b,feestermname c,scholarship
			// d,studentallocation e,candidateregister f where
			// e.studentallocationid='"+studentallocationid+"' and
			// d.instituteid='"+instituteid+"' and
			// e.candidateregisterid=f.candidateregisterid and
			// a.studentapprovalid=f.studentapprovalid and
			// a.termfeesid=b.termfeesid and c.termid=b.termid and
			// d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A'
			// order by c.termid";;
			select_query = "select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%m-%Y')as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%m-%Y %r')as feescollectiondate,a.feescollectionstatus,d.scholarshipname,a.paymenttype from feescollection a join termfees b on a.termfeesid=b.termfeesid join feestermname c on c.termid=b.termid join studentallocation e on e.studentallocationid='"
					+ studentallocationid
					+ "'  join candidateregister f on e.candidateregisterid=f.candidateregisterid and a.studentapprovalid=f.studentapprovalid left outer join scholarship d on d.instituteid='"
					+ instituteid
					+ "' and d.scholarshipid = a.scholarshipid  and d.scholarshipstatus='A' order by c.termid";

			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception e) {
			log.error(e);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/StudentEvent.jsp
	 * Get listEventstudentdetails for student - prasanth
	 * 
	 * @param studentallocationid
	 *            that can be used to get student student list details details
	 *            and it can be printed on the screen by studentallocationid
	 *            wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList listEventstudentdetails(String studentallocationid) {
		ArrayList arraylist = new ArrayList();
		try {
			log
					.info("invoking student list details from com.iGrandee.StudentSearch.StudentSearchEntry");
			// select_query = "SELECT
			// c.venu,ec.extcurricularcategoryname,e.awarddetails,c.curriculareventname,date_format(c.eventdate,'%d-%M-%Y')
			// as eventdate FROM eventparticipants e,curricularevent
			// c,extracurricularcategory ec where
			// e.studentallocationid='"+studentallocationid+"' and
			// e.curriculareventid=c.curriculareventid and
			// c.extracurricularcategoryid=ec.extracurricularcategoryid and
			// ec.curricularstatus='A' and c.eventstatus='A' and
			// e.eventparticipantstatus='A'";

			select_query = "SELECT c.venu,ec.extracurricularname,e.awarddetails,c.curriculareventname,date_format(c.eventdate,'%d-%M-%Y') as eventdate FROM eventparticipants e,curricularevent c,extracurricularactivity ec where e.studentallocationid='"
					+ studentallocationid
					+ "'and e.curriculareventid=c.curriculareventid and c.extracurricularactivityid=ec.extracurricularactivityid and ec.extracurricularstatus='A' and c.eventstatus='A' and e.eventparticipantstatus='A'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentAttendance.jsp Get start,end date -
	 * prasanth
	 * 
	 * @param standardscheduleid
	 *            that can be used to get student start,end date details and it
	 *            can be printed on the screen by standardscheduleid wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList getseendate(String standardscheduleid) {
		ArrayList arraylist = new ArrayList();
		try {
			log
					.info("Get start,end date from com.iGrandee.StudentSearch.StudentSearchEntry");

			select_query = "select standardscheduleid,standardid,startdate,enddate,sessionid, date_format(startdate,'%d-%M-%Y') as sdate,date_format(enddate,'%d-%M-%Y') as edate from standardschedule where standardscheduleid='"
					+ standardscheduleid + "' and stdschedulestatus='A'";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentAttendance.jsp Get getAttendance in
	 * between start,end dates - prasanth
	 * 
	 * @param sdate
	 *            that can be used to get Attendance details and it can be
	 *            printed on the screen
	 * 
	 * @param edate
	 *            that can be used to get Attendance details and it can be
	 *            printed on the screen
	 * 
	 * @param rollno
	 *            that can be used to get Attendance details and it can be
	 *            printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList getAttendance(String sdate, String edate, String rollno) {
		ArrayList arraylist = new ArrayList();
		try {
			log
					.info("invoking student attandance details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select a.studentstate,a.studentallocationid,a.studentattendanceid from studentattendance a,studentallocation b where a.attendancedate between '"
					+ sdate
					+ "' and '"
					+ edate
					+ "' and a.studentattendancestatus='A' and b.rollno='"
					+ rollno
					+ "' and b.studentallocationid=a.studentallocationid and b.studentallocationstatus='A'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentAttendance.jsp Get
	 * TotalNoofDaysForStudent in between start,end dates - prasanth
	 * 
	 * @param sdate
	 *            that can be used to get TotalNoofDaysForStudent and it can be
	 *            printed on the screen
	 * 
	 * @param edate
	 *            that can be used to get TotalNoofDaysForStudent and it can be
	 *            printed on the screen
	 * 
	 * @return String by which result can be printed on the screen
	 */
	public String TotalNoofDaysForStudent(String sdate, String edate) {
		String returnStr = null;
		try {
			log
					.info("invoking student no od days for stud details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "select DATEDIFF('" + edate + "','" + sdate
					+ "') as totalnodays";
			System.out.println(select_query);
			returnStr = common_data_object.getString(select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return returnStr;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/StudentAttendance.jsp Get getTotalHolidays in
	 * between start,end dates - prasanth
	 * 
	 * @param sdate
	 *            that can be used to get getTotalHolidays and it can be printed
	 *            on the screen
	 * 
	 * @param edate
	 *            that can be used to get getTotalHolidays and it can be printed
	 *            on the screen
	 * 
	 * @param instituteid
	 *            that can be used to get getTotalHolidays and it can be printed
	 *            on the screen
	 * 
	 * @param sessionid
	 *            that can be used to get getTotalHolidays and it can be printed
	 *            on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList getTotalHolidays(String sessionid, String sdate,
			String edate, String instituteid) {
		ArrayList arraylist = new ArrayList();
		try {
			log
					.info("invoking student no of leave days for stud details from com.iGrandee.StudentSearch.StudentSearchEntry");
			select_query = "SELECT a.schoolcalendarid,a.sessionid,a.holidaystatus FROM schoolcalendar a,standardschedule b where a.sessionid='"
					+ sessionid
					+ "' and a.calendarstatus='A' and b.instituteid='"
					+ instituteid
					+ "' AND b.sessionid=a.sessionid and b.startdate >= '"
					+ sdate
					+ "'  and    b.enddate<= '"
					+ edate
					+ "' and b.stdschedulestatus='A'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return arraylist;
	}
	
	
	
	public ArrayList getTotalHolidaysnew(String sessionid, String sdate,
			String edate, String instituteid,String standardscheduleid) {
		ArrayList arraylist = new ArrayList();
		try {
			select_query = "SELECT a.schoolcalendarid,a.sessionid,a.holidaystatus  FROM schoolcalendar a,standardschedule b where a.sessionid='"+sessionid+"' and a.calendarstatus='A'  and b.instituteid='"+instituteid+"' AND b.sessionid=a.sessionid  and a.eventdate  between '"+sdate+"'  and  '"+edate+"'  and b.stdschedulestatus='A' and b.standardscheduleid='"+standardscheduleid+"'";
			System.out.println(select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception e) {
			log.error("",e);
		}
		return arraylist;
	}
	
	public ArrayList getTotalHolidays(String sessionid, String sdate,
			String edate, String instituteid,String standardscheduleid) {
		ArrayList arraylist = new ArrayList();
		try {
			select_query = "SELECT a.schoolcalendarid,a.sessionid,a.holidaystatus  FROM schoolcalendar a,standardschedule b where a.sessionid='"+sessionid+"' and a.calendarstatus='A'  and b.instituteid='"+instituteid+"' AND b.sessionid=a.sessionid  and b.startdate >= '"+sdate+"'  and    b.enddate<= '"+edate+"'  and b.stdschedulestatus='A' and b.standardscheduleid='"+standardscheduleid+"'";
			System.out.println(select_query);
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception e) {
			log.error("",e);
		}
		return arraylist;
	}
	
	

	/**
	 * This method is accessed from
	 * kycportal/jsp/StudentSearch/Studentassignment.jsp Get getStudentId -
	 * prasanth
	 * 
	 * @param studentid
	 *            that can be used to get loadAssignmentViewForStudent and it
	 *            can be printed on the screen
	 * 
	 * @param sessionid
	 *            that can be used to get loadAssignmentViewForStudent and it
	 *            can be printed on the screen
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList loadAssignmentViewForStudent(String sectionid,
			String studentid) {
		log
				.info("invoking loadAssignmentViewForStudent from from com.iGrandee.StudentSearch.StudentSearchEntry");

		ArrayList periodsList = null;
		try {
			// select_query = "select
			// g.questionid,subjectname,lessonname,questionname,g.mark as
			// questionmark, g.file as
			// questionfile,date_format(h.assignmentdate,'%d-%b-%Y') as
			// assignmentdate, date_format(h.submissiondate,'%d-%b-%Y') as
			// submissiondate, i.studentremarks,facultyremarks,
			// date_format(studentdate,'%d-%b-%Y') as studentdate,
			// date_format(facultydate,'%d-%b-%Y') as facultydate,i.file,
			// i.mark, c.subjectscheduleid,concat(k.firstname,' ',k.lastname) as
			// staffname, e.lessonscheduleid from sectionschedule a join
			// standardschedule b on a.sectionscheduleid='"+sectionid+"' and
			// a.standardscheduleid=b.standardscheduleid and
			// a.sectionschedulestatus='A' and b.stdschedulestatus='A' join
			// subjectschedule c on b.standardscheduleid=c.standardscheduleid
			// and c.status='A' join subject d on c.subjectid=d.subjectid and
			// d.subjectstatus='A' join lessonschedule e on
			// c.subjectscheduleid=e.subjectscheduleid and e.status='A' join
			// lesson f on e.lessonid=f.lessonid and f.lessonstatus='A' join
			// assignmentmaster h on find_in_set('"+studentid+"',h.studentids)
			// join assignemntquestion g on
			// e.lessonscheduleid=g.lessonscheduleid and g.status='A' and
			// g.questionid=h.questionid left outer join assignmenttracking i on
			// h.assignmentid = i.assignmentid and i.studentid='"+studentid+"'
			// left outer join login j on j.userid=g.createdby and
			// j.loginstatus='A' left outer join personmaster k on
			// j.personid=k.personid";
			// new query
			select_query = "select subjectname,lessonname,questionname,g.mark as questionmark, g. file as questionfile,date_format(h.assignmentdate,'%d-%b-%Y') as assignmentdate, date_format(h.submissiondate,'%d-%b-%Y') as submissiondate, i.studentremarks,h.assignmentid, facultyremarks, date_format(studentdate,'%d-%b-%Y') as studentdate, date_format(facultydate,'%d-%b-%Y') as facultydate,i.file,i.mark, c.subjectscheduleid,concat(k.firstname,' ',k.lastname) as staffname, e.lessonscheduleid from sectionschedule a join standardschedule b on a.sectionscheduleid='"
					+ sectionid
					+ "' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' join lessonschedule e on c.subjectscheduleid=e.subjectscheduleid and e.status='A' join lesson f on e.lessonid=f.lessonid and f.lessonstatus='A' left outer join assignemntquestion g on e.lessonscheduleid=g.lessonscheduleid and g.status='A' left outer join assignmentmaster h on find_in_set('"
					+ studentid
					+ "',h.studentids) and g.questionid=h.questionid  left outer join assignmenttracking i on h.assignmentid = i.assignmentid  and i.studentid='"
					+ studentid
					+ "' left outer join login j on j.userid=g.createdby  and j.loginstatus='A' left outer join personmaster k on j.personid=k.personid";

			periodsList = common_data_object.getListMap(select_query);
			// System.out.println(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/HomePage.jsp
	 * This method accessed by all JSP files in kycportal/jsp/StudentSearch/ Get
	 * getYearOfSession Details - prasanth
	 * 
	 * @param standardscheduleid
	 *            that can be used to get getYearOfSession and it can be printed
	 *            on the screen by standardscheduleid wise
	 * 
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList getYearOfSession(String standardscheduleid) {
		log
				.info("invoking year of session from com.iGrandee.StudentSearch.StudentSearchEntry");

		ArrayList periodsList = null;
		try {
			select_query = "select a.sessionid,b.sessionname from standardschedule a,yearofsession b where a.standardscheduleid='"
					+ standardscheduleid
					+ "' and a.sessionid=b.sessionid and b.sessionstatus='A' and a.stdschedulestatus='A'";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	public ArrayList ListstaffDetailsForStudent(String sectionscheduleid) {
		log
				.info("invoking list staff details from com.iGrandee.StudentSearch.StudentSearchEntry");

		ArrayList periodsList = null;
		try {
			select_query = "select case when middlename='-' or middlename='' or middlename  is null then concat(prefix,f.firstname,' ',f.lastname) else concat(prefix,f.firstname,' ',f.middlename,' ',f.lastname) end as uname,f.mobilenumber,f.emailid,f.imagepath,f.qualification, g.subjectname,a.staffid,b.staffcategoryid,a.subjectscheduleid,d.standardscheduleid, e.personid,h.subjectypename from subjectallotment a,staffmaster b,staffcategory c,login e,personmaster f,subjectschedule d, subject g left outer join subjecttype h on g.subjecttypeid=h.subjecttypeid and h.subjecttypestatus='A' where a.sectionpublishid='"
					+ sectionscheduleid
					+ "' and a.subjectallotmentstatus='A' and b.staffid=a.staffid and b.staffstatus='A'  and c.staffcategoryid=b.staffcategoryid and c.staffcategorystatus='A' and e.userid=b.userid and e.loginstatus='A' and f.personid=e.personid and f.status='A' and d.subjectscheduleid=a.subjectscheduleid and d.status='A' and g.subjectid=d.subjectid and g.subjectstatus='A'";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	public ArrayList ListSyllabusForStudent(String standardscheduleid) {
		log
				.info("invoking SyllabusForStudent from com.iGrandee.StudentSearch.StudentSearchEntry");
		ArrayList periodsList = null;
		try {
			select_query = "select c.subjectid,c.subjectname,c.subjectcode,d.subjectypename,b.theoryinternalmin,b.theoryinternalmax, b.theoryexternalmin,b.theoryexternalmax from standardschedule a, subjectschedule b ,subject c,subjecttype d where a.standardscheduleid='"
					+ standardscheduleid
					+ "' and a.stdschedulestatus='A' and a.standardscheduleid=b.standardscheduleid and b.status='A' and b.subjectid=c.subjectid and c.subjectstatus='A' and d.subjecttypeid=c.subjecttypeid and d.subjecttypestatus='A'";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	public ArrayList ListLessionForStudent(String subjectid) {
		log
				.info("invoking ListLessionForStudent from com.iGrandee.StudentSearch.StudentSearchEntry");
		ArrayList periodsList = null;
		try {
			select_query = "select lessonname,lessondescription from lesson where subjectid='"
					+ subjectid + "' and lessonstatus='A';";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	public ArrayList gradefinalquery() {
		log
				.info("invoking ListLessionForStudent from com.iGrandee.StudentSearch.StudentSearchEntry");

		ArrayList periodsList = null;
		try {
			select_query = "select rangefrom,rangeto,gradename from gradesystem where gradesystemstatus='A'";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	/**
	 * This method is accessed from kycportal/jsp/StudentSearch/checkRollNo.jsp
	 * Check Roll present or not - prasanth
	 * 
	 * @param tablename
	 *            that can be used to get getYearOfSession and it can be printed
	 *            on the screen
	 * 
	 * @param columnname
	 *            that can be used to get getYearOfSession and it can be printed
	 *            on the screen
	 * 
	 * @param fieldname
	 *            that can be used to get getYearOfSession and it can be printed
	 *            on the screen
	 * 
	 * @return boolean by which result can be printed on the screen
	 */
	public boolean checkDuplicate(String tablename, String columnname,
			String fieldname) {
		boolean return_flag = false;
		String return_string = null;
		try {
			log
					.info("invoking duplicate from com.iGrandee.StudentSearch.StudentSearchEntry");

			String select_query = "select " + columnname + " from " + tablename
					+ " where " + columnname + "='" + fieldname
					+ "' and  studentallocationstatus='A' ";
			return_string = common_data_object.getString(select_query);

			if (return_string == null || return_string.equalsIgnoreCase("null")
					|| return_string.equals("")) {
				return_flag = false;
			} else {
				return_flag = true;
			}

		} catch (Exception e) {
			log.error(e);
		}
		return return_flag;
	}

	// access from jsp/StudentSearch/checkRollNo.jsp
	// created by subhash to check the roll no institute wise
	public boolean checkDuplicate(String tablename, String columnname,
			String fieldname, String instituteid) {
		boolean return_flag = false;
		String return_string = null;
		try {
			log
					.info("invoking duplicate from com.iGrandee.StudentSearch.StudentSearchEntry");

			String select_query = "select a."
					+ columnname
					+ " from "
					+ tablename
					+ " a,personmaster b,institution c,sectionschedule d,standardschedule e,yearofsession f where a."
					+ columnname
					+ "='"
					+ fieldname
					+ "' and  a.studentallocationstatus='A' and a.createdby=b.personid and b.instituteid=c.instituteid and b.instituteid='"
					+ instituteid
					+ "' and d.sectionscheduleid=a.sectionscheduleid and e.standardscheduleid=d.standardscheduleid and e.sessionid=f.sessionid and f.sessionstatus='A'";
			return_string = common_data_object.getString(select_query);
			log.info("select_query : " + select_query);
		//	System.out.println("select_query : " + select_query);
			if (return_string == null || return_string.equalsIgnoreCase("null")
					|| return_string.equals("")) {
				return_flag = false;
			} else {
				return_flag = true;
			}

		} catch (Exception e) {
			log.error("",e);
		}
		return return_flag;
	}

	public ArrayList loadExtrcurricularProfileView(String extraids) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT extracurricularname FROM extracurricularactivity  where find_in_set(extracurricularactivityid,'"
					+ extraids + "') and extracurricularstatus='A'";
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public int getcountalloteddiary(String rollno) {
	int result=0;
	try{
		
		select_query="select count(b.studentdiaryid) from studentallocation a, studentdiary b where a.rollno='"+rollno+"' and a.sectionscheduleid=b.sectionscheduleid and " +
		"a.studentallocationstatus='A' and b.studentdiarystatus='A'";
		result=Integer.parseInt(common_data_object.getString(select_query));
	}
	catch (Exception e) {
		
		e.printStackTrace();
	}
	return result;
	}	
	CommonDataAccess common_data_object;
	
	String insert_query;
	String select_query;
	int return_value;
	int[] returnvalue;
	Connection connection;
	DateTime datetime;

}
