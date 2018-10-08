package com.iGrandee.Registration;

import java.io.Serializable;

public class StudentRegistrationBean   implements Serializable
{
    private  String studprefix = null;

    private  String applicantname = null;
    private  String fathername = null;
    private  String mothername = null;
    private  String photo = null;
    private  String dob = null;
    private String dobMail = null;
    
    
    private  String nationality = null;
    private  String community = null;
    private  String religion = null;
    private  String language = null;
    private  String bloodgroup = null;
    private  String landlinenumber = null;
    private  String emailid = null;
    private  String guardianname = null;
    private  String guardianmailid= null;
    private  String guardiandob = null;
    private  String guardrelation = null;
    private  String guardemployment = null;
    private  String nameoforg = null;
    private  String annualincome = null;
    private  String guardposition = null;
    private  String physicallyChallenge = null;
    private  String ExServiceman = null;
    
    
    private  String TamilOrigin = null;
    private  String firstgraduate = null;
    private  String physicalmarks = null;
    
    private  String ExtraCurricular = null;
    private  String PreviousSchoolDetails = null;
    private  String PreviousSchooladdress = null;
    
    private  String PreviousSchoolboard = null;
    private  String PreviousSchoolmedium = null;
    private  String receiptofconcessio = null;
    
    
    
    
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
    private  String feestermid = null;
    
    
    
    public String getFeestermid() {
		return feestermid;
	}
	public void setFeestermid(String feestermid) {
		this.feestermid = feestermid;
	}

	private  String subject [] = null;
    private  String communities[] = null;
    private  String religions[] = null;
    

    /**
	 * @return the religions
	 */
	public String[] getReligions() {
		return religions;
	}
	/**
	 * @param religions the religions to set
	 */
	public void setReligions(String[] religions) {
		this.religions = religions;
	}
	public String[] getCommunities() {
		return communities;
	}
	public void setCommunities(String[] communities) {
		this.communities = communities;
	}
	
	private  String scholarshipnames[] = null;
	

	public String[] getScholarshipnames() {
		return scholarshipnames;
	}
	public void setScholarshipnames(String[] scholarshipnames) {
		this.scholarshipnames = scholarshipnames;
	}

	private  String monthyear[] = null;
    private  String markscored[] = null;
    private  String maxmark[] = null;
    private  String registionno[] = null;
    private  String scholarshipamountallocationid[] = null;
    private  String feescollectionid[] = null;
    private  String schemeforstudentid[] = null;
    
    
   
    
    public String[] getSchemeforstudentid() {
		return schemeforstudentid;
	}
	public void setSchemeforstudentid(String[] schemeforstudentid) {
		this.schemeforstudentid = schemeforstudentid;
	}
	public String[] getFeescollectionid() {
		return feescollectionid;
	}
	public void setFeescollectionid(String[] feescollectionid) {
		this.feescollectionid = feescollectionid;
	}
	public String[] getScholarshipamountallocationid() {
		return scholarshipamountallocationid;
	}
	public void setScholarshipamountallocationid(
			String[] scholarshipamountallocationid) {
		this.scholarshipamountallocationid = scholarshipamountallocationid;
	}

	private  String tccheck = null;
    private  String cccheck = null;
    private  String sccheck = null;
    private  String mccheck = null;
    private  String mscheck = null;
    private  String spccheck = null;
    private  String ipaddress=null;
    private  String createdby=null;
    private  String instituteid=null;
    
    private  String sessionid=null;
    private  String boardid=null;
    private  String standardscheduleid=null;
    
    private  String userid=null;

    private  String studentusername=null;
    private  String studentpassword=null;
    private  String studentapprovalid=null;
    
    private String parentusername=null;
    private String  parentpassword=null;
    private String studmiddlename=null;
    private String  studlastname=null;
    private String  studage=null;
    private String  studsex=null;
    private String  schoolstatus=null;
    private String  mobileno=null;
    private String personid= null;
    private String studentguardianid = null;
    
    private String canidateregisterid= null;
    
    private String updateStatus[] = null;
    
    private String examinfoid[]= null;
    
    private String  parentid=null;
    
    
    private String[] scholarshipallocation;
    private String[] termfeesid;
    private String[] amount;
    

