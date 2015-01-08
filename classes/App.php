<?php
	class App extends DB {

		/**
		 * init DB handler
		 */
		function __construct()
		{
			parent::__construct();
		}

		/**
		 * Available methods
		 */
		public static $allowed_methods = array(
			'saveCV',
			'deleteCV'
		);

		/**
		 * @var default response body
		 */
		public static $response = array(
			'data' => null,
			'success' => false
		);

		/**
		 * return all CVs in the DB
		 * @return [array]
		 */
		public static function getCVs()
		{
			// list array
			$list = array();

			// fetch CVs data
			$sql = DB::query( 'SELECT cv.cvID, cv.dateline, p.personName, p.phone, p.location, p.birthdate, p.hobbies, p.institutions, p.companies FROM cvs cv JOIN persons p ON cv.personID = p.personID ORDER BY cvID DESC' );
			while ( $item = $sql->fetch_assoc() )
				$list[] = self::prepareCV( $item );

			// return list
			return $list;
		}

		/**
		 * Preparing CV data for being shown
		 * @param  [array] $data [unprepared array data]
		 * @return [array]       [ready to output array]
		 */
		public static function prepareCV( $data )
		{

			$institutions = self::getFields ( 'institutions' , 'institutionID' , $data['institutions'] );
			$companies = self::getFields ( 'companies' , 'companyID' , $data['companies'] );

			$cv = array(
				'cvID' => $data['cvID'],
				'name' => urldecode( $data['personName'] ),
				'phone' => urldecode( $data[ 'phone' ] ),
				'location' => urldecode( $data[ 'location' ] ),
				'birthdate' => date( 'j M Y', $data[ 'birthdate' ]),
				'fields' => array(
					'dates' => array(
						'hobbies' => array(),
						'education' => array(),
						'work_experience' => array()
					),
					'hobbies' => json_decode( urldecode( $data[ 'hobbies' ] ) , true ),
					'education' => ( count( $institutions ) ) ? array() : array( null, null ),
					'work_experience' => ( count( $companies ) ) ? array() : array( null, null )
				),
				'dateline' => date( 'j M Y, H:i', $data[ 'dateline' ] )
			);

			foreach ( $institutions as $institution )
			{
				$cv[ 'fields' ][ 'dates' ][ 'education' ][] = $institution[ 'period' ];
				$cv[ 'fields' ][ 'education' ][] = urldecode( $institution[ 'institutionName' ] );
			}

			foreach ( $companies as $company )
			{
				$cv[ 'fields' ][ 'dates' ][ 'work_experience' ][] = array(
					'from' => date( 'M Y', $company[ 'from' ] ),
					'until' => date( 'M Y', $company[ 'until' ] )
				);

				$cv[ 'fields' ][ 'work_experience' ][] = urldecode( $company[ 'companyName' ] );
			}

			return $cv;

		}

		/**
		 * Get fields from list
		 */
		private static function getFields ( $table, $field, $list )
		{
			if ( !$list )
				return null;

			$result = array();

			foreach( explode( ',', $list ) as $value )
				$result[] = DB::query( "SELECT * FROM " . $table . " WHERE " . $field . " = ". (int) $value )->fetch_assoc();

			return $result;
		}

		/**
		 * read data from files of specified type
		 * @return [array]
		 */
		public static function getData( $folder )
		{
			// language var
			$data = array();

			// search for language files
			$files = array_diff(
				scandir ( sprintf( '%s/%s/', ROOT_PATH, $folder ) ),
				array ( '.', '..' )
			);

			// switch method of data reading due to different nature of files
			$type = ( $folder == 'lang' ) ? 'parse_ini_file' : 'file_get_contents';

			// read data from files
			foreach ( $files as $file )
				$data[ pathinfo( $file, PATHINFO_FILENAME ) ] = $type( sprintf('%s/%s/%s', ROOT_PATH, $folder, $file ) );

			return $data;
		}

		/**
		 * Validating and inserting CV into DB
		 * @param  array $data CV data
		 * @return mixed
		 */
		public static function saveCV( $data )
		{

			// trim whitespaces
			array_filter( $data , 'trim' );

			// validate dates
			$birthdate = strtotime( 'DD.MM.YY', $data['birthdate'] );
			if ( $birthdate )
			{
				// validate number
				if ( ctype_digit( $data['phone'] ) )
				{
					// inserting person
					$sql = DB::query( "INSERT INTO persons ( personName, phone, location, birthdate, hobbies, companies, institutions ) VALUES ( '". urldecode( $data['name'] )."', '".$data['phone']."', '".urldecode( $data['location'] )."', ".." )" );

					// getting person ID
					$personID = DB::inserted_id();

					// Insert CV entry
					DB::query( "INSERT INTO cvs ( personID, dateline ) VALUES ( ".$personID.", unix_timestamp() )" );

					// Get CV id
					$cvID = DB::inserted_id();

					// give it a rest !
					sleep( 1 );

					// Set state to successful
					self::$response = array(
						'data' => self::prepareCV( $cv ),
						'success' => true
					);
				} else
					self::$response['data'] = 'invalid_phone';
			} else
				self::$response['data'] = 'invalid_birthdate';
		}

		/**
		 * Deleting a CV entry from database
		 * @param  int $id CV ID
		 */
		public static function deleteCV ( $data )
		{

			return true;

			// delete all entries related to the cvID
			DB::query( "DELETE FROM list WHERE cvID = " . ( int ) $data[ 'cvID' ] . " LIMIT 1" );

			// change state
			self::$response = array(
				'data' => ( int ) $data[ 'cvID' ],
				'success' => true
			);

			return true;
		}

	}
?>