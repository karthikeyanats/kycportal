
package com.iGrandee.Registration;

import java.io.Serializable;

import org.apache.log4j.Logger;

public class StaffRegistrationBean   implements Serializable
{
	static Logger log = Logger.getLogger(StaffRegistrationBean.class);

    public StaffRegistrationBean()
    {
    }
    
    public void setipaddress(String s)
    {
    	ipaddress = s;
    }

    public String getipaddress()
    {
        return ipaddress;
    }
    public void setOperation(String s)
    {
        operation = s;
    }

    public String getOperation()
    {
        return operation;
    }
    public void setAgent_Id(String l)
    {
        agent_id = l;
    }

    public String getAgent_Id()
    {
        return agent_id;
    }

    public void setAppFilePath(String s)
    {
        appfilepath = s;
    }

    public String getAppFilePath()
    {
        return appfilepath;
    }

    public void setInstituteAppId(String s)
    {
        instituteappid = s;
    }

    public String getInstituteAppId()
    {
        return instituteappid;
    }

    public void setAgentId(String s)
    {
        agentid = s;
    }

    public String getAgentId()
    {
        return agentid;
    }

    public void setInstituteId(String s)
    {
        instituteid = s;
    }

    public String getInstituteId()
    {
        return instituteid;
    }

    public void setPersonId(String s)
    {
        personid = s;
    }

    public String getPersonId()
    {
        return personid;
    }

    public void setPersonName(String s)
    {
        personname = s;
    }

    public String getPersonName()
    {
        return personname;
    }

    public void setContact(String s)
    {
        contact = s;
    }

    public String getContact()
    {
        return contact;
    }

    public void setFirstName(String s)
    {
        firstname = s;
    }

    public String getFirstName()
    {
        return firstname;
    }
    public void setprefix(String s)
    {
    	prefix = s;
    }

    public String getprefix()
    {
        return prefix;
    }

    public void setUserId(String s)
    {
        user = s;
    }

    public String getUserId()
    {
        return user;
    }

    public void setMidName(String s)
    {
        midname = s;
    }

    public String getMidName()
    {
        return midname;
    }

    public void setLastName(String s)
    {
        lastname = s;
    }

    public String getLastName()
    {
        return lastname;
    }

    public void setGender(String s)
    {
        gender = s;
    }

    public String getGender()
    {
        return gender;
    }

    public void setDOB(String s)
    {
        dob = s;
    }

    public String getDOB()
    {
        return dob;
    }

    public void setPhoto(String s)
    {
		log.info("(((((((((((setPhoto)))))))))))"+photo);
        photo = s;
    }

    public String getPhoto()
    {
		log.info("(((((((((((getPhoto)))))))))))"+photo);
        return photo;
    }

    public void setMStatus(String s)
    {
        mstatus = s;
    }

    public String getMStatus()
    {
        return mstatus;
    }

    public void setStreet1(String s)
    {
        street1 = s;
    }

    public String getStreet1()
    {
        return street1;
    }
    public void setStreet2(String s)
    {
        street2 = s;
    }

    public String getStreet2()
    {
        return street2;
    }
    public void setpermanentStreet1(String s)
    {
    	permanentstreet1 = s;
    }

    public String getpermanentStreet1()
    {
        return permanentstreet1;
    }
    public void setpermanentStreet2(String s)
    {
    	permanentstreet2 = s;
    }

    public String getpermanentStreet2()
    {
        return permanentstreet2;
    }

    public void setCity(String s)
    {
        city = s;
    }

    public String getCity()
    {
        return city;
    }

    public void setState(String s)
    {
        state = s;
    }

    public String getState()
    {
        return state;
    }

    public void setCountry(String s)
    {
        country = s;
    }

    public String getCountry()
    {
        return country;
    }

    public void setZipCode(String s)
    {
        zipcode = s;
    }

    public String getZipCode()
    {
        return zipcode;
    }
    public void setpermanentCity(String s)
    {
    	permanentcity = s;
    }

    public String getpermanentCity()
    {
        return permanentcity;
    }

