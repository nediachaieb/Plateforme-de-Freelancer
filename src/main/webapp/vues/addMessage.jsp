<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<spring:url value="src/bootstrap" var="bts" />
<link rel="stylesheet" href="${bts}/css/bootstrap.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<sec:authentication property="principal" var="u" />
<title>Ajoute msg</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<c:set var="cxt" value="${pageContext.request.contextPath}" />
	<div class="container my-5">
		<div class="col-md-10 py-4">
			<div class="compose-form">
				<h4 class="mb-4">Envoyer un nouveau message</h4>

				<form:form action="${cxt}/saveMessage" method="post"
					modelAttribute="message">

					<!-- Destinataire -->
					<div class="mb-3">
						<label for="recipient" class="form-label">Destinataire</label> 
						<form:select path="userreceive.id"
							 class="form-select" items="${users}" itemValue="id" itemLabel="nom">
						
						 </form:select>
					</div>
				

					<!-- Sujet -->
					<div class="mb-3">
						<label for="subject" class="form-label">Sujet</label>
						<form:input path="sujet" type="text" class="form-control"
							id="subject" name="sujet" value="${message.sujet}" />
					</div>

					<!-- Contenu -->
					<div class="mb-3">
						<label for="message" class="form-label">Message</label>
						<form:input path="contenu" class="form-control" name="contenu"
							value="${message.contenu}" />
					</div>

					<!-- Boutons -->
					<button type="submit" class="btn btn-primary">
						<i class="fas fa-paper-plane"></i> Envoyer
					</button>

					<button type="reset" class="btn btn-secondary">Réinitialiser</button>
				</form:form>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>
