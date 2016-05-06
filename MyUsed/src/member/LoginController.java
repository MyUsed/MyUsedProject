/**
 * �ۼ��� : 160502
 * �ۼ��� : �̼���
 * ���̹� �α��� , �Ϲ� ȸ������ 
 * 
 * ���� : 160503
 * �Ϲ� ȸ������ �и�
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
	

	/** ���̹� �α׾ƿ� ���� �ȵ� */
	@RequestMapping("/MyUsedLogout.nhn")
	public String logout(HttpServletRequest request){
		
		HttpSession session = request.getSession();
		session.removeAttribute("memId");
		
		return "/member/MyUsedLogoutPro.jsp";
	}
	
	@RequestMapping("/MyUsedNaverLoginPro.nhn")
	public String MyUsedNaverLoginPro(HttpServletRequest request, String id, String email, String name, String gender, String birthday, String accesstoken){

		String result="";
		
		/** �α��� üũ -> �α������������� 1 / ù�α��� 0 */
		int check = (Integer)sqlMapClientTemplate.queryForObject("member.checkNaverId", id);
		if(check == 1){
			/** �α����� �� ���ִ� ���̵� -> ���̵� ���ǿ� ���� */
			HttpSession session = request.getSession();
			session.setAttribute("memId", email);

			result="/member/MyUsedNaverLoginPro.jsp";
			
		}else{
			/** ù �α����� ���̵� -> ȸ������Ʈ��� ����/ȸ���������̺����/���ǿ��� ����  */
			// ���̹� �α��� �� �佺���� ���� �����Ͽ� �ֱ�
			int pw = (int) (Math.random()*100000);
			String spw = pw+"";
			
			memDTO.setId(email);
			memDTO.setName(name);
			memDTO.setPassword(spw);
			memDTO.setBirthdate(birthday);
			memDTO.setGender(gender);
			memDTO.setNaverid(id);
			/* ���� �� ��1
			 * �α����� �� ���̹����̵�� ���ʰ����� ���̵� �Ǻ���
			 * ���̹� �α��� ȸ���̴� ���̹� �������� �α����϶�� �˸�â ����
			 *  */
			

			// ȸ������Ʈ ��� �߰�
			sqlMapClientTemplate.insert("member.insertMem", memDTO);
			
			// ȸ������ ��� ����(���� �ȵ�)
			//sqlMapClientTemplate.update("createMemInfo", id);

			// ���ǿ� ����(���̹����� �ο��� ���� id)
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
		if(naver == 0){			//���̹� ���̵� �ƴҰ��
			
			int check = (Integer)sqlMapClientTemplate.queryForObject("member.loginCheck", loginmap);
			if(check == 1){
				// ���Ե� ���̵� ������ ���ǿ� ����
				HttpSession session = request.getSession();
				session.setAttribute("memId", id);
				
				result = "/member/MyUsedLoginPro.jsp";
			}else{
				/**  
				 * ���̵� ��� �ִ��� �˻��� �� 
				 * ��� ������ ~~�� ��������? â ���� �ٽ� �α���/���ã��
				 * ��� ������ �α���â ���� ��������(�Էµ� �̸��ϰ� ��ġ�ϴ� ������ �����ϴ�. ������ �����ϼ���.)
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
