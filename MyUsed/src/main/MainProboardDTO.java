package main;

import java.sql.Timestamp;

public class MainProboardDTO {
	
	private int num;
	private String content;
	private String categ0;
	private String categ1;
	private String name;
	private int likes;
	private int price;
	private Timestamp reg;
	
	private String pro_pic;
	private String mem_num;
	
	
	
	public void setNum(int num) {	this.num = num;}
	public void setContent(String content) {	this.content = content;}
	public void setCateg0(String categ0) {this.categ0 = categ0;}
	public void setCateg1(String categ1) {this.categ1 = categ1;}
	public void setName(String name) {	this.name = name;}
	public void setLikes(int likes) {	this.likes = likes;}
	public void setPrice(int price) {	this.price = price;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	public void setPro_pic(String pro_pic) {this.pro_pic = pro_pic;}
	public void setMem_num(String mem_num) {this.mem_num = mem_num;}
	
	
	public String getMem_num() {return mem_num;}
	public int getNum() {	return num;}
	public String getContent() {	return content;}
	public String getCateg0() {	return categ0;}
	public String getCateg1() {	return categ1;}
	public String getName() {	return name;}
	public int getLikes() {	return likes;}
	public int getPrice() {	return price;}
	public Timestamp getReg() {	return reg;}
	public String getPro_pic() {return pro_pic;}
	
	
	
	
	

}
