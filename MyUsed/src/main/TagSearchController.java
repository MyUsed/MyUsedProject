package main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TagSearchController {

	@Autowired
	private SqlMapClientTemplate sqlMapClientTemplate;
	
	@RequestMapping("/tegSearch.nhn")
	public String tegSearch(HttpServletRequest request, String word){
		System.out.println(word);	// 태그 검색할 문자
		word = word.substring(1, word.length());	//앞에 특수문자, 빼고 나머지 String 추출
		String content = "#"+word;
		
		List tegList = new ArrayList();
		tegList = sqlMapClientTemplate.queryForList("main.tegSearch", content);
		
		for(int i = 0; i < tegList.size() ; i++){
			System.out.println(((MainboardDTO)tegList.get(i)).getContent());
		}
		
		request.setAttribute("tegList", tegList);
		request.setAttribute("content", content);	//검색한 단어
		
		return "/main/MyUsedTegSearch.jsp";
	}
	
	@RequestMapping("/protegSearch.nhn")
	public String protegSearch(HttpServletRequest request, String word){
		System.out.println(word);
		
		return "";
	}
}
