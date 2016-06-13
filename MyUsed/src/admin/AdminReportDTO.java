package admin;
import java.sql.Timestamp;

public class AdminReportDTO {
	private int seq_num;
	private String title;
	private String contents;
	private String readcount;
	private String mem_id;
	private String pw;
	private int qna_ref;
	private int qna_re_step;
	private int qna_re_level;
	private String reg;
	
	

	public String getReadcount() {
		return readcount;
	}
	public void setReadcount(String readcount) {
		this.readcount = readcount;
	}
	public int getSeq_num() {
		return seq_num;
	}
	public void setSeq_num(int seq_num) {
		this.seq_num = seq_num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public int getQna_ref() {
		return qna_ref;
	}
	public void setQna_ref(int qna_ref) {
		this.qna_ref = qna_ref;
	}
	public int getQna_re_step() {
		return qna_re_step;
	}
	public void setQna_re_step(int qna_re_step) {
		this.qna_re_step = qna_re_step;
	}
	public int getQna_re_level() {
		return qna_re_level;
	}
	public void setQna_re_level(int qna_re_level) {
		this.qna_re_level = qna_re_level;
	}
	public String getReg() {
		return reg;
	}
	public void setReg(String reg) {
		this.reg = reg;
	}
	
	
	
	

}
