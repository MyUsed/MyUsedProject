package admin;

import java.sql.Timestamp;

public class AdminBoardRepleDTO {
	private int seq_num;
	private int mem_num;
	private String content;
	private String name;
	private Timestamp reg;
	
	public int getSeq_num() {
		return seq_num;
	}
	public void setSeq_num(int seq_num) {
		this.seq_num = seq_num;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
}
