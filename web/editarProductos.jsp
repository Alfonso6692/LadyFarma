<div class="modal fade" id="actualizaModal" tabindex="-1" aria-labelledby="actualizaModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="actualizaModalLabel">Actualiza Producto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="updateProductoForm" action="ProductoServlet" method="POST">
                <div class="modal-body">
                    <h1 class="text-center mb-4">Detalles del Producto</h1>
                    <div class="mb-3">
                        <label for="productoactualizar-id" class="form-label">Id Producto</label>
                        <input type="text" class="form-control" id="productoactualizar-id" name="productoId" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="productoactualizar-descripcion" class="form-label">Descripcion</label>
                        <input type="text" class="form-control" id="productoactualizar-descripcion" name="productoDescripcion" required>
                    </div>
                    <div class="mb-3">
                        <label for="productoactualizar-costo" class="form-label">Costo</label>
                        <input type="text" class="form-control" id="productoactualizar-costo" name="productocosto" required>
                    </div>
                    <div class="mb-3">
                        <label for="productoactualizar-precio" class="form-label">Precio</label>
                        <input type="text" class="form-control" id="productoactualizar-precio" name="productoprecio" required>
                    </div>
                    <div class="mb-3">
                        <label for="productoactualizar-cantidad" class="form-label">Cantidad</label>
                        <input type="text" class="form-control" id="productoactualizar-cantidad" name="productocantidad" required>
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
