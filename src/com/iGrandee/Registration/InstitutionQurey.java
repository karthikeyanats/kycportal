package com.iGrandee.Registration;

import java.util.ArrayList;
import java.util.HashMap;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.DateTime;

import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Prinicipal.PrinicipalQuery;

// Referenced classes of package com.iGrandee.Common:
//            CommonDataAccess

public class InstitutionQurey {
	static Logger log = Logger.getLogger(InstitutionQurey.class);

	public InstitutionQurey() {
		common_data_object = new CommonDataAccess();
		select_query = null;
		}

	public int checkUser(String s, String s1) {
		int i = 0;
		try {
			ArrayList arraylist = null;
			select_query = "select * from login where username='" + s + "'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info(arraylist);
			if (arraylist != null && arraylist.size() > 0) {
				i = 1;
			}
			select_query = null;
		} catch (Exception exception) {
		}
		return i;
	}
	/*
	 * This method is accessed from kycportal/jsp/Registration/SchoolRegistration.jsp.jsp
	 * Created by         - Maruthu
	 */
	/**
	 * This Method is Used to Get Max InstituteId
	 * @param  none
     * @return  max instituteid 
	*/
	public long maxinstituteid() {
		long max_addressid = 0;
		try {
			log.info(select_query);
			 max_addressid = common_data_object.fmaxId("select max(instituteid) from institution");
			
		} catch (Exception exception) {
		}
		return max_addressid;
	}
	/**
	 * This method is accessed from kycportal/jsp/Registration/ProfileInfo.jsp
	 * This method is accessed from kycportal/jsp/Registration/SchoolInformationUpdate.jsp
	 * List  active Institute Profile          - prasanth
	  @param  instituteid that can be used to get all institution details from  nstitution table by instituteid wise
      @return  ArrayList by which result can be printed on the screen
	*/
	public ArrayList getInstituteDetails(String instituteid)
	{
		
			ArrayList academicList = null;
			try
			{log.info("Invoke List  active Institute Profile from com.iGrandee.Registration.InstitutionQurey");
				select_query  	= "select a.city,a.zip,a.institutename,a.contactaddress,a.country,a.state,a.landlinenumber,a.mobilenumber,emailid,a.fax,a.institutelogo,a.url from institution a where a.status='A' and a.instituteid='"+instituteid+"'"; 
				academicList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
							
				log.error(exception);	
			}
			return academicList;
	}
	/**
	 * This method is accessed from kycportal/jsp/Registration/SchoolInformationSubmit.jsp
	 * School Information Update (Institute Profile )         - prasanth
	  @param  institutename that can be used to update institute details to institution table
	  *
     @param contactaddress that can be used to update institute details to institution table
     *
     @param country that can be used to update institute details to institution table
     *
     @param state that can be used to update institute details to institution table
     *
     @param landlinenumber that can be used to update institute details to institution table
     *
     @param emailid that can be used to update institute details to institution table
     *
     @param url that can be used to update institute details to institution table
     *
     @param ipaddress that can be used to update institute details to institution table
     *
     @param fax that can be used to update institute details to institution table
     *
     @param institutelogo that can be used to update institute details to institution table
     *
     @param dateofcreation that can be used to update institute details to institution table
     *
     @param mobilenumber that can be used to update institute details to institution table
     *
     @param ipaddress that can be used to update institute details to institution table
     *

      @return  int by which result can be printed on the screen
	*/
	public int SchoolInformationUpdate(InstitutionBean beanobj) throws SQLException
	{
		int result = 0;
		PreparedStatement pstmt = null;

		String Query = "";
		Connection connection = null;
		try {
			log.info("School Information Update Institute Profile from com.iGrandee.Registration.InstitutionQurey");
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String txt_school_name = beanobj.getSchool_name();
			String txt_street1 = beanobj.gettxt_street1();
			String txt_city = beanobj.gettxt_city();
			String txt_zip = beanobj.gettxt_zip();
			
			String slt_country = beanobj.getslt_country();
			String slt_state = beanobj.getslt_state();
			String txt_contact = beanobj.gettxt_contact();
			String txt_mail = beanobj.gettxt_mail();
			String txt_web = beanobj.gettxt_web();
			String hid_photo = beanobj.gethid_photo();
			String ipaddress = beanobj.getipaddress();
			String txt_mobile = beanobj.gettxt_mobile();
			String txt_fax = beanobj.gettxt_fax();
			String instituteid=beanobj.getinstitutionid();
			String photo=beanobj.getPhoto();
			String mobilenumber=beanobj.gettxt_mobile();
			String ipadress=beanobj.getipaddress();  
			Query = "update institution set institutename=?,contactaddress=?,country=?,state=?,landlinenumber=?,emailid=?,url=?,ipaddress=?,fax=?,institutelogo=?,dateofcreation=?,mobilenumber=?,ipaddress=?,city=?,zip=? where instituteid=?";
			pstmt = connection.prepareStatement(Query);
			pstmt.setString(1, txt_school_name);
			pstmt.setString(2, txt_street1);
			pstmt.setString(3, slt_country);
			pstmt.setString(4, slt_state);
			pstmt.setString(5, txt_contact);
			pstmt.setString(6, txt_mail);
			pstmt.setString(7, txt_web);
			pstmt.setString(8, ipaddress);
			pstmt.setString(9, txt_fax);
			pstmt.setString(10, photo);
			pstmt.setString(11, datetime.showTime("databaseinsert"));
			pstmt.setString(12, mobilenumber);
			pstmt.setString(13, ipadress);
			pstmt.setString(14, txt_city);
			pstmt.setString(15, txt_zip);
			pstmt.setString(16, instituteid);

			result += pstmt.executeUpdate();
			connection.commit();
		}
	 catch (Exception exception)
	 {		
		 log.error("",exception);

		 return 0;

	} finally
	{
		if (pstmt != null)
			pstmt.close();


		

		if (connection != null)
			connection.close();
	}
		return result;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/SchoolRegistrationSubmit.jsp
	 * Insert  School Details For Registration
	 * Used  by maruthu
	 */
	public int SchoolRegistration(InstitutionBean beanobj) throws SQLException {
		log.info("School Registration  from com.iGrandee.Registration.InstitutionQurey");

		int result = 0;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null;
		PreparedStatement pstmt6 = null;
		PreparedStatement pstmt7 = null;
		PreparedStatement pstmt8 = null;
		PreparedStatement pstmt9 = null;
		PreparedStatement pstmt10 = null;
		PreparedStatement pstmt11 = null;
		PreparedStatement pstmt12 = null;

		


		String Query = "";
		Connection connection = null;

		try {
			if(common_data_object.checkDuplicate("login", "username", beanobj.gettxt_username()))
			{
				result=1000;
			}
			else
			{
			long max_addressid = common_data_object.fmaxId("select max(addressid) from personaddress");

			long max_instituteid = common_data_object
					.fmaxId("SELECT max(instituteid) FROM institution");
			long max_institutelogid = common_data_object
					.fmaxId("SELECT max(institutionlogid) FROM institutionlog");

			long max_userid = common_data_object
					.fmaxId("select max(userid) from login");

			long max_personid = common_data_object
					.fmaxId("select max(personid) from personmaster");
			long max_departmentid = common_data_object
			.fmaxId("select max(departmentid) from department");
			long max_departmentlogid = common_data_object
			.fmaxId("select max(departmentlogid) from departmentlog");
			long max_roleid = common_data_object
			.fmaxId("select max(roleid) from role");
			long max_rolelogid = common_data_object
			.fmaxId("select max(rolelogid) from rolelog");
			long max_staffcategoryid = common_data_object
			.fmaxId("select max(staffcategoryid) from staffcategory");
			long max_staffcategoryidfirst = common_data_object
			.fmaxId("select max(staffcategoryid) from staffcategory");
			
			long max_staffid = common_data_object
			.fmaxId("select max(staffid) from staffmaster");
			
			long max_stafflogid = common_data_object
			.fmaxId("select max(stafflogid) from staffmasterlog");
			
			long max_staffextraid = common_data_object
			.fmaxId("select max(staffextraid) from staffextraactivity");
			//log.info(max_personid + "================"	+ max_instituteid);
			//log.info(beanobj.gettxt_street2()+ "===============gettxt_street2");


			String txt_school_name = beanobj.getSchool_name();
			String txt_street1 = beanobj.gettxt_street1();
			String txt_street2 = beanobj.gettxt_street2();
			String txt_city = beanobj.gettxt_city();
			String slt_country = beanobj.getslt_country();
			String slt_state = beanobj.getslt_state();
			String txt_zip = beanobj.gettxt_zip();
			String txt_contact = beanobj.gettxt_contact();
			String txt_mail = beanobj.gettxt_mail();
			String txt_web = beanobj.gettxt_web();
			String txt_fname = beanobj.gettxt_fname();
			String txt_mname = beanobj.gettxt_mname();
			String txt_lname = beanobj.gettxt_lname();
			String slt_prefix = beanobj.getslt_prefix();
			String txt_street_admin = beanobj.gettxt_street_admin();
			String txt_city_admin = beanobj.gettxt_city_admin();
			String slt_country_admin = beanobj.getslt_country_admin();
			String slt_state_admin = beanobj.getslt_state_admin();
			String txt_mail_admin = beanobj.gettxt_mail_admin();
			String txt_dob = beanobj.gettxt_dob();
			String slt_sex = beanobj.getslt_sex();
			String txt_qualification = beanobj.gettxt_qualification();
			String txt_username = beanobj.gettxt_username();
			String txt_answer = beanobj.gettxt_answer();
			String slt_hint = beanobj.getslt_hint();
			String txt_passward = beanobj.gettxt_passward();
			String hid_photo = beanobj.gethid_photo();
			String hid_photo1 = beanobj.getHid_photo2();

			String txt_mobile_admin = beanobj.gettxt_mobile_admin();
			String txt_zip_admin = beanobj.gettxt_zip_admin();
			String txt_contact_admin = beanobj.gettxt_contact_admin();
			String ipaddress = beanobj.getipaddress();
			String txt_mobile = beanobj.gettxt_mobile();
			String txt_fax = beanobj.gettxt_fax();
			String institutionmode = beanobj.getinstitutionmode();

			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);

			Query = "insert into institution(instituteid, institutename, contactaddress, country, state, landlinenumber, mobilenumber, emailid, url, dateofcreation, ipaddress, fax, status,institutionmode,institutelogo,currencytype,city,zip,hint,answer) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt1 = connection.prepareStatement(Query);
			pstmt1.setLong(1, max_instituteid);
			pstmt1.setString(2, txt_school_name);
			pstmt1.setString(3, txt_street1);
			pstmt1.setString(4, slt_country);
			pstmt1.setString(5, slt_state);
			pstmt1.setString(6, txt_mobile);
			pstmt1.setString(7, txt_contact);
			pstmt1.setString(8, txt_mail);
			pstmt1.setString(9, txt_web);
			pstmt1.setString(10, DateTime.showTime("databaseinsert"));
			pstmt1.setString(11, ipaddress);
			pstmt1.setString(12, txt_fax);
			pstmt1.setString(13, "A");
			pstmt1.setString(14, institutionmode);
			pstmt1.setString(15, hid_photo);
			pstmt1.setString(16, beanobj.getCurrencytype());
			pstmt1.setString(17, txt_city);
			pstmt1.setString(18, txt_zip);
			pstmt1.setString(19, slt_hint);
			pstmt1.setString(20, txt_answer);
			
			
			
			result += pstmt1.executeUpdate();

			Query = "insert into institutionlog(institutionlogid, institutionid, logstatus, dateofcreation, status) values(?,?,?,?,?)";
			pstmt2 = connection.prepareStatement(Query);
			pstmt2.setLong(1, max_institutelogid);
			pstmt2.setLong(2, max_instituteid);
			pstmt2.setString(3, "A");
			pstmt2.setString(4, DateTime.showTime("databaseinsert"));
			pstmt2.setString(5, "A");
			result += pstmt2.executeUpdate();
			
			
			
			// connection = ConnectionManager.getKycConnection();
			Query = "insert into personmaster(personid,firstname, middlename, lastname, sex, dob, street1, street2, city, state, country, postalcode, landlinenumber, mobilenumber, emailid, imagepath, dateofcreation, createdby, ipaddress, instituteid, status,prefix,qualification,age) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = connection.prepareStatement(Query);
			pstmt.setLong(1, max_personid);
			pstmt.setString(2, txt_fname);
			pstmt.setString(3, txt_mname);
			pstmt.setString(4, txt_lname);
			pstmt.setString(5, slt_sex);
			pstmt.setString(6, txt_dob);
			pstmt.setString(7, txt_street2);
			pstmt.setString(8, txt_street_admin);
			pstmt.setString(9, txt_city_admin);
			pstmt.setString(10, slt_state_admin);
			pstmt.setString(11, slt_country_admin);
			pstmt.setString(12, txt_zip_admin);
			pstmt.setString(13, txt_contact_admin);
			pstmt.setString(14, txt_mobile_admin);
			pstmt.setString(15, txt_mail_admin);
			pstmt.setString(16, hid_photo1);
			pstmt.setString(17, datetime.showTime("databaseinsert"));
			pstmt.setLong(18, max_userid);
			pstmt.setString(19, ipaddress);
			pstmt.setLong(20, max_instituteid);
			pstmt.setString(21, "A");
			pstmt.setString(22, slt_prefix);
			pstmt.setString(23, txt_qualification);
			pstmt.setString(24, beanobj.getAge());

			

			result += pstmt.executeUpdate();

			Query = "insert into personaddress(addressid, personid, communicationstreet1, communicationstreet2, communicationstate, communicationcountry, communicationcity, communicationpin, permanentstreet1, permanentstreet2, permanentstate, permanentcountry, permanentcity, permanentpin, dateofcreation, createdby, peraddstatus) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt11 = connection.prepareStatement(Query);
			pstmt11.setLong(1, max_addressid);
			pstmt11.setLong(2, max_userid);
			pstmt11.setString(3, txt_street2);
			pstmt11.setString(4, txt_street_admin);
			pstmt11.setString(5, slt_state_admin);
			pstmt11.setString(6, slt_country_admin);
			pstmt11.setString(7, txt_city_admin);
			pstmt11.setString(8, txt_zip_admin);
			pstmt11.setString(9, txt_street2);
			pstmt11.setString(10, txt_street_admin);
			pstmt11.setString(11, slt_state_admin);
			pstmt11.setString(12, slt_country_admin);
			pstmt11.setString(13, txt_city_admin);
			pstmt11.setString(14, txt_zip_admin);
			pstmt11.setString(15, datetime.showTime("databaseinsert"));
			pstmt11.setLong(16, max_userid);
			pstmt11.setString(17, "A");
			result += pstmt11.executeUpdate();
			
			
			Query = "insert into login(userid, username, password, usercategory, personid, dateofcreation, createdby, ipaddress, loginstatus) values(?,?,?,?,?,?,?,?,?)";
			pstmt3 = connection.prepareStatement(Query);
			pstmt3.setLong(1, max_userid);
			pstmt3.setString(2, txt_username);
			String usrpassword 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(txt_passward);
			pstmt3.setString(3, usrpassword);
			if(institutionmode.equals("MA"))
	    	   {
				pstmt3.setString(4, "MA");
	    	   }
			else
			{
				pstmt3.setString(4, "SA");

			}
			pstmt3.setLong(5, max_personid);
			pstmt3.setString(6, datetime.showTime("databaseinsert"));
			pstmt3.setString(7, "1");
			pstmt3.setString(8, ipaddress);
			pstmt3.setString(9, "A");

			result += pstmt3.executeUpdate();
			
			Query = "insert into department(departmentid, departmentname, description, dateofcreation, createdby, instituteid, ipaddress, status) values(?,?,?,?,?,?,?,?)";
			pstmt4 = connection.prepareStatement(Query);
			pstmt4.setLong(1, max_departmentid);
			pstmt4.setString(2, "Administration");
			pstmt4.setString(3, "Administration");
			pstmt4.setString(4, datetime.showTime("databaseinsert"));
			pstmt4.setLong(5, max_userid);
			pstmt4.setLong(6, max_instituteid);
			pstmt4.setString(7, ipaddress);
			pstmt4.setString(8, "A");
			result += pstmt4.executeUpdate();

			Query = "insert into departmentlog(departmentlogid, departmentid, logstatus, dateofcreation, deptlogstatus, createdby) values(?,?,?,?,?,?)";
			pstmt5 = connection.prepareStatement(Query);
			pstmt5.setLong(1, max_departmentlogid);
			pstmt5.setLong(2,max_departmentid);
			pstmt5.setString(3, "Created");
			pstmt5.setString(4, datetime.showTime("databaseinsert"));
			pstmt5.setString(5, "A");
			pstmt5.setLong(6, max_userid);
			
			result += pstmt5.executeUpdate();
			
			Query = "insert into role(roleid, rolename, description, instituteid, dateofcreation, status) values(?,?,?,?,?,?)";
			pstmt6 = connection.prepareStatement(Query);
			pstmt6.setLong(1, max_roleid);
			pstmt6.setString(2, "Administrator");
			pstmt6.setString(3, "Administrator");
			pstmt6.setLong(4, max_instituteid);
			pstmt6.setString(5, datetime.showTime("databaseinsert"));
			pstmt6.setString(6, "A");
			
			result += pstmt6.executeUpdate();

			Query = "insert into rolelog(rolelogid, rolelog, logstatus, dateofcreation, rolelogstatus, createdby) values(?,?,?,?,?,?)";
			pstmt7 = connection.prepareStatement(Query);
			pstmt7.setLong(1, max_rolelogid);
			pstmt7.setLong(2,max_roleid);
			pstmt7.setString(3, "Created");
			pstmt7.setString(4, datetime.showTime("databaseinsert"));
			pstmt7.setString(5, "A");
			pstmt7.setLong(6,max_userid);
			
			result += pstmt7.executeUpdate();
			String [] staffcategoryid={"Non Teaching","Teaching","Headmaster","Library Administrator","Student","Financiar"};
			for(int x=0;x<staffcategoryid.length;x++)
			{
			Query = "insert into staffcategory(staffcategoryid, categoryname, instituteid, createdby, dateofcreation, staffcategorystatus) values(?,?,?,?,?,?)";
			pstmt8 = connection.prepareStatement(Query);
			pstmt8.setLong(1, max_staffcategoryid);
			pstmt8.setString(2,staffcategoryid[x]);
			pstmt8.setLong(3, max_instituteid);
			pstmt8.setLong(4, max_userid);
			pstmt8.setString(5, datetime.showTime("databaseinsert"));
			pstmt8.setString(6, "A");
			result += pstmt8.executeUpdate();
			max_staffcategoryid++;
		 }
			
			Query = "insert into staffmaster(staffid, departmentid, roleid, dateofjoin, createdby, dateofcreation, ipaddress, userid, staffstatus, staffcategoryid) values(?,?,?,?,?,?,?,?,?,?)";
			pstmt9 = connection.prepareStatement(Query);
			pstmt9.setLong(1, max_staffid);
			pstmt9.setLong(2, max_departmentid);
			pstmt9.setLong(3, max_roleid);
			pstmt9.setString(4, datetime.showTime("databaseinsert"));
			pstmt9.setLong(5, max_userid);
			pstmt9.setString(6, datetime.showTime("databaseinsert"));
			pstmt9.setString(7, ipaddress);
			pstmt9.setLong(8, max_userid);
			pstmt9.setString(9, "A");
			pstmt9.setLong(10, max_staffcategoryidfirst);
			
			result += pstmt9.executeUpdate();
			
			Query = "insert into staffmasterlog(stafflogid, staffid, roleid, dateofcreation, stafflogdetail, createdby, ipaddress, stafflogstatus) values(?,?,?,?,?,?,?,?)";
			pstmt10 = connection.prepareStatement(Query);
			pstmt10.setLong(1, max_stafflogid);
			pstmt10.setLong(2, max_staffid);
			pstmt10.setLong(3, max_roleid);
			pstmt10.setString(4, datetime.showTime("databaseinsert"));
			pstmt10.setString(5, "Created");
			pstmt10.setLong(6, max_userid);
			pstmt10.setString(7, ipaddress);
			pstmt10.setString(8, "A"); 
     		result += pstmt10.executeUpdate();
			Query = "insert into staffextraactivity(staffextraid, areaofinterest, publications, userid, createdby, dateofcreation, ipaddress, staffextrastatus) values(?,?,?,?,?,?,?,?)";
			pstmt12 = connection.prepareStatement(Query);
			pstmt12.setLong(1, max_staffextraid);
			pstmt12.setString(2, "-");
			pstmt12.setString(3, "-");
			pstmt12.setLong(4, max_userid);
			pstmt12.setLong(5, max_userid);
			pstmt12.setString(6, datetime.showTime("databaseinsert"));
			pstmt12.setString(7, ipaddress);
			pstmt12.setString(8, "A");
	
			result += pstmt12.executeUpdate();
			
			connection.commit();
			}
		} catch (Exception exception) {
			log.error(exception);
			connection.rollback();
			return 0;
		} finally {
			if (pstmt != null)
				pstmt.close();

			if (pstmt1 != null)
				pstmt1.close();

			if (pstmt2 != null)
				pstmt2.close();

			if (pstmt3 != null)
				pstmt3.close();
			
			if (pstmt4 != null)
				pstmt4.close();

			if (pstmt5 != null)
				pstmt5.close();

			if (pstmt6 != null)
				pstmt6.close();
			
			if (pstmt7 != null)
				pstmt7.close();

			if (pstmt8 != null)
				pstmt8.close();
			
			if (pstmt9 != null)
				pstmt9.close();

			if (pstmt10 != null)
				pstmt10.close();
			
			if (pstmt11 != null)
				pstmt11.close();
			
			if (pstmt12 != null)
				pstmt12.close();

			if (connection != null)
				connection.close();
		}

		return result;
	}

