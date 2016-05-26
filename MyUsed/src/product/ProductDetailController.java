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
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
	
	private List<RepleDTO> proreplelist = new ArrayList<RepleDTO>();;	
	private ProfilePicDTO proDTO = new ProfilePicDTO();
	
	@RequestMapping("/ProductDetailView.nhn")
	public String ProductDetailView(HttpServletRequest request, int num){
		
		System.out.println(num);	// ��ǰ�۹�ȣ
		
		
		/*��� �ҷ�����*/
		Timestamp reg = (Timestamp)sqlMap.queryForObject("reple.proboardreg",num); // �Խñ� ��ϵ� �ð� ��������
		String name = (String)sqlMap.queryForObject("reple.proboardname",num); // boardlist���� �۾��� �̸� ��������
		int mem_num = (int)sqlMap.queryForObject("reple.promem_num",num); // ��۴ٴ� ����� ȸ����ȣ ��������

		
		proreplelist = sqlMap.queryForList("reple.proselect", num); // ��� �������� 
		
		/*
		String sql = "";
		// ����� 0���� Ŭ ��
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
		
		HttpSession session = request.getSession();
	    String sessionId = (String) session.getAttribute("memId");
	    int session_num = (int)sqlMap.queryForObject("main.num",sessionId); // ȸ����ȣ ��������

	    Map picmap = new HashMap();
		picmap.put("mem_num", session_num);   
		proDTO = (ProfilePicDTO) sqlMap.queryForObject("profile.newpic", picmap); // ��۴� ������ ������ ������
		
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
