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
		System.out.println(word);	// �±� �˻��� ����
		word = word.substring(1, word.length());	//�տ� Ư������, ���� ������ String ����
		String content = "#"+word;
		
		List tegList = new ArrayList();
		tegList = sqlMapClientTemplate.queryForList("main.tegSearch", content);
		
		for(int i = 0; i < tegList.size() ; i++){
			System.out.println(((MainboardDTO)tegList.get(i)).getContent());
		}
		
		request.setAttribute("tegList", tegList);
		request.setAttribute("content", content);	//�˻��� �ܾ�
		
		return "/main/MyUsedTegSearch.jsp";
	}
	
	@RequestMapping("/protegSearch.nhn")
	public String protegSearch(HttpServletRequest request, String word){
		System.out.println(word);
		
		return "";
	}
}
