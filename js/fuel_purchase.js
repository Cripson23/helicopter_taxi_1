function updateTableRows() {
    return new Promise((resolve, reject) => {
        let vars_names = ['provider_name', 'purchase_volume', 'purchase_date', 'purchase_price', 'branch_name'];
        $.ajax({
            type:"GET",
            url: "php/fuel_purchase.php",
            data: {type: 'get_purchase_rows'},
            datatype: "json",
            success: function(data, textStatus, xhr) {
                $('#table-rows').html("");    
                for (let i = 0, len = data.length; i < len; i++) {
                    let row = $('<tr/>');
                    for (let j = 0; j < 5; j++) {
                        if (j == 0 || j == 4) {
                            let cell = $('<td/>');
                            cell.attr('value', data[i][vars_names[j]][0]);
                            cell.html(data[i][vars_names[j]][1]);
                            row.append(cell);
                        } else {
                            let cell = $('<td/>');
                            cell.html(data[i][vars_names[j]]);
                            row.append(cell);
                        }
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
                    url: "php/fuel_purchase.php",
                    data: {type: 'get_provider_list'},
                    datatype: "json",
                    success: function(data, textStatus, xhr) {
                        let select = $('<select name="add_provider">');
                        for (let i = 0, len = data.length; i < len; i++) {
                            select.append('<option value="' + data[i]["code"] + '">' + data[i]["name"] + '</option>');
                        }
                        select.append('</select>');
                        $('#table-rows').append('<tr id="add_input"> \
                            <td>' + select.prop("outerHTML") + '</td>')
                        
                        $.ajax({
                            type: "GET",
                            url: "php/fuel_purchase.php",
                            data: {type: 'get_branch_list'},
                            datatype: "json",
                            success: function(data, textStatus, xhr) {
                                let select = $('<select name="add_branch">');
                                for (let i = 0, len = data.length; i < len; i++) {
                                    select.append('<option value="' + data[i]["code"] + '">' + data[i]["name"] + '</option>');
                                }
                                select.append('</select>');
                                $('#add_input').append('<td><input type="text" size="20" name="purchase_volume" /></td> \
                                    <td><input type="date" size="20" name="purchase_date" /></td> \
                                    <td><input type="text" size="15" name="purchase_price" /></td> \
                                    <td>' + select.prop("outerHTML") + '</td> \
                                    <td><button type="submit" id="button_add" name="add">ADD</button></td></tr>')
                            }
                        });
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
    let provider_code = $("select[name*='add_provider']").val();
    let purchase_volume = $("input[name*='purchase_volume']").val();
    let purchase_date = $("input[name*='purchase_date']").val();
    let purchase_price = $("input[name*='purchase_price']").val();
    let branch_code = $("select[name*='add_branch']").val();

    console.log(provider_code)

    $.ajax({
        type: "POST",
        url: "php/fuel_purchase.php",
        data: {type: 'add', provider_code: provider_code, purchase_volume: purchase_volume, purchase_date: purchase_date, purchase_price: purchase_price, branch_code: branch_code},
        datatype: "json",
        success: function(data) {
            console.log(data)
            updateTableRows();
        }
    });
});

$("#table-rows").on('click', ".delete-button", function(e) {
    e.preventDefault();
    let delete_code = $(this).val()
    $.ajax({
        type: "POST",
        url: "php/fuel_purchase.php",
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
    let input_names = ['provider_name', 'purchase_volume', 'purchase_date', 'purchase_price', 'branch_name'];
    for (let i = 1; i < trs.length-2; i++) {
        if (i != 2)
            trs[i].innerHTML = '<input type="text" size="15" name="' + input_names[i] + '" value="' + trs[i].innerText +  '"/>';
        else
            trs[i].innerHTML = '<input type="date" size="15" name="' + input_names[i] + '" value="' + trs[i].innerText +  '"/>';
    }

    $.ajax({
        type: "GET",
        url: "php/fuel_purchase.php",
        data: {type: 'get_provider_list'},
        datatype: "json",
        success: function(data, textStatus, xhr) {
            let select = $('<select name="edit_provider">');
            for (let i = 0, len = data.length; i < len; i++) {
                if (trs[0].attributes[0].value == data[i]["code"])
                    select.append('<option selected value="' + data[i]["code"] + '">' + data[i]["name"] + '</option>');
                else
                    select.append('<option value="' + data[i]["code"] + '">' + data[i]["name"] + '</option>');
            }
            trs[0].innerHTML = select.prop("outerHTML");
            
            $.ajax({
                type: "GET",
                url: "php/fuel_purchase.php",
                data: {type: 'get_branch_list'},
                datatype: "json",
                success: function(data, textStatus, xhr) {
                    let select = $('<select name="edit_branch">');
                    for (let i = 0, len = data.length; i < len; i++) {
                        if (trs[4].attributes[0].value == data[i]["code"])
                            select.append('<option selected value="' + data[i]["code"] + '">' + data[i]["name"] + '</option>');
                        else
                            select.append('<option value="' + data[i]["code"] + '">' + data[i]["name"] + '</option>');
                    }
                    trs[trs.length-2].innerHTML = select.prop("outerHTML");
                }
            });
        }
    });

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
    purchase_id = $(this).val();
    $.ajax({
        type: "POST",
        url: "php/fuel_purchase.php",
        data: {type: 'update', purchase_id: purchase_id, provider_code: data[0], purchase_volume: data[1], purchase_date: data[2], purchase_price: data[3], branch_code: data[4]},
        datatype: "json",
        success: function(data) {
            updateTableRows();
        }
    });
});