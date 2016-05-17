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
	
		
		System.out.println("--------- mainSubmit ���� ---------");
		 // << ������ ���̵� �� num �������� >> 
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		System.out.println("����ID = "+sessionId);
		int num = (int)sqlMap.queryForObject("main.num", sessionId); // ������ ���̵�� num �������� 
		String name = (String)sqlMap.queryForObject("main.name", sessionId); // ������ ���̵�� �̸� �������� 
		System.out.println("�������� num = "+num);
		System.out.println("�������� name = "+name);
		
		
		String Submit = request.getParameter("deposit");
		System.out.println("���� submit ���� = "+Submit);
		if(Submit.equals("update")){   // submit�� update�϶� ����
		String content = dto.getContent().replaceAll("\r\n","<br>"); // textarea���� ���� ó�� ; 
		Map map = new HashMap();
		map.put("num", num);
		map.put("content",content);
		map.put("name", name);
		
		
		request.setAttribute("view", "view");	// div1�� ���̰�
		request.setAttribute("view2", "none"); // div2�� �Ⱥ��̰� 
		request.setAttribute("checked", "checked");

		
		// <<  num �����޾�  insert >>
		if(request.getFile("image1").isEmpty()){	
			sqlMap.insert("main.addContent", map);
			System.out.println("�Ϲ� �Խñ� ��ϼ���");
			sqlMap.insert("main.insertboardlist", map);
			System.out.println("��Ż �Խñ� ��ϼ���");	

			int boardnum = (int)sqlMap.queryForObject("main.boardnum", null); // ������ ���̵�� num �������� 
			System.out.println("�Խñ۹�ȣ"+boardnum);
			
			sqlMap.insert("create.boardreple",boardnum); // �Խñ� ��� ���̺� ���� 
			System.out.println("�Խñ۴�� DB ����");
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
	System.out.println("��������������������������������");
	
	request.setAttribute("orgName"+i, orgName);
	request.setAttribute("copy", copy);
	
	
	try{
		mf.transferTo(copy);	// ���ε� 
	}catch(Exception e){e.printStackTrace();}
	
	}

	}
		
		}else if(Submit.equals("product")){ // product �� submit �ɶ� ���� ;;
			
			
			request.setAttribute("view", "none");  // div1 �� �Ⱥ��̰� 
			request.setAttribute("view2", "view"); // div2 �� ���̰� 
			request.setAttribute("checked1", "checked");
			
			System.out.println("product ����");
			String content = prodto.getContent().replaceAll("\r\n","<br>"); // textarea���� ���� ó�� ;
			
			
			String SendPay = request.getParameter("sendPay"); // ��۷� �������� �ƴ��� �޾ƿ� 
			request.setAttribute("SendPay", SendPay);
			
			String categ0 = prodto.getCateg0();
			String categ1 = prodto.getCateg1();
			String categ = categ0 +"/"+ categ1;
			int price = prodto.getPrice();
			
			System.out.println(categ);
			
			Map promap = new HashMap();
			promap.put("num", num);
			promap.put("name", name);
			promap.put("content", content);
			promap.put("categ", categ);
			promap.put("price", price);
			
			
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
		
		// ������ ������ �ö���� ������ִ� ������̺� ( ��ǰ �Ϲ� ��� )
	
		int boardnums = (int)sqlMap.queryForObject("main.boardnum", null); // ������ ���̵�� num �������� 
		System.out.println("�Խñ۹�ȣ"+boardnums);
		
		sqlMap.insert("create.boardreple",boardnums); // �Խñ� ��� ���̺� ���� 
		System.out.println("�Խñ۴�� DB ����");

		return "MyUsed.nhn";
	}

}
