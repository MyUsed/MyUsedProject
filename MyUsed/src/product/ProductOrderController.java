package product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class ProductOrderController {
	
	@Autowired	 // 컨트롤러로 부터 Date 객체를 자동으로 받아줌;
	private SqlMapClientTemplate sqlMap; // ibatis를 사용 하기위해 
	
	@RequestMapping("productOrder.nhn")
	public ModelAndView productOrder(){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/product/ProductOrder.jsp");
		
		return mv;
	}

}
