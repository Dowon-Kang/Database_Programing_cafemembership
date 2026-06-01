<%@ page contentType="text/html; charset=utf-8"%>

<html>
<head>
</head>
<body>
	<h4>---------- 두번째 페이지 START -------------</h4>
		<% String name = request.getParameter("city");%>
		<p> 도시이름1 : <%=java.net.URLDecoder.decode(name)%> </p>
		
		<jsp:include page="3th.jsp"/>
	
	<jsp:useBean id="p" class="ex6.Person" scope="request" />
	
		<p>	아이디1 : <%=p.getId()%>
		<p>	이 름1 : <%=p.getName()%>
		<%	p.setId(20242222);
			p.setName("박찬호");	%>
		
		<p>	아이디2 : <jsp:getProperty name="p" property="id"/> </p>
		<p>	이 름2 : <jsp:getProperty name="p" property="name"/>	</p>
		<jsp:setProperty name="p" property="id" value="20243333"/>
		<jsp:setProperty name="p" property="name" value="박세리"/>	
		
		<p>	아이디3 : <% out.println(p.getId()); %> </p>
		<p>	이 름3 : <% out.println(p.getName()); %> </p>
		
		<jsp:include page="4th.jsp"/>
		
		<p>	이 름3 : ${p.name} </p>
	<h4>---------- 두번째 페이지 END -------------</h4>
</body>
</html>