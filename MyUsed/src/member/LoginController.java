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
		String id = (String) session.getAttribute("memId");
		
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", id);
		request.setAttribute("naverId", memDTO.getNaverid());
		
		sqlMapClientTemplate.update("member.Log_off", id);	// �α��λ��¸� on����(onoff �÷� 1)

		session.removeAttribute("memId");
		
		return "/member/MyUsedLogoutPro.jsp";
	}
	
	@RequestMapping("/MyUsedNaverLoginPro.nhn")
	public String MyUsedNaverLoginPro(HttpServletRequest request, String id, String email, String name, String gender, String birthday, String accesstoken){

		String result="";
		
		/** �α��� üũ -> �α������������� 1 / ù�α��� 0 */
		int check = (Integer)sqlMapClientTemplate.queryForObject("member.checkNaverId", id);
		if(check == 1){
			/** �α����� �� ���ִ� ���̵� -> ���̵� ���ǿ� ����-> �α��� on ���·� �ٲ�*/
			HttpSession session = request.getSession();
			session.setAttribute("memId", email);
			sqlMapClientTemplate.update("member.Log_on", email);	// �α��λ��¸� on����(onoff �÷� 1)

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
			memDTO.setGrade(3);
			memDTO.setPoint(0);
			memDTO.setOnoff("0");	//0 ��α���/ 1 �α���
			memDTO.setNaverid(id);
			memDTO.setChatonoff("0");
			

			// ȸ������Ʈ ��� �߰�
			sqlMapClientTemplate.insert("member.insertMem", memDTO);
			
			// ���ǿ� ����(���̹����� �ο��� ���� id)
			HttpSession session = request.getSession();
			session.setAttribute("memId", email);
			sqlMapClientTemplate.update("member.Log_on", email);	// �α��λ��¸� on����(onoff �÷� 1)

			System.out.println("First LOGIN");
			
			// ��ϵ� ȸ���� �ҹ��� �����´�.
			int num = (Integer)sqlMapClientTemplate.queryForObject("member.findNum", memDTO);
		
			// creatDB�� num������ ������.
			request.setAttribute("num", num);

			//result="/member/MyUsedNaverFirstLoginPro.jsp";
			result="/member/createDB.jsp";
		}

		return result;
	}
	
	/* �Ϲ� �α��� */
	@RequestMapping("/MyUsedLoginPro.nhn")
	public String MyUsedLoginPro(HttpServletRequest request, String id, String pw){
		String result = "";
		
		Map loginmap = new HashMap();
		loginmap.put("id", id);
		loginmap.put("password", pw);
		
		/**  
		 * 1.���̵� ��� �ִ��� �˻��� �� 
		 * 2.���̵� ��� ������ ~~�� ��������? â ���� �ٽ� �α���/���ã��
		 * 3.���̵� ��� ������ �α���â ���� ��������(�Էµ� �̸��ϰ� ��ġ�ϴ� ������ �����ϴ�. ������ �����ϼ���.)
		 * */

		// ��� ���̵� �ִ��� ������ �Ǵ� ��
		int checkId = (Integer)sqlMapClientTemplate.queryForObject("member.checkId", id);
		if(checkId == 1){	//�ִ� ���
			// �ش� ���̵� ���̹� ���̵����� �ƴ��� �Ǵ�
			int naver = (Integer) sqlMapClientTemplate.queryForObject("member.joinedNaverId", id);
			System.out.println(naver);
			if(naver == 0){			//���̹� ���̵� �ƴҰ��
				// ���̵� ����� �־� ��ġ�ϴ��� Ȯ��
				int check = (Integer)sqlMapClientTemplate.queryForObject("member.loginCheck", loginmap);
				if(check == 1){
					// map���� ���� ���̵� ����� ��ġ�ϸ� ���̵� ���ǿ� ����
					HttpSession session = request.getSession();
					session.setAttribute("memId", id);
					sqlMapClientTemplate.update("member.Log_on", id);	// �α��λ��¸� on����(onoff �÷� 1)

					result = "/member/MyUsedLoginPro.jsp";
					
				}else{	// ���̵� ����� ��ġ���� �ʴ� ���(����� Ʋ����)
					String name = (String) sqlMapClientTemplate.queryForObject("member.selectName", id);

					request.setAttribute("name", name);
					request.setAttribute("id", id);

					result = "/member/MyUsedLoginReconfirm.jsp";	//~~���̼���? �����°�
				}
			}else{
				result = "/member/MyUsedLoginFailed.jsp";	// �ش� ���̵�� ���̹� �����̹Ƿ�~ �����°�
			}
			
			
		}else{
			request.setAttribute("id", id);
			result = "/member/MyUsedLoginOnly.jsp";	// �ƿ� �ٽ� �α���(��� ���̵� ���°�줤)
			
			
		}
		return result;
	}

}
