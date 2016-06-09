package admin;

import java.sql.Timestamp;

public class adminTermsDTO {
	private int seq_num;
	private String content1, content2, content3;
	private Timestamp reg;
	
	public void setSeq_num(int seq_num){this.seq_num = seq_num;}
	public int getSeq_num(){return seq_num;}
	
	public String getContent1() {return content1;}
	public void setContent1(String content1) {this.content1 = content1;}
	
	public String getContent2() {return content2;}
	public void setContent2(String content2) {this.content2 = content2;}
	
	public String getContent3() {return content3;}
	public void setContent3(String content3) {this.content3 = content3;}
	
	public Timestamp getReg() {return reg;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	
}
