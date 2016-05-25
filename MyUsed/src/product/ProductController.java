package product;

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

import main.MainProboardDTO;
import main.ProBoardCategDTO;
import friend.FriendDTO;
import member.MemberDTO;
import member.ProfilePicDTO;

@Controller
public class ProductController {
	
	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private ProfilePicDTO sessionproDTO = new ProfilePicDTO();

	@RequestMapping("/MyUsedProductView.nhn")
	public String MyUsedProductView(HttpServletRequest request, String categ, int currentPage){
		
		/** 1�� ī�װ����� ��ǰ �ѷ��ֱ�(MyUsed���������� ������ ī�װ�) */
		int number=0;
		int totalCount; 		// �� �Խù��� ��
		int blockCount = 9;	// �� ��������  �Խù��� ��
		int blockPage = 10; 	// �� ȭ�鿡 ������ ������ ��
		String pagingHtml; 	//����¡�� ������ HTML
		PagingController page; 	// ����¡ Ŭ���� 
		
		System.out.println(categ);
		System.out.println(categ);
		System.out.println(categ);
		
		List proList = new ArrayList(); 
		proList = sqlMapClientTemplate.queryForList("product.view_categ0", categ);
		
		totalCount = proList.size(); // ��ü �� ������ ���Ѵ�.
		page = new PagingController(currentPage, totalCount, blockCount, blockPage, categ); // pagingAction ��ü ����.
		pagingHtml = page.getPagingHtml().toString(); // ������ HTML ����.

		// ���� ���������� ������ ������ ���� ��ȣ ����.
		int lastCount = totalCount;

		// ���� �������� ������ ���� ��ȣ�� ��ü�� ������ �� ��ȣ���� ������ lastCount�� +1 ��ȣ�� ����.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		// ��ü ����Ʈ���� ���� ��������ŭ�� ����Ʈ�� �����´�.
		proList = proList.subList(page.getStartCount(), lastCount);
		number = page.getNumber();
		
		/** 1�� ī�װ��� ���ϴ� 2�� ī�װ� ��� */
	    ProBoardCategDTO categDTO0 = new ProBoardCategDTO();
	    List categList = new ArrayList();
	    categList = sqlMapClientTemplate.queryForList("product.categ1_List", categ);
	    
	    
	    /** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		// ���� ���̵��� �����ʻ���
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		sessionproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap2);
				
	    
	  	/** ģ�� ��� ����Ʈ(state2) */
	  	Map map = new HashMap();
	  	map.put("num", memDTO.getNum());
	  	List friendState2 = new ArrayList();
	  	friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);
	  	
	  	/** ģ�� ��� ������ �����̱� */
		if(friendState2.size() > 0){
			List friprofileList = new ArrayList();
			for(int i = 0 ; i < friendState2.size() ; i++){
				// ����2�� ģ�� ����� ��ȣ�� �̱�
				int frinum = ((FriendDTO)friendState2.get(i)).getMem_num();
				System.out.println(frinum);
				
				// �ش� ��ȣ�� ���� ������ ���� ���̺��� ã�� �ֱ� ���� ���ڵ带 ����Ʈ�� �ִ´�
				Map frinumMap = new HashMap();
				frinumMap.put("mem_num", frinum);
				
				ProfilePicDTO friproDTO = new ProfilePicDTO();
				friproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", frinumMap);

				friprofileList.add(i, friproDTO);				
			}

			for (int i = 0; i < friprofileList.size() ; i++){
				//System.out.println(knewFriendList_image.get(i));
				System.out.println(((ProfilePicDTO)friprofileList.get(i)).getProfile_pic());
			}
			request.setAttribute("friprofileList", friprofileList);//ģ����� ������ ����
			request.setAttribute("friendState2", friendState2);	//ģ����� �ҷ����� ����Ʈ
		}
	  		
	    

	    request.setAttribute("categList", categList);	//���� �ѷ����� 2�� ī�װ� ����Ʈ
		request.setAttribute("categ", categ);	//1��ī�װ�
		request.setAttribute("sessionproDTO", sessionproDTO);	//���� ���̵� ���� ������ ���� DTO
		request.setAttribute("memDTO", memDTO);
		/*����������*/
		request.setAttribute("proList", proList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("blockCount", blockCount);
		request.setAttribute("blockPage", blockPage);
		request.setAttribute("pagingHtml", pagingHtml);
		request.setAttribute("page", page);
		request.setAttribute("number", number);
		
		return "/product/MyUsedProductView.jsp";
	}
	
