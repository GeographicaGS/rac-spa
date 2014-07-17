<?
  require_once "php/ini.php";
?>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Cabo Tres Forcas. Iniciativa RAC/SPA para la declaración como Área Marina Protegida">
    <meta name="author" content="Geographica.gs">
    <link href='http://fonts.googleapis.com/css?family=Titillium+Web:400,300italic,300,200italic,200,400italic,600,600italic,700,900' rel='stylesheet' type='text/css'>
    <link rel="shortcut icon" href="img/favicon.png">

    <title>RAC-SPA</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/RACSPA-template.css" rel="stylesheet">
	  
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&language=fr"></script>
	
	<script src="js/GeoJSON.js"></script>
  <script src="js/GeoJsonStyles.js"></script>
	<script src="js/map.js"></script>


    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="../../docs-assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
	
	  ga('create', 'UA-9148278-55', 'geographica.gs');
	  ga('send', 'pageview');
	
	</script>
  </head>  
  <body>
  	<div class="container">

		<div class="row">
        	<div class="col-md-9 mapa">
			  <div id="map" ></div>
        <img src="img/leyenda.png" class="leyenda">
			  <!--<img src="img/mapa.jpg" width="1918" height="">-->
			
			</div><!--/.mapa -->
            <div class="col-md-3 Columna_mapas">

                <div class="page-header">
                	<div class="btn-group pull-right idiomas">
                      <button class="btn btn-default btn-xs dropdown-toggle" type="button" data-toggle="dropdown" style="display: none">
                        Idiomas <span class="caret"></span>
                      </button>
                      <ul class="dropdown-menu" role="menu">
                        <li><a href="#">Español</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Francés</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Inglés</a></li>
                      </ul>
                    </div>
                	<div class="logos">
                        <img src="img/circulo_logo.png" width="80" height="80" alt="logo proyecto" class="logoCirculo">
                        <a href="http://www.rac-spa.org/" title="RAC-SPA" target="_blank"><img src="img/rac-spa_logo.png" width="87" height="55" alt="rac spa" class="racspaLogo"></a>
                    </div>
                    <h1 class="title">Cabo Tres Forcas</h1>
                    <h2 class="subtitle"><span>Iniciativa RAC/SPA</span> para la declaración como Área Marina Protegida
                    </h2>
                </div><!--/.page-header -->
                <div class="panel-group" id="accordion">
                  <div class="panel panel-default presentation">
                    <div class="panel-heading">
                      <h4 class="panel-title presetationH4">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                          Presentación
                        </a>
                      </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse in">
                      <div class="panel-body">
                        <p class="lead">
                        	Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                        </p>
                        <p>
                            Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat face.
                        </p>
                        <div class="Partners">
                        <h3>Con el apoyo de:</h3>
                        <div class="PartnersLogos">
                            <a href="http://www.us.es/" title="Universidad de Sevilla" target="_blank"><img class="US" src="img/us-logo.png" width="63" height="55" alt="Universidad de Sevilla"></a>
                            <a href="http://www.um5a.ac.ma" title="Université Mohammed V Agdal - Rabat" target="_blank"><img class="UMA" src="img/uma-logo.png" width="60" height="76" alt="Université Mohammed V Agdal - Rabat"></a>
                            <a href="http://www.unep.org" title="UNEP" target="_blank"><img class="UNEP" src="img/unep-logo.png" width="68" height="65" alt="UNEP"></a>
                            <a href="http://www.unepmap.org/" title="MAP" target="_blank"><img class="MAP" src="img/map-logo.png" width="87" height="65" alt="MAP"></a>
                        </div>
                        <button class="btn btn-primary btn-sm readMore" data-toggle="modal" data-target="#myModal">
                        	<span class="glyphicon glyphicon-plus"></span> Leer más
                        </button>
                        <!-- Modal -->
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                          <div class="modal-dialog">
                            <div class="modal-content">
                              <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModalLabel">Lorem ipsum dolor sit amet</h4>
                              </div>
                              <div class="modal-body">
                              <p class="lead">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec facilisis elit ac elit fermentum, eu fringilla nisi suscipit. Vivamus sed malesuada nisl. Curabitur gravida, urna dictum dictum iaculis, ante erat ullamcorper nibh, eget mattis metus nulla aliquet dui. Nulla ligula ante, faucibus vitae purus quis, consequat dignissim tellus. Donec pulvinar massa erat, nec lobortis metus elementum ac. Etiam nec mi nec ligula interdum sollicitudin. Maecenas porttitor tincidunt mauris, eget aliquet elit luctus ut. Proin ut turpis auctor, ullamcorper quam eu, dictum orci.</p>
                              
                              <p>Sed molestie velit ante, ac auctor orci fermentum at. Pellentesque vel mi porttitor, pretium mi in, ullamcorper neque. Nullam dictum dapibus quam. Proin feugiat quam at mauris tincidunt porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent nec tempus dolor. Duis interdum nibh varius nunc feugiat tempor. Aliquam sem purus, gravida vel mi vitae, tristique sagittis est. Ut ut sem facilisis orci pharetra eleifend. Ut cursus adipiscing ipsum ut suscipit. Cras rhoncus sem velit, eget mattis lacus laoreet sed. Nunc ac posuere leo. Suspendisse vitae magna quis felis aliquet facilisis sed pharetra nisl. Quisque sit amet pulvinar orci, quis mattis ante.</p>
                              <p>Proin placerat volutpat erat at varius. Phasellus et sem enim. Ut elementum ac nisl a varius. Pellentesque sollicitudin bibendum dictum. Donec sed tempor ante. Morbi nisi lacus, dignissim id semper sit amet, tristique eu turpis. Praesent ultrices, enim nec blandit vulputate, nunc nisi vestibulum ligula, nec dignissim neque tortor nec odio. Mauris erat mi, aliquet vel mi id, aliquam interdum lacus. Nunc pulvinar sit amet lorem et venenatis. Phasellus vitae nunc sapien. Donec accumsan mollis nisi adipiscing tempor. Suspendisse mi justo, dictum non aliquam quis, varius ultrices orci. In rutrum purus id neque pretium, ac mollis dui tempor. Praesent adipiscing tellus ac nunc volutpat viverra. Pellentesque rhoncus convallis lectus, eget aliquet quam euismod a.</p>
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                              </div>
                            </div><!-- /.modal-content -->
                          </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->
                        <!-- Modal -->
                    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Lorem ipsum dolor sit amet</h4>
                          </div>
                          <div class="modal-body">
                                  <p class="lead">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec facilisis elit ac elit fermentum, eu fringilla nisi suscipit. Vivamus sed malesuada nisl. Curabitur gravida, urna dictum dictum iaculis, ante erat ullamcorper nibh, eget mattis metus nulla aliquet dui. Nulla ligula ante, faucibus vitae purus quis, consequat dignissim tellus. Donec pulvinar massa erat, nec lobortis metus elementum ac. Etiam nec mi nec ligula interdum sollicitudin. Maecenas porttitor tincidunt mauris, eget aliquet elit luctus ut. Proin ut turpis auctor, ullamcorper quam eu, dictum orci.</p>
                                  
                                  <p>Sed molestie velit ante, ac auctor orci fermentum at. Pellentesque vel mi porttitor, pretium mi in, ullamcorper neque. Nullam dictum dapibus quam. Proin feugiat quam at mauris tincidunt porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent nec tempus dolor. Duis interdum nibh varius nunc feugiat tempor. Aliquam sem purus, gravida vel mi vitae, tristique sagittis est. Ut ut sem facilisis orci pharetra eleifend. Ut cursus adipiscing ipsum ut suscipit. Cras rhoncus sem velit, eget mattis lacus laoreet sed. Nunc ac posuere leo. Suspendisse vitae magna quis felis aliquet facilisis sed pharetra nisl. Quisque sit amet pulvinar orci, quis mattis ante.</p>
                                  <p>Proin placerat volutpat erat at varius. Phasellus et sem enim. Ut elementum ac nisl a varius. Pellentesque sollicitudin bibendum dictum. Donec sed tempor ante. Morbi nisi lacus, dignissim id semper sit amet, tristique eu turpis. Praesent ultrices, enim nec blandit vulputate, nunc nisi vestibulum ligula, nec dignissim neque tortor nec odio. Mauris erat mi, aliquet vel mi id, aliquam interdum lacus. Nunc pulvinar sit amet lorem et venenatis. Phasellus vitae nunc sapien. Donec accumsan mollis nisi adipiscing tempor. Suspendisse mi justo, dictum non aliquam quis, varius ultrices orci. In rutrum purus id neque pretium, ac mollis dui tempor. Praesent adipiscing tellus ac nunc volutpat viverra. Pellentesque rhoncus convallis lectus, eget aliquet quam euismod a.</p>
                                  </div>
                                  <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                                  </div>
                                </div><!-- /.modal-content -->
                              </div><!-- /.modal-dialog -->
                            </div><!-- /.modal -->
                    	</div><!--/Partners -->
                      </div>
                    </div>
                  </div>
                  <div class="panel panel-default">
                    <div class="panel-heading">
                      <h4 class="panel-title presetationH4">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                           Mapas <span class="badge">(8)</span>
                         
                        </a>
                      </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse">
                      <div class="panel-body">
                        <div class="list-group capas">
                          
                          <div class="list-group-item" style="padding-left: 20px; font-weight:bold">De base</div>
                          <a href="javascript:Map.drawPoints()" class="list-group-item active" >Enquête</a>
            						  <a href="javascript:Map.drawLayer('bottom')" class="list-group-item">Fonds marines</a>
                          <a href="javascript:Map.drawLayer('community')" class="list-group-item">Communautés biologiques marines </a>
                          <div class="list-group-item" style="padding-left: 20px; font-weight:bold">Espèce</div>
                          <a href="javascript:Map.drawLayer('astroides_calycularis')" class="list-group-item ">Astroides Calycularis</a>              
            						  <a href="javascript:Map.drawLayer('cystoseira_mediterranea')" class="list-group-item">Cystoseira Mediterranea</a>
            						  <a href="javascript:Map.drawLayer('ophidiaster_ophidianus')" class="list-group-item">Ophidiaster Ophidianus</a>
            						  <a href="javascript:Map.drawLayer('pinna_rudis')" class="list-group-item">Pinna Rudis</a>
            						  <a href="javascript:Map.drawLayer('savalia_savaglia')" class="list-group-item">Savalia Savaglia</a>
						  

                         
                        </div>

                      </div>
                    </div>
                  </div>
                </div><!--/#accordion -->
                <div id="footer" class="col-md-12">
                  <div class="container">
                    <p class="text-muted"><span class="copy">2013 © RAC/SPA</span> <span class="copy pull-right geographica">D+D por <strong><a class="" href="http://geographica.gs" target="_blank">Geographica </a></strong>
                        <img src="img/GEO_W12_icon_bygeographica.png" width="19" height="14" alt="geographica.gs" class="geo"></span></p>
                    
                  </div>
            	</div><!--/.footer -->
            </div><!--/.Columna_mapas -->
		</div>

  </div>

	

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
	
	
	<!-- Add mousewheel plugin (this is optional) -->
	<script type="text/javascript" src="fancyapps-fancyBox-18d1712/lib/jquery.mousewheel-3.0.6.pack.js"></script>

	<!-- Add fancyBox main JS and CSS files -->
	<script type="text/javascript" src="fancyapps-fancyBox-18d1712/source/jquery.fancybox.js?v=2.1.5"></script>
	<link rel="stylesheet" type="text/css" href="fancyapps-fancyBox-18d1712/source/jquery.fancybox.css?v=2.1.5" media="screen" />

	<!-- Add Button helper (this is optional) -->
	<link rel="stylesheet" type="text/css" href="fancyapps-fancyBox-18d1712/source/helpers/jquery.fancybox-buttons.css?v=1.0.5" />
	<script type="text/javascript" src="fancyapps-fancyBox-18d1712/source/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>

	<!-- Add Thumbnail helper (this is optional) -->
	<link rel="stylesheet" type="text/css" href="fancyapps-fancyBox-18d1712/source/helpers/jquery.fancybox-thumbs.css?v=1.0.7" />
	<script type="text/javascript" src="fancyapps-fancyBox-18d1712/source/helpers/jquery.fancybox-thumbs.js?v=1.0.7"></script>

	<!-- Add Media helper (this is optional) -->
	<script type="text/javascript" src="fancyapps-fancyBox-18d1712/source/helpers/jquery.fancybox-media.js?v=1.0.6"></script>
	
	
	<script>
	  function resizeMe(args) {
		$("#map").height($(window).height()).width($(window).width() - $("#accordion").outerWidth(true) );		
	  }
	  
	  function showMsg(text){
		  $("#info_fancy_box_data").html(text);
		  $("#info_fancybox").fancybox().trigger('click');
	  
	  }
	  $(document).ready(function(){
		$(window).resize(resizeMe);
		resizeMe();
		Map.initialize();
		
		$(".list-group-item").click(function(){
		  $(".list-group-item").removeClass("active");
		  $(this).addClass("active");
		});
	  });
	</script>
	<div id="co_images"></div>
	 <div style="display:none">
         <a id="info_fancybox" href="#info_fancy_box_data">Fancybox hidden_link</a>
         <div id="info_fancy_box_data"></div>
      </div>
  </body>
</html>