	/**
	 * list the forgot password requested list
	 */
	
	public ArrayList listForgotPasswordRequest(String instituteid,String usertstate)
	{
		
			ArrayList forgotList = null;
			try
			{log.info("Invoke List  active listForgotPasswordRequest");
			if(usertstate.equals("others"))
			{
				select_query  	= "select a.forgotpassid, a.username, a.email, date_format(a.dateofrequest,'%d-%b-%Y %r') as dateofrequest , a.userid, a.status, a.requestedby,c.password from forgotpassword a,login c,personmaster b where a.userid=c.userid and b.personid=c.personid and b.instituteid='"+instituteid+"'  and a.requestedby='others' order by a.dateofrequest desc"; 
				log.info(select_query);
				forgotList 	= common_data_object.getListMap(select_query);
			}
			else if(usertstate.equals("parent"))
			{
				select_query  	= "select a.forgotpassid, a.username, a.email, date_format(a.dateofrequest,'%d-%b-%Y %r') as dateofrequest , a.userid, a.status, a.requestedby,d.parentpassword as password from forgotpassword a,login c,personmaster b,parentlogin d where a.username=d.parentusername and a.userid=c.userid and b.personid=c.personid and b.instituteid='"+instituteid+"' and a.requestedby='parent' order by a.dateofrequest desc"; 
				log.info(select_query);
				forgotList 	= common_data_object.getListMap(select_query);
			}
			}
			
			catch(Exception exception) { 
							
				log.error(exception);	
			}
			return forgotList;
	}
	
	/**
	 * This method is accessed from jsp/SuperAdmin/SuperAdminPage.jsp
	 * 	 @return ArrayList by which result printed on the screen
	 * Created by Subhash
	 */ 
	public ArrayList listInstitution()
	{
		log.info("invoking listInstitution to list all institution");
		ArrayList instituteList = new ArrayList();
		String currdate = "";
		try
		{
			String query = "SELECT instituteid,institutename FROM institution i where institutionmode='SSP' and status='A'";
			//System.out.println("query-->"+query);
			instituteList = common_data_object.getListMap(query);
		}catch(Exception e){log.error(e);}
		return instituteList;
	}	
	
	CommonDataAccess common_data_object;
	DateTime datetime;

	String select_query;
	
}