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


	/** 일반 회원가입 */
	@RequestMapping("/MyUsedJoinPro.nhn")
	public String MyUsedJoinPro(HttpServletRequest request, String signup_lname, String signup_fname,String signup_pw, String signup_id, String year, String month, String date, String gender){

		String birthdate = year +"-"+ month +"-"+ date;
		
		memDTO.setId(signup_id);
		memDTO.setName(signup_lname+signup_fname);
		memDTO.setPassword(signup_pw);
		memDTO.setBirthdate(birthdate);
		memDTO.setGender(gender);
		memDTO.setNaverid("0");

		// 회원 등록
		sqlMapClientTemplate.insert("member.insertMem", memDTO);


		return "/member/MyUsedJoinPro.jsp";
	}
	
	@RequestMapping("/MyUsedAgreement.nhn")
	public String MyUsedAgreement(HttpServletRequest request, String signup_lname, String signup_fname,String signup_pw, String signup_id, String year, String month, String date, String gender){

		String result = "";
		int check = (Integer)sqlMapClientTemplate.queryForObject("member.checkId", signup_id);
		if(check == 1){
			// 동일한 아이디 있을 경우 가입 불가
			result = "/member/MyUsedNotJoin.jsp";
		}else{
			// 동일한 아이디가 없을 경우 가입 약관
			result = "/member/MyUsedAgreement.jsp";
		}

		request.setAttribute("signup_lname", signup_lname);
		request.setAttribute("signup_fname", signup_fname);
		request.setAttribute("signup_pw", signup_pw);
		request.setAttribute("signup_id", signup_id);
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		request.setAttribute("date", date);
		request.setAttribute("gender", gender);

		return result;
	}
	
}