    public void setpermanentState(String s)
    {
    	permanentstate = s;
    }

    public String getpermanentState()
    {
        return permanentstate;
    }

    public void setpermanentCountry(String s)
    {
    	permanentcountry = s;
    }

    public String getpermanentCountry()
    {
        return permanentcountry;
    }

    public void setpermanentZipCode(String s)
    {
    	permanentzipcode = s;
    }

    public String getpermanentZipCode()
    {
        return permanentzipcode;
    }

    public void setFatherName(String s)
    {
        fathername = s;
    }

    public String getFatherName()
    {
        return fathername;
    }

    public void setMotherName(String s)
    {
        mothername = s;
    }

    public String getMotherName()
    {
        return mothername;
    }
    
    public void setFQualification(String s)
    {
        fqualification = s;
    }

    public String getFQualification()
    {
        return fqualification;
    }

    public void setFOccupation(String s)
    {
        occupation = s;
    }

    public String getFOccupation()
    {
        return occupation;
    }

    public void setJoiningDate(String s)
    {
        joiningdate = s;
    }

    public String getJoiningDate()
    {
        return joiningdate;
    }

    public void setCaste(String s)
    {
        caste = s;
    }

    public String getCaste()
    {
        return caste;
    }

    public void setCommunity(String s)
    {
        community = s;
    }

    public String getCommunity()
    {
        return community;
    }

    public void setReligion(String s)
    {
        religion = s;
    }

    public String getReligion()
    {
        return religion;
    }

    public void setBloodGroup(String s)
    {
        bloodgroup = s;
    }

    public String getBloodGroup()
    {
        return bloodgroup;
    }

    public void setPhone(String s)
    {
        phone = s;
    }

    public String getPhone()
    {
        return phone;
    }

    public void setMobile(String s)
    {
        mobile = s;
    }

    public String getMobile()
    {
        return mobile;
    }

    public void setLandLine(String s)
    {
        landline = s;
    }

    public String getLandLine()
    {
        return landline;
    }

    public void setEmergency(String s)
    {
        emergency = s;
    }

    public String getEmergency()
    {
        return emergency;
    }

    public void setQualification(String s)
    {
        qualification = s;
    }

    public String getQualification()
    {
        return qualification;
    }

    public void setExperience(String s)
    {
        experience = s;
    }

    public String getExperiencen()
    {
        return experience;
    }

    public void setSpecialization(String s)
    {
        specialization = s;
    }

    public String getSpecialization()
    {
        return specialization;
    }

    public void setUserName(String s)
    {
        userid = s;
    }

    public String getUserName()
    {
        return userid;
    }

    public void setPassWd(String s)
    {
        passwd = s;
    }

    public String getPassWd()
    {
        return passwd;
    }

    public void setQuestion(String s)
    {
        question = s;
    }

    public String getQuestion()
    {
        return question;
    }

    public void setAnswer(String s)
    {
        answer = s;
    }

    public String getAnswer()
    {
        return answer;
    }

    public void setPost(String s)
    {
        post = s;
    }

    public String getPost()
    {
        return post;
    }

    public void setEMail(String s)
    {
        email = s;
    }

    public String getEMail()
    {
        return email;
    }

    public void setStdId(String s)
    {
        log.info("bean ==>" + s);
        stdid = s;
    }

    public String getStdId()
    {
        log.info(stdid);
        return stdid;
    }

    public void setStdName(String s)
    {
        stdname = s;
    }

    public String getStdName()
    {
        return stdname;
    }

