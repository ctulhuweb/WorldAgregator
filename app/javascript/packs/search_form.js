export function initSearchForm() {
  $('.search-form').change(function (event) {
    $.ajax({
      method: "GET",
      dataType: 'json',
      url: "/",
      data: getSearchFormData(),
      success: function (data) {
        $('.parse-items').replaceWith(data.content)
      }
    })
  })
}

export function getSearchFormData() {
  const form = document.querySelector(".search-form");
  const formData = new FormData(form);
  const data = {
    search: {
      title: formData.get("title"),
      created_at: formData.get("created_at"),
      chosen: formData.get("chosen"),
      status: formData.get("status")
    }
  }
  return data;
}

export function initOpenSeachForm() {
  $('.btn-open-search').click(() => {
    $('.search-form').fadeToggle();
  });
}