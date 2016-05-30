package admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	private List<AdminListDTO> partlist = new ArrayList<AdminListDTO>();;
	private List<AdminListDTO> GradePartlist = new ArrayList<AdminListDTO>();;	
	
	
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
	
	@RequestMapping("/AdminDelete.nhn")
	public ModelAndView admindelete(String id){
		ModelAndView mv = new ModelAndView();
		
		
		sqlMap.delete("admin.adminDelete",id); // ���� ���� 
		
		mv.setViewName("/AdminMember.nhn");
		return mv;
	}
	
	@RequestMapping("/AdminUpdate.nhn")
	public ModelAndView adminupdate(){
		ModelAndView mv = new ModelAndView();
		
		list = sqlMap.queryForList("admin.adminSelect",null);
		
		mv.addObject("list",list);
		mv.setViewName("/admin/AdminUpdate.jsp");
		return mv;
	}
	
	@RequestMapping("/AdminChange.nhn")
	public ModelAndView adminchange(AdminListDTO adminDTO , String gradeSelect){
		ModelAndView mv = new ModelAndView();
		
		System.out.println(adminDTO.getGrade());
		System.out.println(adminDTO.getPart());
		System.out.println(gradeSelect);
		
		mv.setViewName("/AdminMember.nhn");
		return mv;
	}
	
	@RequestMapping("/AdminUpdateMem.nhn")
	public ModelAndView adminUpdateMem(int seq_num){
		ModelAndView mv = new ModelAndView();
		
		adminDTO = (AdminListDTO)sqlMap.queryForObject("admin.adminMemSelect", seq_num);
		
		mv.addObject("adminDTO",adminDTO);
		mv.setViewName("/admin/AdminUpdateMem.jsp");
		return mv;
	}
	
	@RequestMapping("/AdminUpdateCheck.nhn")
	public ModelAndView adminUpdateCheck(AdminListDTO adminDTO){
		ModelAndView mv = new ModelAndView();
		
	
		Map map = new HashMap();
		map.put("seq_num", adminDTO.getSeq_num());
		map.put("grade", adminDTO.getGrade());
		map.put("part", adminDTO.getPart());
		
		System.out.println(adminDTO.getSeq_num());
		System.out.println(adminDTO.getGrade());
		sqlMap.update("admin.updateAdmin",map);
		
		
		mv.setViewName("/AdminMember.nhn");
		return mv;
	}
	
	
	@RequestMapping("/AdminSearch.nhn")
	public ModelAndView adminSearch(String grade , String part , String search, String ser){
		ModelAndView mv = new ModelAndView();
		
		
	
		Map map = new HashMap();
		map.put("grade", grade);
		map.put("part", part);
		list = sqlMap.queryForList("admin.GradePart",map);
		
		if(part.equals("null")){
			list = sqlMap.queryForList("admin.searchGrade",grade);				
		}
		if(grade.equals("null")){
			list = sqlMap.queryForList("admin.searchPart",part);
		}
		
		if(ser.equals("id")){
			list = sqlMap.queryForList("admin.searchAdminId",search);
		}
		
		if(ser.equals("name")){
			list = sqlMap.queryForList("admin.searchAdminName",search);
		}
		
		
		mv.addObject("list",list);
		mv.setViewName("/admin/AdminSearch.jsp");
		return mv;
	}
	
	
	
	
	
	
	
}
