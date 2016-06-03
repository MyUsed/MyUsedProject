package member;

public class MemberDTO {

	private int num;
	private String id;
	private String name;
	private String password;
	private String birthdate;
	private String gender;
	private int grade;
	private int point;
	private String onoff;
	private String naverid;
	private String chatonoff;
	
	private String profile_pic;	//조인햇을때 
	
	public int getNum() 		{		return num;			}
	public String getId() 		{		return id;			}
	public String getName() 	{		return name;		}
	public String getPassword() {		return password;	}
	public String getBirthdate(){		return birthdate;	}
	public String getGender() 	{		return gender;		}
	public String getNaverid() 	{		return naverid;		}
	public int getGrade() {		return grade;	}
	public int getPoint() {		return point;	}
	public String getOnoff() {		return onoff;	}
	public String getChatonoff() {		return chatonoff;	}
	public String getProfile_pic() {		return profile_pic;	}
	
	public void setNum(int num) 			   {		this.num = num;				}
	public void setId(String id) 			   {		this.id = id;				}
	public void setName(String name) 		   {		this.name = name;			}
	public void setPassword(String password)   {		this.password = password;	}
	public void setBirthdate(String birthdate) {		this.birthdate = birthdate;	}
	public void setGender(String gender) 	   {		this.gender = gender;		}
	public void setNaverid(String naverid) 	   {		this.naverid = naverid;		}
	public void setGrade(int grade) {		this.grade = grade;	}
	public void setPoint(int point) {		this.point = point;	}
	public void setOnoff(String onoff) {		this.onoff = onoff;	}
	public void setChatonoff(String chatonoff) {		this.chatonoff = chatonoff;	}
	public void setProfile_pic(String profile_pic) {		this.profile_pic = profile_pic;	}
	
	
}
