<?
require_once "ini.php";

if (!$conn)
{
 echo "An error occurred.\n";
  exit;
}

$layers = array("astroides_calycularis","bottom","community","cystoseira_mediterranea","ophidiaster_ophidianus","pinna_rudis","savalia_savaglia","bathymetry");


if (!isset($_GET["layer"]) || !$_GET["layer"] || array_search($_GET["layer"] ,$layers)===FALSE)
{
    echo "No layer";
    exit;
}

$layer = $_GET["layer"];

switch ($layer)
{
    case "astroides_calycularis":
        $sql = "SELECT st_asgeojson(st_transform(geom,4326)) as geojson FROM www.astroides_calycularis_map";
        break;
    case "bottom":
        $sql = "SELECT description_fr,st_asgeojson(st_transform(geom,4326)) as geojson FROM www.bottom_map";
        break;
    case "community":
        $sql = "SELECT gid, com,st_asgeojson(st_transform((st_dump(geom)).geom,4326)) as geojson FROM www.community_map";
        break;
    case "cystoseira_mediterranea":
        $sql = "SELECT st_asgeojson(st_transform(geom,4326)) as geojson FROM www.cystoseira_mediterranea_map";
        break;
    case "ophidiaster_ophidianus":
        $sql = "SELECT st_asgeojson(st_transform(geom,4326)) as geojson FROM www.ophidiaster_ophidianus_map";
        break;    
    case "pinna_rudis":
        $sql = "SELECT st_asgeojson(st_transform(geom,4326)) as geojson FROM www.pinna_rudis_map";
        break;    
    case "savalia_savaglia":
        $sql = "SELECT st_asgeojson(st_transform(geom,4326)) as geojson FROM www.savalia_savaglia_map";
        break;
    case "bathymetry":
        $sql = "SELECT height,st_asgeojson(st_transform(geom,4326)) as geojson FROM context.bathimetry_line";
        break;

}

$result = pg_query($conn, $sql);

if (!$result) {
  echo "An error occurred.\n";
  exit;
}

$response = array();

$response["results"] = array();

while($row = pg_fetch_object($result))
{
    $row->geojson = json_decode($row->geojson);
    $response["results"] []= $row;
}


echo json_encode((object) $response);
