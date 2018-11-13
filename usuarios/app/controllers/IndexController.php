<?php

//otro objecto para crear paginación con QueryBuilder
use \Phalcon\Paginator\Adapter\QueryBuilder as PaginacionBuilder;

class IndexController extends ControllerBase
{

	/**
	* @desc - creamos la paginación de los usuarios y los pasamos a la vista
	* @return object
	*/
    public function indexAction()
    {

        $user = $this->modelsManager->createBuilder()
	    ->from('Users')
	    ->orderBy('id');

		$paginator = new PaginacionBuilder(array(
		    "builder" => $user,
		    "limit"=> 5,
		    "page" => $this->request->getQuery('page', 'int')
		));
 		
        //pasamos el objeto a la vista con el nombre de $page
        $this->view->page = $paginator->getPaginate();
    }

    /**
	* @desc - permitimos añadir nuevos usuarios
	* @return json
	*/
    public function addAction()
    {
    	//deshabilitamos la vista para peticiones ajax
        $this->view->disable();
 
        //si es una petición post
        if($this->request->isPost() == true) 
        {
            //si es una petición ajax
            if($this->request->isAjax() == true) 
            {
            	//si existe el token del formulario y es correcto(evita csrf)
            	if($this->security->checkToken()) 
            	{

		        	$user = new Users();
                    $user->nombre = $this->request->getPost('nombre');
                    $user->identificacion = $this->request->getPost('identificacion');
                    $user->fechanac = $this->request->getPost('fechanac');
                    $user->genero = $this->request->getPost('genero');
                    $user->estadocivil = $this->request->getPost('estadicivil');
                    $user->direccion = $this->request->getPost('direccion');
					$user->telefono = $this->request->getPost('telefono');
					
	                //si el usuario se guarda correctamente
	                if($user->save())
	                {	
						$this->response->setJsonContent(array("res"	=> "success"));
						
				        //devolvemos un 200, todo ha ido bien
						$this->response->setStatusCode(200, "OK");
						
	                }
	                else
	                {
	                	$this->response->setJsonContent(array("res"	=> "error")); 
				        //devolvemos un 500, error
				        $this->response->setStatusCode(500, "Internal Server Error");
	                }
				    $this->response->send();
	            }
            }
        }
    }

    /**
	* @desc - permitimos editar un usuario
	* @return json
	*/
    public function editAction()
    {
    	//deshabilitamos la vista para peticiones ajax
        $this->view->disable();
 
        //si es una petición post
        if($this->request->isPost() == true) 
        {
            //si es una petición ajax
            if($this->request->isAjax() == true) 
            {
            	//si existe el token del formulario y es correcto(evita csrf)
            	if($this->security->checkToken()) 
            	{
            		$parameters = array(
			            "id" => $this->request->getPost('id')
			        );

		        	$user = Users::findFirst(array(
			            "id = :id:",
			            "bind" => $parameters
					));

					$user->nombre = $this->request->getPost('nombre');
                    $user->identificacion = $this->request->getPost('identificacion');
                    $user->fechanac = $this->request->getPost('fechanac');
                    $user->genero = $this->request->getPost('genero');
                    $user->estadocivil = $this->request->getPost('estadicivil');
                    $user->direccion = $this->request->getPost('direccion');
                    $user->telefono = $this->request->getPost('telefono');
	                //si el usuario se actualiza correctamente
	                if($user->update())
	                {
	                	$this->response->setJsonContent(array("res"	=> "success"));
				        //devolvemos un 200, todo ha ido bien
				        $this->response->setStatusCode(200, "OK");
	                }
	                else
	                {
	                	$this->response->setJsonContent(array("res" => "error")); 
				        //devolvemos un 500, error
				        $this->response->setStatusCode(500, "Internal Server Error");
	                }
				    $this->response->send();
	            }
            }
        }
    }

    /**
	* @desc - permitimos eliminar un usuario
	* @return json
	*/
    public function deleteAction()
    {
    	//deshabilitamos la vista para peticiones ajax
        $this->view->disable();
 
        //si es una petición get
        if($this->request->isGet() == true) 
        {
            //si es una petición ajax
            if($this->request->isAjax() == true) 
            {
	        	$user = Users::findFirst($this->request->get("id"));
				if($user != false) 
				{
				    if($user->delete() != false) 
				    {
	                	$this->response->setJsonContent(array("res"	=>"success" ));
				        //devolvemos un 200, todo ha ido bien
				        $this->response->setStatusCode(200, "OK");
	                }
	                else
	                {
	                	$this->response->setJsonContent(array("res" => "error" )); 
				        //devolvemos un 500, error
				        $this->response->setStatusCode(500, "Internal Server Error");
	                }
	            }
			    $this->response->send();
            }
        }
    }
}
//Location: app/controllers IndexController.php