	public String[] getTermfeesid() {
		return termfeesid;
	}
	public void setTermfeesid(String[] termfeesid) {
		this.termfeesid = termfeesid;
	}
	public String[] getAmount() {
		return amount;
	}
	public void setAmount(String[] amount) {
		this.amount = amount;
	}
	public String[] getScholarshipallocation() {
		return scholarshipallocation;
	}
	public void setScholarshipallocation(String[] scholarshipallocation) {
		this.scholarshipallocation = scholarshipallocation;
	}
	public String getApplicantname() {
		return applicantname;
	}
	public void setApplicantname(String applicantname) {
		this.applicantname = applicantname;
	}
	public String getFathername() {
		return fathername;
	}
	public void setFathername(String fathername) {
		this.fathername = fathername;
	}
	public String getMothername() {
		return mothername;
	}
	public void setMothername(String mothername) {
		this.mothername = mothername;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public String getNationality() {
		return nationality;
	}
	public void setNationality(String nationality) {
		this.nationality = nationality;
	}
	public String getCommunity() {
		return community;
	}
	public void setCommunity(String community) {
		this.community = community;
	}
	public String getReligion() {
		return religion;
	}
	public void setReligion(String religion) {
		this.religion = religion;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getBloodgroup() {
		return bloodgroup;
	}
	public void setBloodgroup(String bloodgroup) {
		this.bloodgroup = bloodgroup;
	}
	public String getLandlinenumber() {
		return landlinenumber;
	}
	public void setLandlinenumber(String landlinenumber) {
		this.landlinenumber = landlinenumber;
	}
	public String getEmailid() {
		return emailid;
	}
	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}
	public String getGuardianname() {
		return guardianname;
	}
	public void setGuardianname(String guardianname) {
		this.guardianname = guardianname;
	}
	
	
	public String getGuardianmailid() {
		return guardianmailid;
	}
	public void setGuardianmailid(String guardianmailid) {
		this.guardianmailid = guardianmailid;
	}
	public String getGuardiandob() {
		return guardiandob;
	}
	public void setGuardiandob(String guardiandob) {
		this.guardiandob = guardiandob;
	}
	public String getGuardrelation() {
		return guardrelation;
	}
	public void setGuardrelation(String guardrelation) {
		this.guardrelation = guardrelation;
	}
	public String getGuardemployment() {
		return guardemployment;
	}
	public void setGuardemployment(String guardemployment) {
		this.guardemployment = guardemployment;
	}
	public String getNameoforg() {
		return nameoforg;
	}
	public void setNameoforg(String nameoforg) {
		this.nameoforg = nameoforg;
	}
	public String getAnnualincome() {
		return annualincome;
	}
	public void setAnnualincome(String annualincome) {
		this.annualincome = annualincome;
	}
	public String getGuardposition() {
		return guardposition;
	}
	public void setGuardposition(String guardposition) {
		this.guardposition = guardposition;
	}
	public String getPhysicallyChallenge() {
		return physicallyChallenge;
	}
	public void setPhysicallyChallenge(String physicallyChallenge) {
		this.physicallyChallenge = physicallyChallenge;
	}
	public String getExServiceman() {
		return ExServiceman;
	}
	public void setExServiceman(String exServiceman) {
		ExServiceman = exServiceman;
	}
	public String getTamilOrigin() {
		return TamilOrigin;
	}
	public void setTamilOrigin(String tamilOrigin) {
		TamilOrigin = tamilOrigin;
	}
	public String getFirstgraduate() {
		return firstgraduate;
	}
	public void setFirstgraduate(String firstgraduate) {
		this.firstgraduate = firstgraduate;
	}
	public String getPhysicalmarks() {
		return physicalmarks;
	}
	public void setPhysicalmarks(String physicalmarks) {
		this.physicalmarks = physicalmarks;
	}
	public String getExtraCurricular() {
		return ExtraCurricular;
	}
	public void setExtraCurricular(String extraCurricular) {
		ExtraCurricular = extraCurricular;
	}
	public String getPreviousSchoolDetails() {
		return PreviousSchoolDetails;
	}
	public void setPreviousSchoolDetails(String previousSchoolDetails) {
		PreviousSchoolDetails = previousSchoolDetails;
	}
	public String getPreviousSchooladdress() {
		return PreviousSchooladdress;
	}
	public void setPreviousSchooladdress(String previousSchooladdress) {
		PreviousSchooladdress = previousSchooladdress;
	}
	public String getPreviousSchoolboard() {
		return PreviousSchoolboard;
	}
	public void setPreviousSchoolboard(String previousSchoolboard) {
		PreviousSchoolboard = previousSchoolboard;
	}
	public String getPreviousSchoolmedium() {
		return PreviousSchoolmedium;
	}
	public void setPreviousSchoolmedium(String previousSchoolmedium) {
		PreviousSchoolmedium = previousSchoolmedium;
	}
	public String getReceiptofconcessio() {
		return receiptofconcessio;
	}
	public void setReceiptofconcessio(String receiptofconcessio) {
		this.receiptofconcessio = receiptofconcessio;
	}
	public String getStreet1() {
		return street1;
	}
	public void setStreet1(String street1) {
		this.street1 = street1;
	}
	public String getStreet2() {
		return street2;
	}
	public void setStreet2(String street2) {
		this.street2 = street2;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getPermanentstreet1() {
		return permanentstreet1;
	}
	public void setPermanentstreet1(String permanentstreet1) {
		this.permanentstreet1 = permanentstreet1;
	}
	public String getPermanentstreet2() {
		return permanentstreet2;
	}
	public void setPermanentstreet2(String permanentstreet2) {
		this.permanentstreet2 = permanentstreet2;
	}
	public String getPermanentcity() {
		return permanentcity;
	}
	public void setPermanentcity(String permanentcity) {
		this.permanentcity = permanentcity;
	}
	public String getPermanentstate() {
		return permanentstate;
	}
	public void setPermanentstate(String permanentstate) {
		this.permanentstate = permanentstate;
	}
	public String getPermanentcountry() {
		return permanentcountry;
	}
	public void setPermanentcountry(String permanentcountry) {
		this.permanentcountry = permanentcountry;
	}
	public String getPermanentzipcode() {
		return permanentzipcode;
	}
	public void setPermanentzipcode(String permanentzipcode) {
		this.permanentzipcode = permanentzipcode;
	}
	public String[] getSubject() {
		return subject;
	}
	public void setSubject(String[] subject) {
		this.subject = subject;
	}
	public String[] getMonthyear() {
		return monthyear;
	}
	public void setMonthyear(String[] monthyear) {
		this.monthyear = monthyear;
	}
	public String[] getMarkscored() {
		return markscored;
	}
	public void setMarkscored(String[] markscored) {
		this.markscored = markscored;
	}
	public String[] getMaxmark() {
		return maxmark;
	}
	public void setMaxmark(String[] maxmark) {
		this.maxmark = maxmark;
	}
	public String[] getRegistionno() {
		return registionno;
	}
	public void setRegistionno(String[] registionno) {
		this.registionno = registionno;
	}
	public String getTccheck() {
		return tccheck;
	}
	public void setTccheck(String tccheck) {
		this.tccheck = tccheck;
	}
	public String getCccheck() {
		return cccheck;
	}
	public void setCccheck(String cccheck) {
		this.cccheck = cccheck;
	}
	public String getSccheck() {
		return sccheck;
	}
	public void setSccheck(String sccheck) {
		this.sccheck = sccheck;
	}
	public String getMccheck() {
		return mccheck;
	}
	public void setMccheck(String mccheck) {
		this.mccheck = mccheck;
	}
	public String getMscheck() {
		return mscheck;
	}
	public void setMscheck(String mscheck) {
		this.mscheck = mscheck;
	}
	public String getSpccheck() {
		return spccheck;
	}
	public void setSpccheck(String spccheck) {
		this.spccheck = spccheck;
	}
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	public String getStudentusername() {
		return studentusername;
	}
	public void setStudentusername(String studentusername) {
		this.studentusername = studentusername;
	}
	public String getStudentpassword() {
		return studentpassword;
	}
	public void setStudentpassword(String studentpassword) {
		this.studentpassword = studentpassword;
	}
	public String getStandardscheduleid() {
		return standardscheduleid;
	}
	public void setStandardscheduleid(String standardscheduleid) {
		this.standardscheduleid = standardscheduleid;
	}
	public String getStudentapprovalid() {
		return studentapprovalid;
	}
	public void setStudentapprovalid(String studentapprovalid) {
		this.studentapprovalid = studentapprovalid;
	}
	public String getParentusername() {
		return parentusername;
	}
	public void setParentusername(String parentusername) {
		this.parentusername = parentusername;
	}
	public String getParentpassword() {
		return parentpassword;
	}
	public void setParentpassword(String parentpassword) {
		this.parentpassword = parentpassword;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getStudmiddlename() {
		return studmiddlename;
	}
	public void setStudmiddlename(String studmiddlename) {
		this.studmiddlename = studmiddlename;
	}
	public String getStudlastname() {
		return studlastname;
	}
	public void setStudlastname(String studlastname) {
		this.studlastname = studlastname;
	}
	public String getStudage() {
		return studage;
	}
	public void setStudage(String studage) {
		this.studage = studage;
	}
	public String getStudsex() {
		return studsex;
	}
	public void setStudsex(String studsex) {
		this.studsex = studsex;
	}
	public String getStudprefix() {
		return studprefix;
	}
	public void setStudprefix(String studprefix) {
		this.studprefix = studprefix;
	}
	public String getSchoolstatus() {
		return schoolstatus;
	}
	public void setSchoolstatus(String schoolstatus) {
		this.schoolstatus = schoolstatus;
	}
	public String getMobileno() {
		return mobileno;
	}
	public void setMobileno(String mobileno) {
		this.mobileno = mobileno;
	}
	
	private  String sessionInstituteName=null;

	public String getSessionInstituteName() {
		return sessionInstituteName;
	}
	public void setSessionInstituteName(String sessionInstituteName) {
		this.sessionInstituteName = sessionInstituteName;
	}
	
	private  String smsContactNo=null;

	public String getSmsContactNo() {
		return smsContactNo;
	}
	public void setSmsContactNo(String smsContactNo) {
		this.smsContactNo = smsContactNo;
	}
	
	
	
	public String getDobMail() {
		return dobMail;
	}
	public void setDobMail(String dobMail) {
		this.dobMail = dobMail;
	}
	public String getPersonid() {
		return personid;
	}
	public void setPersonid(String personid) {
		this.personid = personid;
	}
	public String getStudentguardianid() {
		return studentguardianid;
	}
	public void setStudentguardianid(String studentguardianid) {
		this.studentguardianid = studentguardianid;
	}
	public String getCanidateregisterid() {
		return canidateregisterid;
	}
	public void setCanidateregisterid(String canidateregisterid) {
		this.canidateregisterid = canidateregisterid;
	}
	public String[] getUpdateStatus() {
		return updateStatus;
	}
	public void setUpdateStatus(String[] updateStatus) {
		this.updateStatus = updateStatus;
	}
	public String[] getExaminfoid() {
		return examinfoid;
	}
	public void setExaminfoid(String[] examinfoid) {
		this.examinfoid = examinfoid;
	}
	
	
    private String[] applicationnos				= null;
    private String[] prefixs					= null; 
    private String[] firstnames					= null; 
    private String[] middlenames				= null;
    private String[] lastnames					= null;
    private String[] dateofbirths				= null;
    private String[] genders					= null;
    private String[] fathernames				= null;
    private String[] mothernames				= null;
    private String[] nationalitys				= null;
    private String[] languages					= null;
    private String[] bloodgroups				= null;
    private String[] street1s					= null;
    private String[] street2s					= null;
    private String[] countrys					= null;
    private String[] states						= null;
    private String[] citys 						= null;
    private String[] pincodes					= null;
    private String[] landlinenos				= null;
    private String[] mobilenos					= null;
    private String[] emails						= null;
    private String[] smscontacts				= null;
    private String[] guardiannames				= null;
    private String[] guardianmails				= null;
    private String[] guardianrelation			= null;
    private String[] selfemployed				= null;
    private String[] organizationnames			= null;
    private String[] income						= null;
    private String[] position					= null;
    private String[] physicallychallenged 		= null;	
    private String[] childofexserviceman		= null;
    private String[] personalphysicalmarks		= null;
    private String[] existingstudentrollnos		= null;
    private String[] studentapprovalids			= null;
    private String   resultstaus				= null;
    
    

	public String[] getApplicationnos() {
		return applicationnos;
	}
	public void setApplicationnos(String[] applicationnos) {
		this.applicationnos = applicationnos;
	}
	public String[] getPrefixs() {
		return prefixs;
	}
	public void setPrefixs(String[] prefixs) {
		this.prefixs = prefixs;
	}
	public String[] getFirstnames() {
		return firstnames;
	}
	public void setFirstnames(String[] firstnames) {
		this.firstnames = firstnames;
	}
	public String[] getMiddlenames() {
		return middlenames;
	}
	public void setMiddlenames(String[] middlenames) {
		this.middlenames = middlenames;
	}
	public String[] getLastnames() {
		return lastnames;
	}
	public void setLastnames(String[] lastnames) {
		this.lastnames = lastnames;
	}
	public String[] getDateofbirths() {
		return dateofbirths;
	}
	public void setDateofbirths(String[] dateofbirths) {
		this.dateofbirths = dateofbirths;
	}
	public String[] getGenders() {
		return genders;
	}
	public void setGenders(String[] genders) {
		this.genders = genders;
	}
	public String[] getFathernames() {
		return fathernames;
	}
	public void setFathernames(String[] fathernames) {
		this.fathernames = fathernames;
	}
	public String[] getMothernames() {
		return mothernames;
	}
	public void setMothernames(String[] mothernames) {
		this.mothernames = mothernames;
	}
	public String[] getNationalitys() {
		return nationalitys;
	}
	public void setNationalitys(String[] nationalitys) {
		this.nationalitys = nationalitys;
	}
	public String[] getLanguages() {
		return languages;
	}
	public void setLanguages(String[] languages) {
		this.languages = languages;
	}
	public String[] getBloodgroups() {
		return bloodgroups;
	}
	public void setBloodgroups(String[] bloodgroups) {
		this.bloodgroups = bloodgroups;
	}
	public String[] getStreet1s() {
		return street1s;
	}
	public void setStreet1s(String[] street1s) {
		this.street1s = street1s;
	}
	public String[] getStreet2s() {
		return street2s;
	}
	public void setStreet2s(String[] street2s) {
		this.street2s = street2s;
	}
	public String[] getCountrys() {
		return countrys;
	}
	public void setCountrys(String[] countrys) {
		this.countrys = countrys;
	}
	public String[] getStates() {
		return states;
	}
	public void setStates(String[] states) {
		this.states = states;
	}
	public String[] getCitys() {
		return citys;
	}
	public void setCitys(String[] citys) {
		this.citys = citys;
	}
	public String[] getPincodes() {
		return pincodes;
	}
	public void setPincodes(String[] pincodes) {
		this.pincodes = pincodes;
	}
	public String[] getLandlinenos() {
		return landlinenos;
	}
	public void setLandlinenos(String[] landlinenos) {
		this.landlinenos = landlinenos;
	}
	public String[] getMobilenos() {
		return mobilenos;
	}
	public void setMobilenos(String[] mobilenos) {
		this.mobilenos = mobilenos;
	}
	public String[] getEmails() {
		return emails;
	}
	public void setEmails(String[] emails) {
		this.emails = emails;
	}
	public String[] getSmscontacts() {
		return smscontacts;
	}
	public void setSmscontacts(String[] smscontacts) {
		this.smscontacts = smscontacts;
	}
	public String[] getGuardiannames() {
		return guardiannames;
	}
	public void setGuardiannames(String[] guardiannames) {
		this.guardiannames = guardiannames;
	}
	public String[] getGuardianmails() {
		return guardianmails;
	}
	public void setGuardianmails(String[] guardianmails) {
		this.guardianmails = guardianmails;
	}	
	public String[] getGuardianrelation() {
		return guardianrelation;
	}
	public void setGuardianrelation(String[] guardianrelation) {
		this.guardianrelation = guardianrelation;
	}
	public String[] getSelfemployed() {
		return selfemployed;
	}
	public void setSelfemployed(String[] selfemployed) {
		this.selfemployed = selfemployed;
	}
	public String[] getOrganizationnames() {
		return organizationnames;
	}
	public void setOrganizationnames(String[] organizationnames) {
		this.organizationnames = organizationnames;
	}
	public String[] getIncome() {
		return income;
	}
	public void setIncome(String[] income) {
		this.income = income;
	}
	public String[] getPosition() {
		return position;
	}
	public void setPosition(String[] position) {
		this.position = position;
	}
	public String[] getPhysicallychallenged() {
		return physicallychallenged;
	}
	public void setPhysicallychallenged(String[] physicallychallenged) {
		this.physicallychallenged = physicallychallenged;
	}
	public String[] getChildofexserviceman() {
		return childofexserviceman;
	}
	public void setChildofexserviceman(String[] childofexserviceman) {
		this.childofexserviceman = childofexserviceman;
	}
	public String[] getPersonalphysicalmarks() {
		return personalphysicalmarks;
	}
	public void setPersonalphysicalmarks(String[] personalphysicalmarks) {
		this.personalphysicalmarks = personalphysicalmarks;
	}
	public String[] getExistingstudentrollnos() {
		return existingstudentrollnos;
	}
	public void setExistingstudentrollnos(String[] existingstudentrollnos) {
		this.existingstudentrollnos = existingstudentrollnos;
	}
	public String[] getStudentapprovalids() {
		return studentapprovalids;
	}
	public void setStudentapprovalids(String[] studentapprovalids) {
		this.studentapprovalids = studentapprovalids;
	}
	public String getResultstaus() {
		return resultstaus;
	}
	public void setResultstaus(String resultstaus) {
		this.resultstaus = resultstaus;
	}
	
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	public String getBoardid() {
		return boardid;
	}
	public void setBoardid(String boardid) {
		this.boardid = boardid;
	}
	
	
	
    
}