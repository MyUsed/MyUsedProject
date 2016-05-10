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
		
		int mem_num = (int)sqlMap.queryForObject("delete.mem_num", num); // board_ (���� board�� ��ȣ�� ������)
		
		
		Map map = new HashMap();
		map.put("mem_num", mem_num);
		map.put("num", num);
		
		
		int board_num = (int)sqlMap.queryForObject("delete.board_num", map); // board_#num# �� �Խñ۹�ȣ�� ������
		map.put("board_num", board_num);
		
		
		sqlMap.delete("delete.boardDelete", map);	 // ���� db �Խñ� ����
		sqlMap.delete("delete.boardlistDelete", num); // ��Ż db �Խñ� ����
		sqlMap.delete("delete.picDelete", map); // ���� pic ���� ����
		
		System.out.println("board�� ȸ�� mem_num = "+mem_num);
		System.out.println("����board�� �Խñ� num = "+board_num);
		
		System.out.println(num+"�� ��Ż�Խñۻ����Ϸ�");
		System.out.println(mem_num+"����board��"+board_num+"�Խñۻ����Ϸ�");
		mv.setViewName("/main/Delete.jsp");
		return mv;
	}

}
