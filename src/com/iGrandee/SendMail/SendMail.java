
package com.iGrandee.SendMail;

import java.util.ArrayList;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.iGrandee.Registration.StaffRegistrationBean;
import com.iGrandee.Registration.StudentRegistrationBean;



 public class SendMail{
		static Logger log = Logger.getLogger(SendMail.class);

   
    String USER = null;
	String PASSWORD= null;
	String fromMailId = null;
	String passWord = null;


	public SendMail()
		{
		USER 		= null;
		PASSWORD 	= null;

		}
	/**
	  * This method is accessed from kycportal/forgotsubmit.jsp
	  * send password details to corresponding person mail   - prasanth
	  * @param to that can be used to send mail to  corresponding person mail
	  * 
      @param  from that can be used to send mail to  corresponding person mail
      *
      @param  msgContent that can be used to send mail to  corresponding person mail
      *
      @param subject that can be used to send mail to  corresponding person mail
      *
      @param cc that can be used to send mail to  corresponding person mail
	 */
	public void send(String to,String from,String msgContent,String subject,String cc){
		try{
			log.info("invoking sendmail from com.iGrandee.SendMail.SendMail");

			ResourceBundle rb = ResourceBundle.getBundle("resources.smtp");
			String HOST		=	rb.getString("smttp_name");
			String PORT		=	rb.getString("smttp_port");
			fromMailId 		= 	rb.getString("from_mail");
			passWord 		= 	rb.getString("mail_pwd");
			String networktype = rb.getString("networktype");
			
			
			Properties props = new Properties();
	        props.put("mail.smtp.user", fromMailId);
			props.put("mail.smtp.host", HOST);
			props.put("mail.smtp.port", PORT);
	        System.out.print("networktype11-->"+networktype);
	        
	        if(networktype!=null && networktype.equals("internet")){
	            props.put("mail.smtp.starttls.enable","true");
	            props.put("mail.smtp.debug", "true");
	            props.put("mail.smtp.socketFactory.port", PORT);
	        	System.out.print("networktype3 inside if-->"+networktype);
	        	props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
	            props.put("mail.smtp.socketFactory.fallback", "false");
	            props.put("mail.smtp.auth", "true");
	        }

	        
			
			Authenticator auth = new SMTPAuthenticator();
			
			Session session = Session.getInstance(props, auth);
			session.setDebug(true);

			MimeMessage message = new MimeMessage(session);
			message.setSubject("Password Request");
			message.setContent(getMailContent(subject,msgContent,from,to),"text/html");
 			message.setFrom(new InternetAddress(fromMailId));
 			if(cc.equals(""))
 			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
			}
			else
			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
 			message.setRecipients(RecipientType.CC,  InternetAddress.parse((to+","+cc), false));
			}
 			message.saveChanges();
 			
			Transport transport = session.getTransport("smtp");
 			transport.connect(HOST, fromMailId, passWord);
 		
 			Transport.send(message, message.getAllRecipients());
 			transport.close();
		}
		catch (Exception e) {
			log.error("",e);
		}
	}
	

	private class SMTPAuthenticator extends javax.mail.Authenticator
	{  
		
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(fromMailId, passWord);
		}
	}

	public String  getMailContent(String subject,String msgContent,String fromemailid,String to)
	{
		StringBuffer contentMail= new StringBuffer();
		contentMail.append("<table  width='80%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>DEAR "+subject+",</font></td></tr>");
		contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+msgContent+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");
		contentMail.append("</table>");
		return contentMail.toString();
	}

	/**
	  * This method is accessed from kycportal/forgotsubmit.jsp
	  * send password details to corresponding person mail   - prasanth
	  * @param to that can be used to send mail to  corresponding person mail
	  * 
     @param  from that can be used to send mail to  corresponding person mail
     *
     @param  msgContent that can be used to send mail to  corresponding person mail
     *
     @param subject that can be used to send mail to  corresponding person mail
     *
     @param cc that can be used to send mail to  corresponding person mail
	 */
	public void send(String to,String from,String msgContent,String subject,String cc,HttpServletRequest request,ArrayList instList){
		try{
			log.info("invoking sendmail from com.iGrandee.SendMail.SendMail");

			ResourceBundle rb = ResourceBundle.getBundle("resources.smtp");
			String HOST		=	rb.getString("smttp_name");
			String PORT		=	rb.getString("smttp_port");
			fromMailId 		= 	rb.getString("from_mail");
			passWord 		= 	rb.getString("mail_pwd");
			String networktype = rb.getString("networktype");
			
			
			Properties props = new Properties();
	        props.put("mail.smtp.user", fromMailId);
			props.put("mail.smtp.host", HOST);
			props.put("mail.smtp.port", PORT);
	        System.out.print("networktype11-->"+networktype);
	        
	        if(networktype!=null && networktype.equals("internet")){
	            props.put("mail.smtp.starttls.enable","true");
	            props.put("mail.smtp.debug", "true");
	            props.put("mail.smtp.socketFactory.port", PORT);
	        	System.out.print("networktype3 inside if-->"+networktype);
	        	props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
	            props.put("mail.smtp.socketFactory.fallback", "false");
	            props.put("mail.smtp.auth", "true");
	        }

	        
			
			Authenticator auth = new SMTPAuthenticator();
			
			Session session = Session.getInstance(props, auth);
			session.setDebug(true);

			MimeMessage message = new MimeMessage(session);
			message.setSubject("Password Request");
			message.setContent(getMailContent(subject,msgContent,from,to,request,instList),"text/html");
			message.setFrom(new InternetAddress(fromMailId));
			if(cc.equals(""))
			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
			}
			else
			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
			message.setRecipients(RecipientType.CC,  InternetAddress.parse((to+","+cc), false));
			}
			message.saveChanges();
			
			Transport transport = session.getTransport("smtp");
			transport.connect(HOST, fromMailId, passWord);
		
			Transport.send(message, message.getAllRecipients());
			transport.close();
		}
		catch (Exception e) {
			log.error("",e);
		}
	}
	/**
	 * @param password
	 * @param username
	 * @return
	 */
	public String getMailContent(String subject,String msgContent,String fromemailid,String to,HttpServletRequest request,ArrayList instList)
	{
		StringBuffer contentMail= new StringBuffer();
		try{
			
			ResourceBundle rb_mail_cont = ResourceBundle.getBundle("resources.smtp");
			contentMail.append( "<html><body>");
        	contentMail.append("<table  border=0 width=1040>");
        	contentMail.append("<tr height=50px><td align=left>");
			
			contentMail.append("<table  border=0 width=98% class=tablebold cellpadding='0' cellspacing='0'>");
			contentMail.append("<tr height=100px ><td>");
			contentMail.append("<table border=0  cellpadding='0' cellspacing='0' style='float:left;' align=left width=100%>");
			
	    	if(instList!=null && instList.size()>0)
	    	{
	    		java.util.HashMap map=(java.util.HashMap)instList.get(0);
	        	String inslogo=map.get("institutelogo")+"";
	        	String insname=map.get("institutename")+"";
	        	String contactaddress=map.get("contactaddress")+"";
	        	String country=map.get("country")+"";
	        	String landlinenumber=map.get("landlinenumber")+"";
	        	String state=map.get("state")+"";
	        	String mobilenumber=map.get("mobilenumber")+"";
	        	String emailid=map.get("emailid")+"";
	        	String url=map.get("url")+"";
	        	String zip=map.get("zip")+"";
	        	String fax=map.get("fax")+"";
	        	        	
	        	if(url.equals("-") || url.equals("") || url.trim()=="")
	        		url="";
	        	else
	        		url="Website :"+url;
	        	if(zip.equals("-") || zip.equals("") || zip.trim()=="")
	        		zip="";
	        	else
	        		zip="Zipcode :"+zip;
	    		
	        	contentMail.append("<tr align=left>");
	        	//contentMail.append("<td rowspan=3 valign=top><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+inslogo+"' width=100 height=110></td>");
	        	contentMail.append("<td rowspan=3 valign=top>");
	        	contentMail.append("<img src=http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+inslogo+"></td>");
	        	contentMail.append("</tr>");
	        	contentMail.append("<tr>");
	        	contentMail.append("<td valign=top>");
	        	contentMail.append("<table  align=left width='60%'>");
	        	contentMail.append("<tr align=left>");
	        	contentMail.append("<td class=tablelight>&nbsp;<h3>"+insname+"</h3></td>");
	        	contentMail.append("<table border=0 align=right>");
	        	contentMail.append("<tr align=left>");
	        	contentMail.append("<td>&nbsp;"+contactaddress+"</td>"); 
	        	contentMail.append("</tr>");
	        	contentMail.append("<tr align=left>");
	        	contentMail.append("<td>&nbsp;"+state+","+country+"</td>");
	        	contentMail.append("</tr>");
	        	contentMail.append("<tr align=left>");
	        	contentMail.append("<td>&nbsp;"+zip+"</td>");
	        	contentMail.append("</tr>");
	        	contentMail.append("<tr align=left>");
	        	contentMail.append("<td>&nbsp;Phone:"+landlinenumber+"</td>");
	        	contentMail.append("</tr>");
	        	contentMail.append("<tr align=left>");
	        	contentMail.append("<td>&nbsp;Fax:"+fax+"</td>");
	        	contentMail.append("</tr>");
	        	contentMail.append("<tr align=left>");
	        	contentMail.append("<td>&nbsp;Email:<a href='mailto:"+emailid+"'>"+emailid+"</a></td>");
	        	contentMail.append("</tr>");
	        	contentMail.append("<tr align=left>");
	        	contentMail.append("<td>&nbsp;"+url+"</td>");
	        	contentMail.append("</tr>");
	        	
	        	
	        	}			
	    	contentMail.append("</table></td></tr></table></td></tr>");
	    	
			/*contentMail.append("<table width='100%' height='250' cellpadding='2' cellspacing='0' border='0' bordercolor='#007D9D' bgcolor='#F5F5F5'>");
			contentMail.append("<tr><td>");
			//contentMail.append("<table border=0 width='100%' rules='groups' cellpadding='4' cellspacing='0' background='http://"+mailservername+":"+request.getServerPort()+request.getContextPath()+"/images/his/ereg_images/banner_02.jpg'>");
			contentMail.append("<tr valign='top'><td align='left' width='5%'>");
			contentMail.append("<table border='0' cellpadding='0' cellspacing='0'><tr><td>");
			//contentMail.append("<img src='http://"+mailservername+":"+request.getServerPort()+request.getContextPath()+"/OpenFile?r1=eregister_docpath&r2=Organization/LogoAndAdmin/doc_1337252047045134531426626180657261.png' width='70' height='73' border='0'></td></tr></table>");
			contentMail.append("</td><td class='logo' valign='middle' align='justify'>");
			contentMail.append("<font face='arial Rounded MT bold' size='4'>hosname&nbsp;&nbsp;-&nbsp;&nbsp;org</font></td>");
			//contentMail.append("<font face='arial Rounded MT bold' size='4'>"+hosname+"&nbsp;&nbsp;-&nbsp;&nbsp;"+org+"</font></td>");
			//contentMail.append("<td align='right' background=\"/TeleRad/images/his/ereg_images/banner_02.jpg\">");
			//contentMail.append("<img src=http://"+mailservername+":"+request.getServerPort()+request.getContextPath()+"/images/his/ereg_images/banner_03.jpg></td>");
			contentMail.append("</tr></table>");
			contentMail.append("</td></tr>");*/
		    
		    
			contentMail.append("<tr><td vAlign='top' width='90%' align='center'>&nbsp;</td></tr>"); 
			contentMail.append("<tr><td vAlign='top' colspan='3'><font face='Verdana' size=\"3\"><b>Dear "+subject+", </font></td></tr>");
			contentMail.append("<tr><td vAlign='top' colspan='3'><font face='Verdana' size=\"2\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Your account has been successfully reset</font></td>");
			//contentMail.append("<tr><td vAlign='top'><font face='Verdana' size=\"2\" color=green>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>UserName </b>: "+username+"</font></td></tr>");
			contentMail.append("<tr><td vAlign='top' colspan='3'><font face='Verdana' size=\"2\" color=green>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Your Password is :  </b>: "+msgContent+"</font></td></tr>"); 
			//contentMail.append("<tr><td vAlign='top'><font face='Verdana' size=\"2\" color=green>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='http://"+mailservername+":"+request.getServerPort()+request.getContextPath()+"'>Click here to login</a> </font></td></tr>");
			
			//contentMail.append("<tr><td><table border='0' width='100%'><tr valign='bottom'><td align='center' colspan='3' class='copyright'><font color='gray'>Copyright&nbsp;&copy; 2012 i-Grandee, all rights reserved </font></td></tr></table></td></tr>");
			contentMail.append( "</table>");
			contentMail.append( "</body>");
			contentMail.append( "</html>");  
			
		}
		catch(Exception e){
			log.error("getMailContent method exception :",e);
			e.printStackTrace();
		}
		catch(Error e){
			e.printStackTrace();
			log.error("getMailContent Error is :",e);
		}
		return contentMail.toString();
	}
	
	
	/*public void sendStaffRegistraion(String to,String from,String msgContent,String subject,String cc,StaffRegistrationBean staffBean,String deptName,String roleName){
		try{
			log.info("invoking sendStaffRegistraion from com.iGrandee.SendMail.SendMail");
			//System.out.println("2deptName,roleName"+deptName+"--"+roleName);
			ResourceBundle rb = ResourceBundle.getBundle("resources.smtp");
			String HOST		=	rb.getString("smttp_name");
			String PORT		=	rb.getString("smttp_port");

  	
			Properties props = new Properties();
			props.put("mail.smtp.host", HOST);
			props.put("mail.smtp.port", PORT);
			Authenticator auth = new SMTPAuthenticator();
			
			Session session = Session.getInstance(props, auth);
			session.setDebug(true);

			MimeMessage message = new MimeMessage(session);
			message.setSubject("KYCPORTAL - Your Profile Registered");
			message.setContent(getStaffContent(subject,msgContent,from,to,staffBean,deptName,roleName),"text/html");
			//System.out.println("3deptName,roleName"+deptName+"--"+roleName);
			/*if(userStat.equalsIgnoreCase("Staff")){
				message.setContent(getStaffContent(subject,msgContent,from,to),"text/html");
			}
			else if(userStat.equalsIgnoreCase("Student")){
				message.setContent(getStudentContent(subject,msgContent,from,to),"text/html");
			}*/
 			/*message.setFrom(new InternetAddress(from));
 			if(cc.equals(""))
 			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
			}
			else
			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
 			message.setRecipients(RecipientType.CC,  InternetAddress.parse((to+","+cc), false));
			}
 			message.saveChanges();
 			
			Transport transport = session.getTransport("smtp");
 			transport.connect(HOST, USER, PASSWORD);
 		
 			Transport.send(message, message.getAllRecipients());
 			transport.close();
		}
		catch (Exception e) {
			log.error(e);
		}
	}*/
	
	public void sendStaffRegistraion(String to,String from,String msgContent,String subject,String cc,StaffRegistrationBean staffBean,String deptName,String roleName){
		try{
			log.info("invoking sendStaffRegistraion from com.iGrandee.SendMail.SendMail");
			//System.out.println("2deptName,roleName"+deptName+"--"+roleName);
			ResourceBundle rb = ResourceBundle.getBundle("resources.smtp");
			String HOST		=	rb.getString("smttp_name");
			String PORT		=	rb.getString("smttp_port");
			passWord 		= 	rb.getString("mail_pwd");
			fromMailId 		= 	rb.getString("from_mail");
			String networktype = rb.getString("networktype");
			
  	
			Properties props = new Properties();
	        props.put("mail.smtp.user", fromMailId);
			props.put("mail.smtp.host", HOST);
			props.put("mail.smtp.port", PORT);
			
	        if(networktype!=null && networktype.equals("internet")){
	            props.put("mail.smtp.starttls.enable","true");
	            props.put("mail.smtp.debug", "true");
	            props.put("mail.smtp.socketFactory.port", PORT);
	        	System.out.print("networktype3 inside if-->"+networktype);
	        	props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
	            props.put("mail.smtp.socketFactory.fallback", "false");
	            props.put("mail.smtp.auth", "true");
	        }

			
			Authenticator auth = new SMTPAuthenticator();
			
			Session session = Session.getInstance(props, auth);
			session.setDebug(true);

			MimeMessage message = new MimeMessage(session);
			message.setSubject("KYCPORTAL - Your Profile Registered");
			message.setContent(getStaffContent(subject,msgContent,from,to,staffBean,deptName,roleName),"text/html");
			
 			message.setFrom(new InternetAddress(from));
 			if(cc.equals(""))
 			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
			}
			else
			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
 			message.setRecipients(RecipientType.CC,  InternetAddress.parse((to+","+cc), false));
			}
 			message.saveChanges();
 			
			Transport transport = session.getTransport("smtp");
 			transport.connect(HOST, fromMailId, passWord);
 		
 			Transport.send(message, message.getAllRecipients());
 			transport.close();
		}
		catch (Exception e) {
			log.error("",e);
		}
	}
	
	public String  getStaffContent(String subject,String msgContent,String fromemailid,String to,StaffRegistrationBean beanobj,String deptName,String roleName)
	{
		String prefix = beanobj.getprefix();
		String qualification = beanobj.getQualification();
		
		String firstname = beanobj.getFirstName();
		String midname = beanobj.getMidName();
		String lastname = beanobj.getLastName();
		
		String fathername = beanobj.getFatherName();
		String mothername = beanobj.getMotherName();
		
		String created=beanobj.getUserId();

		String username=beanobj.getUserName();
		String password =beanobj.getPassWd();
		
		String photo=beanobj.getPhoto();
		String gender = beanobj.getGender();
		
		String mstatus =beanobj.getMStatus();
		String dob =beanobj.getDOB();

		String landline =beanobj.getLandLine();
		String mobileno =beanobj.getMobile();

		String emidid =beanobj.getEMail();
		
		String ipaddress =beanobj.getipaddress();
		
		String instituteid =beanobj.getInstituteId();

		//String departid =beanobj.getDepartment();
		//String roleid =beanobj.getRole();

		String dateofjoin =beanobj.getJoiningDate();
		String role[] =beanobj.getinstRole();
		String period[] =beanobj.getinstPeriod();
		
		String areaofinterest =beanobj.getAreaOfInterest();
		String publication =beanobj.getPubliCations();
		
		String jobcategory =beanobj.getPost();


		String street1 =beanobj.getStreet1();
		String street2 =beanobj.getStreet2();
		String city =beanobj.getCity();
		String state =beanobj.getState();
		String country =beanobj.getCountry();
		String zipcode =beanobj.getZipCode();

		String permanentstreet1 =beanobj.getpermanentStreet1();
		String permanentstreet2 =beanobj.getpermanentStreet2();
		String permanentcity =beanobj.getpermanentCity();
		String permanentstate =beanobj.getpermanentState();
		String permanentcountry =beanobj.getpermanentCountry();
		String permanentzipcode =beanobj.getpermanentZipCode();

		String major[] = null;
		String user_qualification[] = null;
		String Yearofgrad[] = null;
		String marks[] = null;
		String institutename[] = null;
		
		String age = beanobj.getAge();
		
		/*PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null;
		PreparedStatement pstmt6 = null;
		PreparedStatement pstmt7 = null;

		String Query = "";
		Connection connection = null;

		try {
			long max_userid = common_data_object.fmaxId("select max(userid) from login");
			long max_personid = common_data_object.fmaxId("select max(personid) from personmaster");
			long max_staffid = common_data_object.fmaxId("select max(staffid) from staffmaster");
			long max_stafflogid = common_data_object.fmaxId("select max(stafflogid) from staffmasterlog");
			long max_staffqualificationid = common_data_object.fmaxId("select max(staffqualificationid) from staffqualification");
			//log.info(max_personid + "================"	+ max_instituteid);
			//log.info(beanobj.gettxt_street2()+ "===============gettxt_street2");
			long max_experienceid = common_data_object.fmaxId("select max(experienceid) from userexperience");
			long max_staffextraid = common_data_object.fmaxId("select max(staffextraid) from staffextraactivity");
			long max_addressid = common_data_object.fmaxId("select max(addressid) from personaddress");

			
			
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			// connection = ConnectionManager.getKycConnection();
			Query = "insert into personmaster(personid,firstname, middlename, lastname, fathername, mothername, sex, dob,maritalstatus, landlinenumber, mobilenumber, emailid, imagepath, dateofcreation, createdby, ipaddress, instituteid, status,prefix, qualification,age) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = connection.prepareStatement(Query);
			pstmt.setLong(1, max_personid);
			pstmt.setString(2, firstname);
			pstmt.setString(3, midname);
			pstmt.setString(4, lastname);
			pstmt.setString(5, fathername);
			pstmt.setString(6, mothername);
			pstmt.setString(7, gender);
			pstmt.setString(8, dob);
			pstmt.setString(9, mstatus);
			pstmt.setString(10, landline);
			pstmt.setString(11, mobileno);
			pstmt.setString(12, emidid);
			pstmt.setString(13, photo);
			pstmt.setString(14, datetime.showTime("databaseinsert"));
			pstmt.setString(15, created);
			pstmt.setString(16, ipaddress);
			pstmt.setString(17, instituteid);
			pstmt.setString(18, "A");
			pstmt.setString(19, prefix);
			pstmt.setString(20, qualification);
			pstmt.setString(21, beanobj.getAge());

			result += pstmt.executeUpdate();
			log.info("personmaster================>>");

			Query = "insert into login(userid, username, password, usercategory, personid, dateofcreation, createdby, ipaddress, loginstatus) values(?,?,?,?,?,?,?,?,?)";
			pstmt1 = connection.prepareStatement(Query);
			pstmt1.setLong(1, max_userid);
			pstmt1.setString(2, username);
			pstmt1.setString(3, password);
			
			String jobtype= common_data_object.getString("SELECT categoryname FROM staffcategory s where staffcategoryid='"+jobcategory+"'");
			log.info("jobtype================>>"+jobtype);
			if(jobtype.equalsIgnoreCase("Headmaster") || jobtype.equalsIgnoreCase("HM"))
			{
					pstmt1.setString(4, "HM");
			}
			else
			{
				pstmt1.setString(4, "T");
			}

			pstmt1.setLong(5, max_personid);
			pstmt1.setString(6, datetime.showTime("databaseinsert"));
			pstmt1.setString(7, created);
			pstmt1.setString(8, ipaddress);
			pstmt1.setString(9, "A");
			result += pstmt1.executeUpdate();
			log.info("login================>>");

			
			Query = "insert into staffmaster(staffid, departmentid, roleid, dateofjoin, createdby, dateofcreation, ipaddress, userid, staffstatus,staffcategoryid) values(?,?,?,?,?,?,?,?,?,?)";
			pstmt2 = connection.prepareStatement(Query);
			pstmt2.setLong(1, max_staffid);
			pstmt2.setString(2, departid);
			pstmt2.setString(3, roleid);
			pstmt2.setString(4, dateofjoin);
			pstmt2.setString(5, created);
			pstmt2.setString(6, datetime.showTime("databaseinsert"));
			pstmt2.setString(7, ipaddress);
			pstmt2.setLong(8, max_userid);
			pstmt2.setString(9, "A");
			pstmt2.setString(10, jobcategory);

			result += pstmt2.executeUpdate();
			
			log.info("staffmaster================>>");

			Query = "insert into staffmasterlog(stafflogid, staffid, roleid, dateofcreation, stafflogdetail, createdby, ipaddress, stafflogstatus) values(?,?,?,?,?,?,?,?)";
			pstmt3 = connection.prepareStatement(Query);
			pstmt3.setLong(1, max_stafflogid);
			pstmt3.setLong(2, max_staffid);
			pstmt3.setString(3, roleid);
			pstmt3.setString(4, datetime.showTime("databaseinsert"));
			pstmt3.setString(5, "Created");
			pstmt3.setString(6, created);
			pstmt3.setString(7, ipaddress);
			pstmt3.setString(8, "A");
			result += pstmt3.executeUpdate();
			
			log.info("staffmasterlog================>>");
		 	*/
			
			major=beanobj.getmajor();
			user_qualification=beanobj.getuser_qualification();
			Yearofgrad=beanobj.getYearofgrad();
			marks=beanobj.getmarks();
			institutename=beanobj.getinstitutename();
		log.info("invoking getStaffContent from com.iGrandee.SendMail.SendMail");
		String fullname = firstname+midname+lastname;
		if(gender.equalsIgnoreCase("M"))
			gender = "Male";
		else
			gender = "Female";
		
		StringBuffer contentMail= new StringBuffer();
		contentMail.append("<table  width='80%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Dear "+fullname+",</font></td></tr>");
		
		//contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>DEAR Staff"+subject+",</font></td></tr>");
		contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your UserName is : "+username+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");
		
		contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+password+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");
		contentMail.append("</table>");

		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor=gray><td colspan=2 align='left'><font face='bookman old style' size='3'>Personal Information</font></td></tr>");
		//contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>DEAR Staff"+subject+",</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Name :</font></td><td>"+prefix+""+fullname+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Date of Birth :</font></td><td>"+beanobj.getDobmail()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Age :</font></td><td>"+age+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Gender :</font></td><td>"+gender+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Marital Status :</font></td><td>"+mstatus+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Father Name :</font></td><td>"+fathername+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Mother Name :</font></td><td>"+mothername+"</td></tr>");
		/*contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+msgContent+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");*/
		contentMail.append("</table>");
		
		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor=gray><td colspan=2 align='left'><font face='bookman old style' size='3'>Contact Information</font></td></tr>");
		contentMail.append("<tr><td colspan=2 align='left'><font face='bookman old style' size='3'><b>Communication Address</b></font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street1 :</font></td><td>"+street1+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street2 :</font></td><td>"+street2+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>City :</font></td><td>"+city+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>State :</font></td><td>"+state+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Country :</font></td><td>"+country+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Pin Code :</font></td><td>"+zipcode+"</td></tr>");
		/*contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+msgContent+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");*/
		//contentMail.append("</table>");

		//contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		contentMail.append("<tr><td colspan=2 align='left'><font face='bookman old style' size='3'><b>Permanent Address</b></font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street1 :</font></td><td>"+permanentstreet1+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street2 :</font></td><td>"+permanentstreet2+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>City :</font></td><td>"+permanentcity+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>State :</font></td><td>"+permanentstate+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Country :</font></td><td>"+permanentcountry+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Pin Code :</font></td><td>"+permanentzipcode+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Mobile :</font></td><td>"+mobileno+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Landline :</font></td><td>"+landline+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Email :</font></td><td>"+emidid+"</td></tr>");
		contentMail.append("</table>");		

		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor=gray><td colspan=6 align='left'><font face='bookman old style' size='3'>Qualification</font></td></tr>");
		//contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>DEAR Staff"+subject+",</font></td></tr>");
		if(major.length>0){
			contentMail.append("<tr><td align='left'><font face='bookman old style'><b>SNo</b></font></td><td align='left'><font face='bookman old style'><b>Major</b></font></td><td align='left'><font face='bookman old style'><b>Area of Specialization</b></font></td><td align='left'><font face='bookman old style'><b>Year of Graduation</b></font></td><td align='left'><font face='bookman old style'><b>Percentage / GPA</b></font></td><td align='left'><font face='bookman old style'><b>College / University</b></font></td></tr>");
		  	 	  	
		for(int quallen=0;quallen<major.length;quallen++){
			contentMail.append("<tr><td>"+(quallen+1)+"</td><td>"+major[quallen]+"</td><td>"+user_qualification[quallen]+"</td><td>"+Yearofgrad[quallen]+"</td><td>"+marks[quallen]+"</td><td>"+institutename[quallen]+"</td></tr>");
			if((quallen+1)==major.length)
				contentMail.append("</table>");
		}
		}
		else
			contentMail.append("</table>");
		/*contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+msgContent+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");*/
		
		
		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor=gray><td colspan=2 align='left'><font face='bookman old style' size='3'>Job Information</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Department :</font></td><td>"+deptName+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Joining Date :</font></td><td>"+beanobj.getJoiningdatemail()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Position :</font></td><td>"+roleName+"</td></tr>");
		/*contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+msgContent+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");*/
		contentMail.append("</table>");
		
		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor=gray><td colspan=3 align='left'><font face='bookman old style' size='3'>Experience Details</font></td></tr>");
		//contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>DEAR Staff"+subject+",</font></td></tr>");
		if(role.length>0){
			contentMail.append("<b><tr><td align='left'><font face='bookman old style'><b>SNo</b></font></td><td align='left'><font face='bookman old style'><b>Position</b></font></td><td align='left'><font face='bookman old style'><b>Period</b></font></td></tr>");
		for(int explen=0;explen<role.length;explen++){
			if(role[explen]!=null && period[explen]!=null)
				contentMail.append("<tr><td>"+(explen+1)+"</td><td>"+role[explen]+"</td><td>"+period[explen]+"</td></tr>");			
		}
		}
		/*contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+msgContent+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");*/
		contentMail.append("</table>");

		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor=gray><td colspan=2 align='left'><font face='bookman old style' size='3'>Area of Interest & Publication</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Area of Interest :</font></td><td>"+areaofinterest+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Publication :</font></td><td>"+publication+"</td></tr>");
		contentMail.append("</table>");

		contentMail.append("<table  width='80%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		//contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>DEAR Staff"+subject+",</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>-- Administrator,</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>"+beanobj.getSessionInstituteName()+"</font></td></tr>");
		contentMail.append("</table>");
		return contentMail.toString();
	}
	
	public void sendStudentRegistraion(String to,String from,String msgContent,String subject,String cc,StudentRegistrationBean beanobj){
		try{
			log.info("invoking sendStudentRegistraion from com.iGrandee.SendMail.SendMail");
			ResourceBundle rb = ResourceBundle.getBundle("resources.smtp");
			String HOST		=	rb.getString("smttp_name");
			String PORT		=	rb.getString("smttp_port");
			passWord 		= 	rb.getString("mail_pwd");
			fromMailId 		= 	rb.getString("from_mail");
			String networktype = rb.getString("networktype");

			Properties props = new Properties();
			if(networktype!=null && networktype.equals("internet"))
				props.put("mail.smtp.user", fromMailId);
			else
				props.put("mail.smtp.user", from);
			
			props.put("mail.smtp.host", HOST);
			props.put("mail.smtp.port", PORT);
			
	        if(networktype!=null && networktype.equals("internet")){
	            props.put("mail.smtp.starttls.enable","true");
	            props.put("mail.smtp.debug", "true");
	            props.put("mail.smtp.socketFactory.port", PORT);
	        	System.out.print("networktype3 inside if-->"+networktype);
	        	props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
	            props.put("mail.smtp.socketFactory.fallback", "false");
	            props.put("mail.smtp.auth", "true");
	        }

			
			Authenticator auth = new SMTPAuthenticator();
			
			Session session = Session.getInstance(props, auth);
			session.setDebug(true);

			MimeMessage message = new MimeMessage(session);
			message.setSubject("KYCPORTAL - Your Profile Registered");
			message.setContent(getStudentContent(subject,msgContent,from,to,beanobj),"text/html");
			
			/*if(userStat.equalsIgnoreCase("Staff")){
				message.setContent(getStaffContent(subject,msgContent,from,to),"text/html");
			}
			else if(userStat.equalsIgnoreCase("Student")){
				message.setContent(getStudentContent(subject,msgContent,from,to),"text/html");
			}*/
 			//message.setFrom(new InternetAddress(fromMailId));
 			message.setFrom(new InternetAddress(from));
 			if(cc.equals(""))
 			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
			}
			else
			{
			message.setRecipients(RecipientType.TO,   InternetAddress.parse((to), false));
 			message.setRecipients(RecipientType.CC,  InternetAddress.parse((to+","+cc), false));
			}
 			message.saveChanges();
 			
			Transport transport = session.getTransport("smtp");
			if(networktype!=null && networktype.equals("internet"))
				transport.connect(HOST, fromMailId, passWord);
			else
				transport.connect(HOST, USER, PASSWORD);
 		
 			Transport.send(message, message.getAllRecipients());
 			transport.close();			
		}
		catch (Exception e) {
			e.printStackTrace();
			log.error("",e);
		}
	}
	
	public String  getStudentContent(String subject,String msgContent,String fromemailid,String to,StudentRegistrationBean studentBean)
	{
		log.info("invoking getStudentContent from com.iGrandee.SendMail.SendMail");
		
		//System.out.println("0");
		
		StringBuffer contentMail= new StringBuffer();
		contentMail.append("<table  width='80%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Dear "+studentBean.getApplicantname()+",</font></td></tr>");
		contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your UserName is : "+studentBean.getStudentusername()+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");
		contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+studentBean.getStudentpassword()+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");
		//System.out.println("1");
		contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Parent UserName is : "+studentBean.getParentpassword()+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");
		contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Parent Password is : "+studentBean.getParentpassword()+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");
		contentMail.append("</table>");
		//System.out.println("2");
		/*try {
			String parentid=beanobj.getParentid()+"";
			long max_parentloginid =0l;
			long max_userid = common_data_object.fmaxId("select max(userid) from login");
			long max_personid = common_data_object.fmaxId("select max(personid) from personmaster");
			long max_studentguardianid = common_data_object.fmaxId("select max(studentguardianid) from studentguardian");
			long max_candidateregisterid = common_data_object.fmaxId("select max(candidateregisterid) from candidateregister");
			long max_studentqualificationid = common_data_object.fmaxId("select max(studentqualificationid) from studentqualification");
			//log.info(max_personid + "================"	+ max_instituteid);
			//log.info(beanobj.gettxt_street2()+ "===============gettxt_street2");
			if(parentid.equals("nodatafound") || parentid.equals("null"))
			{
			 max_parentloginid = common_data_object.fmaxId("select max(parentloginid) from parentlogin");
			}
			else
			{
			 max_parentloginid=Long.parseLong(parentid);
			}
			log.info(max_parentloginid+ "===============max_parentloginid");
			long max_studentparentid = common_data_object.fmaxId("select max(studentparentid) from studentparent");

			long max_addressid = common_data_object.fmaxId("select max(addressid) from personaddress");

			connection = ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			// connection = ConnectionManager.getKycConnection();
			Query = "insert into personmaster(personid,firstname, fathername, mothername,dob, landlinenumber, emailid, imagepath, dateofcreation, createdby, ipaddress, instituteid, status,nationality, religion, community,language,bloodgroup, middlename, lastname,age,sex,prefix,mobilenumber) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = connection.prepareStatement(Query);
			pstmt.setLong(1, max_personid);
			pstmt.setString(2, beanobj.getApplicantname().trim());
			pstmt.setString(3, beanobj.getFathername().trim());
			pstmt.setString(4, beanobj.getMothername().trim());
			pstmt.setString(5, beanobj.getDob());
			pstmt.setString(6, beanobj.getLandlinenumber());
			pstmt.setString(7, beanobj.getEmailid());
			pstmt.setString(8, beanobj.getPhoto());
			pstmt.setString(9, datetime.showTime("databaseinsert"));
			pstmt.setString(10, beanobj.getCreatedby());
			pstmt.setString(11, beanobj.getIpaddress());
			pstmt.setString(12, beanobj.getInstituteid());
			pstmt.setString(13, "A");
			pstmt.setString(14, beanobj.getNationality());
			pstmt.setString(15, beanobj.getReligion());
			pstmt.setString(16, beanobj.getCommunity());
			pstmt.setString(17, beanobj.getLanguage());
			pstmt.setString(18, beanobj.getBloodgroup());
			pstmt.setString(19, beanobj.getStudmiddlename().trim());
			pstmt.setString(20, beanobj.getStudlastname().trim());
			pstmt.setString(21, beanobj.getStudage());
			pstmt.setString(22, beanobj.getStudsex());
			pstmt.setString(23, beanobj.getStudprefix());
			pstmt.setString(24, beanobj.getMobileno());
			result += pstmt.executeUpdate();
			log.info("personmaster================>>");

			Query = "insert into login(userid, username, password, usercategory, personid, dateofcreation, createdby, ipaddress, loginstatus) values(?,?,?,?,?,?,?,?,?)";
			pstmt1 = connection.prepareStatement(Query);
			pstmt1.setLong(1, max_userid);
			pstmt1.setString(2, beanobj.getStudentusername());
			pstmt1.setString(3, beanobj.getStudentpassword());
			pstmt1.setString(4, "S");
			pstmt1.setLong(5, max_personid);
			pstmt1.setString(6, datetime.showTime("databaseinsert"));
			pstmt1.setString(7, beanobj.getCreatedby());
			pstmt1.setString(8, beanobj.getIpaddress());
			pstmt1.setString(9, "A");
			result += pstmt1.executeUpdate();
			log.info("login================>>");

			Query = "insert into personaddress(addressid, personid, communicationstreet1, communicationstate, communicationcountry, communicationcity, communicationpin, permanentstreet1,permanentstate, permanentcountry, permanentcity, permanentpin, dateofcreation, createdby, peraddstatus,communicationstreet2,permanentstreet2) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt7 = connection.prepareStatement(Query);
			pstmt7.setLong(1, max_addressid);
			pstmt7.setLong(2, max_userid);
			pstmt7.setString(3, beanobj.getStreet1());
			pstmt7.setString(4, beanobj.getState());
			pstmt7.setString(5, beanobj.getCountry());
			pstmt7.setString(6, beanobj.getCity());
			pstmt7.setString(7, beanobj.getZipcode());
			pstmt7.setString(8, beanobj.getPermanentstreet1());
			pstmt7.setString(9, beanobj.getPermanentstate());
			pstmt7.setString(10, beanobj.getPermanentcountry());
			pstmt7.setString(11, beanobj.getPermanentcity());
			pstmt7.setString(12, beanobj.getPermanentzipcode());
			pstmt7.setString(13, datetime.showTime("databaseinsert"));
			pstmt7.setString(14, beanobj.getCreatedby());
			pstmt7.setString(15, "A");
			pstmt7.setString(16, beanobj.getStreet2());
			pstmt7.setString(17, beanobj.getPermanentstreet2());
			
			result += pstmt7.executeUpdate();
			
			log.info("personaddress================>>");

			Query = "insert into studentguardian(studentguardianid, personid, guardianname, relation, self, nameoforganization, annualincome, position, createdby, dateofcreation, ipaddress, studentguardianstatus) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt2 = connection.prepareStatement(Query);
			pstmt2.setLong(1, max_studentguardianid);
			pstmt2.setLong(2, max_userid);
			pstmt2.setString(3, beanobj.getGuardianname());
			pstmt2.setString(4, beanobj.getGuardrelation());
			pstmt2.setString(5, beanobj.getGuardemployment());
			pstmt2.setString(6, beanobj.getNameoforg());
			pstmt2.setString(7, beanobj.getAnnualincome());
			pstmt2.setString(8, beanobj.getGuardposition());
			pstmt2.setString(9, beanobj.getCreatedby());
			pstmt2.setString(10, datetime.showTime("databaseinsert"));
			pstmt2.setString(11, beanobj.getIpaddress());
			pstmt2.setString(12, "A");
			result += pstmt2.executeUpdate();
			log.info("studentguardian================>>");
			String schoolstatus= beanobj.getSchoolstatus();
					
			Query = "insert into candidateregister(candidateregisterid, studentapprovalid, standardscheduleid, personid, createdby, dateofcreation, ipaddress, candidateregisterstatus, physicallyfit, exserviceman, physicalmark, previousschoolname, previousschooladdress, mediumstudied, tc, cc, splcategory, medicalcertificate, marksheet, sportscertificate,studextracurricular,previousschoolhistory) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt3 = connection.prepareStatement(Query);
			pstmt3.setLong(1, max_candidateregisterid);
			pstmt3.setString(2,beanobj.getStudentapprovalid());
			pstmt3.setString(3, beanobj.getStandardscheduleid());
			pstmt3.setLong(4,max_userid);
			pstmt3.setString(5, beanobj.getCreatedby());
			pstmt3.setString(6, datetime.showTime("databaseinsert"));
			pstmt3.setString(7, beanobj.getIpaddress());
			pstmt3.setString(8, "A");
			pstmt3.setString(9, beanobj.getPhysicallyChallenge());
			pstmt3.setString(10, beanobj.getExServiceman());
			pstmt3.setString(11, beanobj.getPhysicalmarks());
			pstmt3.setString(12, beanobj.getPreviousSchoolDetails());
			pstmt3.setString(13, beanobj.getPreviousSchooladdress());
			pstmt3.setString(14, beanobj.getPreviousSchoolmedium());
			pstmt3.setString(15, beanobj.getTccheck());
			pstmt3.setString(16, beanobj.getCccheck());
			pstmt3.setString(17,beanobj.getSccheck());
			pstmt3.setString(18, beanobj.getMccheck());
			pstmt3.setString(19, beanobj.getMscheck());
			pstmt3.setString(20, beanobj.getSpccheck());
			pstmt3.setString(21, beanobj.getExtraCurricular());
			pstmt3.setString(9, beanobj.getPhysicallyChallenge());
			pstmt3.setString(10, beanobj.getExServiceman());
			pstmt3.setString(11, beanobj.getPhysicalmarks());
			pstmt3.setString(12, beanobj.getPreviousSchoolDetails());
			pstmt3.setString(13, beanobj.getPreviousSchooladdress());
			pstmt3.setString(14, beanobj.getPreviousSchoolmedium());
			pstmt3.setString(15, beanobj.getTccheck());
			pstmt3.setString(16, beanobj.getCccheck());
			pstmt3.setString(17,beanobj.getSccheck());
			pstmt3.setString(18, beanobj.getMccheck());
			pstmt3.setString(19, beanobj.getMscheck());
			pstmt3.setString(20, beanobj.getSpccheck());
			pstmt3.setString(21, beanobj.getExtraCurricular());
			pstmt3.setString(22, beanobj.getSchoolstatus());

			result += pstmt3.executeUpdate();
			log.info("candidateregister================>>");
			
			if(schoolstatus.equals("yes"))
			{
			String subject []= beanobj.getSubject();
			String monthyear []= beanobj.getMonthyear();
			String Registionno []= beanobj.getRegistionno();
			String Markscored []= beanobj.getMarkscored();
			String Maxmark []= beanobj.getMaxmark();

			if(subject.length>0)
			{
			for(int i=0;i<subject.length;i++)
			{
			Query = "insert into studentqualification(studentqualificationid, subject, monthandyear, registrationno, marksscored, maxmarks, userid, createdby, dateofcreation, studqualificationstatus) values(?,?,?,?,?,?,?,?,?,?)";
			pstmt4 = connection.prepareStatement(Query);
			pstmt4.setLong(1, max_studentqualificationid);
			pstmt4.setString(2, subject[i]);
			pstmt4.setString(3, monthyear[i]);
			pstmt4.setString(4, Registionno[i]);
			pstmt4.setString(5,Markscored[i]);
			pstmt4.setString(6, Maxmark[i]);
			pstmt4.setLong(7, max_userid);
			pstmt4.setString(8, beanobj.getCreatedby());
			pstmt4.setString(9, datetime.showTime("databaseinsert"));
			pstmt4.setString(10,"A");
			result += pstmt4.executeUpdate();
			max_studentqualificationid++;
			}
			}
			}
			log.info("studentqualification================>>"+result);

			
			log.info("max_parentloginid================>>"+max_parentloginid);
			if(parentid.equals("nodatafound") || parentid.equals("null"))
			{
			Query = "insert into parentlogin(parentloginid, parentusername, parentpassword, dateofcreation, createdby, parentstatus) values(?,?,?,?,?,?)";
			pstmt6 = connection.prepareStatement(Query);
			pstmt6.setLong(1, max_parentloginid);
			pstmt6.setString(2,beanobj.getParentusername());
			pstmt6.setString(3,beanobj.getParentpassword());
			pstmt6.setString(4, datetime.showTime("databaseinsert"));
			pstmt6.setString(5,beanobj.getCreatedby());
			pstmt6.setString(6,"A");
				
			result += pstmt6.executeUpdate();
			log.info("parentlogin================>>");
			}
			//log.info("max_studentparentid================>>"+max_studentparentid);

			Query = "insert into studentparent(studentparentid, userid, parentid, dateofcreation, studentparentstatus) values(?,?,?,?,?)";
			pstmt5 = connection.prepareStatement(Query);
			pstmt5.setLong(1, max_studentparentid);
			pstmt5.setLong(2,max_userid);
			pstmt5.setLong(3,max_parentloginid);
			pstmt5.setString(4, datetime.showTime("databaseinsert"));
			pstmt5.setString(5,"A");
					
			result += pstmt5.executeUpdate();
			log.info("studentparent================>>");

			connection.commit();
			
		}*/
		//System.out.println("3");
		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor='grey'><td colspan=2 align='left'><font face='bookman old style' size='3'>Personal Details</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Name :</font></td><td>"+studentBean.getStudprefix()+""+studentBean.getApplicantname()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Date of Birth :</font></td><td>"+studentBean.getDobMail()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Age :</font></td><td>"+studentBean.getStudage()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Gender :</font></td><td>"+studentBean.getStudsex()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Nationality :</font></td><td>"+studentBean.getNationality()+"</td></tr>");
		ResourceBundle sb = ResourceBundle.getBundle("resources.serversetup");
		
		if(sb.getString("communityflag").equals("yes"))
			contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Community :</font></td><td>"+studentBean.getCommunity()+"</td></tr>");
		if(sb.getString("religionflag").equals("yes"))
			contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Religion :</font></td><td>"+studentBean.getReligion()+"</td></tr>");
		
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Language :</font></td><td>"+studentBean.getLanguage()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Blood Group :</font></td><td>"+studentBean.getBloodgroup()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Father Name :</font></td><td>"+studentBean.getFathername()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Mother Name :</font></td><td>"+studentBean.getMothername()+"</td></tr>");
		contentMail.append("</table>");
		//System.out.println("4");
		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor='grey'><td colspan=2 align='left'><font face='bookman old style' size='3'>Contact Details</font></td></tr>");
		contentMail.append("<tr><td colspan=2 align='left'><font face='bookman old style' size='3'><b>Communication Address</b></font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street1 :</font></td><td>"+studentBean.getStreet1()+"</td></tr>");
		if(studentBean.getStreet2().trim().equals(""))
			contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street2 :</font></td><td>-</td></tr>");
		else
			contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street2 :</font></td><td>"+studentBean.getStreet2()+"</td></tr>");
		
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>City :</font></td><td>"+studentBean.getCity()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>State :</font></td><td>"+studentBean.getState()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Country :</font></td><td>"+studentBean.getCountry()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Pin Code :</font></td><td>"+studentBean.getZipcode()+"</td></tr>");
		//contentMail.append("</table>");
		//System.out.println("5");
		//contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		contentMail.append("<tr><td colspan=2 align='left'><font face='bookman old style' size='3'><b>Permanent Address</b></font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street1 :</font></td><td>"+studentBean.getPermanentstreet1()+"</td></tr>");
		if(studentBean.getPermanentstreet2().trim().equals(""))
			contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street2 :</font></td><td>-</td></tr>");
		else
			contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Street2 :</font></td><td>"+studentBean.getPermanentstreet2()+"</td></tr>");
		
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>City :</font></td><td>"+studentBean.getPermanentcity()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>State :</font></td><td>"+studentBean.getPermanentstate()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Country :</font></td><td>"+studentBean.getPermanentcountry()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Pin Code :</font></td><td>"+studentBean.getPermanentzipcode()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Mobile :</font></td><td>"+studentBean.getMobileno()+"</td></tr>");
		if(studentBean.getPermanentstreet2().trim().equals(""))
			contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Landline :</font></td><td>-</td></tr>");
		else
			contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Landline :</font></td><td>"+studentBean.getLandlinenumber()+"</td></tr>");
		
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Email :</font></td><td>"+studentBean.getEmailid()+"</td></tr>");
		contentMail.append("</table>");		
		//System.out.println("6");
		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor=gray><td colspan=2 align='left'><font face='bookman old style' size='3'>Parent / Guardian Details</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Parent/Guardian Name :</font></td><td>"+studentBean.getGuardianname()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Parent/Guardian Relation :</font></td><td>"+studentBean.getGuardrelation()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Parent/Guardian Self Employed :</font></td><td>"+studentBean.getGuardemployment()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Name of Organization :</font></td><td>"+studentBean.getNameoforg()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Annual Income Rs. :</font></td><td>"+studentBean.getAnnualincome()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Position :</font></td><td>"+studentBean.getGuardposition()+"</td></tr>");
		contentMail.append("</table>");	
		//System.out.println("7");
		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor=gray><td colspan=2 align='left'><font face='bookman old style' size='3'>Scholarship Details</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Physically Challenged :</font></td><td>"+studentBean.getPhysicallyChallenge()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Child of Ex-Serviceman :</font></td><td>"+studentBean.getExServiceman()+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Personal physical marks :</font></td><td>"+studentBean.getPhysicalmarks()+"</td></tr>");
		if(studentBean.getPermanentstreet2().trim().equals(""))
			contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Extra Curricular activities :</font></td><td>-</td></tr>");
		else
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Extra Curricular activities :</font></td><td>"+studentBean.getExtraCurricular()+"</td></tr>");

		contentMail.append("</table>");	
		//System.out.println("8");
		String schoolstatus= studentBean.getSchoolstatus();
		if(schoolstatus.equals("yes")){
		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='1' bordercolor='#FFFFFF'>");
		contentMail.append("<tr bgcolor=gray><td colspan=6 align='left'><font face='bookman old style' size='3'>Previous School Details</font></td></tr>");
		//contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>DEAR Staff"+subject+",</font></td></tr>");
		//System.out.println("9");	  	 	 	 	
		if(studentBean.getMonthyear()!=null && studentBean.getMonthyear().length>0){
			contentMail.append("<tr><b><td align='left'><font face='bookman old style'>SNo</font></td><td align='left'><font face='bookman old style' size='3'>Subjects</font></td><td align='left'><font face='bookman old style' size='3'>Month - Year</font></td><td align='left'><font face='bookman old style' size='3'>Registration No.</font></td><td align='left'><font face='bookman old style' size='3'>Marks Scored</font></td><td align='left'><font face='bookman old style' size='3'>Max Marks</font></td></tr>");
			for(int prevSchool=0;prevSchool<studentBean.getMonthyear().length;prevSchool++){
			contentMail.append("<tr><td>"+(prevSchool+1)+"</td><td>"+studentBean.getSubject()[prevSchool]+"</td><td>"+studentBean.getMonthyear()[prevSchool]+"</td><td>"+studentBean.getRegistionno()[prevSchool]+"</td><td>"+studentBean.getMarkscored()[prevSchool]+"</td><td>"+studentBean.getMaxmark()[prevSchool]+"</td></tr>");			
			}
		}
		else{
			contentMail.append("<tr><td align='center'><font face='bookman old style' size='3'>Not Entered</font></td></tr>");	
		}
		contentMail.append("</table>");
		}
		//System.out.println("10");
		contentMail.append("<table  width='80%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		//contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>DEAR Staff"+subject+",</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>From,</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Administrator,</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>"+studentBean.getSessionInstituteName()+"</font></td></tr>");
		contentMail.append("</table>");
		//System.out.println("11");
		/*contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Job Information</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Department :</font></td><td>"+departid+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Joining Date :</font></td><td>"+dateofjoin+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Position :</font></td><td>"+jobcategory+"</td></tr>");*/
		/*//contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+msgContent+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");*/
		/*contentMail.append("</table>");
		
		contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Experience Details</font></td></tr>");
		//contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>DEAR Staff"+subject+",</font></td></tr>");
		for(int explen=0;explen<major.length;explen++){
			contentMail.append("<tr><td>"+explen+1+"</td><td>"+role[explen]+"</td><td>"+period[explen]+"</td></tr>");			
		}*/
		/*contentMail.append("<tr><td vAlign='top'><font face='bookman old style' size='2'>");
		contentMail.append("<p >Your Password is : "+msgContent+"</p>");
		contentMail.append("</font>");
		contentMail.append("</td>");
		contentMail.append("</tr>");*/
		//contentMail.append("</table>");

		/*contentMail.append("<table  width='100%' height='40%' cellpadding='2' cellspacing='0' border='0' bordercolor='#FFFFFF'>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Area of Interest & Publication</font></td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Area of Interest :</font></td><td>"+areaofinterest+"</td></tr>");
		contentMail.append("<tr><td align='left'><font face='bookman old style' size='3'>Publication :</font></td><td>"+publication+"</td></tr>");
		contentMail.append("</table>");*/
		
		return contentMail.toString();

	}
	

}