export function initUpload() {
  if (document.querySelector('.custom-file-input'))
    document.querySelector('.custom-file-input').addEventListener("change", function () {
      this.nextElementSibling.innerText = this.files[0].name;
      readUrl(this);
    })
}

function readUrl(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      $('.current-image').hide();
      $('.file-upload-image').attr('src', e.target.result);
    };

    reader.readAsDataURL(input.files[0]);
  }
}