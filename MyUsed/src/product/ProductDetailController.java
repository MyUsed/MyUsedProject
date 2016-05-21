package product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import main.MainProboardDTO;
import member.ProfilePicDTO;

@Controller
public class ProductDetailController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	
	@RequestMapping("/ProductDetailView.nhn")
	public String ProductDetailView(HttpServletRequest request, int num){
		
		System.out.println(num);	// 상품글번호
		
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

		request.setAttribute("profilepic", profilepic);
		request.setAttribute("propicList", propicList);
		request.setAttribute("productDTO", productDTO);
		
		return "/product/ProductDetailView.jsp";
	}
	

}
