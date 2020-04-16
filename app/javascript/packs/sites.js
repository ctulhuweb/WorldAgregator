import Bell from './bell';
import * as upload from './custom_file_input';
import * as searchForm from './search_form';

var changeStatus = function (target) {
  const pi = $(target).closest('.parse-item');
  const parseItemId = $(pi).data("id");
  const siteId = $(pi).data("site-id");
  $.ajax({
    method: "PATCH",
    url: `sites/${siteId}/parse_items/${parseItemId}/change_status`,
    dataType: 'json',
    success: function(){
      let status = $(pi).find('.parse-item__status');
      $(status).fadeOut("slow");
      $(status).text("Viewed");
      $(status).removeClass("text-warning").addClass("text-primary");
      $(status).fadeIn("fast");
      let bell = new Bell();
      bell.decrease();
      bell.update();
    }
  })
}

function initEventParseItem(){
  $(".container").on("click", ".parse-item__status", function (e) {
    changeStatus(e.target);
  });
}

function initEventButtonUp(){
  let btnUp = document.querySelector(".btn-up")
  if (btnUp){
    btnUp.addEventListener("click", function(){
      $("html, body").animate({ scrollTop: "0" }, 1000);
    })

    $(window).scroll(function(){
      if ($(this).scrollTop() > 0){
        $(btnUp).fadeIn()
      }
      else{
        $(btnUp).fadeOut()
      }
    })
  }

}

function initPopper(){
  const options = {
    html: true,
  }  
  $('[data-toggle="popover"]').popover(options)
  $('[data-toggle="popover"]').on('shown.bs.popover', function () {
    $('.btn-sign-out-js').attr({"data-method": "delete"})
  })
}

function initTestParse() {
  $('.test-parse-js').on("click", function(event) {
    $.ajax({
      url: event.target.dataset.url,
      method: "GET",
      dataType: "json",
      success: function (data) {
        $('.left-column').append(data.content);
      }
    })
  });
}

function initStarEvent(){
  $('.container').on('click', '.star-js', (e) => {
    const pi = $(e.target).closest('.parse-item');
    const parseItemId = $(pi).data("id");
    const siteId = $(pi).data("site-id");
    $.ajax({
      method: 'PATCH',
      url: `sites/${siteId}/parse_items/${parseItemId}/chosen`,
      dataType: 'json',
      success: function () {
        let star = $(pi).find('.star-js');
        if (star.hasClass('fa-star_chosen')) {
          star.removeClass('fa-star_chosen');
        }
        else {
          star.addClass('fa-star_chosen');
        }
      }
    });
  });
}

function initTariffBuyEvent() {
  $('.buy-tariff-js').click(function() {
    const tariffTitle = $(this).data("tariff-title");   

    fetch(`/payment/checkout_session?tariff_title=${tariffTitle}`, {
      headers: {
        'Accept': "application/json",
        'Content-Type': "application/json"
      }
    })
    .then((response) => {
      response.json().then((data) => {
        console.log(data.ch_session.id);
        var stripe = Stripe('pk_test_27AjUighaL0Es18xRpHA57uD00e3Tt21ra');
        stripe.redirectToCheckout({
          sessionId: data.ch_session.id
        }).then(function (result) {
          console.log(result.error.message);
        });
      });
    });
  });
}

function initDatePicker() {
  $('#datepicker').datepicker({
    onSelect: function(formattedData, date, inst) {
      $('.search-form').change();
    }
  });
}

function htmlToElement(html) {
  var template = document.createElement('template');
  template.innerHTML = html;
  return template.content.firstChild;
}

function initShowMore() {
  $(".container").on("click", ".btn-show-more", function () {
    var btn = this;
    var data = searchForm.getSearchFormData();
    data["page"] = this.dataset.page;
    $.ajax({
      method: "GET",
      dataType: 'json',
      url: "/",
      data: data,
      success: function (data) {
        var container = document.querySelector('.container');
        $(btn.parentElement).remove();
        container.appendChild(htmlToElement(data.content));
      }
    });
  });
}

function initCocoon() {
  $('.add_fields').data("association-insertion-node", '.table.parse_fields tbody');
}

var initEvents = function() {
  initEventParseItem();
  initEventButtonUp();
  initPopper();
  initTestParse();
  searchForm.initSearchForm();
  searchForm.initOpenSeachForm();
  initStarEvent();
  initTariffBuyEvent();
  upload.initUpload();
  initDatePicker();
  initShowMore();
  initCocoon();
  setTimeout(() => {
    $('.alert, .notice').fadeOut("slow");
  }, 4000);
}
// $(document).ready(initEvents);
$(document).on("turbolinks:load", initEvents);


