package main;

import java.sql.Timestamp;

public class MainboardDTO {
	 
	private int num;
	private String likes;
	private int mem_num;
	private String content;
	private String categ;
	
	private String sendPay;
	private String name;
	private String mem_pic;
	private Timestamp reg;
	
	
	
	public void setNum(int num) {this.num = num;}
	public void setLikes(String likes) {this.likes = likes;}
	public void setMem_num(int mem_num) {this.mem_num = mem_num;}
	public void setContent(String content) {this.content = content;}
	public void setCateg(String categ) {this.categ = categ;}
	
	public void setSendPay(String sendPay) {this.sendPay = sendPay;}
	public void setName(String name) {this.name = name;}
	public void setMem_pic(String mem_pic) {this.mem_pic = mem_pic;}
	public void setReg(Timestamp reg) {this.reg = reg;}

	
	
	public int getNum() {return num;}
	public String getLikes() {return likes;}
	public int getMem_num() {return mem_num;}
	public String getContent() {return content;}
	public String getCateg() {return categ;}
	
	public String getSendPay() {return sendPay;}
	public String getName() {return name;}
	public String getMem_pic() {return mem_pic;}
	public Timestamp getReg() {return reg;}
	

}
