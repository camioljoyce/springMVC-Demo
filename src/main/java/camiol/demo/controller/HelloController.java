package camiol.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import camiol.demo.entity.Student;
import camiol.demo.service.StudentService;

@Controller
public class HelloController {
	@Autowired
	private StudentService service;
	
	@RequestMapping("hello")
	public ModelAndView hello() {
		return new ModelAndView("hello");
	}
	@RequestMapping("list")
	public ModelAndView list() {
		List<Student> resultList = service.findStudent();
		ModelAndView model = new ModelAndView();
		model.setViewName("list");
		model.addObject("resultList",resultList);
		
		return model;
	}
	
	@RequestMapping(value = "view" ,method = RequestMethod.POST)
	public ModelAndView view(@RequestParam long id,@RequestParam String type) {
		System.out.println(id);
		System.out.println(type);
		Student s = service.findStudent(id);
		ModelAndView model = new ModelAndView();
		model.setViewName("view");
		model.addObject("s", s);
		model.addObject("type",type);
		return model;
	}
	
	@RequestMapping(value = "update" ,method = RequestMethod.POST)
	public ModelAndView update(@ModelAttribute("s") Student s,RedirectAttributes attr) {
		service.updateStudent(s);
		
		attr.addFlashAttribute("message","修改成功");
		return new ModelAndView("redirect:hello");
	}
}
