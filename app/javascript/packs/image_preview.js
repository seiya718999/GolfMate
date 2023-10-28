document.addEventListener("turbolinks:load", function() {
    const postImageInput = document.getElementById('post_image');
    const imagePreview = document.getElementById('image-preview');

    postImageInput.addEventListener('change', function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imagePreview.setAttribute('src', e.target.result);
                imagePreview.style.display = 'block';
            }
            reader.readAsDataURL(file);
        } else {
            imagePreview.style.display = 'none';
        }
    });
});