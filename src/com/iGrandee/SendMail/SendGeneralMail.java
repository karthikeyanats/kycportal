
package com.iGrandee.SendMail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.mail.Authenticator;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;



 public class SendGeneralMail{
		static Logger log = Logger.getLogger(SendGeneralMail.class);

    String USER = null;
	String PASSWORD= null;
	 String passWord=null;
	   String fromMailId=null;
	   CommonDataAccess common_data_object = new CommonDataAccess();
	public SendGeneralMail()
		{
		}
	public int sendMailToAll(String mailsubject,String Content,String towhom,String instituteid)
	{
		String from ="Admin"; 
		int retvalue=0;
			
		//System.out.println("mailsubject"+mailsubject);
		//System.out.println("mailContent"+Content);
		System.out.println("mailtowhom"+towhom);
	
		try {
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
			System.out.println("networktype"+networktype);
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
			message.setSubject(mailsubject);
				
			message.setContent("<p>"+Content+"</p>","text/html");
				
			message.setFrom(new InternetAddress(fromMailId));
			String mailids = "";
			
			 mailids= getMailIDs(towhom,instituteid);
			 //	System.out.println("mailids"+mailids);

			String to ="";
			String cc="";
			//if(cc.equals("")){
				message.setRecipients(RecipientType.BCC,  InternetAddress.parse((mailids), false));
				message.saveChanges();

				Transport transport = session.getTransport("smtp");
				transport.connect(HOST, fromMailId, passWord);

				Transport.send(message, message.getAllRecipients());
				transport.close();
				retvalue=1;
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			retvalue=0;
			e.printStackTrace();
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			retvalue=0;
			e.printStackTrace();
			
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			retvalue=0;
			e.printStackTrace();
		}		
		return retvalue;
	}
	
	public String getMailIDs(String towhom,String instituteid)
	{
		String mailidstr= null;
		ArrayList secList = null;
		String select_query  = null;
		try{
			
				if(towhom.equals("SendAllParents"))
				{
					//the guardian mail getting form studentguardian table.
					select_query  	= "select g.personid,h.guardianmailid as emailid from standard c,standardschedule a,yearofsession b,sectionschedule d, studentallocation e,candidateregister f,personmaster g,studentguardian h where a.sessionid=b.sessionid  and c.standardid=a.standardid and  b.sessionstatus='A' and stdschedulestatus='A' and c.standardstatus='A' and sectionschedulestatus='A' and c.instituteid='"+instituteid+"'  and d.standardscheduleid=a.standardscheduleid and e.sectionscheduleid=d.sectionscheduleid   and e.studentallocationstatus='A' and f.candidateregisterid=e.candidateregisterid  and f.candidateregisterstatus='A' and g.personid=f.personid and h.personid=g.personid";
 					secList		 	= common_data_object.getListMap(select_query);
				}
				if(towhom.equals("SendAllStudent"))
				{
					//	String select_query  	= "select g.firstname,g.emailid,a.standardscheduleid,b.sessionname,c.standardname from standard c,standardschedule a,yearofsession b,sectionschedule d,studentallocation e,candidateregister f,personmaster g where a.sessionid=b.sessionid and b.sessionid='"+sessionid+"' and c.standardid=a.standardid and  b.sessionstatus='A' and stdschedulestatus='A' and c.standardstatus='A' and sectionschedulestatus='A' and c.instituteid='"+instituteid+"' and d.standardscheduleid=a.standardscheduleid and e.sectionscheduleid=d.sectionscheduleid and e.studentallocationstatus='A' and f.candidateregisterid=e.candidateregisterid and f.candidateregisterstatus='A' and g.personid=f.personid";
					select_query  	= "select g.firstname,g.emailid,a.standardscheduleid,b.sessionname,c.standardname from standard c,standardschedule a,yearofsession b,sectionschedule d,studentallocation e,candidateregister f,personmaster g where a.sessionid=b.sessionid and c.standardid=a.standardid and  b.sessionstatus='A' and stdschedulestatus='A' and c.standardstatus='A' and sectionschedulestatus='A' and c.instituteid='"+instituteid+"' and d.standardscheduleid=a.standardscheduleid and e.sectionscheduleid=d.sectionscheduleid and e.studentallocationstatus='A' and f.candidateregisterid=e.candidateregisterid and f.candidateregisterstatus='A' and g.personid=f.personid";
					secList		 	= common_data_object.getListMap(select_query);
				}
				else if(towhom.equals("SendAllStaffs"))
				{
					select_query  = "select g.personid,g.emailid from standardschedule a,yearofsession b,subjectschedule c,subjectallotment d,staffmaster e,login f,personmaster g where a.sessionid=b.sessionid and b.sessionstatus='A' and a.stdschedulestatus='A' and c.status='A' and c.standardscheduleid=a.standardscheduleid and c.subjectscheduleid=d.subjectscheduleid and e.staffstatus='A' and d.staffid=e.staffid and f.userid=e.userid and f.loginstatus='A' and g.status='A' and g.personid=f.personid and g.instituteid='"+instituteid+"' group by g.personid";
					secList		 	= common_data_object.getListMap(select_query);
				}
				else if(towhom.equals("SendAll"))
				{//both student and staff those are in selected instituteid the year of session should be in active mode.
					/*select_query  = "select g.personid,g.emailid from standard c,standardschedule a,yearofsession b," +
									"sectionschedule d,studentallocation e, candidateregister f,personmaster g where a.sessionid=b.sessionid  " +
									"and c.standardid=a.standardid and  b.sessionstatus='A' and stdschedulestatus='A' and c.standardstatus='A'" +
									" and sectionschedulestatus='A' and c.instituteid='2' and d.standardscheduleid=a.standardscheduleid " +
									"and e.sectionscheduleid=d.sectionscheduleid and e.studentallocationstatus='A' and " +
									"f.candidateregisterid=e.candidateregisterid and f.candidateregisterstatus='A' " +
									"and g.personid=f.personid " +
									"union " +
									"select g.personid,g.emailid from standardschedule a,yearofsession b,subjectschedule c,subjectallotment d," +
									"staffmaster e,login f,personmaster g where a.sessionid=b.sessionid and b.sessionstatus='A' " +
									"and a.stdschedulestatus='A' and c.status='A' and c.standardscheduleid=a.standardscheduleid " +
									"and c.subjectscheduleid=d.subjectscheduleid and e.staffstatus='A' and d.staffid=e.staffid" +
									" and f.userid=e.userid and f.loginstatus='A' and g.status='A' and g.personid=f.personid" +
									" and g.instituteid='"+instituteid+"' group by g.personid";
								*/	   
					select_query  = "select g.personid,h.guardianmailid as emailid from standard c,standardschedule a,yearofsession b,sectionschedule d, studentallocation e,candidateregister f,personmaster g,studentguardian h where a.sessionid=b.sessionid  and c.standardid=a.standardid and b.sessionstatus='A' and stdschedulestatus='A' and c.standardstatus='A' and sectionschedulestatus='A' and c.instituteid='"+instituteid+"'  and d.standardscheduleid=a.standardscheduleid and e.sectionscheduleid=d.sectionscheduleid   and e.studentallocationstatus='A' and f.candidateregisterid=e.candidateregisterid  and f.candidateregisterstatus='A' and g.personid=f.personid and h.personid=g.personid union select g.personid,g.emailid from standardschedule a,yearofsession b,subjectschedule c,subjectallotment d,staffmaster e,login f,personmaster g where a.sessionid=b.sessionid and b.sessionstatus='A' and a.stdschedulestatus='A' and c.status='A' and c.standardscheduleid=a.standardscheduleid and c.subjectscheduleid=d.subjectscheduleid and e.staffstatus='A' and d.staffid=e.staffid and f.userid=e.userid and f.loginstatus='A' and g.status='A' and g.personid=f.personid and g.instituteid='"+instituteid+"' group by g.personid";
					secList		 	= common_data_object.getListMap(select_query);
				}
				if(secList != null && secList.size()>0)
				{
				
					StringBuffer strbuf = new StringBuffer();
					for(int y=0,j=1;y<secList.size();y++,j++)
					{		
						HashMap hm =(HashMap)secList.get(y);
						strbuf.append((String)hm.get("emailid"));
						if(y<(secList.size()-1)){
						strbuf.append(",");}
					}
					mailidstr= strbuf.toString();
				}
		}catch(Exception e){}
		return mailidstr;
	}
	
	private class SMTPAuthenticator extends javax.mail.Authenticator
	{  
		public PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(fromMailId, passWord);
		}
	}
 }