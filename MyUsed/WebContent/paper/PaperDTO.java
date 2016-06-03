package paper;

import java.sql.Timestamp;

public class PaperDTO {
	// s = 보내는 사람
	private int m_no, s_num, state;
	private String s_name, s_content;
	private String id, name;
	private String reg;
	

	
	public String getName() {return name;}
	public void setName(String name) {this.name = name;}
	
	public String getId() {return id;}
	public void setId(String id) {this.id = id;}
	
	public void setM_no(int m_no) { this.m_no = m_no; }
	public int getM_no() { return m_no; }
	
	public int getS_num() {return s_num;}
	public void setS_num(int s_num) {this.s_num = s_num;}
	
	public int getState() {return state;}
	public void setState(int state) {this.state = state;}
	
	public String getS_name() {return s_name;}
	public void setS_name(String s_name) {this.s_name = s_name;}
	
	public String getS_content() {return s_content;}
	public void setS_content(String s_content) {this.s_content = s_content;}
	
	public String getReg() {return reg;}
	public void setReg(String reg) 	{this.reg = reg;}
	
}
