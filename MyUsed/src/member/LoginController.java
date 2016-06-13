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
		String id = (String) session.getAttribute("memId");
		
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", id);
		request.setAttribute("naverId", memDTO.getNaverid());
		
		sqlMapClientTemplate.update("member.Log_off", id);	// 로그인상태를 on으로(onoff 컬럼 1)

		session.removeAttribute("memId");
		
		return "/member/MyUsedLogoutPro.jsp";
	}
	
	@RequestMapping("/MyUsedNaverLoginPro.nhn")
	public String MyUsedNaverLoginPro(HttpServletRequest request, String id, String email, String name, String gender, String birthday, String accesstoken){

		String result="";
		
		/** 로그인 체크 -> 로그인한적있으면 1 / 첫로그인 0 */
		int check = (Integer)sqlMapClientTemplate.queryForObject("member.checkNaverId", id);
		if(check == 1){
			/** 로그인을 한 적있는 아이디 -> 아이디를 세션에 넣음-> 로그인 on 상태로 바꿈*/
			HttpSession session = request.getSession();
			session.setAttribute("memId", email);
			sqlMapClientTemplate.update("member.Log_on", email);	// 로그인상태를 on으로(onoff 컬럼 1)

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
			memDTO.setGrade(3);
			memDTO.setPoint(0);
			memDTO.setOnoff("0");	//0 비로그인/ 1 로그인
			memDTO.setNaverid(id);
			memDTO.setChatonoff("0");
			

			// 회원리스트 디비에 추가
			sqlMapClientTemplate.insert("member.insertMem", memDTO);
			
			// 세션에 넣음(네이버에서 부여한 고유 id)
			HttpSession session = request.getSession();
			session.setAttribute("memId", email);
			sqlMapClientTemplate.update("member.Log_on", email);	// 로그인상태를 on으로(onoff 컬럼 1)

			System.out.println("First LOGIN");
			
			// 등록된 회원의 넙버를 가져온다.
			int num = (Integer)sqlMapClientTemplate.queryForObject("member.findNum", memDTO);
		
			// creatDB로 num변수를 보낸다.
			request.setAttribute("num", num);

			//result="/member/MyUsedNaverFirstLoginPro.jsp";
			result="/member/createDB.jsp";
		}

		return result;
	}
	
	/* 일반 로그인 */
	@RequestMapping("/MyUsedLoginPro.nhn")
	public String MyUsedLoginPro(HttpServletRequest request, String id, String pw){
		String result = "";
		
		Map loginmap = new HashMap();
		loginmap.put("id", id);
		loginmap.put("password", pw);
		
		/**  
		 * 1.아이디가 디비에 있는지 검색한 후 
		 * 2.아이디가 디비에 있으면 ~~님 맞으세요? 창 띄우고 다시 로그인/비번찾기
		 * 3.아이디가 디비에 없으면 로그인창 띄우고 계정가입(입력된 이메일과 일치하는 계정이 없습니다. 계정을 가입하세요.)
		 * */

		// 디비에 아이디가 있는지 없는지 판단 후
		int checkId = (Integer)sqlMapClientTemplate.queryForObject("member.checkId", id);
		if(checkId == 1){	//있는 경우
			// 해당 아이디가 네이버 아이디인지 아닌지 판단
			int naver = (Integer) sqlMapClientTemplate.queryForObject("member.joinedNaverId", id);
			System.out.println(naver);
			if(naver == 0){			//네이버 아이디가 아닐경우
				// 아이디 비번을 넣어 일치하는지 확인
				int check = (Integer)sqlMapClientTemplate.queryForObject("member.loginCheck", loginmap);
				if(check == 1){
					// map으로 넣은 아이디 비번이 일치하면 아이디를 세션에 넣음
					HttpSession session = request.getSession();
					session.setAttribute("memId", id);
					sqlMapClientTemplate.update("member.Log_on", id);	// 로그인상태를 on으로(onoff 컬럼 1)

					result = "/member/MyUsedLoginPro.jsp";
					
				}else{	// 아이디 비번이 일치하지 않는 경우(비번이 틀리면)
					String name = (String) sqlMapClientTemplate.queryForObject("member.selectName", id);

					request.setAttribute("name", name);
					request.setAttribute("id", id);

					result = "/member/MyUsedLoginReconfirm.jsp";	//~~님이세요? 나오는거
				}
			}else{
				result = "/member/MyUsedLoginFailed.jsp";	// 해당 아이디는 네이버 계정이므로~ 나오는거
			}
			
			
		}else{
			request.setAttribute("id", id);
			result = "/member/MyUsedLoginOnly.jsp";	// 아예 다시 로그인(디비에 아이디 없는경우ㄴ)
			
			
		}
		return result;
	}

}
