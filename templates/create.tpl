<section class="{{ preview ? 'preview' : '' }}" data-title="{{ lang( current, 'cv_creator' ) }}">

	<!-- personal details -->
	<section id="details">

		<div>
			{{ lang( current , 'name' ) }} * :
			<input type="text" value="{{ cv.name }}">
		</div>

		<div>
			{{ lang( current , 'phone' ) }} * :
			<input type="text" value="{{ cv.phone }}">
		</div>

		<div>
			{{ lang( current , 'location' ) }} * :
			<input type="text" value="{{ cv.location }}">
		</div>

		<div>
			{{ lang( current , 'birthdate' ) }} * :
			<input type="text" value="{{ cv.birthdate }}" placeholder="dd.mm.yyyy">
		</div>

	</section>

	<!-- general info -->
	<section id="info">
		{{ # groups:group }}

			<div class="group {{ . }}">
				<!-- group title -->
				<div class="title">
					{{ lang( current, groups[ group ] ) }}:
					<i class="icon icon-add" on-click="addField:{{ groups[ group ] }}"></i>
				</div>
				{{ # cv.fields[ groups[ group ] ]:index }}

					<div>

						<input type="text" value="{{ cv.fields[ groups[ group ]][ index ] }}" placeholder="{{ lang( current , groups[ group ] + '_placeholder' ) }} {{ index + 1 }} ...">

						<!-- adding date selection for institution fields -->
						{{ # groups[ group ] == 'education' }}
							<input type="text" class="date" value="{{ cv.fields.dates.education[ index ] }}" placeholder="2012-2014">
						{{ / groups }}

						<!-- adding date selection for company fields -->
						{{ # groups[ group ] == 'work_experience' }}
							<input type="month" value="{{ cv.fields.dates.work_experience[ index ].from }}"> <input type="month" value="{{ cv.fields.dates.work_experience[ index ].until }}">
						{{ / groups }}

						<!-- remove icon -->
						<i class="icon icon-remove" on-click="removeField:[ {{ groups[ group ] }}, {{ index }} ]"></i>

					</div>

				{{ / fields }}
			</div>

		{{ / groups }}
	</section>

	<!-- save CV -->
	<button on-click="saveCV" class="{{ saving ? 'loading' : '' }}">
		<i class="icon icon-add"></i>
		{{ saving ? lang( current, 'saving' ) : lang ( current , 'save' ) }}
	</button>

</section>