/**
 * 작성일 : 160502
 * 작성자 : 이수민
 * 네이버 로그인 , 일반 회원가입 
 */
package member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private MemberDTO memDTO = new MemberDTO();
	

	/** 로그아웃 아직 안됨 */
/*	@RequestMapping("/logout.nhn")
	public String logout(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		session.removeAttribute("memId");
		
		return "/naver/logout.jsp";
	}*/
	
	@RequestMapping("/MyUsedNaverLoginPro.nhn")
	public String MyUsedNaverLoginPro(HttpServletRequest request, String id, String email, String name, String gender, String birthday, String accesstoken){
		
		System.out.println(id);
		System.out.println(email);
		System.out.println(name);
		System.out.println(gender);
		System.out.println(birthday);
		
		/** 로그인 체크 -> 로그인한적있으면 1 / 첫로그인 0 */
		int check = (Integer)sqlMapClientTemplate.queryForObject("member.checkId", id);
		if(check == 1){
			/** 로그인을 한 적있는 아이디 -> 아이디를 세션에 넣음 */
			HttpSession session = request.getSession();
			session.setAttribute("memId", id);
			
			
		}else{
			/** 첫 로그인인 아이디 -> 회원리스트디비에 넣음/회원개인테이블생성/세션에도 넣음  */
			memDTO.setId(email);
			memDTO.setName(name);
			memDTO.setPassword("0");
			memDTO.setBirthdate(birthday);
			memDTO.setGender(gender);
			memDTO.setNaverid(id);
			/* 수정 할 점
			 * 네이버 로그인시 페스워드는 난수 생성해서 넣기(보안)
			 * 로그인할 때 네이버아이디로 최초가입한 아이디를 판별해
			 * 네이버 로그인 회원이니 네이버 계정으로 로그인하라는 알림창 띄우기
			 *  */
			

			// 회원리스트 디비에 추가
			sqlMapClientTemplate.insert("member.insertMem", memDTO);
			
			// 회원개인 디비 생성(아직 안됨)
			//sqlMapClientTemplate.update("createMemInfo", id);

			// 세션에 넣음(네이버에서 부여한 고유 id)
			HttpSession session = request.getSession();
			session.setAttribute("memId", id);
			
			System.out.println("First LOGIN");
		}


		
		return "/member/MyUsedNaverLoginPro.jsp";
	}
	
	
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
	

}
