package camiol.demo.dao;

import java.util.List;

import camiol.demo.entity.Student;

public interface StudentDao {
	Student findById(long id);
	List<Student> findAll();
	void update(Student s);
}
