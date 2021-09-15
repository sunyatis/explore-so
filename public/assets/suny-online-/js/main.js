

jQuery(document).ready( function($) {
  	// UID function
  $("body > img:not([alt])").attr("alt", "<YOURALTTEXT>");
    // Header & Footer Code

    function copyrightDate() {
        var year = new Date().getFullYear();
        $('#cr-date').text(year);
    }
    
    copyrightDate();
    
    $(document).on('click', '#footerArrow', function(e){
        e.preventDefault();
        $("html, body").animate({ scrollTop: 0 }, 700);
    });
  
  	// Mobile Menu Code
  
    $(document).on('click', '.mobile_menu__toggle', function(e) {
		e.preventDefault();
      	$('.mobile_menu__container').addClass('open');
    });
  
    $(document).on('click', '.mobile_menu__close', function(e) {
		e.preventDefault();
      	$('.mobile_menu__container.open').removeClass('open');
    });
  
  	// Scroll to Section code 
	$(document).on('click', '.scroll__me', function(e) {
		e.preventDefault();
		$("html, body").stop(); 

        var href = $(this).attr('href'),
            split = href.split('#'),
            row = '#'+split[1],
            action = split[0];
			
			if (!action || action == '' || action == window.location.href) {
				$('html, body').animate({
					scrollTop: $(row).offset().top
				}, 2000);
            } else {
              	$("html, body").animate({ scrollTop: 0 }, 2000);
            }
	});

	// Hero Filter Code

 	$(document).on('click', function(event) {
        if (!$(event.target).closest('#hero_filter__program').length && !$(event.target).closest('#hero_filter__industry').length) {
            $('.hero_filter__select.open').removeClass('open');
        }
    });
    
    $(document).on('focus', '.hero_filter', function(e) {
        var id = $(this).attr('id');
        $('.hero_filter:not(#'+id+') .hero_filter__select.open').removeClass('open');
      	$('#'+id+' .hero_filter__select:not(.open)').addClass('open');
      
    });
  

  
    $(document).on('click', '.hero_filter__options > span', function(e) {
        
        if ($(this).attr('data-value')) {
            var ind = $(this).attr('data-value'), txt = $(this).text();
            $('#hero_filter__industry .hero_filter__options > span.selected').removeClass('selected');
            $(this).addClass('selected');
          	$('#hero_filter__program').addClass('open');
            $('#hero_filter__program').attr('data-industry', ind);
            $('#hero_filter__program .visible:not([data-industry="'+ind+'"])').removeClass('visible');
            $('#hero_filter__program [data-industry="'+ind+'"]').addClass('visible');
            $('#hero_filter__industry .hero_filter__trigger > span').text(txt);
            $('#hero_filter__industry .hero_filter__select.open').removeClass('open');
        }
        
        if ($(this).attr('data-href')) {
            var href = $(this).attr('data-href');
            if (href != 'na') {
                //alert('Redirect to "'+$(this).attr('data-href')+'"');
                window.location.href = $(this).attr('data-href');
            }
        }
    });
    
    $(document).on('keyup', '.hero_filter__options > span', function(e) {
        if(e.which == 13) {
          if ($(this).attr('data-value')) {
              var ind = $(this).attr('data-value'), txt = $(this).text();
              $('#hero_filter__industry .hero_filter__options > span.selected').removeClass('selected');
              $(this).addClass('selected');
              $('#hero_filter__program').attr('data-industry', ind);
              $('#hero_filter__program .visible:not([data-industry="'+ind+'"])').removeClass('visible');
              $('#hero_filter__program [data-industry="'+ind+'"]').addClass('visible');
              $('#hero_filter__industry .hero_filter__trigger > span').text(txt);
              $('#hero_filter__program').focus();
          }

          if ($(this).attr('data-href')) {
              var href = $(this).attr('data-href');
              if (href != 'na') {
                  //alert('Redirect to "'+$(this).attr('data-href')+'"');
                  window.location.href = $(this).attr('data-href');
              }
          }
        }
    });
  

  	// Smart Resize Script
  
  	(function($,sr){
      // debouncing function from John Hann
      // http://unscriptable.com/index.php/2009/03/20/debouncing-javascript-methods/
      var debounce = function (func, threshold, execAsap) {
          var timeout;

          return function debounced () {
              var obj = this, args = arguments;
              function delayed () {
                  if (!execAsap)
                      func.apply(obj, args);
                  timeout = null;
              };

              if (timeout)
                  clearTimeout(timeout);
              else if (execAsap)
                  func.apply(obj, args);

              timeout = setTimeout(delayed, threshold || 100);
          };
      }
      // smartresize 
      jQuery.fn[sr] = function(fn){  return fn ? this.bind('resize', debounce(fn)) : this.trigger(sr); };

    })(jQuery,'smartresize');
  
  	// Auto-define Height for Info Boxes
    
    function match_heights() {
        $('.degreeInfoSection').find('.about_program__padding').each(function() {
            var elementHeights = $(this).map(function() {
              		console.log($('> .about_program__box > .about_program__content', this).outerHeight());
                    return $('> .about_program__box > .about_program__content', this).outerHeight();
                }).get();

            // Math.max takes a variable number of arguments
            // `apply` is equivalent to passing each height as an argument
            var maxHeight = Math.max.apply(null, elementHeights);

            // Set each height to the max height
          $('.programBoxHeight').remove();
          $('head').append('<style class="programBoxHeight"> .about_program__box { height: '+maxHeight+'px; } @media screen and (max-width: 47.938em) { .about_program__box { height: auto; } } </style>');
            //$('.about_program__box').height(maxHeight);
        });
    }

    $(window).smartresize(function(){
        match_heights();
    });
  
    match_heights();

	// Industry Menu Script

	if ($(".industry__list")[0]){
      var link_list = [], i = 0, seeall = false; //Set "seeall" to true to add the "See All Programs" button
      var max = (seeall ? 5 : 6);
      
      $('.industry__list > ul > li > ul > li').each(function() {
          i ++; if (i <= max) {
            var url = $('> a', this).attr('href'),
                title = $('> a', this).html(),
                output = '<li id="industry__'+i+'"><i class="fas fa-circle-notch fa-spin"></i><div class="category_list__link"><a alt="'+title+'" title="'+title+'" class="full__link" href="'+url+'"></a><div class="category_list__ajax"></div><a class="category_list__button" href="'+url+'">MORE INFO <i class="fas fa-chevron-right"></i></a></div></li>';

            $('.category_list__ul').append(output);
            $('#industry__'+i+' > .category_list__link > .category_list__ajax').load(url + ' #industry__metadata', function(){
                $(this).parent().parent().addClass('loaded');
                $('> #industry__metadata', this).attr('id', 'industry__metadata'+uniqid('id'));
            });
          }
        
          if (seeall) { 
            if (i == (max+1)) {
              var url = $('.industry__list > ul > li > a').attr('href');
              var output = '<li id="industry__6"><i class="fas fa-circle-notch fa-spin"></i><div class="category_list__link"><a alt="View All Programs" title="View All Programs" class="full__link" href="'+url+'"></a><div class="category_list__ajax"></div></div></li>';
              $('.category_list__ul').append(output);
              $('#industry__6 > .category_list__link > .category_list__ajax').load(url + ' #industry__metadata', function(){
                $(this).parent().parent().addClass('loaded');
                $('> #industry__metadata > strong', this).text('View All Programs');
                $('> #industry__metadata', this).attr('id', 'industry__metadata'+uniqid('id'));
              });
            }
          }
      });

      $(document).on('click', '.category_list__more_info', function(e) {
        e.preventDefault();
        $(this).closest('.category_list__link').addClass('active');
        $(this).siblings('p').slideDown();
        $(this).siblings('img').slideUp();
        $(this).siblings('.category_list__close').fadeIn();
        $(this).parent().parent().siblings('.category_list__button').fadeIn();
        $(this).fadeOut('fast');
      });

      $(document).on('click', '.category_list__close', function(e) {
        e.preventDefault();
        $(this).closest('.category_list__link').removeClass('active');
        $(this).siblings('p').slideUp();
        $(this).siblings('img.icon__home').slideDown();
        $(this).siblings('.category_list__more_info').fadeIn();
        $(this).parent().parent().siblings('.category_list__button').fadeOut();
        $(this).fadeOut('fast');
      });
    }

	if ($(".industry_list__program")[0]){
      var link_list = [], i = 0;
      $('.industry_list__program > ul > li > ul > li').each(function() {
          i ++; if (i <= 6) {
            var url = $('> a', this).attr('href'),
                output = '<li id="industry__'+i+'"><a href="'+url+'"><i class="fas fa-circle-notch fa-spin"></i><div class="category_list__link"><div class="category_list__ajax"></div></div></a></li>';

            $('.industry_list__small').append(output);
            $('#industry__'+i+' > a > .category_list__link > .category_list__ajax').load(url + ' #industry__metadata', function(){
                $(this).parent().parent().parent().addClass('loaded');
                $('> #industry__metadata', this).attr('id', 'industry__metadata'+uniqid('id'));
            });
          }
      });
    }
});


$(document).ready(function() {
		var owl = $('.owl-carousel');
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
					items: 2
		        },
		        769:{
		          items: 5
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