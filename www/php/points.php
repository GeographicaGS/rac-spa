<?

require_once "ini.php";

if (!$conn) {
  echo "An error occurred.\n";
  exit;
}

$sql = "SELECT id_survey,name,depth,st_asgeojson(geom) as geojson FROM www.survey ";
$result = pg_query($conn, $sql);

if (!$result) {
  echo "An error occurred.\n";
  exit;
}

$response = array();

$response["results"] = array();

while($row = pg_fetch_object($result))
{
    $directory = "../gallery/$row->id_survey";
    
    $row->images = glob($directory . "/*{JPG,GIF,PNG,jpg,gif,png}", GLOB_BRACE);
    $row->videos = glob($directory . "/*{MOV,AVI,MP4,MPG,mov,avi,mp4,mpg}", GLOB_BRACE);
    $row->geojson = json_decode($row->geojson);
    $response["results"] []= $row;
}

echo json_encode((object) $response);
