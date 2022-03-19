function updateTableRows() {
    return new Promise((resolve, reject) => {
        let vars_names = ['branch_name', 'full_name_director', 'branch_address', 'branch_phone', 'company_name'];
        $.ajax({
            type:"GET",
            url: "php/branch.php",
            data: {type: 'get_branch_rows'},
            datatype: "json",
            success: function(data, textStatus, xhr) {
                $('#table-rows').html("");    
                for (let i = 0, len = data.length; i < len; i++) {
                    let row = $('<tr/>');
                    for (let j = 0; j < 5; j++) {
                        let cell = $('<td/>');
                        cell.html(data[i][vars_names[j]]);
                        row.append(cell);
                    }
                    let cell = $('<td/>');
                    cell.html('<div class="ud-buttons"> \
                            <button class="edit-button" type="submit" name="button_edit" value="' + data[i]['id'] + '">EDIT</button> \
                            <button class="delete-button" type="submit" name="button_delete" value="' + data[i]['id'] + '">DELETE</button> \
                    </div>');
                    row.append(cell);

                    $('#table-rows').append(row);
                }
                $('#count-rows').text(data.length);

                $.ajax({
                    type: "GET",
                    url: "php/branch.php",
                    data: {type: 'get_companies_list'},
                    datatype: "json",
                    success: function(data, textStatus, xhr) {
                        let select = $('<select name="add_company">');
                        for (let i = 0, len = data.length; i < len; i++) {
                            select.append('<option value="' + data[i]["code"] + '">' + data[i]["name"] + '</option>');
                        }
                        select.append('</select>');
                        $('#table-rows').append('<tr id="add_input"> \
                            <td><input type="text" size="20" name="add_branch_name" /></td> \
                            <td><input type="text" size="20" name="add_full_name_director" /></td> \
                            <td><input type="text" size="20" name="add_branch_address" /></td> \
                            <td><input type="text" size="15" name="add_branch_phone" /></td> \
                            <td>' + select.prop("outerHTML") + '</td> \
                            <td><button type="submit" id="button_add" name="add">ADD</button></td> \
                        </tr>')
                    }
                });
            }
        });
    })
}

$(document).ready(function() {
    updateTableRows();
});

$("#table-rows").on('click', "#button_add", function(e) {
    e.preventDefault();
    let branch_name = $("input[name*='add_branch_name']").val();
    let full_name_director = $("input[name*='add_full_name_director']").val();
    let branch_address = $("input[name*='add_branch_address']").val();
    let branch_phone = $("input[name*='add_branch_phone']").val();
    let company_code = $("select[name*='add_company']").val();

    $.ajax({
        type: "POST",
        url: "php/branch.php",
        data: {type: 'add', branch_name: branch_name, full_name_director: full_name_director, branch_address: branch_address, branch_phone: branch_phone, company_code: company_code},
        datatype: "json",
        success: function() {
            updateTableRows();
        }
    });
});

$("#table-rows").on('click', ".delete-button", function(e) {
    e.preventDefault();
    let delete_code = $(this).val()

    $.ajax({
        type: "POST",
        url: "php/branch.php",
        data: {delete_code: delete_code},
        datatype: "json",
        success: function() {
            updateTableRows();
        }
    });
});

$("#table-rows").on('click', ".edit-button", function(e) {
    e.preventDefault();
    let trs = $(this).closest('tr')[0].cells;
    let input_names = ['branch_name', 'full_name_director', 'branch_address', 'branch_phone'];
    for (let i = 0; i < trs.length-2; i++) {
        trs[i].innerHTML = '<input type="text" size="15" name="' + input_names[i] + '" value="' + trs[i].innerText +  '"/>';
    }
    $.ajax({
        type: "GET",
        url: "php/branch.php",
        data: {type: 'get_companies_list'},
        datatype: "json",
        success: function(data, textStatus, xhr) {
            let select = $('<select name="edit_company">');
            for (let i = 0, len = data.length; i < len; i++) {
                select.append('<option value="' + data[i]["code"] + '">' + data[i]["name"] + '</option>');
            }
            trs[trs.length-2].innerHTML = select.prop("outerHTML");
        }
    })

    $(this)[0].innerHTML = "UPDATE";
    $(this).attr('class', 'update-button');
    $(this).attr('name', 'button_update');
});

$("#table-rows").on('click', ".update-button", function(e) {
    e.preventDefault();
    let trs = $(this).closest('tr')[0].cells;
    let data = [];
    for (let i = 0; i < trs.length-1; i++) {
        data.push(trs[i].firstChild.value);
    }
    branch_id = $(this).val();
    $.ajax({
        type: "POST",
        url: "php/branch.php",
        data: {type: 'update', branch_id: branch_id, branch_name: data[0], full_name_director: data[1], branch_address: data[2], branch_phone: data[3], company_code: data[4]},
        datatype: "json",
        success: function(data) {
            updateTableRows();
        }
    });
});