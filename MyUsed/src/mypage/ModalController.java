package mypage;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ModalController {

	@Autowired
	private SqlMapClientTemplate sqlMap;

	@RequestMapping("/MypageModal.nhn")
	public String MypageModal(HttpServletRequest request, int mem_num, int listnum, Timestamp reg){
		
		String board_pic = (String)sqlMap.queryForObject("reple.pic",listnum); // 게시글의 사진 가져오기
		
		// 사진을 전부 꺼내오는 작업
		String mem_pic = (String)sqlMap.queryForObject("reple.mem_pic",listnum); // 메인사진의 이름을 가져오기
				
		Map remap = new HashMap();
		if(mem_pic != null){
			remap.put("mem_num", mem_num);
			remap.put("mem_pic", mem_pic);
			remap.put("reg", reg);
			//int pic_num = (int)sqlMap.queryForObject("reple.pic_num",remap); // 사진의 num을 가져오기
			int pic_num = (int)sqlMap.queryForObject("reple.pic_reg_num",remap); // 사진의 num을 가져오기
			remap.put("pic_num", pic_num);
		}
		
		List piclist = new ArrayList();
		piclist = sqlMap.queryForList("reple.all_pic",remap);
		
		
		request.setAttribute("board_pic", board_pic);
		
		return "/mypage/list_modalpic.jsp";
	}
}
