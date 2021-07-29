<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PROFILE :: LIST</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-2"></div>

        <div class="col-md">
            <div class="col align-self-start">
                <legend>
                    Profile List
                    <span>
                        <a type="button" href="/profile/create" class="btn btn-primary mb-3"
                           style="margin-top: 15px">
                            <i class="fas fa-plus-circle"></i>
                        </a>
                    </span>
                </legend>
            </div>

            <table class="table">
                <thead>
                <tr>
                    <th>Sl.</th>
                    <th>Name</th>
                    <th>Password</th>
                    <th>Edit</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${profiles}" var="profile" varStatus="i">
                    <tr id="brand-${profile.id}">
                        <td>${i.index + 1}</td>

                        <td>${profile.name}</td>

                        <td>${profile.password}</td>

                        <td>
                            <a href="/profile/edit?id=${profile.id}" class="link">
                                <i class="fas fa-pen"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
