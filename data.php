<?php
	/**
	 * Content Type
	 */
	header( 'Content-Type: application/json' );

	/**
	 * ROOT PATH
	 */
	define( 'ROOT_PATH' , __DIR__ );

	/**
	 * AUTOLOADING CLASSES
	 * @param  [class name]
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
	 * fetch all existing CV's
	 */
	$list = App::getCVs();

	/**
	 * fetch language data
	 */
	$language = App::getData( 'lang' );

	/**
	 * fetch templates data
	 */
	$templates = App::getData( 'templates' );

?>
/* APP DATA */
var app = <?php echo json_encode( array( 'current_language' => 'en', 'list' => $list, 'language' => $language, 'templates' => $templates ) , JSON_PRETTY_PRINT ); ?>