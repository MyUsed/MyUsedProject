package product;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import friend.FriendDTO;
import main.MainProboardDTO;
import main.RepleDTO;
import member.ProfilePicDTO;

@Controller
public class ProductDetailController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	private List<RepleDTO> proreplelist = new ArrayList<RepleDTO>();;	
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	
	@RequestMapping("/ProductDetailView.nhn")
	public String ProductDetailView(HttpServletRequest request, int num){
		
		System.out.println(num);	// 상품글번호
		
		
		/*댓글 불러오기*/
		Timestamp reg = (Timestamp)sqlMap.queryForObject("reple.proboardreg",num); // 게시글 등록된 시간 가져오기
		String name = (String)sqlMap.queryForObject("reple.proboardname",num); // boardlist에서 글쓴이 이름 가져오기
		int mem_num = (int)sqlMap.queryForObject("reple.promem_num",num); // 댓글다는 사람의 회원번호 가져오기

		
		proreplelist = sqlMap.queryForList("reple.proselect", num); // 댓글 가져오기 
		
		/*
		String sql = "";
		// 댓글이 0보다 클 때
		if(proreplelist.size() > 0){
			for(int i = 0 ; i < proreplelist.size() ; i++){
				System.out.println(((RepleDTO)proreplelist.get(i)).getMem_num());
				sql += "select * from profilepic_"+((RepleDTO)proreplelist.get(i)).getMem_num()+" where pic_num = (select max(pic_num) from profilepic_"+((RepleDTO)proreplelist.get(i)).getMem_num()+") union ";
			}
			sql += "select * from profilepic_"+((RepleDTO)proreplelist.get(proreplelist.size()-1)).getMem_num()+" where pic_num = (select max(pic_num) from profilepic_"+((RepleDTO)proreplelist.get(proreplelist.size()-1)).getMem_num()+")";
		}
		System.out.println(sql);
		
		proreplelist = sqlMap.queryForList("reple.proSelectWithPic", sql);
		
		*/
		
		request.setAttribute("proreplelist",proreplelist);
		

		// 상품 글번호를 이용해서 proboarlist에서 정보를 뽑아옴(모든 상품 글 리스트)
		MainProboardDTO productDTO = new MainProboardDTO();
		productDTO = (MainProboardDTO) sqlMap.queryForObject("product.selectProNum",num);
		
		/** 상품 사진 전체 불러오기!
		* proboardlist에서의 mem_num을 이용하여 개인 상품글 테이블을 검색한 후
		* proboardlist의 content와 reg와 일치하는 개인 상품글을 찾아 해당 상품의 num을 찾는다.
		* 해당 상품의 num을 이용하여 개인 상품 사진 테이블에서 이미지들을 찾아온다.
		*/
		Map mem_numMap = new HashMap();
		mem_numMap.put("mem_num", productDTO.getMem_num());
		mem_numMap.put("content", productDTO.getContent());
		mem_numMap.put("reg", productDTO.getReg());
		int proNum = (Integer)sqlMap.queryForObject("product.findProboard", mem_numMap);
		mem_numMap.put("num", proNum);
		
		List propicList = new ArrayList();
		propicList = sqlMap.queryForList("product.findPropic", mem_numMap);
		
		
		/** 해당 상품 글쓴이의 프로필 사진 */
		String profilepic = (String) sqlMap.queryForObject("product.propic", mem_numMap);
		
		HttpSession session = request.getSession();
	    String sessionId = (String) session.getAttribute("memId");
	    int session_num = (int)sqlMap.queryForObject("main.num",sessionId); // 회원번호 가져오기

	    Map picmap = new HashMap();
		picmap.put("mem_num", session_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // 댓글단 프로필 사진을 가져옴
		
		int procount = (int)sqlMap.queryForObject("reple.procount",num);
		
		request.setAttribute("procount", procount);
		request.setAttribute("session_num", session_num);
		request.setAttribute("profilepic", profilepic);
		request.setAttribute("propicList", propicList);
		request.setAttribute("productDTO", productDTO);
		request.setAttribute("proDTO", proDTO);
		request.setAttribute("num", num);
		
		return "/product/ProductDetailView.jsp";
	}
	
	@RequestMapping("/ProBigImage.nhn")
	public String ProBigimage(HttpServletRequest request, String pic){	
		request.setAttribute("pic", pic);
		return "/product/ProBigImage.jsp";
	}

	

}
