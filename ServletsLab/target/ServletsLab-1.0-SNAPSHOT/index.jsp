<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <style>
        form {
            margin-left: auto;
            margin-right: auto;
            width: 400px;
        }
    </style>
</head>
<body>
<form action="LoginController" method="post">
    Enter username : <input type="text" name="username" /> <br />
    Enter password : <input type="password" name="password" /> <br />
    <input type="submit" value="Login" />
</form>
</body>
</html>