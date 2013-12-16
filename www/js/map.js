Map = {
    _points : {},
    initialize: function(){
        var mapOptions = {
            zoom: 13,
            center: new google.maps.LatLng(35.42385594056947, -2.99102783203125),
            mapTypeId: google.maps.MapTypeId.TERRAIN,
            mapTypeControl: true,
            mapTypeControlOptions: {
              position: google.maps.ControlPosition.RIGHT_TOP,
              style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
            }			
        };
        this._map = new google.maps.Map(document.getElementById('map'),mapOptions);
        this._drawPoints();
    },
    openPointImageGallery:function(id_survey){
        var $el = $("a[data-fancybox-group=gallery_"+id_survey+"]");
        if ($el.length > 0 ){
            $($el[0]).trigger("click");
        }
        else{
            showMsg("There is no images at this place");
        }
    },
    openPointVideoGallery: function(id_survey){
        
        var el = this._points[id_survey];
        
        textMsg = "<h4>Galerie de vidéos</h4><br/>";
        
        for (i in el.videos){
            var url = el.videos[i].substr(3);
            textMsg += "<a href=\""+url+"\" target='_blank'>Vidéo " + (parseInt(i)+1) +".</a><br/><br/>";
        }
                    
       showMsg(textMsg);
          
    },
    _setClickPoints: function(el){
        this._points[el.id_survey] = el;
        
        var googleVector = new GeoJSON(el.geojson,{"icon":"img/marcador.png"}),obj = this;
        googleVector.setMap(this._map);
        googleVector.setTitle(el.name);
    
        
        var html = "";
        
        for (i in el.images){
            var url = el.images[i].substr(3);
            html += "<a class='fancybox' href='"+ url +"' data-fancybox-group='gallery_" + el.id_survey + "' title='"+ el.name +" [" + el.depth +" m]' style='display:none'><img src='" + url + "' alt='' /></a>"; 
        }
        
        if (html!= "") {
            $("body").append(html);
        }
        
        html = "<div class='infowindow'>" +
                    "<h4>"+el.name+"</h4>" + 
                    "<p>Profondeur:&nbsp"+el.depth +" mètres.</p>";
                    
        if (el.images.length>0)
        {
            html += "<p><a href='javascript:Map.openPointImageGallery("+el.id_survey+")'> Galerie d'images.</a></p>";
        }        
        
        if (el.videos.length>0)
        {               
            html += "<p><a href='javascript:Map.openPointVideoGallery("+el.id_survey+")'> Galerie de vidéos.</a></p>";
        }
        
        var infowindow = new google.maps.InfoWindow({
            content: html
        });
        
        google.maps.event.addListener(googleVector, 'click', function() {
            if (obj._infowindow) {
                obj._infowindow.close();
            }
            
            obj._infowindow = infowindow;
            
            infowindow.open(googleVector.get('map'), googleVector);           
        });
        
    },
    _drawPoints: function(){
        var obj = this;
        $.getJSON("php/points.php",function (elements){
            console.log(elements);
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