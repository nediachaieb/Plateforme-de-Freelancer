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
		rgba(255, 223, 200, 0.6));
	background-size: cover;
	background-position: center center;
	font-family: 'Arial', sans-serif;
}

.profile-header {
	background-color: #f8f9fa;
	padding: 20px;
	border-radius: 0.5rem;
}

.rating {
	color: gold;
}
</style>
</head>

<body>

	<jsp:include page="header.jsp" />

	<section id="profil" class="py-5">
		<div class="container my-5">
			<div class="profile-header">
				<div class="row">
					<div class="col-md-3">
						<!-- Remplacer l'image par défaut par l'image dynamique si disponible -->
						<img src="${cxt}/src/images/${prf.photo}" alt="Photo de profil"
							class="img-fluid rounded-circle">
					</div>
					<div class="col-md-9">
						<h2>Freelancer ${u.username}</h2>

						<p>
							<strong>Compétences :</strong> ${prf.skills}
						</p>
						<p>
							<strong>Tarif Horaire :</strong> ${prf.tarif}
						</p>
						<div class="rating">
							<span>&#9733;&#9733;&#9733;&#9733;&#9734;</span> (4.0/5)
						</div>
						<button class="btn btn-success mt-2">Contacter</button>
						<button class="btn btn-primary mt-2">Proposer un Projet</button>
					</div>
				</div>
			</div>

			<div class="container">
				<h3 class="mt-4">Portfolio</h3>
				<div class="row">
					<c:forEach items="${ProjF}" var="p">
						<div class="col-md-4 mb-4">
							<div class="card shadow-sm h-100">
								<div class="card-body d-flex flex-column">
									<h4 class="card-title">${p.titre}</h4>
									<p class="card-text">${p.description}</p>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

	</section>

	<jsp:include page="footer.jsp" />

</body>
</html>
