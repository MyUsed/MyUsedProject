package main;

import java.sql.Timestamp;

public class MainboardDTO {
	 
	private String content;
	private String categ;
	private String price;
	private String sendPay;
	private String name;
	private String mem_pic;
	private Timestamp reg;
	
	
	
	public void setContent(String content) {this.content = content;}
	public void setCateg(String categ) {this.categ = categ;}
	public void setPrice(String price) {this.price = price;}
	public void setSendPay(String sendPay) {this.sendPay = sendPay;}
	public void setName(String name) {this.name = name;}
	public void setMem_pic(String mem_pic) {this.mem_pic = mem_pic;}
	public void setReg(Timestamp reg) {this.reg = reg;}

	
	public String getContent() {return content;}
	public String getCateg() {return categ;}
	public String getPrice() {return price;}
	public String getSendPay() {return sendPay;}
	public String getName() {return name;}
	public String getMem_pic() {return mem_pic;}
	public Timestamp getReg() {return reg;}
	

}
