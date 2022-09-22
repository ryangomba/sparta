// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require map

if (POLLING) window.setInterval(poll, 1500)

function poll() {
	$.ajax({
	    url: document.location + '/poll',
		type: 'get',
		dataType: 'script'
	})
}

$(document).ready(function() {
	
	$('.contact').click(function() {
		$(this).siblings().children('.info').hide()
		$(this).children('.info').toggle()
	})
	
	$('span#info-heading').click(function() {
		clear_headings($(this))
		$('#info-content').toggle()
	})
	$('span#contacts-heading').click(function() {
		clear_headings($(this))
		$('#contacts-content').toggle()
	})
	$('span#stats-heading').click(function() {
		clear_headings($(this))
		$('#stats-content').toggle()
	})
	
	initialize_map()
	
})

function clear_headings(new_heading) {
	$('.user-section-content').hide()
	$('.user-section').removeClass('active')
	new_heading.addClass('active')
}
