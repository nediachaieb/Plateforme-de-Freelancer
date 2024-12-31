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
<link rel="stylesheet" href="${bts}/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<title>Mes Projets et Propositions</title>
</head>
<body>
	<c:set var="cxt" value="${pageContext.request.contextPath}" />
	<jsp:include page="header.jsp" />
	<div class="container mt-5">
		<h2 class="text-center mb-4">Mes Projets et Propositions</h2>

		<c:forEach var="project" items="${clientProjects}">
			<div class="card mb-4 shadow border-primary">
				<div class="card-header bg-primary text-white">
					<h4>${project.titre}</h4>
				</div>
				<div class="card-body">
					
					<div >
						
						<a href="${cxt}/detail_project/${project.id}"
							class="btn btn-sm btn-info"> <i class="fas fa-eye"></i> Voir
							le Projet
						</a>
					</div>

					<h5>Propositions :</h5>
					<table class="table table-striped table-bordered">
						<thead>
							<tr>
								<th>#</th>
								<th>Freelancer</th>
								<th>Montant</th>
								<th>Delai</th>
								<th>Description</th>
								
							</tr>
						</thead>
						<tbody>
							<c:forEach var="proposition" items="${project.propositions}">
								<tr>
									<td>${proposition.id}</td>
									<td>${proposition.freelancer.username}</td>
									<td>${proposition.montant}</td>
									<td>${proposition.delai}</td>
									<td>${proposition.description}</td>
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</c:forEach>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>