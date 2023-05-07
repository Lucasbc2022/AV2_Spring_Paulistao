<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css"/>'>
<title>Tabela de Jogos</title>
</head>
<body>
     <div>
          <jsp:include page="menu.jsp"/>
     </div>
     <div align="center">
          <form action="tabelas" method="post">
               <table class="z">
                 <tr>
                 <br />
                 
                 <td><input type="date" id="data" name="data"><td>
                 <td><input type="submit" id="botao" name="botao" value="Buscar"><td>
                 
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
 
	   <c:choose>
		<c:when test="${not empty tabela }">
			<table class="table" border="1">
				<thead>
					<tr>
						<th>Nome do Time A</th>
						
						<th>Nome do Time B</th>
						
						<th>Data</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${tabela }" var="t">
						<tr>
							<td><c:out value="${t.nometimeA }"></c:out></td>
							
							<td><c:out value="${t.nometimeB }"></c:out></td>
							
							<td><c:out value="${t.data }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:when>
      
		<c:otherwise>
			<div class="z">
                  <p>N�o a jogos nessa data</p>
			</div>
		</c:otherwise>		
	 </c:choose>		
	</div>
</body>
</html>