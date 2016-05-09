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
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
		
	@RequestMapping("/delete.nhn")
	public ModelAndView delete(int num){
		ModelAndView mv = new ModelAndView();
		
		// /////////////////////////////////// 테이블 join해서 문제해결 가능
		Object reg = sqlMap.queryForObject("delete.totalreg", num); // totalboard 의 reg 
		int mem_num = (int)sqlMap.queryForObject("delete.mem_num", num); // board_ (개인 board의 번호를 가져옴)
		
		Map map = new HashMap(); // 2개의 값을 넘겨주기위해
		
		map.put("num",mem_num);
		map.put("reg", reg); 
		
		//sqlMap.delete("delete.boardDelete", map);	 // 개인 db 게시글 삭제
		//sqlMap.delete("delete.totalboardDelete", num); // 토탈 db 게시글 삭제

		System.out.println("board의 mem_num = "+mem_num);
		System.out.println("totalboard의 reg = "+reg);
		
		System.out.println(num+"번 토탈게시글삭제완료");
		System.out.println(mem_num+"개인게시글삭제완료");
		mv.setViewName("/main/Delete.jsp");
		return mv;
	}

}
