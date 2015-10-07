package com.ssh.hibernate;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

/**
 * A data access object (DAO) providing persistence and search support for
 * Meetinginfo entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.ssh.hibernate.Meetinginfo
 * @author MyEclipse Persistence Tools
 */

public class MeetinginfoDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(MeetinginfoDAO.class);
	// property constants
	public static final String DATE = "date";
	public static final String START_TIME = "startTime";
	public static final String END_TIME = "endTime";
	public static final String TOPIC = "topic";

	protected void initDao() {
		// do nothing
	}

	public void save(Meetinginfo transientInstance) {
		log.debug("saving Meetinginfo instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Meetinginfo persistentInstance) {
		log.debug("deleting Meetinginfo instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	//被用于日历 编辑会议时的ajax
	public Meetinginfo findById(java.lang.String id) {
		log.debug("getting Meetinginfo instance with id: " + id);
		try {
			Meetinginfo instance = (Meetinginfo) getHibernateTemplate().get(
					"com.ssh.hibernate.Meetinginfo", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Meetinginfo instance) {
		log.debug("finding Meetinginfo instance by example");
		try {
			List results = getHibernateTemplate().findByExample(instance);
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding Meetinginfo instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Meetinginfo as model where model."
			
				+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByDate(Object date) {
		return findByProperty(DATE, date);
	}

	public List findByStartTime(Object startTime) {
		return findByProperty(START_TIME, startTime);
	}

	public List findByEndTime(Object endTime) {
		return findByProperty(END_TIME, endTime);
	}

	public List findByTopic(Object topic) {
		return findByProperty(TOPIC, topic);
	}

	public List findAll() {
		log.debug("finding all Meetinginfo instances");
		try {
			String queryString = "from Meetinginfo";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public List findByMonth(String month) {
		log.debug("finding all Meetinginfo instances in a certain month");
		 final String mon=month;
       return getHibernateTemplate().executeFind(new HibernateCallback() {
			
			
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				// TODO Auto-generated method stub
				Query query=session.createQuery("select m from Meetinginfo m where m.date like'%"+mon+"%'");
		
				List list=query.list();
		        
				return list;
			}
       }
       );
	}
	public Meetinginfo merge(Meetinginfo detachedInstance) {
		log.debug("merging Meetinginfo instance");
		try {
			Meetinginfo result = (Meetinginfo) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Meetinginfo instance) {
		log.debug("attaching dirty Meetinginfo instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Meetinginfo instance) {
		log.debug("attaching clean Meetinginfo instance");
		try {
			getHibernateTemplate().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
	
	
	
	//add by myself for id count
	public int count() {
		log.debug("count the total Meetinginfo instances number");
		int num=0;
		try {
			String queryString = "select count(c) from Meetinginfo c";
			List list= getHibernateTemplate().find(queryString);
			if(list.size()>0){
		        num=Integer.parseInt(list.get(0).toString());
				
			}
		} catch (RuntimeException re) {
			log.error("find count failed", re);
			throw re;
		}
		return num;
	}
	//图表处用，统计被占用比例
	public int countChart(int number) {
		String meetingroomid="MR00"+number;
		log.debug("count the Meetinginfo instances number");
		int num=0;
		try {System.out.println("into countChart");
			
			String hql= "select count(c) from Meetinginfo c where c.meetingroominfo.meetingroomId=?"; 
			List list=getHibernateTemplate().find(hql, new String[]{meetingroomid});
			
			System.out.println(list);
			if(list.size()>0){
		        num=Integer.parseInt(list.get(0).toString());
				System.out.println(num);
			}
		} catch (RuntimeException re) {
			log.error("find count failed", re);
			throw re;
		}
		return num;
	}
	
	//图表处用，统计柱状图
	public int countBarChart(String meetingroomname,String username) {
		char number=meetingroomname.charAt(11);
		String mrid="MR00"+number;
		int num=0;
		log.debug("count the Meetinginfo instances number");
	    //依赖注入
		Userinfo user=new Userinfo();
		user=(Userinfo) udao.findByUserName(username).get(0);
		String userid=user.getUserId();
		try {System.out.println("into countBarChart");
		
			String hql= "select count(c) from Meetinginfo c where c.meetingroominfo.meetingroomId=? and c.userinfo.userId=?"; 
			List list=getHibernateTemplate().find(hql, new String[]{mrid,userid});
			
			System.out.println(list);
			if(list.size()>0){
		        num=Integer.parseInt(list.get(0).toString());
				System.out.println(num);
			}
		} catch (RuntimeException re) {
			log.error("find count failed", re);
			throw re;
		}
		return num;
	}
	UserinfoDAO udao;
	
	

	public UserinfoDAO getUdao() {
		return udao;
	}

	public void setUdao(UserinfoDAO udao) {
		this.udao = udao;
	}

	public List listByPage(final String hql, final int firstResult, final int maxResult) {
		log.debug("listByPage Meetinginfo instance");
		return getHibernateTemplate().executeFind(new HibernateCallback() {
			
			public Object doInHibernate(Session session) throws HibernateException,
					SQLException {
				// TODO Auto-generated method stub
				Query query=session.createQuery(hql);
				query.setFirstResult(firstResult);
				query.setMaxResults(maxResult);
				List list=query.list();
				return list;
			}
		}
			
			
		);
	}
	
	//按照月份和会议室查出所有的预约情况
	
	public List findByMonthAndMrid(String month,String mrid) {
		log.debug("finding all Meetinginfo instances in a certain month of a certain meetingroom");
		
			try {
				String hql= "from Meetinginfo m where m.date like ? and m.meetingroominfo.meetingroomId=?"; 
				return getHibernateTemplate().find(hql, new String[]{"%"+month+"%", mrid});
			} catch (RuntimeException re) {
				log.error("find failed", re);
				throw re;
			}
		 
    
	}
	
	//根据用户查找我的预约
	public List findByUserId(String userid) {
		log.debug("finding all Meetinginfo instances of a certain user");
		System.out.println("in to findByUserID DAO");
			try {
				String hql="from Meetinginfo m where m.userinfo.userId=?";
				System.out.println(userid);
				return getHibernateTemplate().find(hql,new String[]{userid});
			
				
			} catch (RuntimeException re) {
				log.error("find failed", re);
				throw re;
			}
		 
    
	}



	public static MeetinginfoDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (MeetinginfoDAO) ctx.getBean("MeetinginfoDAO");
	}
}