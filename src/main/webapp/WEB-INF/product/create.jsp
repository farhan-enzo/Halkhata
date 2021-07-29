<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product :: Add</title>
</head>
<body>
<div class="container" style="padding-top: 5%">
    <div class="row content">

        <div class="col-md-4"></div>

        <div class="col-md-4">
            <h3 style="text-align: center; margin-bottom: 5%">
                Add Product
            <hr/>
            </h3>

            <div class="mb-3">
                <form:form method="POST" modelAttribute="product">
                    <div class="mb-3">
                        <div>
                            <label for="name" class="form-label">Product Name</label>
                            <form:input type="text" path="name" cssClass="form-control" autofocus="true"/>
                        </div>

                        <div style="margin-top: 5px">
                            <form:errors path="name" cssClass="alert alert-danger form-control"/>
                        </div>
                    </div>

                    <div class="md-3">
                        <div>
                            <label for="name" class="form-label">Brand Name</label>

                            <form:select path="brand" cssClass="form-select">
                                <form:option value="">--Please Select Brand name--</form:option>
                                <form:options items="${brands}" itemLabel="name" itemValue="id"/>
                            </form:select>
                        </div>

                        <div style="margin-top: 5px">
                            <form:errors path="brand" cssClass="alert alert-danger"/>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div>
                            <label for="buyingPrice" class="form-label">Buying Price</label>
                            <form:input type="number" path="buyingPrice" cssClass="form-control" autofocus="true"/>
                        </div>

                        <div style="margin-top: 5px">
                            <form:errors path="buyingPrice" cssClass="alert alert-danger form-control"/>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div>
                            <label for="sellingPrice" class="form-label">Selling Price</label>
                            <form:input type="number" path="sellingPrice" cssClass="form-control" autofocus="true"/>
                        </div>

                        <div style="margin-top: 5px">
                            <form:errors path="sellingPrice" cssClass="alert alert-danger form-control"/>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div>
                            <label for="quantity" class="form-label">Quantity</label>
                            <form:input type="number" path="quantity" cssClass="form-control" autofocus="true"/>
                        </div>

                        <div style="margin-top: 5px">
                            <form:errors path="quantity" cssClass="alert alert-danger form-control"/>
                        </div>
                    </div>

                    <button class="btn btn-lg btn-primary btn-block" type="submit">Add</button>
                </form:form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
