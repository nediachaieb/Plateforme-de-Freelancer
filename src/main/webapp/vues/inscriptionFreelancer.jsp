<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal" var="u" />
<c:set var="cxt" value="${pageContext.request.contextPath}" />

<!-- Inclure Bootstrap et FontAwesome -->
<spring:url value="/src/bootstrap" var="bts" />
<spring:url value="/src/images" var="img" />
<link rel="stylesheet" href="${bts}/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription Freelancer</title>
</head>
<body>

    <div class="container my-5">
        <div class="signup-container" style="max-width: 500px; margin: auto; padding: 20px; background-color: white; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
            <h2 class="text-center">Inscription Freelancer</h2>
            <form:form method="POST" action="${cxt}/saveFreelancer" modelAttribute="user">

                <div class="mb-3">
                    <label for="name" class="form-label">Nom Complet</label>
                    <form:input path="nom" class="form-control" placeholder="Votre nom complet" />
                </div>

                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <form:input path="username" class="form-control" placeholder="Votre username" />
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">E-mail</label>
                    <form:input path="email" type="email" class="form-control" placeholder="Votre adresse e-mail" />
                </div>

                <div class="mb-3">
                    <label for="fphone" class="form-label">Numéro de téléphone</label>
                    <form:input path="fphone" type="text" class="form-control" placeholder="Entrez votre numéro de téléphone" />
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Mot de Passe</label>
                    <form:input path="password" type="password" class="form-control" placeholder="Choisissez un mot de passe" />
                </div>

                <button type="submit" class="btn btn-primary w-100">S'inscrire</button>
            </form:form>

            <div class="mt-3 text-center">
                <p>Déjà un compte ? <a href="${cxt}/login">Connectez-vous ici</a></p>
            </div>
        </div>
    </div>

</body>
</html>
