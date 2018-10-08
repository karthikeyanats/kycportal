package com.iGrandee.GradeSetting;

public class GradeScaleBean
{
	public GradeScaleBean()
    {
    }
	
	 public String getGradescaleid() {
		return gradescaleid;
	}
	public void setGradescaleid(String gradescaleid) {
		this.gradescaleid = gradescaleid;
	}
	public String getScaleid() {
		return scaleid;
	}
	public void setScaleid(String scaleid) {
		this.scaleid = scaleid;
	}
	public String getGradeid() {
		return gradeid;
	}
	public void setGradeid(String gradeid) {
		this.gradeid = gradeid;
	}
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	public String getRangefrom() {
		return rangefrom;
	}
	public void setRangefrom(String rangefrom) {
		this.rangefrom = rangefrom;
	}
	public String getRangeto() {
		return rangeto;
	}
	public void setRangeto(String rangeto) {
		this.rangeto = rangeto;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getDateofcreation() {
		return dateofcreation;
	}
	public void setDateofcreation(String dateofcreation) {
		this.dateofcreation = dateofcreation;
	}
	public String getGradescalestatus() {
		return gradescalestatus;
	}
	public void setGradescalestatus(String gradescalestatus) {
		this.gradescalestatus = gradescalestatus;
	}
	 public String getBoardid() {
			return boardid;
		}

		public void setBoardid(String boardid) {
			this.boardid = boardid;
		}
		private String gradescaleid= null;
		public String[] getGradescaleId() {
			return gradescaleId;
		}

		public void setGradescaleId(String[] gradescaleId) {
			this.gradescaleId = gradescaleId;
		}
		private String [] gradescaleId= null;

	    private String scaleid= null;
	    private String gradeid= null;
	    private String sessionid= null;
	    private String boardid= null;
	    
	    
	    public String[] getGradeId() {
			return gradeId;
		}

		public void setGradeId(String[] gradeId) {
			this.gradeId = gradeId;
		}
		private String []gradeId= null;
		
		public String[] getRangeFrom() {
			return rangeFrom;
		}

		public void setRangeFrom(String[] rangeFrom) {
			this.rangeFrom = rangeFrom;
		}

		public String[] getRangeTo() {
			return rangeTo;
		}

		public void setRangeTo(String[] rangeTo) {
			this.rangeTo = rangeTo;
		}
		private String []rangeFrom= null;
	    private String []rangeTo= null;
	    public String[] getProcesstype() {
			return processtype;
		}

		public void setProcesstype(String[] processtype) {
			this.processtype = processtype;
		}
		private String []processtype= null;

	    
		private String rangefrom= null;
	    private String rangeto= null;
	    private String createdby= null;
	    private String dateofcreation= null;
	    public String[] getStandardscheduleid() {
			return standardscheduleid;
		}

		public void setStandardscheduleid(String[] standardscheduleid) {
			this.standardscheduleid = standardscheduleid;
		}
		private String [] standardscheduleid= null;
		public String[] getScaleId() {
			return scaleId;
		}

		public void setScaleId(String[] scaleId) {
			this.scaleId = scaleId;
		}
		private String [] scaleId= null;

	    private String gradescalestatus= null;
}