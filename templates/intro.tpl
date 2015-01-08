<!-- CV Manage -->
<div id="manage">

	<!-- create -->
	{{ > create }}

	<!-- separator -->
	<div></div>

	<!-- view -->
	{{ > view }}

</div>
<!-- list with all CV's -->
<div id="cvsList" data-title="{{ lang( current, 'existing_cvs' ) }}">
	{{ # list:num }}
		<article on-click="loadCV:{{ num }}" class="{{ cv.cvID == cvID ? 'current' : ''  }}">
			<i class="icon icon-remove" on-click="deleteCV:[ {{ num }}, {{ cvID }} ]"></i>
			<div id="name">{{ name }}</div>
			<div>{{ dateline }}</div>
		</article>
	{{ else }}
		<article class="error">
			<div>{{ lang( current , 'no_cv_found' ) }}</div>
		</article>
	{{ / cvsList }}
</div>