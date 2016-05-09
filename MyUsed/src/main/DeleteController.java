package main;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DeleteController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
		
	@RequestMapping("/delete.nhn")
	public ModelAndView delete(int num){
		ModelAndView mv = new ModelAndView();
		
		// /////////////////////////////////// ���̺� join�ؼ� �����ذ� ����
		Object reg = sqlMap.queryForObject("delete.totalreg", num); // totalboard �� reg 
		int mem_num = (int)sqlMap.queryForObject("delete.mem_num", num); // board_ (���� board�� ��ȣ�� ������)
		
		Map map = new HashMap(); // 2���� ���� �Ѱ��ֱ�����
		
		map.put("num",mem_num);
		map.put("reg", reg); 
		
		//sqlMap.delete("delete.boardDelete", map);	 // ���� db �Խñ� ����
		//sqlMap.delete("delete.totalboardDelete", num); // ��Ż db �Խñ� ����

		System.out.println("board�� mem_num = "+mem_num);
		System.out.println("totalboard�� reg = "+reg);
		
		System.out.println(num+"�� ��Ż�Խñۻ����Ϸ�");
		System.out.println(mem_num+"���ΰԽñۻ����Ϸ�");
		mv.setViewName("/main/Delete.jsp");
		return mv;
	}

}
