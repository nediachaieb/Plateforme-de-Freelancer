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

<!-- Inclure Bootstrap et FontAwesome -->
<spring:url value="/src/bootstrap" var="bts" />
<spring:url value="/src/images" var="img" />
<link rel="stylesheet" href="${bts}/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<sec:authentication property="principal" var="u" />
<c:set var="cxt" value="${pageContext.request.contextPath}" />
<style>
body {
	padding-top: 56px;
	background: linear-gradient(45deg, rgba(255, 255, 204, 0.6),
		/* Jaune très clair (délai de dégradé) */
                 rgba(255, 223, 200, 0.6) /* Jaune pêche pâle */
               );
	background-size: cover;
	background-position: center center;
	/* Assure que le fond est bien centré */
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
	<jsp:include page="header.jsp" />
	<c:set var="cxt" value="${pageContext.request.contextPath}" />
	<div class="container mt-5">
		<h2>Ajouter un Nouveau Projet</h2>
		<form:form method="POST"
			action="${cxt}/saveProject"
			modelAttribute="project">
			<div class="mb-3">
				<label for="titre" class="form-label">Titre</label>
				<form:input path="titre" class="form-control" id="titre" />
			</div>
			<div class="mb-3">
				<label for="description" class="form-label">Description</label>
				<form:textarea path="description" class="form-control"
					id="description" />
			</div>
			<div class="mb-3">
				<label for="budget" class="form-label">Budget</label>
				<form:input path="budget" type="number" class="form-control"
					id="budget" />
			</div>
			<div class="mb-3">
				<label for="date_limite" class="form-label">Date Limite</label>
				<form:input path="date_limite" type="date" class="form-control"
					id="date_limite" />
			</div>
			<div class="mb-3">
				<label for="nbre_heures" class="form-label">Nombre d'heures</label>
				<form:input path="nbre_heures" type="number" class="form-control"
					id="nbre_heures" />
			</div>
			<div class="mb-3">
				<label for="technologies" class="form-label">Technologies</label>
				<form:input path="technologies" class="form-control"
					id="technologies" />
			</div>
			<div class="mb-3">
				<label for="etat" class="form-label">État</label>
				<form:input path="etat" class="form-control" id="etat" />
			</div>
			<button type="submit" class="btn btn-primary">Enregistrer le
				Projet</button>
		</form:form>
	</div>
	<jsp:include page="footer.jsp" />
	
</body>
</html>
