package camiol.demo.service;

import java.util.List;

import camiol.demo.entity.Student;

public interface StudentService {
	List<Student> findStudent();
	Student findStudent(long id);
	void updateStudent(Student s);
}
