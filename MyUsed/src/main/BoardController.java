package main;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;



@Controller
public class BoardController {

	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
		
	
	
	@RequestMapping("/mainSubmit.nhn")
	public String mainSubmit(MultipartHttpServletRequest request , MainboardDTO dto){
	
		
		
		
		
		 // << ������ ���̵� �� num �������� >> 
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		System.out.println("����ID = "+sessionId);
		int num = (int)sqlMap.queryForObject("main.num", sessionId); // ������ ���̵�� num �������� 
		String name = (String)sqlMap.queryForObject("main.name", sessionId); // ������ ���̵�� �̸� �������� 
		System.out.println("�������� num = "+num);
		System.out.println("�������� name = "+name);
		String content = dto.getContent().replaceAll("\r\n","<br>"); // textarea���� ���� ó�� ; 
		
		
		
		
		Map map = new HashMap();
		map.put("num", num);
		map.put("content",content);
		map.put("name", name);
		
		
		
		// <<  num �����޾�  insert >>
		if(request.getFile("image1").isEmpty()){	
			sqlMap.insert("main.addContent", map);
			System.out.println("�Ϲ� �Խñ� ��ϼ���");
			sqlMap.insert("main.addTotalContent", map);
			System.out.println("��Ż �Խñ� ��ϼ���");	
		}
			//sqlMap.insert("main.addContent", map); // ���� insert
			//sqlMap.insert("main.addTotalContent", map); // ��Ż insert	
			
			int board_num = (int)sqlMap.queryForObject("main.board_num", num); // �Խñ� ��ȣ ��������
			map.put("board_num", board_num);
	
	for(int i=1;i<=8;i++){

	MultipartFile mf = request.getFile("image"+i); // ������ �޴� MultipartFile Ŭ����  (����)
	String orgName = mf.getOriginalFilename(); 
	if(i == 1){
		orgName = "M_"+mf.getOriginalFilename(); 
	}
		
	map.put("mem_pic",orgName);
	
	if(!mf.isEmpty()){		// mf�� ������ ������ Ȯ�� ���� ������ ���ε� ���� 
		sqlMap.insert("main.addPic", map); // ���� ���� db ����
		sqlMap.insert("main.addTotalPic", map); // ��ü ���� db ����
	File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // ���ε�
	System.out.println("���ε强��");
	
	System.out.println(orgName);
	System.out.println(copy);
	
	
	request.setAttribute("orgName"+i, orgName);
	request.setAttribute("copy", copy);
	
	
	try{
		mf.transferTo(copy);	// ���ε� 
	}catch(Exception e){
		e.printStackTrace();
	}
	
	}

	}
	

		return "MyUsed.nhn";
	}

}
