/**
 * 작성일 : 160503
 * 작성자 : 이수민
 * 일반 회원가입 분리
 */
package member;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class JoinController {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private MemberDTO memDTO = new MemberDTO();

	/** 일반 회원가입-아이디 중복확인 */
	@RequestMapping("/confirmId.nhn")
	public String confirmId(HttpServletRequest request, String id){
		System.out.println(id);
		
		int check = (Integer)sqlMapClientTemplate.queryForObject("member.checkId", id);
	
		request.setAttribute("check", check);
		request.setAttribute("id", id);
		return "/member/confirmId.jsp";
	}
	
	/** 약관 동의 */
	@RequestMapping("/MyUsedAgreement.nhn")
	public String MyUsedAgreement(HttpServletRequest request, String signup_lname, String signup_fname,String signup_pw, String signup_id, String year, String month, String date, String gender){

		System.out.println(gender);
	
		request.setAttribute("signup_lname", signup_lname);
		request.setAttribute("signup_fname", signup_fname);
		request.setAttribute("signup_pw", signup_pw);
		request.setAttribute("signup_id", signup_id);
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		request.setAttribute("date", date);
		request.setAttribute("gender", gender);

		return "/member/MyUsedAgreement.jsp";
	}
	
	
	/** 일반 회원가입 */
	@RequestMapping("/MyUsedJoinPro.nhn")
	public String MyUsedJoinPro(HttpServletRequest request, String signup_lname, String signup_fname,String signup_pw, String signup_id, String year, String month, String date, String gender){
		
		String birthdate = year +"-"+ month +"-"+ date;
		
		memDTO.setId(signup_id);
		memDTO.setName(signup_lname+signup_fname);
		memDTO.setPassword(signup_pw);
		memDTO.setBirthdate(birthdate);
		memDTO.setGender(gender);
		memDTO.setGrade(3);
		memDTO.setPoint(0);
		memDTO.setOnoff("0");	//0 비로그인/ 1 로그인
		memDTO.setNaverid("0");
		memDTO.setChatonoff("0");

		// 회원 등록
		sqlMapClientTemplate.insert("member.insertMem", memDTO);
		
		// 등록된 회원의 넙버를 가져온다.
		int num = (Integer)sqlMapClientTemplate.queryForObject("member.findNum", memDTO);
	
		// creatDB로 num변수를 보낸다.
		request.setAttribute("num", num);


		//return "/member/MyUsedJoinPro.jsp";
		return "/member/createDB.jsp";
	}

	
}
