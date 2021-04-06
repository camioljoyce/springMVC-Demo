package camiol.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import camiol.demo.dao.StudentDao;
import camiol.demo.entity.Student;
import camiol.demo.service.StudentService;

@Service
public class StudentServiceImpl implements StudentService {
	
	@Autowired
	private StudentDao dao;
	
	@Override
	@Transactional
	public List<Student> findStudent() {
		return dao.findAll();
	}

	@Override
	@Transactional
	public Student findStudent(long id) {
		return dao.findById(id);
	}

	@Override
	@Transactional
	public void updateStudent(Student s) {
		dao.update(s);
	}

}
