
package com.iGrandee.Registration;

import java.io.Serializable;

public class InstitutionBean
    implements Serializable
{

    public InstitutionBean()
    {
    }
    //created by prasanth
    public void setinstitutionid(String s)
    {
    	institutionid = s;
    }
    public String getinstitutionid()
    {
        return institutionid;
    }
    public String getPhoto() {
		return photo;
	}
    public void setPhoto(String photo) {
		this.photo = photo;
	}
    public void setSchool_name(String s)
    {
    	School_name = s;
    }

    public String getSchool_name()
    {
        return School_name;
    }

    public void settxt_street1(String s)
    {
    	txt_street1 = s;
    }
    public String gettxt_street1()
    {
        return txt_street1;
    }
    public void settxt_street2(String s)
    {
    	txt_street2 = s;
    }
    public String gettxt_street2()
    {
        return txt_street2;
    }
    public void settxt_city(String s)
    {
    	txt_city = s;
    }
    public String gettxt_city()
    {
        return txt_city;
    }
    public void setslt_country(String s)
    {
    	slt_country = s;
    }
    public String getslt_country()
    {
        return slt_country;
    }
    public void setslt_state(String s)
    {
    	slt_state = s;
    }
    public String getslt_state()
    {
        return slt_state;
    }
    public void settxt_zip(String s)
    {
    	txt_zip = s;
    }
    public String gettxt_zip()
    {
        return txt_zip;
    }
    public void settxt_contact(String s)
    {
    	txt_contact = s;
    }
    public String gettxt_contact()
    {
        return txt_contact;
    }
    public void settxt_mail(String s)
    {
    	txt_mail = s;
    }
    public String gettxt_mail()
    {
        return txt_mail;
    }
    public void settxt_web(String s)
    {
    	txt_web = s;
    }
    public String gettxt_web()
    {
        return txt_web;
    }
    public void settxt_fname(String s)
    {
    	txt_fname = s;
    }
    public String gettxt_fname()
    {
        return txt_fname;
    }
    public void settxt_mname(String s)
    {
    	txt_mname = s;
    }
    public String gettxt_mname()
    {
        return txt_mname;
    }
    public void settxt_lname(String s)
    {
    	txt_lname = s;
    }
    public String gettxt_lname()
    {
        return txt_lname;
    }
    public void setslt_prefix(String s)
    {
    	slt_prefix = s;
    }
    public String getslt_prefix()
    {
        return slt_prefix;
    }
    public void settxt_street_admin(String s)
    {
    	txt_street_admin = s;
    }
    public String gettxt_street_admin()
    {
        return txt_street_admin;
    }
    public void settxt_city_admin(String s)
    {
    	txt_city_admin = s;
    }
    public String gettxt_city_admin()
    {
        return txt_city_admin;
    }
    public void setslt_country_admin(String s)
    {
    	slt_country_admin = s;
    }
    public String getslt_country_admin()
    {
        return slt_country_admin;
    }
    public void setslt_state_admin(String s)
    {
    	slt_state_admin = s;
    }
    public String getslt_state_admin()
    {
        return slt_state_admin;
    }
    public void settxt_zip_admin(String s)
    {
    	txt_zip_admin = s;
    }
    public String gettxt_zip_admin()
    {
        return txt_zip_admin;
    }
    public void settxt_contact_admin(String s)
    {
    	txt_contact_admin = s;
    }
    public String gettxt_contact_admin()
    {
        return txt_contact_admin;
    }
    public void settxt_dob(String s)
    {
    	txt_dob = s;
    }
    public String gettxt_dob()
    {
        return txt_dob;
    }
    public void setslt_sex(String s)
    {
    	slt_sex = s;
    }
    public String getslt_sex()
    {
        return slt_sex;
    }
    public void settxt_mail_admin(String s)
    {
    	txt_mail_admin = s;
    }
    public String gettxt_mail_admin()
    {
        return txt_mail_admin;
    }
    public void settxt_qualification(String s)
    {
    	txt_qualification = s;
    }
    public String gettxt_qualification()
    {
        return txt_qualification;
    }
    public void settxt_username(String s)
    {
    	txt_username = s;
    }
    public String gettxt_username()
    {
        return txt_username;
    }
    public void settxt_passward(String s)
    {
    	txt_passward = s;
    }
    public String gettxt_passward()
    {
        return txt_passward;
    }
    public void setslt_hint(String s)
    {
    	slt_hint = s;
    }
    public String getslt_hint()
    {
        return slt_hint;
    }
    public void settxt_answer(String s)
    {
    	txt_answer = s;
    }
    public String gettxt_answer()
    {
        return txt_answer;
    }
    public void sethid_photo(String s)
    {
    	hid_photo = s;
    }
    public String gethid_photo()
    {
        return hid_photo;
    }
    public void settxt_mobile_admin(String s)
    {
    	txt_mobile_admin = s;
    }
    public String gettxt_mobile_admin()
    {
        return txt_mobile_admin;
    }
    public void setipadress(String s)
    {
    	ipadress = s;
    }
    public String getipaddress()
    {
        return ipadress;
    }
    public void settxt_mobile(String s)
    {
    	txt_mobile = s;
    }
    public String gettxt_mobile()
    {
        return txt_mobile;
    }
    public void settxt_fax(String s)
    {
    	txt_fax = s;
    }
    public String gettxt_fax()
    {
        return txt_fax;
    }
    public void setinstitutionmode(String s)
    {
    	institutionmode = s;
    }
    public String getinstitutionmode()
    {
        return institutionmode;
    }
    
    private  String ipadress;
    private  String txt_mobile_admin;
    private  String hid_photo;
    private  String hid_photo2;

    private  String School_name;
    private  String txt_street1;
    private  String txt_street2;
    private  String txt_city;
    private  String slt_country;
    private  String slt_state;
    private  String txt_zip;
    private  String txt_contact;
    private  String txt_mail;
    private  String txt_web;
    private  String txt_fname;
    private  String txt_mname;
    private  String txt_lname;
    private  String slt_prefix;
    private  String txt_street_admin;
    private  String txt_city_admin;
    private  String slt_country_admin;
    private  String slt_state_admin;
    private  String txt_zip_admin;
    private  String txt_contact_admin;
    private  String txt_mail_admin;
    private  String txt_dob;
    private  String slt_sex;
    private  String txt_qualification;
    private  String txt_username;
    private  String txt_passward;
    private  String slt_hint;
    private  String txt_answer;
    private  String txt_fax;
    private  String txt_mobile;
    private String institutionmode; 
    private String institutionid;
    private  String photo = null;
    private String age;
    private  String currencytype = null;
	public String getHid_photo2() {
		return hid_photo2;
	}
	public void setHid_photo2(String hid_photo2) {
		this.hid_photo2 = hid_photo2;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getCurrencytype() {
		return currencytype;
	}
	public void setCurrencytype(String currencytype) {
		this.currencytype = currencytype;
	} 
}