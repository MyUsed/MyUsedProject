package main;

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
import org.springframework.web.servlet.ModelAndView;

import main.MainboardDTO;

@Controller
public class VoteController {
	@Autowired	 // ��Ʈ�ѷ��� ���� Date ��ü�� �ڵ����� �޾���;
	private SqlMapClientTemplate sqlMap; // ibatis�� ��� �ϱ����� 

	
	@RequestMapping("test1.nhn")
	//���ƿ並 Ŭ����  �Խ����� num�� �޴´�.
	public ModelAndView test1(HttpServletRequest request, int num){
	ModelAndView mv = new ModelAndView();
	HttpSession session = request.getSession(); 
    String sessionId = (String) session.getAttribute("memId"); //�������� sessionId�� �޴´�.
    System.out.println("���Ǿ��̵�="+sessionId);
    
    int mem_num =(int)sqlMap.queryForObject("main.num",sessionId); //���� ���̵� ���� ���� mem_num�� ���Ѵ�.
    System.out.println("�Խñ�  num="+num);
    System.out.println("ȸ�� mem_num="+mem_num);
    
    Map map = new HashMap();
	map.put("num", num);	//map �������� num�� mem_num�� ��Ƽ�
	map.put("mem_num", mem_num);
	System.out.println("main.likescount");
    int count =(int)sqlMap.queryForObject("main.likescount",map);
    System.out.println("�������̺� count="+count);

    if(count==0){ //�������̺� ī��尡 0�̸� 
    	System.out.println("ó��");
    	System.out.println("main.likesInsert");
    	sqlMap.insert("main.likesInsert", map);
    	System.out.println("main.likesBdUpdate");
    	sqlMap.update("main.likesBdUpdate", num); // board likes+1
      }else if(count==1){
    	  //System.out.println("likes value="+likes);
    	  System.out.println("main.likes");
    	  String likes = (String)sqlMap.queryForObject("main.likes", map);
    	  System.out.println("likes value="+likes);
    	  
    	  if(likes!=null){
    	  if(likes.equals("1")){
    		  System.out.println("���̺� ������ �ְ� �̹� Ŭ������ ����");
    		  System.out.println("main.likescancle");
    		  sqlMap.update("main.likescancle", map); 
    		  System.out.println("main.likesBdcancle");    		  
    		  sqlMap.update("main.likesBdcancle", num);
    	  }else if(likes.equals("0")){
    		  System.out.println("���̺� ������ �ְ� Ŭ���� ���� ����");
    		  System.out.println("main.likesUpdate");
    		  sqlMap.update("main.likesUpdate",map);
    		  System.out.println("main.likesBdUpdate");
    		  sqlMap.update("main.likesBdUpdate", num); 
    	  }
    	}else{ //null�� ���
    		  System.out.println("null �� ���");
    		  System.out.println("main.likesInsert");
    	      sqlMap.insert("main.likesInsert", map); 
    		  System.out.println("main.likesBdUpdate");
    	      sqlMap.update("main.likesBdUpdate", num); // board likes+1
        }
      }
    System.out.println("main.likeresult");
    MainboardDTO memDTO = new MainboardDTO();
    List memList = new ArrayList();
    memList  =sqlMap.queryForList("main.likeresult", null);// num�� ���� ���ƿ並 Ȯ��
    
    mv.addObject("memList", memList);
    
    String likes = (String)sqlMap.queryForObject("main.likes", map);
	 System.out.println("likes="+likes);
	request.setAttribute("likes",likes);
	
	mv.setViewName("/MyUsed.nhn");
	return mv;
	}
	
	
	@RequestMapping("likeup.nhn")
	public ModelAndView like(int num){
		ModelAndView mv = new ModelAndView();
		
		
		sqlMap.update("main.likeUpdatePush",num); // ��ü likes ����

		mv.setViewName("/MyUsed.nhn");
		return mv;
		
	}
	
	@RequestMapping("likedown.nhn")
	public ModelAndView likedown(int num){
		ModelAndView mv = new ModelAndView();
		
		
		sqlMap.update("main.likeUpdateDown",num); // ��ü likes ����
	
		mv.setViewName("/MyUsed.nhn");
		return mv;
		
	}
	
	
	
	
	
	
	}
