<?php
include('db_connect.php');

class Branch {
    var $id = null;
    var $branch_name = null;
    var $full_name_director = null;
    var $branch_address = null;
    var $branch_phone = null;
    var $company_name = null;

    function __construct($id, $branch_name, $full_name_director, $branch_address, $branch_phone, $company_name) {
        $this->id = $id;
        $this->branch_name = $branch_name;
        $this->full_name_director = $full_name_director;
        $this->branch_address = $branch_address;
        $this->branch_phone = $branch_phone;
        $this->company_name = $company_name;
    }
}

class Company {
    var $code = null;
    var $name = null;

    function __construct($code, $name) {
        $this->code = $code;
        $this->name = $name;
    }
}

$data_array = array();
$data = null;

if (isset($_GET['type']) && $_GET['type'] == 'get_branch_rows') {
    $sql = "SELECT * FROM `branch` ORDER BY `branch_code`";
    if ($result = mysqli_query($link, $sql)) {
        foreach($result as $row) {  
            $branch_code = intval($row['branch_code']);
            $company_code = intval($row['company_code']);
            $select_company_name = "SELECT `company_name` FROM `company` WHERE `company_code`=$company_code";
            
            if ($res = mysqli_query($link, $select_company_name))
                $company_name = $res->fetch_row()[0];
            else echo json_encode("Ошибка: " . mysqli_error($link));;
            $data = new Branch($branch_code, $row['branch_name'], $row['full_name_director'], $row['branch_address'], $row['branch_phone'], $company_name);
            array_push($data_array, $data);
        }
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }

    header('Content-type: application/json');
    echo json_encode($data_array);

} else if (isset($_GET['type']) && $_GET['type'] == 'get_companies_list') {
    $companies = "SELECT * FROM `company` ORDER BY `company_code`";

    if($result = mysqli_query($link, $companies)){
        foreach($result as $row){
            $data = new Company($row["company_code"], $row["company_name"]);
            array_push($data_array, $data);
        }
    }
    else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    header('Content-type: application/json');
    echo json_encode($data_array);

} else if (isset($_POST['type']) && $_POST['type'] == 'add' && isset($_POST['branch_name']) && isset($_POST['full_name_director']) && isset($_POST['branch_address']) && isset($_POST['branch_phone']) && isset($_POST['company_code'])) {
    $received_branch_name = mysqli_real_escape_string($link, $_POST["branch_name"]);
    $received_full_name_director = mysqli_real_escape_string($link, $_POST["full_name_director"]);
    $received_branch_address = mysqli_real_escape_string($link, $_POST["branch_address"]);
    $received_branch_phone = mysqli_real_escape_string($link, $_POST["branch_phone"]);
    $received_company_code = $_POST["company_code"];

    $sql = "INSERT INTO `branch` (branch_name, branch_address, branch_phone, full_name_director, company_code) VALUES ('$received_branch_name', '$received_branch_address', '$received_branch_phone', '$received_full_name_director', '$received_company_code')";
    if(mysqli_query($link, $sql)){
        header('Content-type: application/json');
        echo json_encode('success');
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    mysqli_close($link);

} else if (isset($_POST['delete_code'])) {
    $select_branch = $_POST["delete_code"];
    $sql = "DELETE FROM `branch` WHERE `branch_code` = '$select_branch'";
    if(mysqli_query($link, $sql)){
        header('Content-type: application/json');
        echo json_encode('success');
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    mysqli_close($link);

} else if (isset($_POST['type']) && $_POST['type'] == 'update' && isset($_POST['branch_name']) && isset($_POST['branch_id']) && isset($_POST['full_name_director']) && isset($_POST['branch_address']) && isset($_POST['branch_phone']) && isset($_POST['company_code'])) {
    $received_branch_name = mysqli_real_escape_string($link, $_POST["branch_name"]);
    $received_full_name_director = mysqli_real_escape_string($link, $_POST["full_name_director"]);
    $received_branch_address = mysqli_real_escape_string($link, $_POST["branch_address"]);
    $received_branch_phone = mysqli_real_escape_string($link, $_POST["branch_phone"]);
    $received_company_code = $_POST["company_code"];
    $received_branch_code = $_POST["branch_id"];

    $sql = "UPDATE `branch` SET `branch_name` = '$received_branch_name', `branch_address` = '$received_branch_address', `branch_phone` = '$received_branch_phone', `full_name_director` = '$received_full_name_director', `company_code` = '$received_company_code' WHERE `branch_code` = '$received_branch_code'";
    if(mysqli_query($link, $sql)){
        header('Content-type: application/json');
        echo json_encode('suck');
    } else {
        echo json_encode("Ошибка: " . mysqli_error($link));
    }
    mysqli_close($link); 
}

?>