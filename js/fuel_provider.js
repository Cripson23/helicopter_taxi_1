function updateTableRows() {
    return new Promise((resolve, reject) => {
        let vars_names = ['provider_name', 'full_name_director', 'provider_address', 'provider_phone', 'branch_name'];
        $.ajax({
            type:"GET",
            url: "php/fuel_provider.php",
            data: {type: 'get_provider_rows'},
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
                    url: "php/fuel_provider.php",
                    data: {type: 'get_branch_list'},
                    datatype: "json",
                    success: function(data, textStatus, xhr) {
                        let select = $('<select name="add_branch">');
                        for (let i = 0, len = data.length; i < len; i++) {
                            select.append('<option value="' + data[i]["code"] + '">' + data[i]["name"] + '</option>');
                        }
                        select.append('</select>');
                        $('#table-rows').append('<tr id="add_input"> \
                            <td><input type="text" size="20" name="add_provider_name" /></td> \
                            <td><input type="text" size="20" name="add_full_name_director" /></td> \
                            <td><input type="text" size="20" name="add_provider_address" /></td> \
                            <td><input type="text" size="15" name="add_provider_phone" /></td> \
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
    let provider_name = $("input[name*='add_provider_name']").val();
    let full_name_director = $("input[name*='add_full_name_director']").val();
    let provider_address = $("input[name*='add_provider_address']").val();
    let provider_phone = $("input[name*='add_provider_phone']").val();
    let branch_code = $("select[name*='add_branch']").val();

    $.ajax({
        type: "POST",
        url: "php/fuel_provider.php",
        data: {type: 'add', provider_name: provider_name, full_name_director: full_name_director, provider_address: provider_address, provider_phone: provider_phone, branch_code: branch_code},
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
        url: "php/fuel_provider.php",
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
    let input_names = ['provider_name', 'full_name_director', 'provider_address', 'provider_phone', 'branch_name'];
    for (let i = 0; i < trs.length-2; i++) {
        trs[i].innerHTML = '<input type="text" size="15" name="' + input_names[i] + '" value="' + trs[i].innerText +  '"/>';
    }
    $.ajax({
        type: "GET",
        url: "php/fuel_provider.php",
        data: {type: 'get_branch_list'},
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
    provider_id = $(this).val();
    $.ajax({
        type: "POST",
        url: "php/fuel_provider.php",
        data: {type: 'update', provider_id: provider_id, provider_name: data[0], full_name_director: data[1], provider_address: data[2], provider_phone: data[3], branch_code: data[4]},
        datatype: "json",
        success: function(data) {
            updateTableRows();
        }
    });
});