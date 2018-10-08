
<%@ page language="java" %>
<%@ page import="com.iGrandee.Registration.StudentRegistrationUpload" %>
<%@ page import="com.iGrandee.Registration.StudentRegistrationBean" %>
<%@ page import="com.iGrandee.Registration.StudentRegistrationQuery" %>

<%@ page import="com.iGrandee.Common.DateTime,java.util.ResourceBundle,java.io.File" %>

<% 

String instituid=(String)session.getValue("instituteid");
String sessionInstituteName = "";
sessionInstituteName=(String)session.getValue("institutename");

String sessionuserid = "";
sessionuserid=(String)session.getValue("userid");
DateTime dateobj=new DateTime();
StudentRegistrationBean gen_qu=new StudentRegistrationBean();

StudentRegistrationQuery gen_query=new StudentRegistrationQuery();
StudentRegistrationUpload upload=new StudentRegistrationUpload(request);
String photo=upload.startProcess();

		int result=0;

		if(!photo.equals("storage not connected"))
		{
		  String applicantname = null;
	      String fathername = null;
	      String mothername = null;
	      String dob = null;
	      String smscontactno	= null;
	    
	    
	      String nationality = null;
	      String community = null;
	      String religion = null;
	      String language = null;
	      String bloodgroup = null;
	      String landlinenumber = null;
	      String emailid = null;
	      String guardianname = null;
	      String guardianmailid = null;
	      String guardiandob = null;
	      String guardrelation = null;
	      String guardemployment = null;
	      String nameoforg = null;
	      String annualincome = null;
	      String guardposition = null;
	      String physicallyChallenge = null;
	      String ExServiceman = null;
	    
	      String TamilOrigin = null;
	      String firstgraduate = null;
	      String physicalmarks = null;
	    
	      String ExtraCurricular = null;
	      String PreviousSchoolDetails = null;
	      String PreviousSchooladdress = null;
	    
	      String PreviousSchoolboard = null;
	      String PreviousSchoolmedium = null;
	      String receiptofconcessio = null;
	    
	    
	    
	    
	      String street = null;
	      String city = null;
	      String state = null;
	      String country = null;
	      String zipcode = null;
	      String permanentstreet = null;
	      String permanentcity = null;
	      String permanentstate = null;
	      String permanentcountry = null;
	      String permanentzipcode = null;
	    
	    
	    
	      String subject [] = null;

	      String monthyear[] = null;
	      String markscored[] = null;
	      String maxmark[] = null;
	      String registionno[] = null;
	    
	   
	    
	      String tccheck = null;
	      String cccheck = null;
	      String sccheck = null;
	      String mccheck = null;
	      String mscheck = null;
	      String spccheck = null;
	      String applicantmiddlename = null;
	      String applicantlastname = null;
	      String studentusername = null;
	      String studentpassword = null;
	      
	       String studprefix = upload.getParameter("stud_prefix");

	       applicantname = upload.getParameter("studentname");
	       fathername = upload.getParameter("fathername");
	       mothername = upload.getParameter("mothername");
	       dob = upload.getParameter("originaldob");
	       applicantmiddlename = upload.getParameter("studentmiddlename");
	       applicantlastname = upload.getParameter("studentlastname");
	    
	       nationality = upload.getParameter("nationality");
	       community = upload.getParameter("community");
	       religion = upload.getParameter("religion");
	       language = upload.getParameter("othersmothertonque");
	       bloodgroup = upload.getParameter("bloodgroup");
	       landlinenumber = upload.getParameter("telephone");
	       emailid = upload.getParameter("email");
	       guardianname = upload.getParameter("guardianname");
	       guardianmailid = upload.getParameter("guardianmailid");
	       
	       guardiandob = upload.getParameter("father_bday");
	       guardrelation = upload.getParameter("relation");
	       guardemployment = upload.getParameter("self");
	       nameoforg = upload.getParameter("organization");
	       annualincome = upload.getParameter("annualincome");
	       guardposition = upload.getParameter("position");
	       physicallyChallenge = upload.getParameter("physically");
	       ExServiceman = upload.getParameter("exservice");
	    
	       TamilOrigin = upload.getParameter("origin");
	       firstgraduate = upload.getParameter("firstgraduate");
	       physicalmarks = upload.getParameter("physicalmarks");
	    
	       ExtraCurricular = upload.getParameter("extrahidden");
	       PreviousSchoolDetails = upload.getParameter("schoolname");
	       PreviousSchooladdress = upload.getParameter("schooladdress");
	    
	       PreviousSchoolboard = upload.getParameter("board");
	       PreviousSchoolmedium = upload.getParameter("medium");
   
	    
	       street = upload.getParameter("AddressForCommunication");
	       String street2 = upload.getParameter("communicationStreet2")+"";
				
	       city = upload.getParameter("communicationcity");
	       state = upload.getParameter("othercommunicationstate");
	       country = upload.getParameter("communicationcountry");
	       zipcode = upload.getParameter("communicationpin");
	       permanentstreet = upload.getParameter("permanent");
	       String   permanentstreet2 = upload.getParameter("permanentStreet2")+"";

	       permanentcity = upload.getParameter("permanentcity");
	       permanentstate = upload.getParameter("othercommunicationstate1");
	       permanentcountry = upload.getParameter("permanentcountry");
	       permanentzipcode = upload.getParameter("permanentpin");
	       smscontactno		= upload.getParameter("smscontactno");
	    
	        
	       subject  = upload.getParameterValues("subject");

	       monthyear = upload.getParameterValues("month");
	       markscored = upload.getParameterValues("mark");
	       maxmark = upload.getParameterValues("max");
	       registionno = upload.getParameterValues("registrationno");
	    
	   
	    
	       tccheck = upload.getParameter("tc");
	       cccheck = upload.getParameter("cc");
	       sccheck = upload.getParameter("splCategory");
	       mccheck = upload.getParameter("mc");
	       mscheck = upload.getParameter("ms");
	       spccheck = upload.getParameter("sc");
	       
	     String standardscheduleid = upload.getParameter("standardscheduleid");
	     String studentapprovalid = upload.getParameter("studentapprovalid");
	     //System.out.println("standardscheduleid===========>>>>"+standardscheduleid);
	    // System.out.println("PreviousSchooladdress===========>>>>"+PreviousSchooladdress);

	       studentusername= upload.getParameter("studusernamehidden");
	       studentpassword = upload.getParameter("studpassword");
	       //System.out.println("studentusername"+studentusername);
	     String  parentusername= upload.getParameter("studparentusername");
	     String  parentpassword = upload.getParameter("studparentpassword");
	     String  ageofstudent = upload.getParameter("ageyears");
	     String  studsex = upload.getParameter("studsex");
	     String  schoolstatus = upload.getParameter("schoolstatus");
	    	String mobileno = upload.getParameter("mobileno")+"";
		if(mobileno.equals("") || mobileno.equals("null"))
			mobileno="-";
	     gen_qu.setStudprefix(studprefix);
	     gen_qu.setSchoolstatus(schoolstatus); 
	     gen_qu.setMobileno(mobileno); 

	     gen_qu.setStudage(ageofstudent);
	     gen_qu.setStudsex(studsex);

	     gen_qu.setStudlastname(applicantlastname);
	     gen_qu.setStudmiddlename(applicantmiddlename);

	     gen_qu.setParentusername(parentusername);
       	 gen_qu.setParentpassword(parentpassword);
	     
	        gen_qu.setStudentapprovalid(studentapprovalid);
	       	 gen_qu.setStandardscheduleid(standardscheduleid);
	       	
	      	gen_qu.setApplicantname(applicantname);
	        gen_qu.setFathername(fathername);
	        gen_qu.setMothername(mothername);
	        gen_qu.setDob(dob);
	        
	        gen_qu.setPhoto(photo);
		    String  phototype = upload.getParameter("phototype");
		    System.out.println("phototype********* "+phototype);

		    if(phototype.equalsIgnoreCase("snapshot"))
		    {
		    	ResourceBundle  rbundle = ResourceBundle.getBundle("resources.serversetup");
		    	String shapshotpath=rbundle.getString("shapshot");
		    	System.out.println("shapshotpath********* "+shapshotpath);
		    	String imagePath=rbundle.getString("storagepath")+"/imagestorage/";
		    	String imageName="studentimage_"+studentapprovalid+".jpg"; 
		    	File src=new File(imagePath+imageName);
		    	String newphotopath=photo.substring(0, photo.lastIndexOf("/"));
		    	File dst=new File(rbundle.getString("storagepath")+newphotopath);
		    	if(!dst.exists())
		    		dst.mkdirs();
		    	File dst2=new File(rbundle.getString("storagepath")+photo);
		    	dst2.createNewFile();
		    	java.io.InputStream in1 = new java.io.FileInputStream(src);
		    	java.io.OutputStream out1 = new java.io.FileOutputStream(dst2);
		    	
		         // Transfer bytes from in to out
		         byte[] buf = new byte[1024];
		         int len;
		         while ((len = in1.read(buf)) > 0) {
		             out1.write(buf, 0, len);
		         }
			    System.out.println("dst********* "+dst.exists());

		         in1.close();
		         out1.close();	
		         src.delete();
		     }
	    
	        gen_qu.setNationality(nationality);
	        gen_qu.setCommunity(community);
	      gen_qu.setReligion(religion);
	        gen_qu.setLanguage(language);
		    // System.out.println("bloodgroup"+bloodgroup);

	        gen_qu.setBloodgroup(bloodgroup);
	        gen_qu.setLandlinenumber(landlinenumber);
	        gen_qu.setEmailid(emailid);
	       gen_qu.setGuardianname(guardianname);
	       gen_qu.setGuardianmailid(guardianmailid);
	       
	       gen_qu.setGuardiandob(guardiandob);
	       gen_qu.setGuardrelation(guardrelation);
	       gen_qu.setGuardemployment(guardemployment);
	       gen_qu.setNameoforg(nameoforg);
	      	gen_qu.setAnnualincome(annualincome);
	       gen_qu.setGuardposition(guardposition);
	        gen_qu.setPhysicallyChallenge(physicallyChallenge);
	         gen_qu.setExServiceman(ExServiceman);
	    
	         gen_qu.setTamilOrigin(TamilOrigin);
	         gen_qu.setFirstgraduate(firstgraduate);
	       gen_qu.setPhysicalmarks(physicalmarks);
	    
	        gen_qu.setExtraCurricular(ExtraCurricular);
	        gen_qu.setPreviousSchoolDetails(PreviousSchoolDetails);
	         gen_qu.setPreviousSchooladdress(PreviousSchooladdress);
	    
	        gen_qu.setPreviousSchoolboard(PreviousSchoolboard);
	        gen_qu.setPreviousSchoolmedium(PreviousSchoolmedium);
	    
	    
	       gen_qu.setStreet1(street);
	       gen_qu.setStreet2(street2);

	        gen_qu.setCity(city);
	       gen_qu.setState(state);
	       gen_qu.setCountry(country);
	        gen_qu.setZipcode(zipcode);
	        gen_qu.setPermanentstreet1(permanentstreet);
	        gen_qu.setPermanentstreet2(permanentstreet2);

	       gen_qu.setPermanentcity(permanentcity);
	        gen_qu.setPermanentstate(permanentstate);
	       gen_qu.setPermanentcountry(permanentcountry);
	       gen_qu.setPermanentzipcode(permanentzipcode);
	       gen_qu.setSmsContactNo(smscontactno);
	    
	    
	    
	        gen_qu.setSubject(subject);
	        gen_qu.setMonthyear(monthyear);
	        gen_qu.setMarkscored(markscored);
	      	gen_qu.setMaxmark(maxmark);
	        gen_qu.setRegistionno(registionno);
	        gen_qu.setTccheck(tccheck);
		     gen_qu.setCccheck(cccheck);
		     gen_qu.setSccheck(sccheck);
		     gen_qu.setMccheck(mccheck);
		     gen_qu.setMscheck(mscheck);
		     gen_qu.setSpccheck(spccheck);
		     gen_qu.setCreatedby(sessionuserid);
		     gen_qu.setInstituteid(instituid);
		     gen_qu.setSessionInstituteName(sessionInstituteName);
		     gen_qu.setStudentusername(studentusername);
		     gen_qu.setStudentpassword(studentpassword);
		     String parentid = upload.getParameter("parentid");
		   //  System.out.println("parentid===========>>>>"+parentid);
		     gen_qu.setParentid(parentid);
		     
		     gen_qu.setScholarshipallocation(upload.getParameterValues("scholarshipallocation"));
		     gen_qu.setTermfeesid(upload.getParameterValues("termfeesid"));
		     gen_qu.setAmount(upload.getParameterValues("amount"));
		     
	         
		      
		String ipaddress  = request.getRemoteHost();
		gen_qu.setIpaddress(ipaddress);
		 result=gen_query.StudentRegistration(gen_qu); 
		}
		else
		{
			result=-1;
		}
		String resultword="";
		if(result ==1000)
		{
			resultword="The Following Student Username Already Exists :"+gen_qu.getStudentusername();
			result=0;
		}
		else if(result ==1001)
		{
			resultword="The Following Parent Username Already Exists :"+gen_qu.getParentusername();
			result=0;
		}
		else if(result >0)
		{
			resultword="Student Profile Inserted Successfully ";
		}
		else
		{
			if(result==-1)
				resultword="Insertion Failed Due to Storage Device not connected ";
				else
				resultword="Operation Failed";
		}
		//System.out.println("result===========>>>>"+result);
		//String return_file = "./Registration/StudentApplicationSearch.jsp";
		String return_file = request.getContextPath()+"/jsp/Registration/StudentApplicationSearch.jsp";
		//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?result="+result+"&returnurl="+return_file+"&message="+resultword);
		response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+resultword+"&result="+result+"&returnurl="+return_file);
		
		%>
		

