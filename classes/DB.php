<?php
	class DB {

		/**
		 * Check and connect to DB
		 */
		function __construct()
		{

			// checking for previously inited connections
			if (!self::$connection)

				// no connection found, init connection
				self::$connection = new MySQLi(
					'localhost',		/* HOST */
					'root',				/* USER */
					'dulumanedy17#', 	/* PASS */
					'cv_manager'		/* DB */
				);

		}

		/**
		 * @var MySQLi Object
		 */
		public static $connection;

		/**
		 * QUERY handler
		 * @return [MySQLi Object]
		 */
		public static function query( $statement )
		{
			// Executing the statement
			$result = self::$connection->query( $statement );

			// one-liner conditional between error and result
			self::$connection->error && print_r( self::$connection->error );

			// return the result , either way
			return $result;

		}

		/**
		 * Return last inserted id in the database
		 * @return [integer]
		 */
		public static function insertedID()
		{
			return self::$connection->insert_id;
		}

	}
?>