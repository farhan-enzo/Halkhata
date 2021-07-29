<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product :: List</title>

    <meta name="${_csrf.parameterName}" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-2"></div>

        <div class="col-md">
            <div class="col align-self-start">
                <legend>
                    Product List
                    <span>
                        <a type="button" href="/product/create" class="btn btn-primary mb-3"
                                style="margin-top: 15px">
                            <i class="fas fa-plus-circle"></i>
                        </a>
                    </span>
                </legend>
            </div>


            <c:if test="${products.size() == 0}">
                <div class="alert alert-info" role="alert">
                    You have no product!
                </div>
            </c:if>

            <table class="table">
                <thead>
                <tr>
                    <th>Sl.</th>
                    <th>Name</th>
                    <th>Buying Price</th>
                    <th>Selling Price</th>
                    <th>Quantity</th>
                    <th>Brand Name</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${products}" var="invioce" varStatus="i">
                    <tr id="brand-${invioce.id}">
                        <td>${i.index + 1}</td>

                        <td>${invioce.name}</td>

                        <td>${invioce.buyingPrice}</td>

                        <td>${invioce.sellingPrice}</td>

                        <td>${invioce.quantity}</td>

                        <td>${invioce.brand.name}</td>

                        <td>
                            <a href="/product/edit?id=${invioce.id}" class="link">
                                <i class="fas fa-pen"></i>
                            </a>
                        </td>

                        <td>
                            <a class="link" onclick="ajaxPostAction(${invioce.id})">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    function ajaxPostAction(id) {
        if (confirm("Are you sure, you want to delete it?")) {
            $.ajax({
                url: '/product/delete?id=' + id,
                type: 'DELETE',
                cache: false,
                contentType: 'application/json; charset=UTF-8',
                dataType: 'text',
                beforeSend: function(xhr) {
                    var token = $("meta[name='_csrf']").attr("content");
                    var header = $("meta[name='_csrf_header']").attr("content");

                    xhr.setRequestHeader(header, token);
                },
                success: function(data) {
                    location.reload();
                },
                error: function() {
                    alert("Error while deleting!");
                }
            });
        }
    }
</script>
</body>
</html>
