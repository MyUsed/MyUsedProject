package main;

import java.sql.Timestamp;

public class MainProboardDTO {
	
	private int num;
	private String procontent;
	private String categ;
	private String name;
	private int likes;
	private int price;
	private Timestamp reg;
	
	private String pro_pic;
	
	
	public void setNum(int num) {	this.num = num;}
	public void setProcontent(String procontent) {	this.procontent = procontent;}
	public void setCateg(String categ) {this.categ = categ;}
	public void setName(String name) {	this.name = name;}
	public void setLikes(int likes) {	this.likes = likes;}
	public void setPrice(int price) {	this.price = price;}
	public void setReg(Timestamp reg) {this.reg = reg;}
	public void setPro_pic(String pro_pic) {this.pro_pic = pro_pic;}
	
	public int getNum() {	return num;}
	public String getProcontent() {	return procontent;}
	public String getCateg() {	return categ;}
	public String getName() {	return name;}
	public int getLikes() {	return likes;}
	public int getPrice() {	return price;}
	public Timestamp getReg() {	return reg;}
	public String getPro_pic() {return pro_pic;}
	
	
	
	
	

}
