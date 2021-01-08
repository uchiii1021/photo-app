document.addEventListener("turbolinks:load", function () {
  $(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
    $('#photo_prev').attr('src', e.target.result);
    $('#user_prev').attr('src', e.target.result);
    $('#category_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $('#field-image').change(function(){
        readURL(this);
    });
  });
});
