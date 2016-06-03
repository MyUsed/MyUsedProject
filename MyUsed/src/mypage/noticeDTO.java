package mypage;

import java.sql.Timestamp;

public class noticeDTO {
	
	private int seq_num;
	private int board_num;
	private int pro_num;
	private int call_memnum;
	private String call_name;
	private String categ;
	private int state;
	private Timestamp reg;
	
	
	public int getSeq_num() {
		return seq_num;
	}
	public void setSeq_num(int seq_num) {
		this.seq_num = seq_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getPro_num() {
		return pro_num;
	}
	public void setPro_num(int pro_num) {
		this.pro_num = pro_num;
	}
	public int getCall_memnum() {
		return call_memnum;
	}
	public void setCall_memnum(int call_memnum) {
		this.call_memnum = call_memnum;
	}
	public String getCall_name() {
		return call_name;
	}
	public void setCall_name(String call_name) {
		this.call_name = call_name;
	}
	public String getCateg() {
		return categ;
	}
	public void setCateg(String categ) {
		this.categ = categ;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	
	

}
