export function initSearchForm() {
  $('.search-form, .aggr-selector').change(function (event) {
    let data = getSearchFormData();
    data["aggregator_id"] = document.querySelector('.aggr-selector').value;
    $.ajax({
      method: "GET",
      dataType: 'json',
      url: "/",
      data: data,
      success: function (data) {
        $('.parse-items').replaceWith(data.content)
      }
    });
  });
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