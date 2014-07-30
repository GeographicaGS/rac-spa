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
                    obj._setGenericLayer(j,name);
                }
                
            }
            if (name != "bathymetry"){
                obj._overlayBathymetry();
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


    _getVectorStyles: function(el,layername){
        var fillColor = "#FF7800",
            styles;

        if (layername=="bathymetry"){
            var color;

            switch(parseInt(el.height)){
                case -10:
                    color = "#ffb366";
                    break;
                case -20:
                    color = "#f4a761";
                    break;
                case -40:
                    color = "#e29657";
                    break;
                case -50:
                    color = "#cf834e";
                    break;
                case -60:
                    color = "#bf7145"
                    break;
                case -100:
                    color = "#b36640"
                    break;
            }
            
            styles = {
                "strokeColor": color,
                "strokeOpacity": 1,
                "strokeWeight": 2
            };
            
        }
        else if (layername == "community"){

            switch(el.gid){
                case "1":
                    fillColor = "#CD5C5C"
                    break;
                case "2":
                    fillColor = "#FA8072"
                    break;
                case "3":
                    fillColor = "#FFA07A"
                    break;

                case "4":
                    fillColor = "#FF0000"
                    break;

                case "5":
                    fillColor = "#FFA07A"
                    break;

                case "6":
                    fillColor = "#FF6347"
                    break;

                case "7":
                    fillColor = "#FF8C00"
                    break;

                case "8":
                    fillColor = "#FFD700"
                    break;

                case "9":
                    fillColor = "#FFFFE0"
                    break;

                case "10":
                    fillColor = "#FFEFD5"
                    break;

                case "11":
                    fillColor = "#FFDAB9"
                    break;

                case "12":
                    fillColor = "#F0E68C"
                    break;

                case "13":
                    fillColor = "#B22222"
                    break;

                case "14":
                    fillColor = "#800000"
                    break;

                case "15":
                    fillColor = "#A0522D"
                    break;

                case "16":
                    fillColor = "#D2691E"
                    break;

                case "17":
                    fillColor = "#B8860B"
                    break;

                case "18":
                    fillColor = "#F4A460"
                    break;

                case "19":
                    fillColor = "#D2B48C"
                    break;

                default:
                    fillColor = "#FF7800"
            }
            styles = {
                "strokeColor": "#FF7800",
                "strokeOpacity": 1,
                "strokeWeight": 2,
                "fillColor": fillColor,
                "fillOpacity":0.25
            };
            
        }
        else if (layername == "bottom"){
            switch(el.description_fr){
                case "Sable":
                    fillColor = "#FF8C00"
                    break;

                case "Rocheux":
                    fillColor = "#FFD700"
                    break;

                case "Mixte sableux-rocheux":
                    fillColor = "#FAFAD2"
                    break;

                case "Détritique":
                    fillColor = "#FFDAB9"
                    break;

                case "Mixte détritique et rocheux":
                    fillColor = "#BDB76B"
                    break;
            }
            styles = {
                "strokeColor": "#FF7800",
                "strokeOpacity": 1,
                "strokeWeight": 2,
                "fillColor": fillColor,
                "fillOpacity":  0.25
            };
        }
        else{
            styles = {
                "strokeColor": "#FF7800",
                "strokeOpacity": 1,
                "strokeWeight": 2,
                "fillColor": fillColor,
                "fillOpacity": (el.hasOwnProperty("description_fr") || el.hasOwnProperty("gid") ? 1: 0.25)
            };
        }

        return styles;
    },

    _overlayBathymetry: function(){
        var _this = this;
        
        $.getJSON("php/base_map.php?layer=bathymetry",function (elements){
           
            for (i in elements.results) {
                var j = elements.results[i];
                
                if (j && j.geojson && j.geojson.type) {
                    var googleVector = new GeoJSON(j.geojson,_this._getVectorStyles(j,"bathymetry"));
                    
                    if (googleVector instanceof Array){
                        // Multi geometries
                        for (var i=0;i<googleVector.length;i++){
                            googleVector[i].setMap(this._map);
                            _this._layerEls.push(googleVector[i]);
                        }
                    }
                    else{
                        googleVector.setMap(_this._map);
                        _this._layerEls.push(googleVector);
                    }
                }
            }
        });
        
    },
    _setGenericLayer: function(el,layername,legend){
        this._points[el.id_survey] = el;

        if (layername == "bottom"){
            $(".leyenda").find("img").attr("src","img/leyende_fondsmarines.png");
            $(".leyenda").show();
        }
        else if (layername == "community"){
            $(".leyenda").find("img").attr("src","img/leyende_communautes.png");
            $(".leyenda").show();
        }
        else if (layername == "bathymetry"){
            $(".leyenda").find("img").attr("src","img/leyende_bathymetrie.png");
            $(".leyenda").show();
        }
        
        else{
            $(".leyenda").hide();
        }
        var googleVector = new GeoJSON(el.geojson,this._getVectorStyles(el,layername));

        var obj = this;
        if (googleVector instanceof Array){
            // Multi geometries
            for (var i=0;i<googleVector.length;i++){
                googleVector[i].setMap(this._map);
                this._layerEls.push(googleVector[i]);
            }
        }
        else{
            googleVector.setMap(this._map);
            this._layerEls.push(googleVector);
        }

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
            obj._overlayBathymetry();
            
        });
        
        $('.fancybox').fancybox();
    }
    
}