    public void setStatus(String s)
    {
        log.info("status" + s);
        status = s;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStdStatus(String s)
    {
        stdstatus = s;
    }

    public String getStdStatus()
    {
        return stdstatus;
    }

    public void setCenterStatus(String s)
    {
        centerstatus = s;
    }

    public String getCenterStatus()
    {
        return centerstatus;
    }

    public void setDocumentName(String s)
    {
        docname = s;
    }

    public String getDocumentName()
    {
        return docname;
    }

    public void setFinishingDate(String s)
    {
        finishingdate = s;
    }

    public String getFinishingDate()
    {
        return finishingdate;
    }

    public void setMerit(String s)
    {
        merit = s;
    }

    public String getMerit()
    {
        return merit;
    }

    public void setInstitution(String s)
    {
        institution = s;
    }

    public String getInstitution()
    {
        return institution;
    }

    public void setVerifiedBy(String s)
    {
        institution = s;
    }

    public String getVerifiedBy()
    {
        return institution;
    }

    public void setRoleid(String s)
    {
        roleid = s;
    }

    public String getRoleid()
    {
        return roleid;
    }

    public void setStdhandle(String s)
    {
        courseval = s;
    }

    public String getStdhandle()
    {
        return courseval;
    }

    public void setInstituteMode(String s)
    {
        instmode = s;
    }

    public String getInstituteMode()
    {
        return instmode;
    }

    public void setEmployeeId(String s)
    {
        employeeId = s;
    }

    public String getEmployeeId()
    {
        return employeeId;
    }

    public void setStudio(String s)
    {
        studio = s;
    }

    public String getStudio()
    {
        return studio;
    }

    public void setMainsubjects(String s)
    {
        mainsubjects = s;
    }

    public String getMainsubjects()
    {
        return mainsubjects;
    }

    public void setSessionval(String s)
    {
        sessionval = s;
    }

    public String getSessionval()
    {
        return sessionval;
    }

    public void setPercentage(String s)
    {
        percentage = s;
    }

    public String getPercentage()
    {
        return percentage;
    }

    public void setUniversity(String s)
    {
        university = s;
    }

    public String getUniversity()
    {
        return university;
    }

    public void setDepartment(String s)
    {
		departmentId = s;
	}
    public String getDepartment()
    {
		return departmentId;
    }

    public void setRole(String s)
    {
		roleId = s;
	}
	public String getRole()
	{
		return roleId;
    }
    public void setRoleDescription(String s)
	    {
			roledescription = s;
		}
		public String getRoleDescription()
		{
			return roledescription;
    }


    public void setInstituteName(String s)
    {
		log.info("instituteName"+instituteName);
		instituteName = s;
	}
	public String getInstituteName()
	{
		return instituteName;
    }

    public void setInstituteRole(String s)
    {
		instituteRole = s;
	}
	public String getInstituteRole()
	{
		return instituteRole;
    }

    public void setInstitutePeriod(String s)
    {
		institutePeriod = s;
	}
	public String getInstitutePeriod()
	{
		return institutePeriod;
    }

    public void setInstituteFDateEx(String s)
    {
		instituteFDateEx = s;
	}
	public String getInstituteFDateEx()
	{
		return instituteFDateEx;
    }

    public void setInstituteTDateEx(String s)
    {
		instituteTDateEx = s;
	}
	public String getInstituteTDateEx()
	{
		return instituteTDateEx;
    }


	public void setPubliCations(String s)
	{
		log.info("publiCationspubliCationspubliCationspubliCationspubliCations"+publiCations);
		publiCations = s;
	}
	public String getPubliCations() {
		return publiCations;
    }
	public void setAboutMe(String s)
	{
		aboutMe = s;
	}
	public String getAboutMe() {
		return aboutMe;
    }

    public void setAreaOfInterest(String s)
    {
		log.info("setAreaOfInterestareaOfInterestareaOfInterestareaOfInterest"+areaOfInterest);
		areaOfInterest = s;
	}
	public String getAreaOfInterest() {
		return areaOfInterest;
    }

    public void setLevelPaper(String s)
    {
		levelPaper = s;
	}
	public String getLevelPaper()
	{
		return levelPaper;
    }

    public void setConName(String s)
    {
		conName = s;
	}
	public String getConName()
	{
		return conName;
    }

    public void setTitlePaper(String s)
    {
		titlePaper = s;
	}
	public String getTitlePaper()
	{
		return titlePaper;
    }

    public void setDatePaper(String s)
    {
		datePaper = s;
	}
	public String getDatePaper()
	{
		return datePaper;
    }

    public void setInstitutePaper(String s)
    {
		institutePaper = s;
	}
	public String getInstitutePaper()
	{
		return institutePaper;
    }

    public void setNamePub(String s)
    {
		namePub = s;
	}
	public String getNamePub()
	{
		return namePub;
    }

    public void setTitlePub(String s)
    {
		titlePub = s;
	}
	public String getTitlePub()
	{
		return titlePub;
    }

    public void setIssuPub(String s)
    {
		issuPub = s;
	}
	public String getIssuPub()
	{
		return issuPub;
    }

    public void setIsbnPub(String s)
    {
		isbnPub = s;
	}
	public String getIsbnPub()
	{
		return isbnPub;
    }

    public void setPagePub(String s)
    {
		pagePub = s;
	}
	public String getPagePub()
	{
		return pagePub;
    }

    public void setAuthorPub(String s)
    {
		authPub = s;
	}
	public String getAuthorPub()
	{
		return authPub;
    }

    public void setYearPub(String s)
    {
		yearPub = s;
	}
	public String getYearPub()
	{
		return yearPub;
    }
	
	
	public void setmajor(String s[])
    {
		major = s;
	}
	public String [] getmajor()
	{
		return major;
    }
	public void setuser_qualification(String s[])
    {
		user_qualification = s;
	}
	public String[] getuser_qualification()
	{
		return user_qualification;
    }
	public void setYearofgrad(String s[])
    {
		Yearofgrad = s;
	}
	public String [] getYearofgrad()
	{
		return Yearofgrad;
    }
	public void setmarks(String s[])
    {
		marks = s;
	}
	public String[] getmarks()
	{
		return marks;
    }
	public void setinstitutename(String s[])
    {
		institutename = s;
	}
	public String [] getinstitutename()
	{
		return institutename;
    }
	public void setdocumentname(String s[])
    {
		documentname = s;
	}
	public String [] getdocumentname()
	{
		return documentname;
    }
	public void setinstitution(String s[])
    {
		institution1 = s;
	}
	public String [] getinstitution()  
	{
		return institution1;
    }
	
	public void setfinishingdate(String s[])
    {
		finishingdate1 = s;
	}
	public String [] getfinishingdate()  
	{
		return finishingdate1;
    }
	public void setinstName(String s[])
    {
		instName = s;
	}
	public String [] getinstName()  
	{
		return instName;
    }
	public void setinstRole(String s[])
    {
		instRole = s;
	}
	public String [] getinstRole()  
	{
		return instRole;
    }
	public void setinstPeriod(String s[])
    {
		instPeriod = s;
	}
	public String [] getinstPeriod()  
	{
		return instPeriod;
    }
	public void setinstFDateEx(String s[])
    {
		instFDateEx = s;
	}
	public String [] getinstFDateEx()  
	{
		return instFDateEx;
    }
	public void setinstTDateEx(String s[])
    {
		instTDateEx = s;
	}
	public String [] getinstTDateEx()  
	{
		return instTDateEx;
    }
	public void setlevelofPaper(String s[])
    {
		levelofPaper = s;
	}
	public String [] getlevelofPaper()  
	{
		return levelofPaper;
    }
	public void setconferenceName(String s[])
    {
		conferenceName = s;
	}
	public String [] getconferenceName()  
	{
		return conferenceName;
    }
	public void settitleofPaper(String s[])
    {
		titleofPaper = s;
	}
	public String [] gettitleofPaper()  
	{
		return titleofPaper;
    }
	public void setdateofPaper(String s[])
    {
		dateofPaper = s;
	}
	public String [] getdateofPaper()  
	{
		return dateofPaper;
    }
	public void setinstituteofPaper(String s[])
    {
		instituteofPaper = s;
	}
	public String [] getinstituteofPaper()  
	{
		return instituteofPaper;
    }
	public void setnameofPub(String s[])
    {
		nameofPub = s;
	}
	public String [] getnameofPub()  
	{
		return nameofPub;
    }
	public void settitleofPub(String s[])
    {
		titleofPub = s;
	}
	public String [] gettitleofPub()  
	{
		return titleofPub;
    }
	public void setissuofPub(String s[])
    {
		issuofPub = s;
	}
	public String [] getissuofPub()  
	{
		return issuofPub;
    }
	public void setisbnofPub(String s[])
    {
		isbnofPub = s;
	}
	public String [] getisbnofPub()  
	{
		return isbnofPub;
    }
	public void setpageofPub(String s[])
    {
		pageofPub = s;
	}
	public String [] getpageofPub()  
	{
		return pageofPub;
    }
	public void setauthofPub(String s[])
    {
		authofPub = s;
	}
	public String [] getauthofPub()  
	{
		return authofPub;
    }
	public void setyearofPub(String s[])
    {
		yearofPub = s;
	}
	public String [] getyearofPub()  
	{
		return yearofPub;
    }
	private String nameofPub[]	=null;
	private String titleofPub[]	=null;
	private String issuofPub[]	=null;
	private String isbnofPub[]	=null;
	private String pageofPub[]	=null;
	private String authofPub[]	=null;
	private String yearofPub[]	=null;
	
	private String levelofPaper[]	=null;
	private String conferenceName[]	=null;
	private String titleofPaper[]	=null;
	private String dateofPaper[]		=null;
	private String instituteofPaper[]		=null; 
	
	private String instName[]	=null;
	private String instRole[]	=null;
	private String instPeriod[]	=null;
	private String instFDateEx[]	=null;
	private String instTDateEx[]	 =null;     
	
	private String [] major=null;
	private String [] user_qualification=null;
	private String [] Yearofgrad=null;
	private String [] marks=null;
	private String [] institutename=null;
	
	private String [] documentname =null;
	private String [] institution1 =null;
	private String [] finishingdate1 =null;
	
    private  String mainsubjects = null;
    private  String sessionval = null;
    private  String percentage = null;
    private  String university = null;
    private  String user = null;
    private  String operation = null;
    private  String agentid = null;
    private  String agent_id = null;
    private  String personid = null;
    private  String personname = null;
    private  String contact = null;
    
    private  String prefix = null;
    private  String age = null;

    private  String firstname = null;
    private  String midname = null;
    private  String lastname = null;
    private  String gender = null;
    private  String photo = null;
    private  String dob = null;
    private String dobmail = null;
    private  String street1 = null;
    private  String street2 = null;
    private  String city = null;
    private  String state = null;
    private  String country = null;
    private  String zipcode = null;
    private  String permanentstreet1 = null;
    private  String permanentstreet2 = null;
    private  String permanentcity = null;
    private  String permanentstate = null;
    private  String permanentcountry = null;
    private  String permanentzipcode = null;
    
    private  String qualification = null;
    private  String experience = null;
    private  String specialization = null;
    private  String userid = null;
    private  String passwd = null;
    private  String question = null;
    private  String answer = null;
    private  String post = null;
    private  String fathername = null;
    private  String mothername = null;
    private  String occupation = null;
    private  String fqualification = null;
    private  String joiningdate = null;
    private  String joiningdatemail = null;
    private  String instmode = null;
    private  String appfilepath = null;
    private  String instituteappid = null;
    private  String mstatus = null;
    private  String caste = null;
    private  String religion = null;
    private  String community = null;
    private  String phone = null;
    private  String mobile = null;
    private  String landline = null;
    private  String emergency = null;
    private  String bloodgroup = null;
    private  String email = null;
    private  String status = null;
    private  String roleid = null;
    private  String stdid = null;
    private  String stdname = null;
    private  String stdstatus = null;
    private  String centerstatus = null;
    private  String instituteid = null;
    private  String docname = null;
    private  String institution = null;
    private  String finishingdate = null;
    private  String merit = null;
    private  String courseval = null;
    private  String employeeId = null;
    private  String studio = null;
	private  String departmentId = null;
	private  String roleId = null;
	private  String instituteName=null;
	private  String instituteRole=null;
	private  String institutePeriod=null;
	private  String instituteFDateEx=null;
	private  String instituteTDateEx=null;

	private  String areaOfInterest=null;
	private  String publiCations=null;
	private  String aboutMe=null;
	private  String roledescription=null;

	private  String levelPaper=null;
	private  String conName=null;
	private  String titlePaper=null;
	private  String datePaper=null;
	private  String institutePaper=null;
	
	private  String documentid []=null;
	private  String documentnames=null;
	private  String documentpath=null;
	private  String documentstatus=null;

	private  String namePub=null;
	private  String titlePub=null;
	private  String issuPub=null;
	private  String isbnPub=null;
	private  String pagePub=null;
	private  String authPub=null;
	private  String yearPub=null;
	private  String ipaddress=null;
	private  String Staffid=null;
	private  String staffqualificationid []=null;
	private  String staffexperienceid []=null;
	private  String updatestatus []=null;
	private  String updatestatus1 []=null;
	
	private  String editdob=null;
	private  String editjoindate=null;
	private  String []  verficertificatename =null;
	private  String []  verficertificatepath =null;
	private  String smsmobile=null;

	

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getStaffid() {
		return Staffid;
	}

	public void setStaffid(String staffid) {
		Staffid = staffid;
	}

	public String[] getStaffqualificationid() {
		return staffqualificationid;
	}

	public void setStaffqualificationid(String[] staffqualificationid) {
		this.staffqualificationid = staffqualificationid;
	}

	public String[] getStaffexperienceid() {
		return staffexperienceid;
	}

	public void setStaffexperienceid(String[] staffexperienceid) {
		this.staffexperienceid = staffexperienceid;
	}

	public String[] getUpdatestatus() {
		return updatestatus;
	}

	public void setUpdatestatus(String[] updatestatus) {
		this.updatestatus = updatestatus;
	}

	public String[] getUpdatestatus1() {
		return updatestatus1;
	}

	public void setUpdatestatus1(String[] updatestatus1) {
		this.updatestatus1 = updatestatus1;
	}

	private  String sessionInstituteName=null;

	public String getSessionInstituteName() {
		return sessionInstituteName;
	}

	public void setSessionInstituteName(String sessionInstituteName) {
		this.sessionInstituteName = sessionInstituteName;
	}

	public String[] getVerficertificatename() {
		return verficertificatename;
	}

	public void setVerficertificatename(String[] verficertificatename) {
		this.verficertificatename = verficertificatename;
	}

	public String[] getVerficertificatepath() {
		return verficertificatepath;
	}

	public void setVerficertificatepath(String[] verficertificatepath) {
		this.verficertificatepath = verficertificatepath;
	}

		public String getDocumentnames() {
		return documentnames;
	}

	public void setDocumentnames(String documentnames) {
		this.documentnames = documentnames;
	}

	public String getDocumentpath() {
		return documentpath;
	}

	public void setDocumentpath(String documentpath) {
		this.documentpath = documentpath;
	}

	public String getDocumentstatus() {
		return documentstatus;
	}

	public void setDocumentstatus(String documentstatus) {
		this.documentstatus = documentstatus;
	}

	public void setDocumentid(String[] documentid) {
		this.documentid = documentid;
	}

	public String[] getDocumentid() {
		return documentid;
	}
	
		public String getDobmail() {
		return dobmail;
	}
	public void setDobmail(String dobmail) {
		this.dobmail = dobmail;
	}

	public String getJoiningdatemail() {
		return joiningdatemail;
	}
	public void setJoiningdatemail(String joiningdatemail) {
		this.joiningdatemail = joiningdatemail;
	}

	public String getEditdob() {
		return editdob;
	}

	public void setEditdob(String editdob) {
		this.editdob = editdob;
	}

	public String getEditjoindate() {
		return editjoindate;
	}

	public void setEditjoindate(String editjoindate) {
		this.editjoindate = editjoindate;
	}

	public String getSmsmobile() {
		return smsmobile;
	}

	public void setSmsmobile(String smsmobile) {
		this.smsmobile = smsmobile;
	}

	    
}