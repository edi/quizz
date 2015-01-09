<section id="viewer" data-title="{{ lang( current, 'cv_viewer' ) }}">

	<!-- personal details -->
	<section id="details">

		<div>
			{{ lang( current , 'name' ) }}:
			<div>{{{ cv.name }}}</div>
		</div>

		<div>
			{{ lang( current , 'phone' ) }}:
			<div>{{{ cv.phone }}}</div>
		</div>

		<div>
			{{ lang( current , 'location' ) }}:
			<div>{{{ cv.location }}}</div>
		</div>

		<div>
			{{ lang( current , 'birthdate' ) }}:
			<div>{{{ cv.birthdate }}}</div>
		</div>

	</section>

	<!-- general info -->
	<section id="info">
		{{ # groups:group }}

			<div class="group">
				<!-- group title -->
				<div class="title">
					{{ lang( current, groups[ group ] ) }}:
				</div>

					<!-- data from inputs -->
					{{ # cv.fields[ groups[ group ] ]:index }}

						<!-- field info -->
						{{ # cv.fields[ groups[ group ]][ index ] }}
							<div class="field {{ groups[ group ] }}">
								{{ index + 1 }}. {{{ . }}}

								<!-- education -->
								{{ # groups[ group ] == 'education' && cv.fields.dates.education[ index ] }}
									( {{{ cv.fields.dates.education[ index ] }}} )
								{{ / education }}


								<!-- work_experience -->
								{{ # groups[ group ] == 'work_experience' && cv.fields.dates.work_experience[ index ].from && cv.fields.dates.work_experience[ index ].until }}

										( {{{ cv.fields.dates.work_experience[ index ].from + ' - ' + cv.fields.dates.work_experience[ index ].until }}} )

								{{ / work_experience }}
							</div>
						{{ / fields }}

					{{ / fields }}

			</div>

		{{ / groups }}
	</section>

	<!-- change language -->
	<button on-click="switchLanguage:{{ current == 'en' ? 'ro' : 'en' }}">
		<i class="icon icon-world"></i>
		{{ lang( current , 'switch_language' ) }}
	</button>

</section>