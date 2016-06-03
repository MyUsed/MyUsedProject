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
		
		/** 1차 카테고리별로 상품 뿌려주기(MyUsed페이지에서 선택한 카테고리) */
		int number=0;
		int totalCount; 		// 총 게시물의 수
		int blockCount = 9;	// 한 페이지의  게시물의 수
		int blockPage = 10; 	// 한 화면에 보여줄 페이지 수
		String pagingHtml; 	//페이징을 구현한 HTML
		Paging_TegController page; 	// 페이징 클래스 
		
		/** 태그 검색 */
		System.out.println(word);	// 태그 검색할 문자
		word = word.substring(1, word.length());	//앞에 특수문자, 빼고 나머지 String 추출
		String content = "#"+word;
		System.out.println(content);
		
		List proList = new ArrayList();
		proList = sqlMapClientTemplate.queryForList("main.protegSearch", content);
		
		
		
		totalCount = proList.size(); // 전체 글 갯수를 구한다.
		page = new Paging_TegController(currentPage, totalCount, blockCount, blockPage, word); // pagingAction 객체 생성.
		pagingHtml = page.getPagingHtml().toString(); // 페이지 HTML 생성.

		// 현재 페이지에서 보여줄 마지막 글의 번호 설정.
		int lastCount = totalCount;

		// 현재 페이지의 마지막 글의 번호가 전체의 마지막 글 번호보다 작으면 lastCount를 +1 번호로 설정.
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		// 전체 리스트에서 현재 페이지만큼의 리스트만 가져온다.
		proList = proList.subList(page.getStartCount(), lastCount);
		number = page.getNumber();
		
		/** 전체 카테고리 목록 뽑기 */
		List viewCategList = new ArrayList();
		viewCategList = sqlMapClientTemplate.queryForList("procateg.viewCateg", null);

	    /** 로그인한 사용자의 이름 가져오기(세션아이디 이용) */
		HttpSession session = request.getSession();
		String sessionId = (String) session.getAttribute("memId");
		MemberDTO memDTO = new MemberDTO();
		memDTO = (MemberDTO) sqlMapClientTemplate.queryForObject("member.selectDTO", sessionId);
		// 세션 아이디의 프로필사진
		Map profileMap2 = new HashMap();
		profileMap2.put("mem_num", memDTO.getNum());
		sessionproDTO = (ProfilePicDTO) sqlMapClientTemplate.queryForObject("profile.newpic", profileMap2);
				
	    
	  	/** 친구 목록 리스트(state2) */
	  	Map map = new HashMap();
	  	map.put("num", memDTO.getNum());
	  	List friendState2 = new ArrayList();
	  	friendState2 = sqlMapClientTemplate.queryForList("friend.friendState2", map);
	  	
	  	/** 친구 목록 프로필 사진뽑기 */
		if(friendState2.size() > 0){
			List friprofileList = new ArrayList();
			for(int i = 0 ; i < friendState2.size() ; i++){
				// 상태2인 친구 목록의 번호만 뽑기
				int frinum = ((FriendDTO)friendState2.get(i)).getMem_num();
				System.out.println(frinum);
				
				// 해당 번호를 가진 프로필 사진 테이블을 찾아 최근 사진 레코드를 리스트에 넣는다
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
			request.setAttribute("friprofileList", friprofileList);//친구목록 프로필 사진
			request.setAttribute("friendState2", friendState2);	//친구목록 불러오는 리스트
		}
	  		
	    

	   // request.setAttribute("categList", categList);	//옆에 뿌려지는 2차 카테고리 리스트
		request.setAttribute("sessionproDTO", sessionproDTO);	//세션 아이디에 대한 프로필 사진 DTO
		request.setAttribute("memDTO", memDTO);
		request.setAttribute("content", content);
		request.setAttribute("viewCategList", viewCategList);
		/*페이지관련*/
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
