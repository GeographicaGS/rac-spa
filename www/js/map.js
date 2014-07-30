Map = {
    _points : {},
    _layerEls: [],
    initialize: function(){
        var mapOptions = {
            zoom: 13,
            center: new google.maps.LatLng(35.42385594056947, -2.99102783203125),
            mapTypeId: google.maps.MapTypeId.SATELLITE,
            mapTypeControl: true,
            streetViewControl: false,
            mapTypeControlOptions: {
              position: google.maps.ControlPosition.RIGHT_TOP,
              style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
              mapTypeIds: [google.maps.MapTypeId.TERRAIN, google.maps.MapTypeId.SATELLITE]
            }			
        };
        this._map = new google.maps.Map(document.getElementById('map'),mapOptions);

        this.drawPoints();
        
        
    },
    drawLayer: function(name){
        
        this._removeEls();
        var obj = this;
         $.getJSON("php/base_map.php?layer="+name,function (elements){
           
            for (i in elements.results) {
                var j = elements.results[i];
                
                if (j && j.geojson && j.geojson.type) {
                    obj._setGenericLayer(j);
                }
                
            }
            
        });
    },
    openPointImageGallery:function(id_survey){
        
        var el = this._points[id_survey];


        var html = "";
        
        for (i in el.images){
            var url = el.images[i].substr(3);
            html += "<a class='fancybox' href='"+ url +"' data-fancybox-group='gallery_" + el.id_survey + "' title='"+ el.name +" [" + el.depth +" m]' style='display:none'><img src='" + url + "' alt='' /></a>"; 
        }
            
        $("#co_images").html(html);
        $("#co_images a:first-child").trigger("click");        

    },
    openPointVideoGallery: function(id_survey){
        
        var el = this._points[id_survey];
        
        textMsg = "<h4>Galerie de vidéos</h4><br/>";
        
        for (i in el.videos){
            var url = el.videos[i].substr(3);
            // textMsg += "<a href=\""+url+"\" target='_blank'>Vidéo " + (parseInt(i)+1) +".</a><br/><br/>";
            textMsg += "<a href=\"javascript:Map.playVideo('" + url + "')\">Vidéo " + (parseInt(i)+1) +".</a><br/><br/>";
        }
                    
       showMsg(textMsg);
          
    },

    playVideo:function(url){
        $.fancybox($("<video  preload='none' style='height:" + ($("#map").outerHeight()-100) + "px;' controls><source src='" + url + "' type='video/mp4'></video>"), {
            'width':'auto',
            "height": "auto",
            'autoDimensions':false,
            'autoSize':false,
            'scrolling'   : 'no',
             afterShow: function() {
                $("video")[0].play();
                $('video').bind('playing', function(){
                    $.fancybox.update();
                })
             }
        });

    },

    _removeEls: function(){
        for (i in this._layerEls)
        {
            this._layerEls[i].setMap(null);
        }
        this._layerEls = [];
    },
    _setGenericLayer: function(el){
        this._points[el.id_survey] = el;

        var fillColor = "#FF7800";
        
        if(el.hasOwnProperty("description_fr")){
            fillColor = GeoJsonStyles(el.description_fr);
            $(".leyenda").find("img").attr("src","img/leyende_fondsmarines.png");
            $(".leyenda").show();
        }else if(el.hasOwnProperty("gid")){
            fillColor = GeoJsonStyles(el.gid);
            $(".leyenda").find("img").attr("src","img/leyende_communautes.png");
            $(".leyenda").show();
        }else{
            $(".leyenda").hide();
        }
        
        var googleVector = new GeoJSON(el.geojson,{
            "strokeColor": "#FF7800",
            "strokeOpacity": 1,
            "strokeWeight": 2,
            "fillColor": fillColor,
            "fillOpacity": (el.hasOwnProperty("description_fr") || el.hasOwnProperty("gid") ? 1: 0.25)
        }),obj = this;
        googleVector.setMap(this._map);
        this._layerEls.push(googleVector);
        //googleVector.setTitle(el.name);

        var h4 = el.hasOwnProperty("description_fr") ? el.description_fr : (el.hasOwnProperty("com") ? el.com.replace("{","").replace("}","").replace(/\//g, '').replace(/\"/g, ' '):null);

        if(h4){
             html = "<div class='infowindow'>" +
                    "<h4 style='line-height:24px;'>"+h4+"</h4></div>";
        
            var infowindow = new google.maps.InfoWindow({
                content: html
            });

            google.maps.event.addListener(this._map, "click", function () { 
                infowindow.close(); 
            });
            
            google.maps.event.addListener(googleVector, 'click', function(evt) {
                if (obj._infowindow) {
                    obj._infowindow.close();
                }
                obj._infowindow = infowindow;
                
                infowindow.setPosition(evt.latLng);
                infowindow.open(googleVector.get('map'));
            });
        }
    },
    
    _setClickPoints: function(el){

        $(".leyenda").hide();

        this._points[el.id_survey] = el;
        
        var googleVector = new GeoJSON(el.geojson,{"icon":"img/marcador.png"}),obj = this;
        googleVector.setMap(this._map);
        googleVector.setTitle(el.name);
        this._layerEls.push(googleVector);
        
       
       
        
        html = "<div class='infowindow'>" +
                    "<h4>"+el.name+"</h4>" + 
                    "<p class='descp'>PROFONDEUR:&nbsp<p class='prof'>"+el.depth +" mètres.</p>";
                    
        if (el.images.length>0)
        {
            html += "<p class='images'><a href='javascript:Map.openPointImageGallery("+el.id_survey+")'> Galerie d'images </a>(" + el.images.length + ")</p>";
        }        
        
        if (el.videos.length>0)
        {               
            html += "<p class='videos'>Vidéo</p>";
            var el = this._points[el.id_survey];
            for (i in el.videos){
                var url = el.videos[i].substr(3);
                if(window.chrome || navigator.appName == 'Microsoft Internet Explorer'){
                    html += "<p class='videoRef'><a href=\"javascript:Map.playVideo('" + url + "')\">" + (parseInt(i)+1) +"</a></p>";
                }else{
                    html += "<p class='videoRef'><a href=\""+url+"\" target='_blank'>" + (parseInt(i)+1) +"</a></p>";
                }
            }
        }
        
        var infowindow = new google.maps.InfoWindow({
            content: html
        });

        google.maps.event.addListener(this._map, "click", function () { 
            infowindow.close(); 
        });
        
        google.maps.event.addListener(googleVector, 'click', function() {
            if (obj._infowindow) {
                obj._infowindow.close();
            }
            
            obj._infowindow = infowindow;
            
            infowindow.open(googleVector.get('map'), googleVector);           
        });
        
    },
    drawPoints: function(){
        
        this._removeEls();
        var obj = this;
        $.getJSON("php/points.php",function (elements){            
            for (i in elements.results) {
                var j = elements.results[i];
                
                if (j && j.geojson && j.geojson.type) {
                    obj._setClickPoints(j);
                }
                
            }
            
        });
        
        $('.fancybox').fancybox();
    }
    
}