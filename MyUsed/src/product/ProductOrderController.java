package product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class ProductOrderController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	@RequestMapping("productOrder.nhn")
	public ModelAndView productOrder(){
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("/product/ProductOrder.jsp");
		
		return mv;
	}

}
