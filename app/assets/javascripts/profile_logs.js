$(document).ready(function(){

    $('#select_profile_log').change(function () {
        var profile_id = $('#profile_id').val();
        var log_id = $(this).val();
        $.ajax({
            type: "GET",
            url: "/profiles/" + profile_id + "/profile_logs/" + log_id + "/detail",
            success:function(data){
                // alert (JSON.stringify(data))
                var paths = data.map(function(path) { return path.split('/'); });
                var result = stringify(structurize(paths)).join("\n");
                $("#treeProfile").text(result);

            },
            error:function(data) {
                alert ("Error: Can't retrieve data!")
            }
        });
    });

    $( "#select_profile_log" ).trigger( "change" );

});

function structurize(paths) {
    var items = [];
    for(var i = 0, l = paths.length; i < l; i++) {
        var path = paths[i];
        var name = path[0];
        var rest = path.slice(1);
        var item = null;
        for(var j = 0, m = items.length; j < m; j++) {
            if(items[j].name === name) {
                item = items[j];
                break;
            }
        }
        if(item === null) {
            item = {name: name, children: []};
            items.push(item);
        }
        if(rest.length > 0) {
            item.children.push(rest);
        }
    }
    for(i = 0, l = items.length; i < l; i++) {
        item = items[i];
        item.children = structurize(item.children);
    }
    return items;
}

function stringify(items) {
    var lines = [];
    for(var i = 0, l = items.length; i < l; i++) {
        var item = items[i];
        lines.push(item.name);
        var subLines = stringify(item.children);
        for(var j = 0, m = subLines.length; j < m; j++) {
            lines.push("  " + subLines[j]);
        }
    }
    return lines;
}