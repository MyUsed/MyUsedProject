/**
 * �ۼ��� : 160502
 * �ۼ��� : �̼���
 * ���̹� �α��� , �Ϲ� ȸ������ 
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
	

	/** �α׾ƿ� ���� �ȵ� */
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
		
		/** �α��� üũ -> �α������������� 1 / ù�α��� 0 */
		int check = (Integer)sqlMapClientTemplate.queryForObject("member.checkId", id);
		if(check == 1){
			/** �α����� �� ���ִ� ���̵� -> ���̵� ���ǿ� ���� */
			HttpSession session = request.getSession();
			session.setAttribute("memId", id);
			
			
		}else{
			/** ù �α����� ���̵� -> ȸ������Ʈ��� ����/ȸ���������̺����/���ǿ��� ����  */
			memDTO.setId(email);
			memDTO.setName(name);
			memDTO.setPassword("0");
			memDTO.setBirthdate(birthday);
			memDTO.setGender(gender);
			memDTO.setNaverid(id);
			/* ���� �� ��
			 * ���̹� �α��ν� �佺����� ���� �����ؼ� �ֱ�(����)
			 * �α����� �� ���̹����̵�� ���ʰ����� ���̵� �Ǻ���
			 * ���̹� �α��� ȸ���̴� ���̹� �������� �α����϶�� �˸�â ����
			 *  */
			

			// ȸ������Ʈ ��� �߰�
			sqlMapClientTemplate.insert("member.insertMem", memDTO);
			
			// ȸ������ ��� ����(���� �ȵ�)
			//sqlMapClientTemplate.update("createMemInfo", id);

			// ���ǿ� ����(���̹����� �ο��� ���� id)
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

		// ȸ�� ���
		sqlMapClientTemplate.insert("member.insertMem", memDTO);


		return "/member/MyUsedJoinPro.jsp";
	}
	

}
