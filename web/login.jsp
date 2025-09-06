<%-- 
    Document   : login
    Created on : 5 oct. 2024, 19:33:25
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true" %>
<html lang="es">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE-edge">
   <meta name="author" content="Web de Trabajadores">
   <meta name="description" content="WebTrabajadores">
   <meta name="copyright" content="Propietario del copyright">
   <meta name="keywords" content="Ladyfarma">
   <meta name="viewport" content="width=device-width, initial-scale=1.0" />
   <link rel="stylesheet" href="../css/all.min.css">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
        crossorigin="anonymous">
    <link href="../EstiloBootstrap.css" rel="stylesheet">
   <title>LADYFARMA</title>
   <style>
      body {
         background-image: url('imagen/fondofarmacia.png');
         background-size: cover;
         position: relative;
      }

      .form-login {
         border: solid;
         position: absolute;
         left: 50%;
         top: 50%;
         transform: translate(-50%, -50%);
         background-color: #fff;
         padding: 20px;
         border-radius: 10px;
         box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      }

      .form-login img {
         height: 85px;
      }
   </style>
</head>
<body>
   <div class="container">
      <div class="form-login col-xl-4 mx-auto bg-white p-5 rounded-5">
         <h3 class="text-center mb-4">Sistema Web</h3>
         <div class="d-flex justify-content-center">
            <img src="imagen/usuario.png" alt="Usuario Image">
         </div>
         <h2 class="text-center mb-3">Iniciar sesión</h2>
         <form class="row g-3 form-sign" action="ValidarLogin" method="POST">
            <div class="form-group mb-3">
               <label for="usuario" class="form-label">Usuario</label>
               <input type="text" name="txtUsuario" class="form-control" required>
            </div>
            <div class="form-group mb-3">
               <label for="contraseña" class="form-label">Contraseña</label>
               <input type="password" name="txtClave" class="form-control" required>
            </div>
            <div class="form-group mb-3 text-center">
               <input type="submit" name="accion" value="Ingresar" class="btn btn-primary form-control">
            </div>
         </form>
      </div>
   </div>

   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>

