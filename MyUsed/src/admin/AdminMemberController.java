package admin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class AdminMemberController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 

	AdminListDTO adminDTO = new AdminListDTO();
	private List<AdminListDTO> list = new ArrayList<AdminListDTO>();;	
	
	
	@RequestMapping("/AdminMember.nhn")
	public ModelAndView adminMember(){
		ModelAndView mv = new ModelAndView();
		
		list = sqlMap.queryForList("admin.adminSelect",null);
		
		mv.addObject("list",list);
		mv.setViewName("/admin/AdminMember.jsp");
		return mv;
	}
	
	@RequestMapping("/AdminCreate.nhn")
	public ModelAndView adminCreate(AdminListDTO adminDTO){
		ModelAndView mv = new ModelAndView();
		
		sqlMap.insert("admin.adminCreate",adminDTO); // �Է¹��� ���� insert


		mv.setViewName("/AdminMember.nhn");
		return mv;
	}
}
