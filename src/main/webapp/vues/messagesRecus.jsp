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
</head>
<body>
	<c:set var="cxt" value="${pageContext.request.contextPath}" />
	<jsp:include page="header.jsp" />
	<div class="container mt-5">
		<div class="col-md-10 email-list py-4">
			<div class="col-md-10 email-list py-4">
				<h4 class="mb-4 text-primary">
					<i class="fas fa-envelope"></i> Boîte de réception
				</h4>
				<div class="list-group shadow-sm rounded">
					<!-- Parcourir les messages -->
					<c:forEach var="m" items="${msgs}">
						<div
							class="list-group-item list-group-item-action email-item d-flex justify-content-between align-items-start border-bottom">
							<div class="ms-3 me-auto">
								<div class="fw-bold text-secondary">
									<i class="fas fa-paper-plane text-success me-2"></i> Sujet :
									${m.sujet}
								</div>
								<p class="mb-1 text-muted small">${m.contenu}</p>
								<small class="text-muted"> <i
									class="fas fa-user text-primary me-1"></i> de :
									${m.usersend.nom}
								</small>
							</div>
							<a href="viewMessage?id=${m.id}"
								class="btn btn-outline-primary btn-sm mt-2"> <i
								class="fas fa-eye"></i> Voir
							</a> <a href="deleteMessage?id=${m.id}"
								class="btn btn-outline-danger btn-sm mt-2"> <i
								class="fas fa-trash"></i> Supprimer
							</a>
						</div>
					</c:forEach>
				</div>
			</div>

		</div>
	</div>
</body>

<jsp:include page="footer.jsp" />

</body>
</html>
