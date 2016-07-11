$(document).ready(function(){
    var animCount = 0;

    $(function() {
        doAnimation();
    });

    function doAnimation(){
        $('#title').animate({ left: 250},2000, function(){
             $('#title').animate({ left: 1},2000, function(){
                    setTimeout(doAnimation, 500);
              });
            animCount++;
        });
        
    }


    $("#flip").click(function(){
        $("#table1").slideToggle("slow");
    });


    $('form').submit(function(e){
        e.preventDefault();
        $('form > input[type="submit"]').val('Submitting...');
        $('form > input[type="submit"]').attr('disabled', true);
        $.ajax({
            method: 'post',
            url: '/urls',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(data){ //hash = { short_url: @url.short_url, long_url: @url.long_url, message: "Its done for u, Bro!" }
                $('form > input[type="submit"]').val('Shorten');
                $('form > input[type="submit"]').attr('disabled', false);
                link = "<a href='/" + data.short_url + "'>" + data.short_url + '</a>';
                $('#table1').append('<tr><td>' + data.long_url + '</td><td>' + link + '</td></tr>');
                $('p.center').html(data.message);
            },
            error: function(data){
                $('form > input[type="submit"]').val('Shorten');
                $('form > input[type="submit"]').attr('disabled', false);
                obj = JSON.parse(data.responseText);
                $('p.center').html(obj.message);
            }
        });
    });
});