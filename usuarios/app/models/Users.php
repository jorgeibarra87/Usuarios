<?php

class Users extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     *
     * @var string
     */
    public $nombre;

    /**
     *
     * @var integer
     */
    public $identificacion;

    /**
     *
     * @var string
     */
    public $fechanac;

    /**
     *
     * @var string
     */
    public $genero;

    /**
     *
     * @var string
     */
    public $estadocivil;

    /**
     *
     * @var string
     */
    public $direccion;

    /**
     *
     * @var string
     */
    public $telefono;

    /**
     *
     * @var string
     */
    public $created_at;

    /**
     * Independent Column Mapping.
     */
    public function columnMap() {
        return array(
            'id' => 'id',
            'nombre' => 'nombre', 
            'identificacion' => 'identificacion', 
            'fechanac' => 'fechanac',
            'genero' => 'genero', 
            'estadocivil' => 'estadocivil', 
            'direccion' => 'direccion',  
            'telefono' => 'telefono',
            'created_at' => 'created_at'
        );
    }

    public function initialize()
    {
        //queremos que este campo se genere sólo, lo evitamos al hacer inserts/updates
        $this->skipAttributes(array('created_at'));
    }
}