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
 * Userinfo entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.ssh.Userinfo
 * @author MyEclipse Persistence Tools
 */

public class UserinfoDAO extends HibernateDaoSupport {
	private static final Logger log = LoggerFactory
			.getLogger(UserinfoDAO.class);
	// property constants
	public static final String USER_NAME = "userName";
	public static final String PASSWORD = "password";
	public static final String MOBILE = "mobile";
	public static final String EMAIL = "email";

	protected void initDao() {
		// do nothing
	}

	public void save(Userinfo transientInstance) {
		log.debug("saving Userinfo instance");
		try {
			getHibernateTemplate().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Userinfo persistentInstance) {
		log.debug("deleting Userinfo instance");
		try {
			getHibernateTemplate().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Userinfo findById(java.lang.String id) {
		log.debug("getting Userinfo instance with id: " + id);
		try {
			Userinfo instance = (Userinfo) getHibernateTemplate().get(
					"com.ssh.hibernate.Userinfo", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}
	
	public List findByExample(Userinfo instance) {
		log.debug("finding Userinfo instance by example");
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
		log.debug("finding Userinfo instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Userinfo as model where model."
					+ propertyName + "= ?";
			return getHibernateTemplate().find(queryString, value);
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByUserName(Object userName) {
		return findByProperty(USER_NAME, userName);
	}

	public List findByPassword(Object password) {
		return findByProperty(PASSWORD, password);
	}

	public List findByMobile(Object mobile) {
		return findByProperty(MOBILE, mobile);
	}

	public List findByEmail(Object email) {
		return findByProperty(EMAIL, email);
	}

	public List findAll() {
		log.debug("finding all Userinfo instances");
		try {
			String queryString = "from Userinfo";
			return getHibernateTemplate().find(queryString);
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public Userinfo merge(Userinfo detachedInstance) {
		log.debug("merging Userinfo instance");
		try {
			Userinfo result = (Userinfo) getHibernateTemplate().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(Userinfo instance) {
		log.debug("attaching dirty Userinfo instance");
		try {
			getHibernateTemplate().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Userinfo instance) {
		log.debug("attaching clean Userinfo instance");
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
		log.debug("count the total Userinfo instances number");
		int num=0;
		try {
			String queryString = "select count(c) from Userinfo c";
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
		log.debug("attaching clean Userinfo instance");
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
	

public List findByUserNameAndPwd(String username,String password) {
		log.debug("finding userinfo instances in a certain name and a certain password");

		 System.out.println("into findByNameAndPWD");
			
			try {
				String hql= "from Userinfo u where u.userName=? and u.password=?"; 
				return getHibernateTemplate().find(hql, new String[]{username, password});
			} catch (RuntimeException re) {
				log.error("find failed", re);
				throw re;
			}
	}
	public static UserinfoDAO getFromApplicationContext(ApplicationContext ctx) {
		return (UserinfoDAO) ctx.getBean("UserinfoDAO");
	}
}