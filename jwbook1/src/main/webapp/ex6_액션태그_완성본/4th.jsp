<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
</head>
<body>
	<h4>---------- 네번째 페이지 START -------------</h4>
		<% String name = request.getParameter("city");%>
		<p> 도시이름2 : <%=java.net.URLDecoder.decode(name)%> </p>

	<jsp:useBean id="q" class="ex6.Person" scope="request" />
		<p>	아이디4 : <%=q.getId()%>
		<p>	이 름4 : <%=q.getName()%>
		
	<jsp:useBean id="p" class="ex6.Person" scope="request" />
		<p>	아이디5 : <jsp:getProperty name="p" property="id"/> </p>
		<p>	이 름5 : <jsp:getProperty name="p" property="name"/>	</p>
		<jsp:setProperty name="p" property="name" value="박지성"/>	
	<h4>---------- 네번째 페이지 END -------------</h4>
</body>
</html>