	@RequestMapping("/MyUsedProductView2.nhn")
	public String MyUsedProductView2(HttpServletRequest request, String categ, String categ2,int currentPage){
		
		/** 2�� ī�װ����� ��ǰ �ѷ��ֱ�(MyUsed���������� ������ ī�װ�) */int number=0;
		int totalCount; 		// �� �Խù��� ��
		int blockCount = 9;	// �� ��������  �Խù��� ��
		int blockPage = 10; 	// �� ȭ�鿡 ������ ������ ��
		String pagingHtml; 	//����¡�� ������ HTML
		PagingController page; 	// ����¡ Ŭ���� 
		
		String fullcateg = categ+"/"+categ2;
		List proList = new ArrayList(); 
		proList = sqlMapClientTemplate.queryForList("product.view_categ1", fullcateg);

		totalCount = proList.size(); // ��ü �� ������ ���Ѵ�.
		page = new PagingController(currentPage, totalCount, blockCount, blockPage, categ, categ2); // pagingAction ��ü ����.
		pagingHtml = page.getPagingHtml().toString(); // ������ HTML ����.

		// ���� ���������� ������ ������ ���� ��ȣ ����.
		int lastCount = totalCount;

		// ���� �������� ������ ���� ��ȣ�� ��ü�� ������ �� ��ȣ���� ������ lastCount�� +1 ��ȣ�� ����.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		// ��ü ����Ʈ���� ���� ��������ŭ�� ����Ʈ�� �����´�.
		proList = proList.subList(page.getStartCount(), lastCount);
		number = page.getNumber();
		
		/** 1�� ī�װ��� ���ϴ� 2�� ī�װ� ��� */
	    ProBoardCategDTO categDTO0 = new ProBoardCategDTO();
	    List categList = new ArrayList();
	    categList = sqlMapClientTemplate.queryForList("product.categ1_List", categ);
		

	    /** �α����� ������� �̸� ��������(���Ǿ��̵� �̿�) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		// ���� ���̵��� �����ʻ���
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		sessionproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap2);
				
	    
	  	/** ģ�� ��� ����Ʈ(state2) */
	  	Map map = new HashMap();
	  	map.put("num", memDTO.getNum());
	  	List friendState2 = new ArrayList();
	  	friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);
	  	
	  	/** ģ�� ��� ������ �����̱� */
		if(friendState2.size() > 0){
			List friprofileList = new ArrayList();
			for(int i = 0 ; i < friendState2.size() ; i++){
				// ����2�� ģ�� ����� ��ȣ�� �̱�
				int frinum = ((FriendDTO)friendState2.get(i)).getMem_num();
				System.out.println(frinum);
				
				// �ش� ��ȣ�� ���� ������ ���� ���̺��� ã�� �ֱ� ���� ���ڵ带 ����Ʈ�� �ִ´�
				Map frinumMap = new HashMap();
				frinumMap.put("mem_num", frinum);
				
				ProfilePicDTO friproDTO = new ProfilePicDTO();
				friproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", frinumMap);

				friprofileList.add(i, friproDTO);				
			}

			for (int i = 0; i < friprofileList.size() ; i++){
				//System.out.println(knewFriendList_image.get(i));
				System.out.println(((ProfilePicDTO)friprofileList.get(i)).getProfile_pic());
			}
			request.setAttribute("friprofileList", friprofileList);
			request.setAttribute("friendState2", friendState2);	
		}
	  		

	    request.setAttribute("categList", categList);
		request.setAttribute("categ2", categ2);
		request.setAttribute("categ", categ);
		request.setAttribute("sessionproDTO", sessionproDTO);
		request.setAttribute("memDTO", memDTO);
		/*����������*/
		request.setAttribute("proList", proList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("blockCount", blockCount);
		request.setAttribute("blockPage", blockPage);
		request.setAttribute("pagingHtml", pagingHtml);
		request.setAttribute("page", page);
		request.setAttribute("number", number);
		
		
		return "/product/MyUsedProductView.jsp";
	}
	
	
}
