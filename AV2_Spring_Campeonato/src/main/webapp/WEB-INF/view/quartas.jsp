<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Quartas de Final</title>
</head>
<body>
     <div>
         <jsp:include page="menu.jsp"></jsp:include>
     </div>

    <div align="center">
          <form action="campeonato" method="get">

          </form>
    </div>
     <br>
     <div>
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
		<c:if test="${not empty saida }">
			<H2><c:out value="${saida }" /></H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty times_classificados }">
		
		
			<table class="table" border="1" > 
				<thead>
					<tr>
						<th>Times Classificados</th>
					</tr>    
				</thead>
				<tbody>
					<c:forEach items="${times_classificados }" var="tc">
						<tr align="center">
							<td><c:out value="${tc.nome_time_quartas }"></c:out></td>							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>  
    <br>
    <br>
    <br>
	  <div>
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
		<c:if test="${not empty saida }">
			<H2><c:out value="${saida }" /></H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty jogos_finais }">
		
		
			<table class= "table" border="1">
				<thead> <h3>Jogos Quartas De Final</h3>
					<tr>
						<th>Nome do Time A</th>
						<th>Nome do Time B</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${jogos_finais }" var="jf">
						<tr align="center">
							<td><c:out value="${jf.nome_timeA }"></c:out></td>
							<td><c:out value="${jf.nome_timeB }"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</c:if>	
	</div>

 
</body>
</html>