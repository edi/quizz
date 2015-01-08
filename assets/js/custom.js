/**
 * dom loaded
 */
$(function(){

	/**
	 * Rendering the CV template
	 * @return instance Promise
	 */
	emptyCV = {
		name : null,
		phone : null,
		location : null,
		birthdate : null,
		fields : {
			dates : {
				hobbies : [],
				education : [],
				work_experience : []
			},
			hobbies : [ null, null ],
			education : [ null, null ],
			work_experience : [ null, null ]
		}
	};
	cvTemplate = new Ractive({
		el : '#wrapper',
		append : true,
		data : {
			lang : function ( lang , block ) { return app.language[ lang ][ block ] || 'lang[' + block + ']' },
			list : app.list,
			current : 'en',
			preview : false,
			groups : [ 'hobbies', 'education', 'work_experience' ],
			cv : {
				name : null,
				phone : null,
				location : null,
				birthdate : null,
				fields : {
					dates : {
						hobbies : [],
						education : [],
						work_experience : []
					},
					hobbies : [ null, null ],
					education : [ null, null ],
					work_experience : [ null, null ]
				}
			}

		},
		template : app.templates.intro,
		partials : {
			create : app.templates.create,
			view : app.templates.view
		}
	});

	/**
	 * binding click events
	 */
	cvTemplate.on({
		/**
		 * Switching language event
		 */
		switchLanguage : function ( event, lang )
		{
			return app.language[ lang ] && cvTemplate.set( 'current' , lang ) || '[' + lang + '] Language data not found';
		},
		/**
		 * Add input field event
		 */
		addField : function ( event, field )
		{
			cvTemplate.get( 'cv.fields.'+field ).push( null );
		},
		/**
		 * Remove input field event
		 */
		removeField : function ( event , data )
		{
			// removin field property
			cvTemplate.get( 'cv.fields.'+data[ 0 ] ).splice( data[ 1 ], 1 );
			// removing date property
			cvTemplate.get( 'cv.fields.dates.'+data[ 0 ] ).splice( data[ 1 ], 1 );
		},
		/**
		 * Saving CV event
		 */
		saveCV : function ( event, data )
		{
			/* gather template data */
			var cv = cvTemplate.get( 'cv' );
			/* current language */
			lang = cvTemplate.get( 'current' );

			/* checking required fields */
			if ( $.trim( cv.name ) && $.trim( cv.phone ) && $.trim( cv.location ) && $.trim( cv.birthdate ) )
			{
				/* processing state */
				cvTemplate.set( 'saving' , true );

				/* sending data to server */
				$.ajax({
					url : 'process.php',
					type : 'POST',
					data : {
						action : 'saveCV',
						data : cv
					},
					dataType : 'json',
					success : function ( response )
					{

						if ( response.success )
						{
							// add cv to list
							app.list.unshift( response.data );
							// clear input data
							cvTemplate.set( 'cv' , emptyCV );
							// load CV
							cvTemplate.fire( 'loadCV' , null, 0 );

						} else
							alert( app.language[ lang ][ 'unknown_error' ]);

						/* remove processing state */
						cvTemplate.set( 'saving' , false );
					}
				})
			}
			/* required fields */
			else
				alert( app.language[ lang ][ 'required_fields' ] )
		},
		/**
		 * Delete CV event
		 */
		deleteCV : function( event, data )
		{

			/* set preview to false */
			cvTemplate.set( 'preview' , false );

			/* unload CV if loaded */
			cvTemplate.get( 'cv.cvID' ) == data[1] && cvTemplate.set( 'cv' , emptyCV );

			/* delete from list */
			app.list.splice( data[0] , 1 );


			/* delete from server */
			$.ajax({
				url : 'process.php',
				type : 'POST',
				data : {
					action : 'deleteCV',
					cvID : data[1]
				}
			});

			// prevent event propagation
			event.original.stopPropagation();

		},
		/**
		 * Load CV event
		 */
		loadCV : function ( event, index )
		{

			/* set preview to false */
			cvTemplate.set( 'preview' , true );

			// break if already loaded
			if ( cvTemplate.get( 'cv.cvID' ) == app.list[ index ].cvID ) return false;

			// replace new CV data
			cvTemplate.set('cv', app.list[ index ])

		}
	});

});