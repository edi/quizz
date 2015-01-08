<?php

	/**
	 * Content Type
	 */
	header( 'Content-Type: application/json' );

	/**
	 * REMOVE WARNINGS
	 */
	error_reporting( E_ALL ^ E_NOTICE );

	/**
	 * Root path
	 */
	define( 'ROOT_PATH' , __DIR__ );
	define( 'action' , $_POST['action'] );

	/**
	 * Autoload classes
	 */
	function __autoload( $className )
	{
		require ROOT_PATH . "/classes/" . $className . ".php";
	}

	/**
	 * @var Init App Handler
	 */
	$app = new App;

	/**
	 * Checking if method is allowed ( avoid __construct / other undesirable requests)
	 */
	if ( in_array( action , App::$allowed_methods ) )
		$response = call_user_func( array ( $app , action ) , $_POST );

	/**
	 * Print out formatted JSON ( just for readability )
	 */
	echo json_encode( App::$response , JSON_PRETTY_PRINT );
?>