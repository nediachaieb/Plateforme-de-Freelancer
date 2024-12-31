<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="fr">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Freelance Projects</title>

<spring:url value="/src/bootstrap" var="bts" />
<link rel="stylesheet" href="${bts}/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
	<c:set var="cxt" value="${pageContext.request.contextPath}" />
	<jsp:include page="header.jsp" />
	<section id="projects" class="py-5">
		<div class="container">
			<h2 class="text-center mb-4">Mes Projets</h2>
			<div class="row">
				<c:forEach items="${ProjC}" var="p">
					<div class="col-md-4 mb-4">
						<div class="card shadow-sm h-100">
							<div class="card-body d-flex flex-column">
								<h4 class="card-title">${p.titre}</h4>
								<p class="card-text">${p.description}</p>
								<p class="text-muted mt-auto">Budget : ${p.budget} DT</p>
								<div class="d-flex justify-content-between mt-3">
									<a href="${cxt}/detail_project/${p.id}"
										class="btn btn-sm btn-info"> <i class="fas fa-eye"></i>
										Voir le Projet
									</a>
									 <a href="${cxt}/deleteprojects/${p.id}" class="btn btn-danger btn-sm">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </a>

							

								</div>
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
