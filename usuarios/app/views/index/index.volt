<div class="row-fluid">
	<h1 class="text-center">Administración CRUD, Usuarios</h1><hr><br>
	<div class="col-md-8 col-md-offset-2">
		<!--botón que abre una modal para añadir un nuevo usuario-->
		<a href="#" class="btn btn-success add pull-right" onclick="usuarios.add()">Añadir usuario</a><br><hr>
		<table class="table table-striped table-bordered table-condensed text-center">
			<thead>
				<tr>
					<th class="text-center">Id</th>
		            <th class="text-center">Nombre</th>
		            <th class="text-center">Identificación</th>
                    <th class="text-center">Fecha de Nacimiento</th>
                    <th class="text-center">Genero</th>
                    <th class="text-center">Estado Civil</th>
                    <th class="text-center">Dirección</th>
                    <th class="text-center">Telefono</th>
		            <th class="text-center">Editar</th>
		            <th class="text-center">Eliminar</th>
		        </tr>
			</thead>
			<tbody>
	        <?php 
	        //si hay usuarios
	        if(count($page->items) > 0)
	        {
	        	//los recorremos y printamos
		        foreach ($page->items as $user) 
		        { 
		        ?>
		        <tr>
		            <td><?php echo $user->id; ?></td>
                    <td><?php echo $user->nombre; ?></td>
                    <td><?php echo $user->identificacion; ?></td>
                    <td><?php echo $user->fechanac; ?></td>
                    <td><?php echo $user->genero; ?></td>
		            <td><?php echo $user->estadocivil; ?></td>
                    <td><?php echo $user->direccion; ?></td>
                    <td><?php echo $user->telefono; ?></td>
		            <td>
		            	<!--en el evento onclick pasamos el usuario en formato json-->
			            <a href="#" class="btn btn-info editar" 
			            onclick="usuarios.edit('<?php echo htmlentities(json_encode($user)) ?>')">
			            	Editar
			            </a>
		            </td>
		            <td>
		            	<!--en el evento onclick pasamos el usuario en formato json-->
			            <a href="#" class="btn btn-danger eliminar" 
			            onclick="usuarios.delete('<?php echo htmlentities(json_encode($user)) ?>')">	
			            	Eliminar
			            </a>
		            </td>
		        </tr>
		        <?php 
		        } 
		        ?>
			    </tbody>
			<?php
			}
			//si no hay usuarios
			else
			{
			?>
			<tbody>
				<tr>
		            <td colspan="6">
		            	<div class="alert alert-danger alert-dismissable text-center">
		            		Actualmente no hay ningún usuario
		            	</div>
		            </td>
		        </tr>
		    </tbody>
			<?php
			}
			?>
		</table>
		<?php 
		//comprobamos si hay usuarios para montar la paginación
	    if(count($page->items) > 0)
	    {
	    ?>
		<center>
		<ul class="pagination pagination-lg pager">
            <li><?php echo $this->tag->linkTo(array("", 'Primera', "class" => "btn")) ?></li>
            <li><?php echo $this->tag->linkTo(array("?page=".$page->before, ' Anterior')) ?></li>
            <li><?php echo $this->tag->linkTo(array("?page=".$page->next, 'Siguiente')) ?></li>
            <li><?php echo $this->tag->linkTo(array("?page=".$page->last, 'Última')) ?></li>
		</ul>
		<p><?php echo "Página ", $page->current, " de ", $page->total_pages; ?></p>
		</center>
		<?php
		}
		?>
	</div>
