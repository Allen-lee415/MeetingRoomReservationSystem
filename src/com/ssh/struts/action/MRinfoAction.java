/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.ssh.struts.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.ssh.hibernate.Meetingroominfo;
import com.ssh.hibernate.MeetingroominfoDAO;
import com.ssh.struts.form.MRinfoForm;

/** 
 * MyEclipse Struts
 * Creation date: 04-19-2014
 * 
 * XDoclet definition:
 * @struts.action path="/userinfo" name="userinfoForm" input="/form/userinfo.jsp" scope="request" validate="true"
 */
public class MRinfoAction extends DispatchAction {
	/*
	 * Generated Methods
	 */

	/** 
	 * Method execute
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return ActionForward
	 * @throws UnsupportedEncodingException 
	 */
	public ActionForward add(ActionMapping mapping, ActionForm form,
		   HttpServletRequest request, HttpServletResponse response) 
	       throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		MRinfoForm mrForm = (MRinfoForm) form;
	    System.out.println("into add action");
	    int num=mrDao.count()+1;
	    String id;
	      if(num<10){
	        id="MR00"+num;
	      }else if(10<=num&&num<100){
		    id="MR0"+num; 
	      }else{
		    id="MR"+num;
	      }
	    mr.setMeetingroomId(id);
	    mr.setMeetingroomName(mrForm.getMeetingroomName());
	    mr.setSeatNum(Integer.valueOf(mrForm.getSeatNum()));
	    mr.setLocation(mrForm.getLocation());
	    mr.setProjector(Boolean.valueOf(mrForm.getProjector()));
	    mrDao.save(mr);
	    response.setCharacterEncoding("utf-8");
	    return this.queryByPage(mapping, form, request, response);
	   }
	
	public ActionForward list(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
	   System.out.println("into list action");
	   List list=mrDao.findAll();
	   request.setAttribute("list", list);
	   return mapping.findForward("list");
	}
	
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
	   System.out.println("into delete action");
	   String id=request.getParameter("id");
	   mr=mrDao.findById(id);
	   mrDao.delete(mr);
	   return this.queryByPage(mapping, form, request, response);
	}
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
	   System.out.println("into edit action");
	   String id=request.getParameter("id");
	   mr=mrDao.findById(id);
	   JSONObject obj=JSONObject.fromObject(mr);
	   response.getWriter().write(obj.toString());
	   response.getWriter().flush();
	   response.getWriter().close();
	   return null;
	}
	
	public ActionForward update(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
	   System.out.println("into update action");
	   MRinfoForm mrForm = (MRinfoForm) form;
	   mr.setMeetingroomId(request.getParameter("meetingroomId"));
	   System.out.println(request.getParameter("meetingroomId"));
	   mr.setMeetingroomName(mrForm.getMeetingroomName());
	   mr.setSeatNum(Integer.valueOf(mrForm.getSeatNum()));
	   mr.setLocation(mrForm.getLocation());
	   mr.setProjector(Boolean.valueOf(mrForm.getProjector()));
	   mrDao.attachDirty(mr);
	   return this.queryByPage(mapping, form, request, response);
	}

	public ActionForward getCountNum(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
	   System.out.println("into getCountNum action");
	   
	   System.out.println(mrDao.count());
	   return null;
	}
	
	public ActionForward queryByPage(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
	   System.out.println("into queryByPage action");
	   String hql="from Meetingroominfo";
	   int firstResult=0;
	   int maxResult=10;
	   if(request.getParameter("firstResult")==null){
		   firstResult=0;
		}else{
		   firstResult=Integer.parseInt(request.getParameter("firstResult"));
		}
	   
	   int totalNum=mrDao.count();
	 
	   int totalPage=0;
	   if(totalNum%maxResult==0){
	     totalPage=totalNum/maxResult;
	   }else{
	     totalPage=totalNum/maxResult+1;
	   }
	   int currentPage=firstResult/maxResult+1;
		   //下一页时候firstresult和muxrult各加3
	   
	   List list=mrDao.listByPage(hql, firstResult, maxResult);
	   request.setAttribute("list", list);
	  
	   request.setAttribute("firstResult",Integer.valueOf(firstResult));
	   request.setAttribute("maxResult",Integer.valueOf(maxResult));
	   request.setAttribute("totalNum", Integer.valueOf(totalNum));
	   request.setAttribute("totalPage", Integer.valueOf(totalPage));
	   request.setAttribute("currentPage", Integer.valueOf(currentPage));
	   return mapping.findForward("list");
	}
	//用户预约界面，查看所有会议室的信息，准备预约，我没有另加一个action，和这个共用了
	public ActionForward queryByPageUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
	   System.out.println("into queryByPageUser action");
	   String hql="from Meetingroominfo";
	   int firstResult=0;
	   int maxResult=10;
	   if(request.getParameter("firstResult")==null){
		   firstResult=0;
		}else{
		   firstResult=Integer.parseInt(request.getParameter("firstResult"));
		}
	   
	   int totalNum=mrDao.count();
	 
	   int totalPage=0;
	   if(totalNum%maxResult==0){
	     totalPage=totalNum/maxResult;
	   }else{
	     totalPage=totalNum/maxResult+1;
	   }
	   int currentPage=firstResult/maxResult+1;
		   //下一页时候firstresult和muxrult各加3
	   
	   List list=mrDao.listByPage(hql, firstResult, maxResult);
	   request.setAttribute("list", list);
	  
	   request.setAttribute("firstResult",Integer.valueOf(firstResult));
	   request.setAttribute("maxResult",Integer.valueOf(maxResult));
	   request.setAttribute("totalNum", Integer.valueOf(totalNum));
	   request.setAttribute("totalPage", Integer.valueOf(totalPage));
	   request.setAttribute("currentPage", Integer.valueOf(currentPage));
	   return mapping.findForward("listMeetroomUser");
	}
	//ajax 更新时候用到，前边那个edit就没用了，从这里查出一个会议室信息，ajax赋值给表格
	public ActionForward queryById(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
	   System.out.println("into queryById action");
	   String id=request.getParameter("id");
	   mr=mrDao.findById(id);
	  JSONObject obj=JSONObject.fromObject(mr);
	  	  
	  response.getWriter().write(obj.toString());
	  response.getWriter().flush();
	  response.getWriter().close();
	  return null;
	}
	
	Meetingroominfo mr;

	MeetingroominfoDAO mrDao;

	public Meetingroominfo getMr() {
		return mr;
	}

	public void setMr(Meetingroominfo mr) {
		this.mr = mr;
	}

	public MeetingroominfoDAO getMrDao() {
		return mrDao;
	}

	public void setMrDao(MeetingroominfoDAO mrDao) {
		this.mrDao = mrDao;
	}

	
}