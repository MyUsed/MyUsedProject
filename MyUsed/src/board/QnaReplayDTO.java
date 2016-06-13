package board;

import java.sql.Timestamp;

public class QnaReplayDTO {
	private int reply_num ;
 	private String reply_cts;
	private Timestamp reg;
	public int getReply_num() {
		return reply_num;
	}
	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}
	public String getReply_cts() {
		return reply_cts;
	}
	public void setReply_cts(String reply_cts) {
		this.reply_cts = reply_cts;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	
}
