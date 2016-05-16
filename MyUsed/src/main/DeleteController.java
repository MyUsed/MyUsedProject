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
		
		int mem_num = (int)sqlMap.queryForObject("delete.mem_num", num); // board_ (개인 board의 번호를 가져옴)
		Map map = new HashMap();
		map.put("mem_num", mem_num);
		map.put("num", num);
		
		
		int board_num = (int)sqlMap.queryForObject("delete.board_num", map); // board_#num# 의 게시글번호를 가져옴
		map.put("board_num", board_num);
		
		
		sqlMap.delete("delete.boardDelete", map);	 // 개인 db 게시글 삭제
		sqlMap.delete("delete.boardlistDelete", num); // 토탈 db 게시글 삭제
		sqlMap.delete("delete.picDelete", map); // 개인 pic 사진 삭제
		
		
		System.out.println("board의 회원 mem_num = "+mem_num);
		System.out.println("개인board의 게시글 num = "+board_num);
		
		System.out.println(num+"번 토탈게시글삭제완료");
		System.out.println(mem_num+"개인board의"+board_num+"게시글삭제완료");
		mv.setViewName("/main/Delete.jsp");
		return mv;
	}
	
	@RequestMapping("/prodelete.nhn")
	public ModelAndView prodelete(int num){
		ModelAndView mv = new ModelAndView();
		
		int promem_num = (int)sqlMap.queryForObject("delete.promem_num", num); // proboardlist 에서 개인의 mem_num을 꺼내옴 
		Map promap = new HashMap();
		promap.put("num", num);
		promap.put("promem_num", promem_num);
		
		int proboard_num = (int)sqlMap.queryForObject("delete.proboard_num", promap); // proboard_#num# 의 게시글 번호를 가져옴
		promap.put("proboard_num", proboard_num);
		
		sqlMap.delete("delete.proboardDelete", promap); // 개인 DB 내용 삭제
		sqlMap.delete("delete.proboardlistDelete", num); // 전체 DB 내용 삭제
		//sqlMap.delete("deletem.propicDelete", promap); // 개인 사진 DB 내용 삭제
		
		mv.setViewName("/main/Delete.jsp");
		return mv;
	}

	
	
	
	
	
	
	
	
}
