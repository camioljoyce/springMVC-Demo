# 建立一個SpringMVC + Spring + Hibernate 的Web專案
[![hackmd-github-sync-badge](https://hackmd.io/wF-EIZsjSO-oE0pmSyQVkA/badge)](https://hackmd.io/wF-EIZsjSO-oE0pmSyQVkA)
**本練習專案都是建立在Spring5上**

**Step1:**
首先要先建立一個Maven專案,可參考之前的筆記
- [在Eclipse上面快速建立一個Maven的Web專案](https://hackmd.io/VrNS_xVIRRy86WQTC94rBA)

在POM檔加入Spring MVC的dependency
![](https://i.imgur.com/v3RuX1a.jpg)
```\
<!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>5.3.4</version>
    </dependency>
```

可以在Libraries的Maven Dependencies看到新加的這些jar檔
![](https://i.imgur.com/uXQuQwC.jpg)

然後在WEB-INF/web.xml設定
```\
<?xml version="1.0" encoding="utf-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
                             http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd" version="3.1">

  <display-name>SpringMVC Demo Project</display-name>
  
  <!-- Spring MVC DispatcherServlet -->
  <servlet>
    <servlet-name>dispatcher</servlet-name>
    <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
    <init-param>
      <param-name>contextConfigLocation</param-name>
      <param-value>classpath:spring-mvc.xml</param-value>
    </init-param>
    <load-on-startup>1</load-on-startup>
  </servlet>
  <servlet-mapping>
    <servlet-name>dispatcher</servlet-name>
    <url-pattern>/</url-pattern>
  </servlet-mapping>
  
</web-app>
```

加入HelloController
![](https://i.imgur.com/yQFOBfU.jpg)
```java=\
package camiol.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HelloController {
	
	@RequestMapping("hello")
	public ModelAndView hello() {
		return new ModelAndView("hello");
	}
}
```

在WEB-INF /pages 加入hello.jsp
![](https://i.imgur.com/9j0hgoN.jpg)
```javascript=\
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HelloWorld</title>
</head>
<body>
  <h1>Hello World!! Spring MVC</h1>
</body>
</html>
```

然後在resources的 config 加入spring-mvc.xml
![](https://i.imgur.com/jeZ1unL.jpg)

```xml=\
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:mvc="http://www.springframework.org/schema/mvc" 
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:tx="http://www.springframework.org/schema/tx"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans 
                           http://www.springframework.org/schema/beans/spring-beans.xsd
                           http://www.springframework.org/schema/mvc 
                           http://www.springframework.org/schema/mvc/spring-mvc.xsd
                           http://www.springframework.org/schema/context 
                           http://www.springframework.org/schema/context/spring-context.xsd
                           http://www.springframework.org/schema/tx
                           http://www.springframework.org/schema/tx/spring-tx.xsd
                           http://www.springframework.org/schema/aop
                           http://www.springframework.org/schema/aop/spring-aop.xsd">
        
    
  <mvc:annotation-driven />
  <context:annotation-config/>
  <context:component-scan base-package="camiol.demo"/>
  
  <bean id="viewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
    <property name="prefix" value="/WEB-INF/pages/" />
    <property name="suffix" value=".jsp" />
  </bean>
  
</beans>
```

最後把專案啟動, 在網址輸入http://localhost:8080/springMVC-Demo/hello
![](https://i.imgur.com/Cai79sL.jpg)

**這樣就完成了初步專案建立!**

---

**Step2:**
再來要加入連資料庫的設定:

首先我們要在POM檔加入必要的dependency
```\
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>camiol</groupId>
	<artifactId>springMVC-Demo</artifactId>
	<packaging>war</packaging>
	<version>0.0.1-SNAPSHOT</version>

	<name>springMVC-Demo Maven Webapp</name>
	<url>http://maven.apache.org</url>
	<dependencies>
		<!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>5.3.4</version>
		</dependency>

		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>3.8.1</version>
			<scope>test</scope>
		</dependency>

		<!-- https://mvnrepository.com/artifact/org.springframework/spring-orm -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-orm</artifactId>
			<version>5.3.4</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/org.hibernate/hibernate-core -->
		<dependency>
			<groupId>org.hibernate</groupId>
			<artifactId>hibernate-core</artifactId>
			<version>5.4.2.Final</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/org.hibernate/hibernate-c3p0 -->
		<dependency>
			<groupId>org.hibernate</groupId>
			<artifactId>hibernate-c3p0</artifactId>
			<version>5.4.2.Final</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>javax.servlet-api</artifactId>
			<version>4.0.1</version>
			<scope>provided</scope>
		</dependency>

		<!-- https://mvnrepository.com/artifact/javax.servlet.jsp.jstl/javax.servlet.jsp.jstl-api -->
		<dependency>
			<groupId>javax.servlet.jsp.jstl</groupId>
			<artifactId>javax.servlet.jsp.jstl-api</artifactId>
			<version>1.2.2</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>8.0.23</version>
		</dependency>
		<!-- https://mvnrepository.com/artifact/com.google.code.gson/gson -->
		<dependency>
			<groupId>com.google.code.gson</groupId>
			<artifactId>gson</artifactId>
			<version>2.8.6</version>
		</dependency>

	</dependencies>


	<build>
		<finalName>springMVC-Demo</finalName>
		<plugins>
			<plugin>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>3.8.1</version>
				<configuration>
					<source>1.8</source>
					<target>1.8</target>
				</configuration>
			</plugin>
			<plugin>
				<artifactId>maven-war-plugin</artifactId>
				<version>3.2.3</version>
				<configuration>
					<warSourceDirectory>WebContent</warSourceDirectory>
				</configuration>
			</plugin>
		</plugins>
	</build>
</project>

```

接著在resources 的properties 加入database.properties

![](https://i.imgur.com/CYfEhhU.jpg)

```\
# DataSource
spring.datasource.url=jdbc:mysql://127.0.0.1:3306/mydb?useUnicode=yes&characterEncoding=UTF-8
spring.datasource.username=root
spring.datasource.password=1qaz@WSX
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# C3P0
connectionPool.init_size=10
connectionPool.min_size=10
connectionPool.max_size=20
connectionPool.timeout=600

# SQL
jdbc.dataSource.dialect=org.hibernate.dialect.MySQLDialect
jdbc.dataSource.showSql=true
```
在resources 的database 加入DataSource.xml和 Hibernate.xml 來設定詳細配置

DataSource.xml
```\
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
                           http://www.springframework.org/schema/beans/spring-beans.xsd
                           http://www.springframework.org/schema/mvc 
                           http://www.springframework.org/schema/mvc/spring-mvc.xsd
                           http://www.springframework.org/schema/context 
                           http://www.springframework.org/schema/context/spring-context.xsd
                           http://www.springframework.org/schema/tx
                           http://www.springframework.org/schema/tx/spring-tx.xsd
                           http://www.springframework.org/schema/aop
                           http://www.springframework.org/schema/aop/spring-aop.xsd">

	<bean
		class="org.springframework.context.support.PropertySourcesPlaceholderConfigurer">
		<property name="location">
			<value>classpath:properties/database.properties</value>
		</property>
	</bean>

	<bean id="dataSource"
		class="com.mchange.v2.c3p0.ComboPooledDataSource">
		<property name="driverClass"
			value="${spring.datasource.driver-class-name}" />
		<property name="jdbcUrl" value="${spring.datasource.url}" />
		<property name="user" value="${spring.datasource.username}" />
		<property name="password" value="${spring.datasource.password}" />
		<property name="autoCommitOnClose" value="false"/> <!-- 連接關閉時默認將所有未提交的操作回復 Default:false -->
		<property name="checkoutTimeout" value="${connectionPool.timeout}"/>
		<property name="initialPoolSize" value="${connectionPool.init_size}"/>
		<property name="minPoolSize" value="${connectionPool.min_size}"/>
		<property name="maxPoolSize" value="${connectionPool.max_size}"/>
	</bean>

</beans>
```

Hibernate.xml
```\
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
                           http://www.springframework.org/schema/beans/spring-beans.xsd
                           http://www.springframework.org/schema/mvc 
                           http://www.springframework.org/schema/mvc/spring-mvc.xsd
                           http://www.springframework.org/schema/context 
                           http://www.springframework.org/schema/context/spring-context.xsd
                           http://www.springframework.org/schema/tx
                           http://www.springframework.org/schema/tx/spring-tx.xsd
                           http://www.springframework.org/schema/aop
                           http://www.springframework.org/schema/aop/spring-aop.xsd">

	<!-- Hibernate session factory -->
	<bean id="sessionFactory"
		class="org.springframework.orm.hibernate5.LocalSessionFactoryBean">

		<property name="dataSource">
			<ref bean="dataSource" />
		</property>
		<property name="packagesToScan">
			<list>
				<value>camiol.demo.entity</value>
			</list>
		</property>

		<property name="hibernateProperties">
			<props>
				<prop key="hibernate.dialect">${jdbc.dataSource.dialect}</prop>
				<prop key="hibernate.show_sql">${jdbc.dataSource.showSql}</prop>
			</props>
		</property>
	</bean>
	
	<bean id="transactionManager" class="org.springframework.orm.hibernate5.HibernateTransactionManager">
		<property name="sessionFactory" ref="sessionFactory"/>
	</bean>
	<tx:annotation-driven transaction-manager="transactionManager"/>
</beans>
```

設定好基本配置後, 在spring-mvc.xml那邊把剛剛的配置import進來

spring-mvc.xml 改成這樣
```\
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
                           http://www.springframework.org/schema/beans/spring-beans.xsd
                           http://www.springframework.org/schema/mvc 
                           http://www.springframework.org/schema/mvc/spring-mvc.xsd
                           http://www.springframework.org/schema/context 
                           http://www.springframework.org/schema/context/spring-context.xsd
                           http://www.springframework.org/schema/tx
                           http://www.springframework.org/schema/tx/spring-tx.xsd
                           http://www.springframework.org/schema/aop
                           http://www.springframework.org/schema/aop/spring-aop.xsd">


	<mvc:annotation-driven />
	<context:annotation-config />
	
	<!-- Database Configuration -->
	<import resource="../database/DataSource.xml" />
	<import resource="../database/Hibernate.xml" />
	
	<context:component-scan
		base-package="camiol.demo" />

	<bean id="viewResolver"
		class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<property name="prefix" value="/WEB-INF/pages/" />
		<property name="suffix" value=".jsp" />
	</bean>

</beans>
```

配置完後, 開始加入entity,dao,service等等class

![](https://i.imgur.com/rOuf42r.jpg)

```java=
package camiol.demo.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Entity
@Table(name = "Student")
public class Student {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;
	@Column(name="Name")
	private String name;
	@Column(name="Math_Score")
	private int mathScore;
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getMathScore() {
		return mathScore;
	}
	public void setMathScore(int mathScore) {
		this.mathScore = mathScore;
	}
	
	public String toString() {
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		return gson.toJson(this);
	}
	
}

```
```java=
package camiol.demo.dao;

import java.util.List;

import camiol.demo.entity.Student;

public interface StudentDao {
	Student findById(long id);
	List<Student> findAll();
	void update(Student s);
}


```
```java=
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


```
```java=
package camiol.demo.service;

import java.util.List;

import camiol.demo.entity.Student;

public interface StudentService {
	List<Student> findStudent();
	Student findStudent(long id);
	void updateStudent(Student s);
}


```
```java=
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
```

最後我們改寫剛剛的HelloController,加入service來撈資料
```java=
package camiol.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import camiol.demo.entity.Student;
import camiol.demo.service.StudentService;

@Controller
public class HelloController {
	@Autowired
	private StudentService service;
	
	@RequestMapping("hello")
	public ModelAndView hello() {
		List<Student> list = service.findStudent();
		System.out.println(list);
		
		System.out.println(service.findStudent(5));
		
		return new ModelAndView("hello");
	}
}

```

啟動專案後, 我們一樣輸入網址
http://localhost:8080/springMVC-Demo/hello

![](https://i.imgur.com/YOrNk62.jpg)
確認有正常連到該頁面後, 來看一下Eclipse這邊的console
![](https://i.imgur.com/cwrn6OW.jpg)
console有印出DB的內容, 已正常連結到資料庫!

---

**Step3:**
最後一步, 我們要把回傳的資料放到網頁上顯示, 並且也能從頁面上輸入資料到資料庫來查詢

首先我們需要準備一些基礎工作, 
在POM檔這邊, 加入taglib 的 dependency
```\
<!-- https://mvnrepository.com/artifact/org.apache.taglibs/taglibs-standard-impl -->
		<dependency>
			<groupId>org.apache.taglibs</groupId>
			<artifactId>taglibs-standard-impl</artifactId>
			<version>1.2.5</version>
		</dependency>
```

我們之前就有先加入jstl的dependency了, 所以這邊只要加入taglib就好

然後下載jquery.min.js檔案, 放在webapp/WEB-INF/js下面
![](https://i.imgur.com/HFI5GMA.jpg)

然後我們在spring-mvc.xml這個檔案裡面,加上下面的設定
![](https://i.imgur.com/77ju57d.jpg)
```\
<mvc:resources location="/WEB-INF/js/" mapping="/js/**"/>
```

指定好jquery.min.js的位置後, 再來我們要在hello.jsp上引入jquery和taglib

![](https://i.imgur.com/E9dZYPP.jpg)
```\
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="<c:url value='/js/jquery-3.3.1.min.js' />"></script>
```
我們在jsp畫面載入時, 加上alert和 按按鈕彈出alert視窗,來檢查jquery.min.js檔是否有正確載入

然後我們啟動專案,輸入
http://localhost:8080/springMVC-Demo/hello

![](https://i.imgur.com/imutN4F.jpg)
可以看到有正常載入js檔和taglib

:::warning
如果沒有反應,可以按shift+ctrl+I, 檢查一下console是否有錯誤
:::

**前置作業完成, 再來要開始把輸入的參數傳回controller和從controller那邊拿到的值顯示在JSP畫面上**

我們要新增list.jsp和 view.jsp , 並且修改一下hello.jsp 
![](https://i.imgur.com/a8nbNwx.jpg)

修改後的Hello.jsp
```javascript=\
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value='/js/jquery-3.3.1.min.js' />"></script>
<title>HelloWorld</title>
</head>
<body>
	<h1>Hello World!! Spring MVC</h1>
	<input type="button" id="getAll" value="列出全部學生" />
</body>
<script type="text/javascript">
	$(document).ready(function() {
		if ('${message}' != '') {
			alert('${message}')
		}

		$("#getAll").click(function() {
			window.location.href = "<c:url value='/list' />"
		});
	})
</script>
</html>

```

list.jsp
```javascript=\
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value='/js/jquery-3.3.1.min.js' />"></script>
<title>List</title>
</head>
<body>
	<h1>學生列表</h1>
	<form id="viewDetail" action="view" method="post">
		<input name="id" type="hidden" /> <input name="type" type="hidden" />
		<table>
			<c:if test="${resultList.size()>0}">
				<tr>
					<td>學號</td>
					<td>名字</td>
					<td>操作</td>
				</tr>
				<c:forEach items="${resultList}" var="result" varStatus="s">
					<tr>
						<td>${result.id}</td>
						<td>${result.name}</td>
						<td><input type="button" value="查看"
							onclick="view(${result.id},'view')"></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</form>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		
	})
	function view(id,type){
		$('input[name="id"]').val(id);
		$('input[name="type"]').val(type);
		$("#viewDetail").submit();
	}
</script>
</html>

```

要使用<form:form>的話並須引入這個taglib
```javascript=
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
```

view.jsp
```javascript=\
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="<c:url value='/js/jquery-3.3.1.min.js' />"></script>
<title>View Detail</title>
</head>
<body>
	<h1>詳細資料</h1>
	<form:form id="viewDetail" action="view" method="post" modelAttribute="s">
		<form:input path="id" type="hidden" /> <input name="type" type="hidden" />
		<table>
			<tr>
				<td>學號</td>
				<td>名字</td>
				<td>數學成績</td>
			</tr>

			<tr>
				<td>${s.id}</td>
				<c:choose>
					<c:when test="${type eq 'view'}">
						
						<td>${s.name}</td>
						<td align="center">${s.mathScore}</td>
					</c:when>
					<c:otherwise>
							<td><form:input path="name" /> </td>
							<td align="center"><form:input path="mathScore" /></td>
					</c:otherwise>
				</c:choose>
			</tr>

		</table>
	</form:form>
	<input type="button" value="回上ㄧ頁" onclick="history.back()" />
	<c:choose>
		<c:when test="${type eq 'view'}">
			<input type="button" value="修改"
				onclick="modifyDetail(${s.id}),'modify'" />
		</c:when>
		<c:otherwise>
			<input type="button" value="確認修改" onclick="update()" />
		</c:otherwise>
	</c:choose>
</body>
<script type="text/javascript">
	$(document).ready(function() {

	})
	function modifyDetail(id,type){
		$('input[name="id"]').val(id);
		$('input[name="type"]').val(type);
		$("#viewDetail").submit();
	}
	function update(){
		$("#viewDetail").attr("action","update").submit();
	}
</script>
</html>

```
:::info
預計流程:
在hello.jsp上面按下列出全部學生按鈕 ->
按下去後資料庫撈出全部學生資料並跳轉到list.jsp ->
點選查看按鈕可以看到該名學生成績並跳轉到view.jsp ->
按下修改按鈕進入修改畫面一樣跳轉到view.jsp ->
按下確認修改按鈕後 redirect到hello.jsp,並帶修改成功參數顯示在畫面上
:::

修改原本的HelloController
```java=
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

```
**redirect 要帶參數的話並且url不會顯示參數的話,要用RedirectAttributes.addFlashAttribute("參數名稱","參數內容")來完成**

**啟動專案後,就可以看到下列成果:**

![](https://i.imgur.com/yzJCT8y.jpg)

**按下"列出全部學生"按鈕後**

![](https://i.imgur.com/vkOYPAT.jpg)

**點選6號學生"查看"按鈕後**

![](https://i.imgur.com/3MkYAgO.jpg)

**按下"修改"按鈕後**

![](https://i.imgur.com/xw2BDAx.jpg)

**畫面變成了修改模式, 將名字改成Camiol Chuang 
數學成績改成 100,按下"確認修改"按鈕**

![](https://i.imgur.com/YlnNAYy.jpg)

**回到了一開始的hello.jsp畫面,並且跳出修改成功提示文字**

![](https://i.imgur.com/U1E0GPh.jpg)

**再次點選"列出全部學生"按鈕,去查詢剛剛的6號學生資料**

![](https://i.imgur.com/7CRHM0s.jpg)

**可以看到資料已被修正過**

![](https://i.imgur.com/EUvXLhE.jpg)


**以上就是STEP-BY-STEP
詳細的SpringMVC專案從前端到後端的完整建置步驟!**

###### tags: `Spring MVC`













