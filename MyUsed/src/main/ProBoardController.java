package main;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProBoardController {
	
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 
		
	@RequestMapping("/proSubmit.nhn")
	public ModelAndView proboardSubmit(MultipartHttpServletRequest request , MainProboardDTO prodto ){
		
		
		
		ModelAndView mv = new ModelAndView();
		
		System.out.println("=========  probard����  ========= ");
		
		String content = prodto.getContent().replaceAll("\r\n","<br>"); // textarea���� ���� ó�� ;
		
		
		String SendPay = request.getParameter("sendPay"); // ��۷� �������� �ƴ��� �޾ƿ� 
		request.setAttribute("SendPay", SendPay);
		
		String categ0 = prodto.getCateg0();
		String categ1 = prodto.getCateg1();
		String categ = categ0 +"/"+ categ1;
		int price = prodto.getPrice();
		
		System.out.println(categ);
		
		HttpSession session = request.getSession();
		String sessionId = (String)session.getAttribute("memId");
		int num = (int)sqlMap.queryForObject("main.num", sessionId); // ������ ���̵�� num �������� 
		String name = (String)sqlMap.queryForObject("main.name", sessionId); // ������ ���̵�� �̸� �������� 
		
		

		Map promap = new HashMap();
		promap.put("num", num);
		promap.put("name", name);
		promap.put("content", content);
		promap.put("categ", categ);
		promap.put("price", price);
		
		
		if(request.getFile("pimage1").isEmpty()){ // ���� ������ ���� ������ 
		sqlMap.insert("main.addProContent", promap); // ��ǰ �Ϲ� DB ���
		System.out.println("insert��ǰ�Ϲ� DB ����");
		sqlMap.insert("main.insertproboardlist", promap); // ��ü ��ǰ DB ���
		System.out.println("insert��ǰ��ü DB ����");
		
	

		
		}else{
		
		
		for(int i=1;i<=8;i++){
		MultipartFile mf = request.getFile("pimage"+i); // ������ �޴� MultipartFile Ŭ����  (����)
		String orgName = mf.getOriginalFilename();
		promap.put("pro_pic",orgName);
		if(i==1){


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
		

		int proboardnum = (int)sqlMap.queryForObject("main.proboardMax", null); // ������ ���̵�� num �������� 
		System.out.println("�Խñ۹�ȣ"+proboardnum);
		
		sqlMap.insert("create.proboardreple",proboardnum); // �Խñ� ��� ���̺� ���� 
		System.out.println("pro�Խñ۴�� DB ����");
		sqlMap.insert("create.proboardreple_seq",proboardnum);
		System.out.println("pro�Խñ۴�� ������ ����");

		mv.setViewName("/MyUsed.nhn");
		return mv;
		
	}

}
