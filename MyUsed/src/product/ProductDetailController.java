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
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	
	@RequestMapping("/ProductDetailView.nhn")
	public String ProductDetailView(HttpServletRequest request, int num){
		
		System.out.println(num);	// ��ǰ�۹�ȣ
		
		// ��ǰ �۹�ȣ�� �̿��ؼ� proboarlist���� ������ �̾ƿ�(��� ��ǰ �� ����Ʈ)
		MainProboardDTO productDTO = new MainProboardDTO();
		productDTO = (MainProboardDTO) sqlMap.queryForObject("product.selectProNum",num);
		
		/** ��ǰ ���� ��ü �ҷ�����!
		* proboardlist������ mem_num�� �̿��Ͽ� ���� ��ǰ�� ���̺��� �˻��� ��
		* proboardlist�� content�� reg�� ��ġ�ϴ� ���� ��ǰ���� ã�� �ش� ��ǰ�� num�� ã�´�.
		* �ش� ��ǰ�� num�� �̿��Ͽ� ���� ��ǰ ���� ���̺��� �̹������� ã�ƿ´�.
		*/
		Map mem_numMap = new HashMap();
		mem_numMap.put("mem_num", productDTO.getMem_num());
		mem_numMap.put("content", productDTO.getContent());
		mem_numMap.put("reg", productDTO.getReg());
		int proNum = (Integer)sqlMap.queryForObject("product.findProboard", mem_numMap);
		mem_numMap.put("num", proNum);
		
		List propicList = new ArrayList();
		propicList = sqlMap.queryForList("product.findPropic", mem_numMap);
		
		
		/** �ش� ��ǰ �۾����� ������ ���� */
		String profilepic = (String) sqlMap.queryForObject("product.propic", mem_numMap);

		request.setAttribute("profilepic", profilepic);
		request.setAttribute("propicList", propicList);
		request.setAttribute("productDTO", productDTO);
		
		return "/product/ProductDetailView.jsp";
	}
	

}
