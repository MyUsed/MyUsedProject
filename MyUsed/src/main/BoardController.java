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
	public String mainSubmit(MultipartHttpServletRequest request , MainboardDTO dto ,MainProboardDTO prodto , String sendPay ,String deposit){
	
		

		 // << ������ ���̵� �� num �������� >> 
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		System.out.println("����ID = "+sessionId);
		int num = (int)sqlMap.queryForObject("main.num", sessionId); // ������ ���̵�� num �������� 
		String name = (String)sqlMap.queryForObject("main.name", sessionId); // ������ ���̵�� �̸� �������� 
		System.out.println("�������� num = "+num);
		System.out.println("�������� name = "+name);
		
		
		String Submit = request.getParameter("deposit");
		
		if(Submit.equals("state")){   // submit�� state�϶� ����
		String content = dto.getContent().replaceAll("\r\n","<br>"); // textarea���� ���� ó�� ; 
		Map map = new HashMap();
		map.put("num", num);
		map.put("content",content);
		map.put("name", name);

		// <<  num �����޾�  insert >>
		if(request.getFile("image1").isEmpty()){	
			sqlMap.insert("main.addContent", map);
			System.out.println("�Ϲ� �Խñ� ��ϼ���");
			sqlMap.insert("main.insertboardlist", map);
			System.out.println("��Ż �Խñ� ��ϼ���");	
		}else
			
			
			
	for(int i=1;i<=8;i++){

	MultipartFile mf = request.getFile("image"+i); // ������ �޴� MultipartFile Ŭ����  (����)
	String orgName = mf.getOriginalFilename(); 
	map.put("mem_pic",orgName);
	if(i==1){
	
	sqlMap.insert("main.addContent", map);
	int board_num = (int)sqlMap.queryForObject("main.board_num", num);
	map.put("board_num", board_num);
	sqlMap.insert("main.insertboardlist", map);
	}
	if(!mf.isEmpty()){		// mf�� ������ ������ Ȯ�� ���� ������ ���ε� ���� 
		sqlMap.insert("main.addPic", map); // ���� ���� db ����
		
	File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // ���ε�
	System.out.println("���ε强��");
	
	System.out.println(orgName);
	System.out.println(copy);
	
	
	request.setAttribute("orgName"+i, orgName);
	request.setAttribute("copy", copy);
	
	
	try{
		mf.transferTo(copy);	// ���ε� 
	}catch(Exception e){e.printStackTrace();}
	
	}

	}
		
		}else{ // product �� submit �ɶ� ���� ;; 
			System.out.println("product ����");
			String content = prodto.getContent().replaceAll("\r\n","<br>"); // textarea���� ���� ó�� ;
			
			System.out.println(prodto.getContent());
			System.out.println(prodto.getPrice());
			System.out.println(name);
			System.out.println(num);
			System.out.println(request.getParameter("sendPay"));
			
			String categ0 = prodto.getCateg0();
			String categ1 = prodto.getCateg1();
			String categ = categ0 +"/"+ categ1;
			System.out.println(categ);
			
			Map promap = new HashMap();
			promap.put("num", num);
			promap.put("name", name);
			promap.put("content", content);
			promap.put("categ", categ);
			promap.put("price", prodto.getPrice());
			
			
			if(request.getFile("pimage1").isEmpty()){ // ���� ������ ���� ������ 
			sqlMap.insert("main.addProContent", promap); // ��ǰ �Ϲ� DB ���
			sqlMap.insert("main.insertproboardlist", promap); // ��ü ��ǰ DB ���
			}else{
			
			
			for(int i=1;i<=8;i++){
			MultipartFile mf = request.getFile("pimage"+i); // ������ �޴� MultipartFile Ŭ����  (����)
			String orgName = mf.getOriginalFilename();
			promap.put("pro_pic",orgName);
			if(i==1){
				sqlMap.insert("main.addProContent", promap); // ��ǰ �Ϲ� DB ���
				int proboard_num = (int)sqlMap.queryForObject("main.proboard_num", num);
				promap.put("proboard_num", proboard_num);
				sqlMap.insert("main.insertproboardlist", promap); // ��ü ��ǰ DB ���
			}
			if(!mf.isEmpty()){
				sqlMap.insert("main.addProPic", promap);
				
				File copy = new File("E:\\Jsp Example\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\MyUsed\\images\\"+ orgName); // ���ε�
				System.out.println("���ε强��");
				
				System.out.println(orgName);
				System.out.println(copy);
				

				request.setAttribute("orgName"+i, orgName);
				request.setAttribute("copy", copy);
				

				try{
					mf.transferTo(copy);	// ���ε� 
				}catch(Exception e){e.printStackTrace();}
			}
			
			
			}
			
			}
			
		}
	

		return "MyUsed.nhn";
	}

}
