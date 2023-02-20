<?php
  if (isset($_POST['attacker']) && isset($_POST['loser']) && isset($_POST['Webhook']) && isset($_POST['riped']) ) {
    $att = $_POST['attacker'];
    $los = $_POST['loser'];
    if (empty($_POST['riped'])){
        die("Items riped is empty");
    }
    $riped = $_POST['riped'];
    if (empty($_POST['Webhook'])){
        die("Webhook is empty");
    }
    $webhook = $_POST['Webhook'];
    if (empty($ip)) {
      die("Retard alert");
    }
    $username;
    if (empty($_POST['Username'])){
        $username = 'Blank';
    }else{
        $username = $_POST['Username'];
    }
    $pfp;
    if (empty($_POST['Profile_Link'])){
        $pfp = 'https://frauth.xyz/jesus/frcat.png';
    }else{
        $pfp = $_POST['Profile_Link'];
    }

    function discordmsg($msg, $webhook) {
      if($webhook != "") {
          $ch = curl_init( $webhook );
          curl_setopt( $ch, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
          curl_setopt( $ch, CURLOPT_POST, 1);
          curl_setopt( $ch, CURLOPT_POSTFIELDS, $msg);
          curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, 1);
          curl_setopt( $ch, CURLOPT_HEADER, 0);
          curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1);

          $response = curl_exec( $ch );
          echo $response;
          curl_close( $ch );
      }
  }


  $timestamp = date("c", strtotime("now"));
  $msg = json_encode([
  // Message
  "content" => "",

  // Username
  "username" => $username,

  // Avatar URL.
  // Uncomment to use custom avatar instead of bot's pic
  "avatar_url" => $pfp,

  // text-to-speech
  "tts" => false,

  // file_upload
  // "file" => "",

  // Embeds Array
  "embeds" => [
      [
          // Title
          "title" => "RIPS BOT",

          // Embed Type, do not change.
          "type" => "rich",

          // Description
          "description" => "",

          // Link in title
          "url" => "steam://connect/$ip",

          // Timestamp, only ISO8601
          "timestamp" => $timestamp,

          // Left border color, in HEX
          "color" => hexdec( "3366ff" ),


          // thumbnail
          //"thumbnail" => [
          //    "url" => "https://ru.gravatar.com/userimage/28503754/1168e2bddca84fec2a63addb348c571d.jpg?size=400"
          //],

          // Author name & url
          //"author" => [
          //    "name" => "gay thug",
          //    "url" => ""
         // ],

          // Custom fields
          "fields" => [
              // Field 1
              [
                  "name" => "Attacker",
                  "value" => "$att",
                  "inline" => false
              ],
              // Field 2
              [
                  "name" => "Loser",
                  "value" => "$los",
                  "inline" => false
              ],

              [
                    'name' => "Lost",
                    'value' => "$riped",
                    "inline" => false


              ]
              // etc
          ]
      ]
  ]

], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE );

  discordmsg($msg, $webhook); // SENDS MESSAGE TO DISCORD
  echo "sent?";
} else {
  echo "IP: $ip";
  die(json_encode(array('message' => 'ERROR', 'code' => 2)));
}
?>
