window.onload = function() {
  initButtonEvents();
}

function initButtonEvents() {
  $('.stripe-add-plan').click(() => {
    const tariffId = document.querySelector(".stripe-actions").dataset.id;
    fetch(`/rails_admin/tariff/${tariffId}/stripe/add`, {
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json'
      }
    }).then((response) => {
      return response.json();
    }).then((data) => {
      const info = $('.stripe-info');
      $(info).removeClass("alert-info");
      $(info).addClass("alert-success");
      $(info).text(data.message);
    })
  })
}