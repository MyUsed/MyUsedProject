package mypage;

import java.sql.Timestamp;

public class AddressDTO {
	
	private String name;
	private int ph;
	private int addrNum;
	private String addr;
	private String addrr;
	private Timestamp reg;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPh() {
		return ph;
	}
	public void setPh(int ph) {
		this.ph = ph;
	}
	public int getAddrNum() {
		return addrNum;
	}
	public void setAddrNum(int addrNum) {
		this.addrNum = addrNum;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddrr() {
		return addrr;
	}
	public void setAddrr(String addrr) {
		this.addrr = addrr;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	
	

}
