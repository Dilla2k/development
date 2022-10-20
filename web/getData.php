<?php
   error_reporting(E_ALL | E_STRICT);
   header("Access-Control-Allow-Origin: *");
   ini_set("display_errors", 1);
   require_once 'getLocalConfig.php';
   $classConfig= new LocalConfig ;

   $classConfig->getConfigParameters();

   $servername= $classConfig->getHost();
   $dbname= $classConfig->getDatabase();
   $password= $classConfig->getPassword();
   $username= $classConfig->getUsername();

   $action = $_POST["action"];
   $conn = new mysqli($servername, $username, $password, $dbname);

   if($conn->connect_error){
      die("Connection Failed: " . $conn->connect_error);
      return;
   }
   if("GET_ALL_CATEGORIES" == $action){
      $db_data = array();
      $sql = "SELECT id,name FROM category order by id";
      $result = $conn->query($sql);
      if($result->num_rows > 0){
         while($row = $result->fetch_assoc()){
            $db_data[] = $row;
         }
         echo json_encode($db_data);
      }
      else{
         echo "error";
      }
      $conn->close();
      return;
   }
   if("GET_ALL_DRINKS" == $action){
      $db_data = array();
      $sql = "SELECT id, name, smallPrice, bigPrice, category FROM drinks order by id";
      $result = $conn->query($sql);
      if($result->num_rows > 0){
         while($row = $result->fetch_assoc()){
            $db_data[] = $row;
         }
         echo json_encode($db_data);
      }
      else{
         echo "error";
      }
      $conn->close();
      return;
   }
   if("GET_ALL_ENERGY" == $action){
      $db_data = array();
      $sql = "SELECT id, name FROM energy order by id";
      $result = $conn->query($sql);
      if($result->num_rows > 0){
         while($row = $result->fetch_assoc()){
            $db_data[] = $row;
         }
         echo json_encode($db_data);
      }
      else{
         echo "error";
      }
      $conn->close();
      return;
   }
   if("GET_ALL_JUICE" == $action){
      $db_data = array();
      $sql = "SELECT id, name FROM juice order by id";
      $result = $conn->query($sql);
      if($result->num_rows > 0){
         while($row = $result->fetch_assoc()){
            $db_data[] = $row;
         }
         echo json_encode($db_data);
      }
      else{
         echo "error";
      }
      $conn->close();
      return;
   }
   if("GET_ALL_FOOD" == $action){
      $db_data = array();
      $sql = "SELECT id, name FROM food order by id";
      $result = $conn->query($sql);
      if($result->num_rows > 0){
         while($row = $result->fetch_assoc()){
            $db_data[] = $row;
         }
         echo json_encode($db_data);
      }
      else{
         echo "error";
      }
      $conn->close();
      return;
   }
   if("GET_OPEN_ORDER_BY_TABLE" == $action){
      $db_data = array();
      $table = $_POST["table"];
      $sql = "SELECT id, `table`, `status`, price, printed, orderTime FROM orders WHERE `table`='$table' AND `status` = '0'";
      $result = $conn->query($sql);
      if($result->num_rows > 0){
         while($row = $result->fetch_assoc()){
            $db_data[] = $row;
         }
         echo json_encode($db_data);
      }
      else{
         echo "error";
      }
      $conn->close();
      return;
   }
   if("GET_ALL_OPEN_ORDERS_BY_ORDERID" == $action){
      $db_data = array();
      $orderId = $_POST["orderId"];
      $sql = "SELECT id, `table`, `status`, price, printed, orderTime FROM orders WHERE id= '$orderId' AND `status` = '0'";
      $result = $conn->query($sql);
      if($result->num_rows > 0){
         while($row = $result->fetch_assoc()){
            $db_data[] = $row;
         }
         echo json_encode($db_data);
      }
      else{
         echo "error";
      }
      $conn->close();
      return;
   }
   if("GET_ALL_ORDERITEMS_BY_ORDERID" == $action){
      $db_data = array();
      $orderId = $_POST["orderId"];
      $sql = "SELECT id, orderId, itemName, price, additionalIndigrends, `count`, payed, printed, countPayed FROM orderitems WHERE orderId= '$orderId'";
      $result = $conn->query($sql);
      if($result->num_rows > 0){
         while($row = $result->fetch_assoc()){
            $db_data[] = $row;
         }
         echo json_encode($db_data);
      }
      else{
         echo "error";
      }
      $conn->close();
      return;
   }
   if("INSERT_ORDER_ENTRIES" == $action){
      $db_data = array();
      $orderId = $_POST["orderId"];
      $itemName = $_POST["itemName"];
      $count = $_POST["count"];
      $additionalIndigrends = $_POST["additionalIndigrends"];
      $itemPrice = $_POST["itemPrice"];
      $id = $_POST["id"];
      $sql = "INSERT INTO barbossa.orderitems (id, orderId, itemName, `count`, price, additionalIndigrends) VALUES ('$id','$orderId','$itemName','$count','$itemPrice','$additionalIndigrends')";
      $result = $conn->query($sql);
      $conn->close();
      return;
   }
   if("UPDATE_ORDER_ENTRIES" == $action){
      $db_data = array();
      $id = $_POST["id"];
      $price = $_POST["price"];
      $count = $_POST["count"];
      $payed = $_POST["payed"];
      $printed = $_POST["printed"];
      $countPayed = $_POST["countPayed"];
      $sql = "UPDATE barbossa.orderitems SET price = '$price', `count`='$count', payed='$payed', printed='$printed',countPayed='$countPayed' WHERE id = '$id'";
      $result = $conn->query($sql);
      $conn->close();
      return;
   }
   if("UPDATE_ORDER_ENTRIES_WITHOUT_COUNT" == $action){
      $db_data = array();
      $id = $_POST["id"];
      $price = $_POST["price"];
      $payed = $_POST["payed"];
      $printed = $_POST["printed"];
      $countPayed = $_POST["countPayed"];
      $sql = "UPDATE barbossa.orderitems SET price = '$price', payed='$payed', printed='$printed',countPayed='$countPayed' WHERE id = '$id'";
      $result = $conn->query($sql);
      $conn->close();
      return;
   }
   if("MAKE_ORDER" == $action){
      $db_data = array();
      $id = $_POST["id"];
      $table = $_POST["table"];
      $status = $_POST["status"];
      $orderTime = $_POST["orderTime"];
      $price = $_POST["price"];
      $sql = "INSERT INTO barbossa.orders (id, `table`, status, orderTime, price) VALUES ('$id','$table','$status','$orderTime','$price')";
      $result = $conn->query($sql);
      $conn->close();
      return;
   }
   if("UPDATE_ORDER" == $action){
      $db_data = array();
      $id = $_POST["id"];
      $table = $_POST["table"];
      $orderTime = $_POST["orderTime"];
      $price = $_POST["price"];
      $status = $_POST["status"];
      $printed = $_POST["printed"];
      $sql = "UPDATE barbossa.orders SET orderTime= '$orderTime', price= '$price', status= '$status', printed= '$printed' WHERE id = '$id'";
      $result = $conn->query($sql);
      $conn->close();
      return;
   }
   if("INSERT_DEVICE" == $action){
      $db_data = array();
      $userId = $_POST["userId"];
      $orderId = $_POST["orderId"];
      $sql = "INSERT INTO barbossa.devices (userId, orderId) VALUES ('$userId','$orderId')";
      $result = $conn->query($sql);
      $conn->close();
      return;
   }
   if("GET_ORDERS_BY_USERID" == $action){
      $db_data = array();
      $userId = $_POST["userId"];
      $sql = "SELECT userId, orderId FROM devices WHERE userId= '$userId'";
      $result = $conn->query($sql);
      if($result->num_rows > 0){
         while($row = $result->fetch_assoc()){
            $db_data[] = $row;
         }
         echo json_encode($db_data);
      }
      else{
         echo "error";
      }
      $conn->close();
      return;
   }
   if("DELETE_DEVICE" == $action){
      $db_data = array();
      $userId = $_POST["userId"];
      $orderId = $_POST["orderId"];
      $sql = "DELETE FROM barbossa.devices WHERE userId='$userId' AND orderID= '$orderId'";
      $result = $conn->query($sql);
      $conn->close();
      return;
   }