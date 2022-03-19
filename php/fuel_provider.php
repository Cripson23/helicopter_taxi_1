<?php
include('db_connect.php');

class FuelProvider {
    var $id = null;
    var $provider_name = null;
    var $full_name_director = null;
    var $provider_address = null;
    var $provider_phone = null;
    var $branch_name = null;

    function __construct($id, $provider_name, $full_name_director, $provider_address, $provider_phone, $branch_name) {
        $this->id = $id;
        $this->provider_name = $provider_name;
        $this->full_name_director = $full_name_director;
        $this->provider_address = $provider_address;
        $this->provider_phone = $provider_phone;
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

$data_array = array();
$data = null;

if (isset($_GET['type']) && $_GET['type'] == 'get_provider_rows') {
    $sql = "SELECT * FROM `fuel_provider` ORDER BY `provider_code`";
    if ($result = mysqli_query($link, $sql)) {
        foreach($result as $row) {  
            $provider_code = intval($row['provider_code']);
            $branch_code = intval($row['branch_code']);
            $select_branch_name = "SELECT `branch_name` FROM `branch` WHERE `branch_code`=$branch_code";
            
            if ($res = mysqli_query($link, $select_branch_name))
                $branch_name = $res->fetch_row()[0];
            else echo json_encode("Ошибка: " . mysqli_error($link));;
            $data = new FuelProvider($provider_code, $row['provider_name'], $row['full_name_director'], $row['provider_address'], $row['provider_phone'], $branch_name);
            array_push($data_array, $data);
        }
    } else {
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

} else if (isset($_POST['type']) && $_POST['type'] == 'add' && isset($_POST['provider_name']) && isset($_POST['full_name_director']) && isset($_POST['provider_address']) && isset($_POST['provider_phone']) && isset($_POST['branch_code'])) {
    $received_provider_name = mysqli_real_escape_string($link, $_POST["provider_name"]);
    $received_full_name_director = mysqli_real_escape_string($link, $_POST["full_name_director"]);
    $received_provider_address = mysqli_real_escape_string($link, $_POST["provider_address"]);
    $received_provider_phone = mysqli_real_escape_string($link, $_POST["provider_phone"]);
    $received_branch_code = $_POST["branch_code"];

    $sql = "INSERT INTO `fuel_provider` (provider_name, provider_address, provider_phone, full_name_director, branch_code) VALUES ('$received_provider_name', '$received_provider_address', '$received_provider_phone', '$received_full_name_director', '$received_branch_code')";
    if(mysqli_query($link, $sql)){
        header('Content-type: application/json');
        echo json_encode('success');
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    mysqli_close($link);

} else if (isset($_POST['delete_code'])) {
    $select_provider = $_POST["delete_code"];
    $sql = "DELETE FROM `fuel_provider` WHERE `provider_code` = '$select_provider'";
    if(mysqli_query($link, $sql)){
        header('Content-type: application/json');
        echo json_encode('success');
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    mysqli_close($link);

} else if (isset($_POST['type']) && $_POST['type'] == 'update' && isset($_POST['provider_name']) && isset($_POST['provider_id']) && isset($_POST['full_name_director']) && isset($_POST['provider_address']) && isset($_POST['provider_phone']) && isset($_POST['branch_code'])) {
    $received_provider_name = mysqli_real_escape_string($link, $_POST["provider_name"]);
    $received_full_name_director = mysqli_real_escape_string($link, $_POST["full_name_director"]);
    $received_provider_address = mysqli_real_escape_string($link, $_POST["provider_address"]);
    $received_provider_phone = mysqli_real_escape_string($link, $_POST["provider_phone"]);
    $received_branch_code = $_POST["branch_code"];
    $received_provider_code = $_POST["provider_id"];

    $sql = "UPDATE `fuel_provider` SET `provider_name` = '$received_provider_name', `provider_address` = '$received_provider_address', `provider_phone` = '$received_provider_phone', `full_name_director` = '$received_full_name_director', `branch_code` = '$received_branch_code' WHERE `provider_code` = '$received_provider_code'";
    if(mysqli_query($link, $sql)){
        header('Content-type: application/json');
        echo json_encode('suck');
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    mysqli_close($link);
}

?>