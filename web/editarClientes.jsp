<%-- 
    Document   : editarClientes
    Created on : 6 oct. 2024, 22:33:56
    Author     : User
--%>

<div class="modal fade" id="actualizaModal" tabindex="-1" aria-labelledby="actualizaModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="actualizaModalLabel">Actualizar Cliente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="updateClienteForm" action="ClienteServlet" method="POST">
                <div class="modal-body">
                    <h1 class="text-center mb-4">Detalles del Cliente</h1>
                    <div class="mb-3">
                        <label for="clienteactualizar-id" class="form-label">Id Cliente</label>
                        <input type="text" class="form-control" id="clienteactualizar-id" name="clienteId" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="clienteactualizare-apellidos" class="form-label">Apellidos</label>
                        <input type="text" class="form-control" id="clienteactualizar-apellidos" name="clienteApellidos" required>
                    </div>
                    <div class="mb-3">
                        <label for="clienteactualizare-nombres" class="form-label">Nombres</label>
                        <input type="text" class="form-control" id="clienteactualizar-nombres" name="clienteNombres" required>
                    </div>
                    <div class="mb-3">
                        <label for="clienteactualizare-dni" class="form-label">DNI</label>
                        <input type="text" class="form-control" id="clienteactualizar-dni" name="clienteDNI" required>
                    </div>
                    <div class="mb-3">
                        <label for="clienteactualizare-direccion" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="clienteactualizar-direccion" name="clienteDireccion" required>
                    </div>
                    <div class="mb-3">
                        <label for="clienteactualizare-telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="clienteactualizar-telefono" name="clienteTelefono" required>
                    </div>
                    <div class="mb-3">
                        <label for="clienteactualizare-movil" class="form-label">Móvil</label>
                        <input type="text" class="form-control" id="clienteactualizar-movil" name="clienteMovil" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" name="accion" value="Actualizar" class="btn btn-primary">Grabar</button>
                </div>
            </form>
        </div>
    </div>
</div>
