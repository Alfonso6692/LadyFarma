<%-- 
    Document   : verClientes
    Created on : 6 oct. 2024, 22:33:48
    Author     : User
--%>
<div class="modal fade" id="consultaModal" tabindex="-1" aria-labelledby="consultaModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="consultaModalLabel">Detalles del Cliente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered table-striped">
                    <tbody>
                        <tr>
                            <th>Id Cliente</th>
                            <td id="cliente-id"></td>
                        </tr>
                        <tr>
                            <th>Apellidos</th>
                            <td id="cliente-apellidos"></td>
                        </tr>
                        <tr>
                            <th>Nombres</th>
                            <td id="cliente-nombres"></td>
                        </tr>
                        <tr>
                            <th>DNI</th>
                            <td id="cliente-dni"></td>
                        </tr>
                        <tr>
                            <th>Dirección</th>
                            <td id="cliente-direccion"></td>
                        </tr>
                        <tr>
                            <th>Teléfono</th>
                            <td id="cliente-telefono"></td>
                        </tr>
                        <tr>
                            <th>Móvil</th>
                            <td id="cliente-movil"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>