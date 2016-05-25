package friend;

import java.sql.Timestamp;

public class FriendDTO {
	
	private int mem_num;
	private String id;
	private String name;
	private String state;
	private String categ;
	private Timestamp reg;
	
	private String onoff;//조인했을때
	private int count;	//친구의 친구 찾을 때 필요

	private String profile_pic;	// 친구의 프로필 사진 불러오기위해
	
	
	
	public int getMem_num() {		return mem_num;		}
	public String getId() 	{		return id;			}
	public String getName() {		return name;		}
	public String getState(){		return state;		}
	public String getCateg(){		return categ;		}
	public Timestamp getReg(){		return reg;			}
	
	public void setMem_num(int mem_num) {		this.mem_num = mem_num;	}
	public void setId(String id) 		{		this.id = id;			}
	public void setName(String name) 	{		this.name = name;		}
	public void setState(String state)  {		this.state = state;		}
	public void setCateg(String categ)  {		this.categ = categ;		}
	public void setReg(Timestamp reg)   {		this.reg = reg;			}
	

	public String getOnoff() {		return onoff;	}
	public void setOnoff(String onoff) {		this.onoff = onoff;	}
	
	public int getCount() {		return count;	}
	public void setCount(int count) {		this.count = count;	}
	

	public String getProfile_pic(){		return profile_pic;	}
	public void setProfile_pic(String profile_pic) 	{		this.profile_pic = profile_pic;	}
	
	
	
	
}
