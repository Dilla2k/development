<?php
class LocalConfig{
   private $host;
   private $database;
   private $password;
   private $username;

   function getHost()
   {
     return $this->host;
   }
   function getDatabase()
   {
     return $this->database;
   }
   function getPassword()
   {
     return $this->password;
   }
   function getUsername()
   {
     return $this->username;
   }

   function startsWith($string, $startString)
   {
      $len = strlen($startString);
      return (substr($string, 0, $len) === $startString);
   }

   function getConfigParameters(){
      $handle = @fopen("/opt/m3rlin/etc/web.cfg", "r");
      //$handle = @fopen("C:\Users\fdill\web.cfg", "r");
      if ($handle) {
         while (($buffer = fgets($handle, 4096)) !== false) {
            if($this->startsWith($buffer,'SQLHost')){
               $this->host=trim(str_replace('SQLHost=','',$buffer));
            }
            if($this->startsWith($buffer,'SQLDB')){
               $this->database=trim(str_replace('SQLDB=','',$buffer));
            }
            if($this->startsWith($buffer,'SQLUser')){
               $this->username=trim(str_replace('SQLUser=','',$buffer));
            }
            if($this->startsWith($buffer,'SQLPW')){
               $this->password=trim(str_replace('SQLPW=','',$buffer));
            }
         }
         if (!feof($handle)) {
           echo "Fehler: unerwarteter fgets() Fehlschlag\n";
         }
         fclose($handle);
      }
   }
}
?>
