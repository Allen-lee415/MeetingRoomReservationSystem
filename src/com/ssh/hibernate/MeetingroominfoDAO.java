package com.ssh.hibernate;

import java.sql.SQLException;
import java.util.List;
import java.util.Set;

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
 * Meetingroominfo entities. Transaction control of the save(), update() and
 * delete() operations can directly support Spring container-managed
 * transactions or they can be augmented to handle user-managed Spring
 * transactions. Each of these methods provides additional information for how
 * to configure it for the desired type of transaction control.
 * 
 * @see com.ssh.hibernate.Meetingroominfo
 * @author MyEclipse Persistence Tools
 */

public class MeetingroominfoDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(MeetingroominfoDAO.class);
	// property constants
	public static final String MEETINGROOM_NAME = "meetingroomName";
	public static final String SEAT_NUM = "seatNum";
	public static final String LOCATION = "location";
	public static final String PROJECTOR = "projector";

	protected void initDao() {
		// do nothing
	}

	public void save(Meetingroominfo transientInstance) {
		log.debug("saving Meetingroominfo instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Meetingroominfo persistentInstance) {
		log.debug("deleting Meetingroominfo instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Meetingroominfo findById(java.lang.String id) {
		log.debug("getting Meetingroominfo instance with id: " + id);
		try {
			Meetingroominfo instance = (Meetingroominfo) getHibernateTemplate()
					.get("com.ssh.hibernate.Meetingroominfo", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(Meetingroominfo instance) {
		log.debug("finding Meetingroominfo instance by example");
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
		log.debug("finding Meetingroominfo instance with property: "
				+ propertyName + ", value: " + value);
		try {
			String queryString = "from Meetingroominfo as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByMeetingroomName(Object meetingroomName) {
		return findByProperty(MEETINGROOM_NAME, meetingroomName);
	}

	public List findBySeatNum(Object seatNum) {
		return findByProperty(SEAT_NUM, seatNum);
	}

	public List findByLocation(Object location) {
		return findByProperty(LOCATION, location);
	}

	public List findByProjector(Object projector) {
		return findByProperty(PROJECTOR, projector);
	}

	public List findAll() {
		log.debug("finding all Meetingroominfo instances");
		try {
			String queryString = "from Meetingroominfo";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Meetingroominfo merge(Meetingroominfo detachedInstance) {
		log.debug("merging Meetingroominfo instance");
		try {
			Meetingroominfo result = (Meetingroominfo) getHibernateTemplate()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Meetingroominfo instance) {
		log.debug("attaching dirty Meetingroominfo instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Meetingroominfo instance) {
		log.debug("attaching clean Meetingroominfo instance");
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
		log.debug("count the total MeetingRoomInfo instances number");
		int num=0;
		try {
			String queryString = "select count(c) from Meetingroominfo c";
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

	public List listByPage(final String hql, final int firstResult, final int maxResult) {
		log.debug("listByPage meetingroomInfo instance");
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

	public static MeetingroominfoDAO getFromApplicationContext(
			ApplicationContext ctx) {
		return (MeetingroominfoDAO) ctx.getBean("MeetingroominfoDAO");
	}
}