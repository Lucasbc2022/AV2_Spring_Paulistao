<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css"/>'>
<title>Grupos pós Jogos</title>
</head>
<body>
     <div>
          <jsp:include page="menu.jsp"/>
     </div>
    <div align="center">
          <form action="grupos_resultados" method="post">
               <table>
                 <tr>
                 <br> 
                 <td><input type="submit" id="botao" name="botao" value="Exibir"><td>
                 </tr>
               </table>
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
	<div class="tabela" align="center">
		<c:if test="${not empty verGrupoA }">
		
		
			<table class="tableA" border="1"> 
				<thead><h2>Grupo A</h2> 
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
						<th>Estado</th>
					</tr>
				    
				</thead>
				<tbody>
					<c:forEach items="${verGrupoA }" var="va">
						<tr align="center">
							<td><c:out value="${va.nome_time }"></c:out></td>
							<td><c:out value="${va.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${va.vitorias }"></c:out></td>
							<td><c:out value="${va.empates }"></c:out></td>
							<td><c:out value="${va.derrotas }"></c:out></td>
							<td><c:out value="${va.gols_marcados }"></c:out></td>
							<td><c:out value="${va.gols_sofridos }"></c:out></td>
							<td><c:out value="${va.saldo_gols }"></c:out></td>
							<td><c:out value="${va.pontos }"></c:out></td>
							<td><c:out value="${va.estado }"></c:out></td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>   

     <br>
     <br>
     
     <div >
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
		<c:if test="${not empty saida }">
			<H2><c:out value="${saida }" /></H2>
		</c:if>
	</div>
	<div class="tabela" align="center">
		<c:if test="${not empty verGrupoB }">
		
		
			<table class="tableB" border="1">
				<thead> <h2>Grupo B</h2>
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
						<th>Estado</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${verGrupoB }" var="vb">
						<tr align="center">
							<td><c:out value="${vb.nome_time }"></c:out></td>
							<td><c:out value="${vb.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${vb.vitorias }"></c:out></td>
							<td><c:out value="${vb.empates }"></c:out></td>
							<td><c:out value="${vb.derrotas }"></c:out></td>
							<td><c:out value="${vb.gols_marcados }"></c:out></td>
							<td><c:out value="${vb.gols_sofridos }"></c:out></td>
							<td><c:out value="${vb.saldo_gols }"></c:out></td>
							<td><c:out value="${vb.pontos }"></c:out></td>
							<td><c:out value="${vb.estado }"></c:out></td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>
	
     <br>
     <br>
     
     <div >
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
		<c:if test="${not empty saida }">
			<H2><c:out value="${saida }" /></H2>
		</c:if>
	</div>
	<div class="tabela" align="center">
		<c:if test="${not empty verGrupoC }">
		
		
			<table class="tableC" border="1">
				<thead> <h2>Grupo C</h2>
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
						<th>Estado</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${verGrupoC }" var="vc">
						<tr align="center">
							<td><c:out value="${vc.nome_time }"></c:out></td>
							<td><c:out value="${vc.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${vc.vitorias }"></c:out></td>
							<td><c:out value="${vc.empates }"></c:out></td>
							<td><c:out value="${vc.derrotas }"></c:out></td>
							<td><c:out value="${vc.gols_marcados }"></c:out></td>
							<td><c:out value="${vc.gols_sofridos }"></c:out></td>
							<td><c:out value="${vc.saldo_gols }"></c:out></td>
							<td><c:out value="${vc.pontos }"></c:out></td>
							<td><c:out value="${vc.estado }"></c:out></td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>
	
     <br>
     <br>
     
     <div >
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
		<c:if test="${not empty saida }">
			<H2><c:out value="${saida }" /></H2>
		</c:if>
	</div>
	<div class="tabela" align="center">
		<c:if test="${not empty verGrupoD }">
		
		
			<table class="tableD" border="1">
				<thead> <h2>Grupo D</h2>
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
						<th>Estado</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${verGrupoD }" var="vd">
						<tr align="center">
							<td><c:out value="${vd.nome_time }"></c:out></td>
							<td><c:out value="${vd.num_jogos_disputados }"></c:out></td>
							<td><c:out value="${vd.vitorias }"></c:out></td>
							<td><c:out value="${vd.empates }"></c:out></td>
							<td><c:out value="${vd.derrotas }"></c:out></td>
							<td><c:out value="${vd.gols_marcados }"></c:out></td>
							<td><c:out value="${vd.gols_sofridos }"></c:out></td>
							<td><c:out value="${vd.saldo_gols }"></c:out></td>
							<td><c:out value="${vd.pontos }"></c:out></td>
							<td><c:out value="${vd.estado }"></c:out></td>
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:if>	
	</div>	
	         <br>
	         <br>
	         <br>
</body>
</html>