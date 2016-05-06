/**
 * 작성일 : 160502
 * 작성자 : 이수민
 * 네이버 로그인 , 일반 회원가입 
 * 
 * 수정 : 160503
 * 일반 회원가입 분리
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
	

	/** 네이버 로그아웃 아직 안됨 */
	@RequestMapping("/MyUsedLogout.nhn")
	public String logout(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		session.removeAttribute("memId");
		
		return "/member/MyUsedLogoutPro.jsp";
	}
	
	@RequestMapping("/MyUsedNaverLoginPro.nhn")
	public String MyUsedNaverLoginPro(HttpServletRequest request, String id, String email, String name, String gender, String birthday, String accesstoken){

		String result="";
		
		/** 로그인 체크 -> 로그인한적있으면 1 / 첫로그인 0 */
		int check = (Integer)sqlMapClientTemplate.queryForObject("member.checkNaverId", id);
		if(check == 1){
			/** 로그인을 한 적있는 아이디 -> 아이디를 세션에 넣음 */
			HttpSession session = request.getSession();
			session.setAttribute("memId", email);

			result="/member/MyUsedNaverLoginPro.jsp";
			
		}else{
			/** 첫 로그인인 아이디 -> 회원리스트디비에 넣음/회원개인테이블생성/세션에도 넣음  */
			// 네이버 로그인 시 페스워드 난수 생성하여 넣기
			int pw = (int) (Math.random()*100000);
			String spw = pw+"";
			
			memDTO.setId(email);
			memDTO.setName(name);
			memDTO.setPassword(spw);
			memDTO.setBirthdate(birthday);
			memDTO.setGender(gender);
			memDTO.setNaverid(id);
			/* 수정 할 점1
			 * 로그인할 때 네이버아이디로 최초가입한 아이디를 판별해
			 * 네이버 로그인 회원이니 네이버 계정으로 로그인하라는 알림창 띄우기
			 *  */
			

			// 회원리스트 디비에 추가
			sqlMapClientTemplate.insert("member.insertMem", memDTO);
			
			// 회원개인 디비 생성(아직 안됨)
			//sqlMapClientTemplate.update("createMemInfo", id);

			// 세션에 넣음(네이버에서 부여한 고유 id)
			HttpSession session = request.getSession();
			session.setAttribute("memId", email);
			
			System.out.println("First LOGIN");
			
			result="/member/MyUsedNaverFirstLoginPro.jsp";
		}

		return result;
	}
	
	@RequestMapping("/MyUsedLoginPro.nhn")
	public String MyUsedLoginPro(HttpServletRequest request, String id, String pw){
		String result = "";
		
		Map loginmap = new HashMap();
		loginmap.put("id", id);
		loginmap.put("password", pw);
		
		int naver = (Integer) sqlMapClientTemplate.queryForObject("member.joinedNaverId", id);
		System.out.println(naver);
		if(naver == 0){			//네이버 아이디가 아닐경우
			
			int check = (Integer)sqlMapClientTemplate.queryForObject("member.loginCheck", loginmap);
			if(check == 1){
				// 가입된 아이디가 있으면 세션에 넣음
				HttpSession session = request.getSession();
				session.setAttribute("memId", id);
				
				result = "/member/MyUsedLoginPro.jsp";
			}else{
				/**  
				 * 아이디가 디비에 있는지 검색한 후 
				 * 디비에 있으면 ~~님 맞으세요? 창 띄우고 다시 로그인/비번찾기
				 * 디비에 없으면 로그인창 띄우고 계정가입(입력된 이메일과 일치하는 계정이 없습니다. 계정을 가입하세요.)
				 * */
				int checkId = (Integer)sqlMapClientTemplate.queryForObject("member.checkId", id);
				if(checkId == 1){
					String name = (String) sqlMapClientTemplate.queryForObject("member.selectName", id);

					request.setAttribute("name", name);
					request.setAttribute("id", id);
				
					result = "/member/MyUsedLoginReconfirm.jsp";
					}else{
						request.setAttribute("id", id);
						result = "/member/MyUsedLoginOnly.jsp";
					}
			}
		}else{
			result = "/member/MyUsedLoginFailed.jsp";
		}
		
		return result;
	}

}
