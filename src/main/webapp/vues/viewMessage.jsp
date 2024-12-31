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
		<div class="container py-4">
    <h4>Détails du message</h4>
    <div class="card">
        <div class="card-header">
            Sujet : ${message.sujet}
        </div>
        <div class="card-body">
            <p class="card-text">${message.contenu}</p>
            <p><strong>Envoyé à :</strong> ${message.userreceive.nom}</p>
        </div>
        <div class="card-footer text-end">
            <a href="${cxt}/messagesenvoyes" class="btn btn-secondary">Retour</a>
        </div>
    </div>
</div>
		

	</div>
</body>

<jsp:include page="footer.jsp" />

</body>
</html>
