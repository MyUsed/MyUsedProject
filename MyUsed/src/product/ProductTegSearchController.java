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

import friend.FriendDTO;
import main.ProBoardCategDTO;
import member.MemberDTO;
import member.ProfilePicDTO;

@Controller
public class ProductTegSearchController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	private ProfilePicDTO sessionproDTO = new ProfilePicDTO();


	@RequestMapping("/ProductTegSearch.nhn")
	public String ProductTegSearch(HttpServletRequest request, String word, int currentPage){
		
		/** 1�� ī�װ����� ��ǰ �ѷ��ֱ�(MyUsed���������� ������ ī�װ�) */
		int number=0;
		int totalCount; 		// �� �Խù��� ��
		int blockCount = 9;	// �� ��������  �Խù��� ��
		int blockPage = 10; 	// �� ȭ�鿡 ������ ������ ��
		String pagingHtml; 	//����¡�� ������ HTML
		Paging_TegController page; 	// ����¡ Ŭ���� 
		
		/** �±� �˻� */
		System.out.println(word);	// �±� �˻��� ����
		word = word.substring(1, word.length());	//�տ� Ư������, ���� ������ String ����
		String content = "#"+word;
		System.out.println(content);
		
		List proList = new ArrayList();
		proList = sqlMapClientTemplate.queryForList("main.protegSearch", content);
		
		
		
		totalCount = proList.size(); // ��ü �� ������ ���Ѵ�.
		page = new Paging_TegController(currentPage, totalCount, blockCount, blockPage, word); // pagingAction ��ü ����.
		pagingHtml = page.getPagingHtml().toString(); // ������ HTML ����.

		// ���� ���������� ������ ������ ���� ��ȣ ����.
		int lastCount = totalCount;

		// ���� �������� ������ ���� ��ȣ�� ��ü�� ������ �� ��ȣ���� ������ lastCount�� +1 ��ȣ�� ����.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		// ��ü ����Ʈ���� ���� ��������ŭ�� ����Ʈ�� �����´�.
		proList = proList.subList(page.getStartCount(), lastCount);
		number = page.getNumber();
		
		/** ��ü ī�װ� ��� �̱� */
		List viewCategList = new ArrayList();
		viewCategList = sqlMapClientTemplate.queryForList("procateg.viewCateg", null);

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
	  		
	    

	   // request.setAttribute("categList", categList);	//���� �ѷ����� 2�� ī�װ� ����Ʈ
		request.setAttribute("sessionproDTO", sessionproDTO);	//���� ���̵� ���� ������ ���� DTO
		request.setAttribute("memDTO", memDTO);
		request.setAttribute("content", content);
		request.setAttribute("viewCategList", viewCategList);
		/*����������*/
		request.setAttribute("proList", proList);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("blockCount", blockCount);
		request.setAttribute("blockPage", blockPage);
		request.setAttribute("pagingHtml", pagingHtml);
		request.setAttribute("page", page);
		request.setAttribute("number", number);
		
		return "/product/MyUsedProductView_tegSearch.jsp";
	}
	
}
