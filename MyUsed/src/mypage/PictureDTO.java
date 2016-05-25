package mypage;

import java.sql.Timestamp;

public class PictureDTO {
	
	private String pic;
	private Timestamp reg;
	
	public String getPic() 		{		return pic;		}
	public Timestamp getReg() 	{		return reg;		}

	public void setPic(String pic) 		{		this.pic = pic;		}
	public void setReg(Timestamp reg) 	{		this.reg = reg;		}
	
	

}
