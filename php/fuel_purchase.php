<?php
include('db_connect.php');

class FuelPurchase {
    var $id = null;
    var $provider_name = null;
    var $purchase_volume = null;
    var $purchase_date = null;
    var $purchase_price = null;
    var $branch_name = null;

    function __construct($id, $provider_name, $purchase_volume, $purchase_date, $purchase_price, $branch_name) {
        $this->id = $id;
        $this->provider_name = $provider_name;
        $this->purchase_volume = $purchase_volume;
        $this->purchase_date = $purchase_date;
        $this->purchase_price = $purchase_price;
        $this->branch_name = $branch_name;
    }
}

class Branch {
    var $code = null;
    var $name = null;

    function __construct($code, $name) {
        $this->code = $code;
        $this->name = $name;
    }
}

class Provider {
    var $code = null;
    var $name = null;

    function __construct($code, $name) {
        $this->code = $code;
        $this->name = $name;
    }
}

$data_array = array();
$data = null;

if (isset($_GET['type']) && $_GET['type'] == 'get_purchase_rows') {
    $sql = "SELECT * FROM `fuel_purchase` ORDER BY `purchase_code`";
    if ($result = mysqli_query($link, $sql)) {
        foreach($result as $row) {  
            $purchase_code = intval($row['purchase_code']);
            $branch_code = intval($row['branch_code']);
            $provider_code = intval($row['provider_code']);
            $purchase_volume = intval($row['purchase_volume']);
            $purchase_price = intval($row['purchase_price']);

            $select_branch_name = "SELECT `branch_name` FROM `branch` WHERE `branch_code`=$branch_code";
            if ($res = mysqli_query($link, $select_branch_name))
                $branch_name = [$branch_code, $res->fetch_row()[0]];
            else echo json_encode("Ошибка: " . mysqli_error($link));;

            $select_provider_name = "SELECT `provider_name` FROM `fuel_provider` WHERE `provider_code`=$provider_code";
            if ($res = mysqli_query($link, $select_provider_name))
                $provider_name = [$provider_code, $res->fetch_row()[0]];
            else echo json_encode("Ошибка: " . mysqli_error($link));;

            $data = new FuelPurchase($purchase_code, $provider_name, $purchase_volume, $row['purchase_date'], $purchase_price, $branch_name);
            array_push($data_array, $data);
        }
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }

    header('Content-type: application/json');
    echo json_encode($data_array);

} else if (isset($_GET['type']) && $_GET['type'] == 'get_provider_list') {
    $companies = "SELECT * FROM `fuel_provider` ORDER BY `provider_code`";

    if($result = mysqli_query($link, $companies)){
        foreach($result as $row){
            $data = new Provider($row["provider_code"], $row["provider_name"]);
            array_push($data_array, $data);
        }
    }
    else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    header('Content-type: application/json');
    echo json_encode($data_array);

} else if (isset($_GET['type']) && $_GET['type'] == 'get_branch_list') {
    $companies = "SELECT * FROM `branch` ORDER BY `branch_code`";

    if($result = mysqli_query($link, $companies)){
        foreach($result as $row){
            $data = new Branch($row["branch_code"], $row["branch_name"]);
            array_push($data_array, $data);
        }
    }
    else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    header('Content-type: application/json');
    echo json_encode($data_array);

} else if (isset($_POST['type']) && $_POST['type'] == 'add' && isset($_POST['provider_code']) && isset($_POST['purchase_volume']) && isset($_POST['purchase_date']) && isset($_POST['purchase_price']) && isset($_POST['branch_code'])) {
    $received_provider_code = $_POST["provider_code"];
    $received_purchase_volume = $_POST["purchase_volume"];
    $received_purchase_date = mysqli_real_escape_string($link, $_POST["purchase_date"]);
    $received_purchase_price = $_POST["purchase_price"];
    $received_branch_code = $_POST["branch_code"];

    $sql = "INSERT INTO `fuel_purchase` (provider_code, purchase_volume, purchase_date, purchase_price, branch_code) VALUES ('$received_provider_code', '$received_purchase_volume', '$received_purchase_date', '$received_purchase_price', '$received_branch_code')";
    if(mysqli_query($link, $sql)){
        header('Content-type: application/json');
        echo json_encode('success');
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    mysqli_close($link);
} else if (isset($_POST['delete_code'])) {
    $select_purchase = $_POST["delete_code"];
    $sql = "DELETE FROM `fuel_purchase` WHERE `purchase_code` = '$select_purchase'";
    if(mysqli_query($link, $sql)){
        header('Content-type: application/json');
        echo json_encode('success');
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    mysqli_close($link);

} else if (isset($_POST['type']) && $_POST['type'] == 'update' && isset($_POST['purchase_id']) && isset($_POST['provider_code']) && isset($_POST['purchase_volume']) && isset($_POST['purchase_date']) && isset($_POST['purchase_price']) && isset($_POST['branch_code'])) {
    $received_purchase_code = $_POST["purchase_id"];
    $received_provider_code = $_POST["provider_code"];
    $received_purchase_volume = $_POST["purchase_volume"];
    $received_purchase_date = mysqli_real_escape_string($link, $_POST["purchase_date"]);
    $received_purchase_price = $_POST["purchase_price"];
    $received_branch_code = $_POST["branch_code"];

    $sql = "UPDATE `fuel_purchase` SET `provider_code` = '$received_provider_code', `purchase_volume` = '$received_purchase_volume', `purchase_date` = '$received_purchase_date', `purchase_price` = '$received_purchase_price', `branch_code` = '$received_branch_code' WHERE `purchase_code` = '$received_purchase_code'";
    if(mysqli_query($link, $sql)){
        header('Content-type: application/json');
        echo json_encode('suck');
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    mysqli_close($link);
}