package member;

import java.sql.Timestamp;

public class FriendDTO {
	
	private int mem_num;
	private String id;
	private String name;
	private String state;
	private String categ;
	private Timestamp reg;
	
	
	public int getMem_num() {		return mem_num;		}
	public String getId() 	{		return id;			}
	public String getName() 	{		return name;			}
	public String getState(){		return state;		}
	public String getCateg(){		return categ;		}
	public Timestamp getReg(){		return reg;			}
	
	public void setMem_num(int mem_num) {		this.mem_num = mem_num;	}
	public void setId(String id) 		{		this.id = id;			}
	public void setName(String name) 	{		this.name = name;		}
	public void setState(String state)  {		this.state = state;		}
	public void setCateg(String categ)  {		this.categ = categ;		}
	public void setReg(Timestamp reg)   {		this.reg = reg;			}
	
	
}
