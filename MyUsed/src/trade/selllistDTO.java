package trade;

import java.sql.Timestamp;

public class selllistDTO {
	private int seq_num;
	private int buy_memnum;
	private String buy_name;
	private int sell_pronum;
	private int sell_memnum;
	private String sell_name;
	private String sell_propic;
	private String send_ph;
	private String acount;
	private String bankname;
	private String sendname;
	private String postnum;
	private int buy_price;
	private int state;
	private Timestamp reg;
	
	
	
	public int getSeq_num() {
		return seq_num;
	}
	public void setSeq_num(int seq_num) {
		this.seq_num = seq_num;
	}
	public int getBuy_memnum() {
		return buy_memnum;
	}
	public void setBuy_memnum(int buy_memnum) {
		this.buy_memnum = buy_memnum;
	}
	public String getBuy_name() {
		return buy_name;
	}
	public void setBuy_name(String buy_name) {
		this.buy_name = buy_name;
	}
	public int getSell_pronum() {
		return sell_pronum;
	}
	public void setSell_pronum(int sell_pronum) {
		this.sell_pronum = sell_pronum;
	}
	public int getSell_memnum() {
		return sell_memnum;
	}
	public void setSell_memnum(int sell_memnum) {
		this.sell_memnum = sell_memnum;
	}
	public String getSell_name() {
		return sell_name;
	}
	public void setSell_name(String sell_name) {
		this.sell_name = sell_name;
	}
	public String getSell_propic() {
		return sell_propic;
	}
	public void setSell_propic(String sell_propic) {
		this.sell_propic = sell_propic;
	}
	public String getSend_ph() {
		return send_ph;
	}
	public void setSend_ph(String send_ph) {
		this.send_ph = send_ph;
	}
	public String getAcount() {
		return acount;
	}
	public void setAcount(String acount) {
		this.acount = acount;
	}
	public String getBankname() {
		return bankname;
	}
	public void setBankname(String bankname) {
		this.bankname = bankname;
	}
	public String getSendname() {
		return sendname;
	}
	public void setSendname(String sendname) {
		this.sendname = sendname;
	}
	public String getPostnum() {
		return postnum;
	}
	public void setPostnum(String postnum) {
		this.postnum = postnum;
	}
	public int getBuy_price() {
		return buy_price;
	}
	public void setBuy_price(int buy_price) {
		this.buy_price = buy_price;
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