</div>
<script type="text/javascript">
//objeto javascript al que le añadimos toda la funcionalidad del crud
var usuarios = {};
$(document).ready(function()
{
	//mostramos la modal para crear un usuario
	usuarios.add = function()
	{
		var html = "";
		$("#modalUsuarios .modal-title").html("Crear un nuevo usuario");
		html += '<?php echo $this->tag->form(array("index/add", "method" => "post", "id" => "form")); ?>';
		html += usuarios.csrfProtection();
		html += '<label>Nombre</label>';
        html += '<input type="text" name="nombre" class="form-control">';
        html += '<label>Identificación</label>';
        html += '<input type="number" name="identificacion" class="form-control">';
        html += '<label>Fecha de Nacimiento</label>';
        html += '<input type="date" name="fechanac" class="form-control">';
        html += '<label>Genero</label>';
        html += '<select name="genero" id="genero" class="form-control">';
        html += '<option value="M">Masculino</option>';
        html += '<option value="F">Femenino</option>';
        html += '</select>';
        html += '<label>Estado Civil</label>';
        html += '<select name="estadocivil" id="estadocivil" class="form-control">';
        html += '<option value="soltero">Soltero</option>';
        html += '<option value="casado">Casado</option>';
        html += '<option value="unionlibre">Union Libre</option>';
        html += '</select>';
        html += '<label>Dirección</label>';
        html += '<input type="text" name="direccion" class="form-control">';
        html += '<label>Telefono</label>';
		html += '<input type="number" name="telefono" class="form-control">';
		html += '<?php echo $this->tag->endForm() ?>';
		$("#onclickBtn").attr("onclick","usuarios.addUser()").text("Crear").show();
		$("#modalUsuarios .modal-body").html(html);
		$("#modalUsuarios").modal("show");
	},
	//mostramos la modal para editar un usuario con sus datos
	usuarios.edit = function(user)
	{
		//en user tenemos todos los datos del usuario parseado
		var json = usuarios.parse(user), html = "";
		$("#modalUsuarios .modal-title").html("Editar " + json.nombre);
		html += '<?php echo $this->tag->form(array("index/edit", "method" => "post", "id" => "form")); ?>';
		html += usuarios.csrfProtection();
		html += '<label>Nombre</label>';
        html += '<input type="text" name="nombre" value="'+json.nombre+'" class="form-control">';
        html += '<label>Identificación</label>';
        html += '<input type="number" name="identificacion" value="'+json.identificacion+'" class="form-control">';
        html += '<label>Fecha de Nacimiento</label>';
        html += '<input type="date" name="fechanac" value="'+json.fechanac+'" class="form-control">';
        html += '<label>Genero</label>';
		if (json.genero == 'M'){
			html += '<select name="genero" id="genero"  class="form-control">';
			html += '<option selected value="M">Masculino</option>';
			html += '<option value="F">Femenino</option>';
			html += '</select>';
		}
		else if (json.genero == 'F'){
			html += '<select name="genero" id="genero"  class="form-control">';
			html += '<option value="M">Masculino</option>';
			html += '<option selected value="F">Femenino</option>';
			html += '</select>';
		}
        html += '<label>Estado Civil</label>';
		if (json.estadocivil == 'soltero'){
			html += '<select name="estadocivil" id="estadocivil" class="form-control">';
			html += '<option selected value="soltero">Soltero</option>';
			html += '<option value="casado">Casado</option>';
			html += '</select>';
		}
		else if (json.estadocivil == 'casado'){
			html += '<select name="estadocivil" id="estadocivil" class="form-control">';
			html += '<option value="soltero">Soltero</option>';
			html += '<option selected value="casado">Casado</option>';
			html += '</select>';
		}
        html += '<label>Dirección</label>';
        html += '<input type="text" name="direccion" value="'+json.direccion+'" class="form-control">';
        html += '<label>Telefono</label>';
		html += '<input type="number" name="telefono" value="'+json.telefono+'" class="form-control">';
		html += '<input type="hidden" name="id" value="'+json.id+'" />';
		html += '<?php echo $this->tag->endForm() ?>';
		$("#onclickBtn").attr("onclick","usuarios.editUser()").text("Editar").show();
		$("#modalUsuarios .modal-body").html(html);
		$("#modalUsuarios").modal("show");
	},
	//mostramos la modal para eliminar un usuario
	usuarios.delete = function(user)
	{
		var json = usuarios.parse(user), html = "";
		$("#modalUsuarios .modal-title").html("Eliminar " + json.nombre);
		html += "<p class='alert alert-warning'>¿Estás seguro que quieres eliminar el usuario?</div>";
		$("#onclickBtn").attr("onclick","usuarios.deleteUser("+json.id+")").text("Eliminar").show();
		$("#modalUsuarios .modal-body").html(html);
		$("#modalUsuarios").modal("show");
	},
	//hacemos la petición ajax para añadir un nuevo usuario
	usuarios.addUser = function()
	{
		$.ajax({
			url: "<?php echo $this->url->get('index/add') ?>",
			data: $("#form").serialize(),
			method: "POST",
			success: function(data)
			{
				$("#modalUsuarios .modal-body").html("").html(
					"<p class='alert alert-success'>Usuario creado correctamente.</p>"
				);
				$("#onclickBtn").hide();
			},
			error: function(error)
			{
				console.log(error);
			}
		});
	},
	//hacemos la petición ajax para editar un usuario
	usuarios.editUser = function()//procesamos la edición
	{
		$.ajax({
			url: "<?php echo $this->url->get('index/edit') ?>",
			data: $("#form").serialize(),
			method: "POST",
			success: function(data)
			{
				$("#modalUsuarios .modal-body").html("").html(
					"<p class='alert alert-success'>Usuario actualizado correctamente.</p>"
				);
				$("#onclickBtn").hide();
			},
			error: function(error)
			{
				console.log(error);
			}
		})
	},
	//hacemos la petición ajax para eliminar un usuario
	usuarios.deleteUser = function(id)
	{
		$.ajax({
			url: "<?php echo $this->url->get('index/delete') ?>",
			data: "id="+id,
			method: "GET",
			success: function(data)
			{
				$("#modalUsuarios .modal-body").html("").html(
					"<p class='alert alert-success'>Usuario eliminado correctamente.</p>"
				);
				$("#onclickBtn").hide();
			},
			error: function(error)
			{
				console.log(error);
			}
		});
	},
	//devuelve un json parseado para utilizar con javascript
	usuarios.parse = function(user)
	{
		return JSON.parse(user);
	},
	//devuelve el campo oculto para evitar csrf en phalcon
	usuarios.csrfProtection = function()
	{
		return '<input type="hidden" name="<?php echo $this->security->getTokenKey() ?>"'+
        	   'value="<?php echo $this->security->getToken() ?>"/>';
	}
});
</script>
<!--ventana modal de bootstrap que utilizaremos para cada caso, crear, editar y eliminar-->
<div class="modal fade" id="modalUsuarios" tabindex="-1" role="dialog" aria-labelledby="modalUsuariosLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body">

        </div>
        <div class="modal-footer">
        	<button type="button" id="onclickBtn" class="btn btn-success">Enviar</button>
            <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        </div>
      </div>
    </div>
</div>

