package camiol.demo.dao.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.persistence.Query;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import camiol.demo.dao.StudentDao;
import camiol.demo.entity.Student;

@Repository
public class StudentDaoImpl implements StudentDao {
//	有多個sessionFactory 可以用Resource來指定
//	@Resource(name = "sessionFactory") 
//	private SessionFactory sessionFactory;
	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	@Transactional
	public Student findById(long id) {
		String sql = "select * from Student where id = :id";
		Query query = sessionFactory.getCurrentSession().createSQLQuery(sql).addEntity(Student.class);
		query.setParameter("id", id);
		return (Student) query.getSingleResult();
	}

	@Override
	@Transactional
	public List<Student> findAll() {
		String sql = "select * from Student";
		Query query = sessionFactory.getCurrentSession().createSQLQuery(sql).addEntity(Student.class);
		
		@SuppressWarnings("unchecked")
		List<Student> resultList = query.getResultList();
		return resultList;
	}

	@Override
	@Transactional
	public void update(Student s) {
		sessionFactory.getCurrentSession().update(s);
	}

}
