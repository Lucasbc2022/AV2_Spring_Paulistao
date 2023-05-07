<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css"/>'>
<title>Campeonato</title>
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
	<div  align="center">
		<c:if test="${not empty camp_resul }">
		
		
			<table class="table" border="1" > 
				<thead>
					<tr>
						<th>Nome do Time</th>
						<th>Numero de jogos disputados</th>
						<th>Vitorias</th>
						<th>Empates</th>
						<th>Derrotas</th>
						<th>Gols Marcados</th>
						<th>Gols Sofridos</th>
						<th>Saldo de Gols</th>
						<th>Pontos</th>
						<th>Classificação nas Quartas</th>
					</tr>
				    
				</thead>
				<tbody>
					<c:forEach items="${camp_resul }" var="cr">
						<tr align="center">
							<td><c:out value="${cr.nome_time }"></c:out></td>
							<td><c:out value="${cr.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${cr.vitorias }"></c:out></td>
							<td><c:out value="${cr.empates }"></c:out></td>
							<td><c:out value="${cr.derrotas }"></c:out></td>
							<td><c:out value="${cr.gols_marcados }"></c:out></td>
							<td><c:out value="${cr.gols_sofridos }"></c:out></td>
							<td><c:out value="${cr.saldo_gols }"></c:out></td>
							<td><c:out value="${cr.pontos }"></c:out></td>
							<td><c:out value="${cr.classificacao }"></c:out></td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>      
</body>
</html>