package main;

import java.sql.Timestamp;

public class MainpicDTO {
	
	private int num;
	private String mem_pic;
	private String name;
	private int likes;
	private int mem_num;
	private Timestamp reg;
	
	public void setNum(int num) {this.num = num;}
	public void setMem_pic(String mem_pic) {this.mem_pic = mem_pic;}
	public void setName(String name) {this.name = name;}
	public void setLikes(int likes) {this.likes = likes;}
	public void setMem_num(int mem_num) {this.mem_num = mem_num;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	
	public int getNum() {return num;}
	public String getMem_pic() {return mem_pic;}
	public String getName() {return name;}
	public int getLikes() {return likes;}
	public int getMem_num() {return mem_num;}
	public Timestamp getReg() {return reg;}
	
	

}
