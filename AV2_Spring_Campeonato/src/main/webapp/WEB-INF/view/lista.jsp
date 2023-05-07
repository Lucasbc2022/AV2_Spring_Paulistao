<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css"/>'>
<title>Lista de Jogos</title>
</head>
<body>
     <div>
          <jsp:include page="menu.jsp"/>
     </div>
     <div align="center">
          <form action="lista" method="post">
               <table >
                 <tr>
                 <br />
                 <td><input type="submit" id="botao" name="botao" value="Listar"><td>
                 
                 </tr>
               </table>
          </form>
     </div>
 <br />
     <div align="center">
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
		<c:if test="${not empty saida }">
			<H2><c:out value="${saida }" /></H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty lista }">
			<table class="table"border="1">
				<thead>
					<tr>
						<th>Nome do Time A</th>
					    <th>Gols do Time A</th>
					    <th>Gols do Time B</th>
						<th>Nome do Time B</th>					    
						<th>Data</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${lista }" var="l">
						<tr>
							<td><c:out value="${l.nometimeA }"></c:out></td>
							<td><c:out value="${l.golstimeA }"></c:out></td>
							<td><c:out value="${l.golstimeB }"></c:out></td>
							<td><c:out value="${l.nometimeB }"></c:out></td>
							
							<td><c:out value="${l.data }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>	
	</div>
	<br>
	<br>
</body>
</html>