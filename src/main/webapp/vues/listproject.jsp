<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Freelance Projects</title>
<spring:url value="/src/bootstrap" var="bts" />

<link rel="stylesheet" href="${bts}/css/bootstrap.min.css">



<style>
body {
	padding-top: 56px;
	background: linear-gradient(45deg, rgba(255, 255, 204, 0.6),
		/* Jaune très clair (délai de dégradé) */
                 rgba(255, 223, 200, 0.6) /* Jaune pêche pâle */
               );
	background-size: cover;
	background-position: center center;
	font-family: 'Arial', sans-serif;
}

.card {
	transition: transform 0.3s, box-shadow 0.3s;
}

.card:hover {
	transform: scale(1.05);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.btn {
	border-radius: 50px;
}
</style>
</head>
<body>
	<c:set var="cxt" value="${pageContext.request.contextPath}" />
	<jsp:include page="header.jsp" />
	<div class="container mt-5">
		<h1>Projets Disponibles</h1>
		<c:if test="${not empty successMessage}">
			<div class="alert alert-success">${successMessage}</div>
		</c:if>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>#</th>
					<th>Titre</th>
					<th>Description</th>
					<th>Budget</th>
					<th>Date Limite</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="project" items="${projects}">
					<tr>
						<td>${project.id}</td>
						<td>${project.titre}</td>
						<td>${project.description}</td>
						<td>${project.budget}</td>
						<td>${project.date_limite}</td>
						<td><a href="${cxt}/detail_project/${project.id}"
							class="btn btn-danger btn-sm">Postuler</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>

<jsp:include page="footer.jsp" />

</body>
</html>
