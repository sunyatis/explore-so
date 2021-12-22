// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap3/bootstrap
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.en-GB.js
//= require filterrific/filterrific-jquery
//= require chardinjs
//= require bootstrap3/bootstrap-multiselect
//= require owl.carousel
//= require mixitup

	if(performance.navigation.type == 2){
	   location.reload(true);
	}

function myFunction() {
		var dg = document.getElementById("degree");
	  var dgchoice = dg.options[dg.selectedIndex].value;
  var stext = document.getElementById('s').value
	  if (dgchoice =="" && stext=="")
	  {
	  	window.location =  "/programs?" + dgchoice + "&" + "filterrific[search_query]=" + stext;
	  }else
	  window.location = "/programs?" + dgchoice + "&" + "filterrific[search_query]=" + stext;
	  
	}
	


	
	function togglemenu (){
	   var w = $(window).width();
	   if (w <= 820) {
	      $('#menu-list').removeClass('in');
	   } else {
	      $('#menu-list').addClass('collapse in');
	   }
	}

	$(window).resize(function(){
	     togglemenu();
	});
	$(window).load(function(){
	     togglemenu();
	});
	togglemenu();
	
	$(function() {
	  $('#ChangeToggle').click(function() {
	    $('#navbar-hamburger').toggleClass('hidden');
	    $('#navbar-close').toggleClass('hidden');  
	  });
	});
	
	$(function() {
	      $('select.show-mobile').on('change',function() {
	            window.location.href = $(this).val();
	      });
	});
	

	
	$(document).ready(function() {
		var owl = $('#owl-demo');
		owl.owlCarousel({
		    items:3,
		    dots: false,
		    mouseDrag: true,
		    responsiveClass: true,
		    responsive: {
		        0:{
		          items: 1
		        },
		        480:{
		          items: 3
		        },
		        769:{
		          items: 3
		        }
		    },
		    onInitialize : function(element){
		        owl.children().sort(function(){
		            return Math.round(Math.random()) - 0.5;
		        }).each(function(){
		            $(this).appendTo(owl);
		        });
		    },
			
			
		});

		
 
	});
	
	
	$(document).ready(function() {
		var owl = $('#owl-demo2');
		owl.owlCarousel({
		    items: 1,
		    dots: false,
		    mouseDrag: true,
		    responsiveClass: true,
		    responsive: {
		        0:{
		          items: 1
		        },
		        480:{
		          items: 1
		        },
		        769:{
		          items: 1
		        }
		    },
		    onInitialize : function(element){
		        owl.children().sort(function(){
		            return Math.round(Math.random()) - 0.5;
		        }).each(function(){
		            $(this).appendTo(owl);
		        });
		    },
			
			
		});

		
 
	});
	
	$(document).ready(function() {
		var owl = $('#owl-demo3');
		owl.owlCarousel({
		    items:3,
		    dots: true,
			/*nav: true,*/
		    mouseDrag: true,
		    responsiveClass: true,
		    responsive: {
		        0:{
		          items: 1
		        },
		        480:{
		          items: 3
		        },
		        769:{
		          items: 3
		        }
		    },
		    onInitialize : function(element){
		        owl.children().sort(function(){
		            return Math.round(Math.random()) - 0.5;
		        }).each(function(){
		            $(this).appendTo(owl);
		        });
		    },
			
			
		});

		
 
	});
	

	
	$(function(){
	  $('#Container').on('mixLoad', function() {
	    console.log('[event-handler] MixItUp Loaded');
	  });
  
	  $('#Container').on('mixStart', function() {
	    console.log('[event-handler] Animation Started')
	  });
  
	  $('#Container').on('mixEnd', function() {
	    console.log('[event-handler] Animation Ended')
	  });
  
	  $('#Container').mixItUp({
	    callbacks: {
	      onMixLoad: function() {
	        console.log('[callback] MixItUp Loaded');
	      },
	      onMixStart: function() {
	        console.log('[callback] Animation Started');
	      },
	      onMixEnd: function() {
	        console.log('[callback] Animation Ended');
	      }
	    }
	  });
	});
	
	// BEGIN area and rating filter
	$('#level_filter').on('click', function() {
	    $('#Container').mixItUp('filter', this.value);

	    // <-- removed from here

	});
	// END area and rating filter
	$(function(){
	  var $filterSelect = $('#level_filter'),
	      $container = $('#Container');
  
	  $container.mixItUp();
  
	  $filterSelect.on('change', function(){
	    $container.mixItUp('filter', this.value);
	  });

	});
	
//schools	
	$(function(){
	  $('#Container-schools').on('mixLoad', function() {
	    console.log('[event-handler] MixItUp Loaded');
	  });
  
	  $('#Container-schools').on('mixStart', function() {
	    console.log('[event-handler] Animation Started')
	  });
  
	  $('#Container-schools').on('mixEnd', function() {
	    console.log('[event-handler] Animation Ended')
	  });
  
	  $('#Container-schools').mixItUp({
	    callbacks: {
	      onMixLoad: function() {
	        console.log('[callback] MixItUp Loaded');
	      },
	      onMixStart: function() {
	        console.log('[callback] Animation Started');
	      },
	      onMixEnd: function() {
	        console.log('[callback] Animation Ended');
	      }
	    }
	  });
	});
	
	// BEGIN area and rating filter
	$('#school_filter').on('click', function() {
	    $('#Container-schools').mixItUp('filter', this.value);

	    // <-- removed from here

	});
	// END area and rating filter
	$(function(){
	  var $filterSelect = $('#school_filter'),
	      $container = $('#Container-schools');
  
	  $container.mixItUp();
  
	  $filterSelect.on('change', function(){
	    $container.mixItUp('filter', this.value);
	  });

	});
	
	
	
