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

	<header class=" text-center py-5">
		<div class="container">
			<hr class="message-inner-separator">
			<h2>Bienvenue sur FreelanceESSAT</h2>
			<hr class="message-inner-separator">
			<h3 class="font-italic text-danger">
				Trouvez le projet idéal<i class="fa fa-exclamation-triangle"
					aria-hidden="true"></i>
			</h3>
			<h3>Connectez-vous avec des freelancers de talent!</h3>
			
				
				<a href="${cxt}/addProject"
					class="btn btn-outline btn-lg mt-3"> Création projet <i
					class="fas fa-briefcase ml-2"></i>
				</a>
		
			
				<a href="${cxt}/addProfil"
					class="btn btn-outline btn-lg mt-3"> Création Profil<i
					class="fas fa-user ml-2 "></i></a>
		

		
		</div>
	</header>

	<section id="projects" class="py-5">
		<div class="container">
			<h2 class="text-center mb-4">Projets Récents</h2>
			<div class="row">
				<c:forEach items="${projs }" var="p">
					<div class="col-md-4 mb-4">
						<div class="card shadow-sm h-100">
							<div class="card-body d-flex flex-column">
								<img src="https://via.placeholder.com/350" class="card-img-top"
									alt="Projet 1">
								<h5 class="card-title">${p.titre }</h5>
								<p class="card-text">${p.description }]</p>
								<a href="detail_project/${p.id}" class="btn btn-danger btn-sm">Voir
									le Projet</a>
							</div>
						</div>
					</div>
				</c:forEach>



			</div>
		</div>
	</section>

	<jsp:include page="footer.jsp" />

</body>
</html>
