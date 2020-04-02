changeStatus = function(parse_item_id){
  if (id == parse_item_id){
    $.ajax({
      method: "POST",
      url: `/parse_items/${id}/change_status`,
      dataType: 'json',
      success: function(data){
        parse_item = $(`.parse-item[data-id=${data.id}] .parse-item__status`)
        $(parse_item).fadeOut("slow")
        $(parse_item).text("Viewed")
        $(parse_item).removeClass("text-warning").addClass("text-primary")
        $(parse_item).fadeIn("fast")
        id = 0
        if (data.count_new_items == 0){
          bellOff()
        }
        console.log(data)
        bellItemChange(data.count_new_items)
      }
    })
  }
}

function bellOff(){
  let bell = document.querySelector('.fa-bell')
  bell.classList.remove("text-warning")
  bell.classList.add("text-secondary")
}

function bellItemChange(count_new_items){
  let bell = document.querySelector('.fa-bell')
  $(bell).attr({"data-content": `New items: ${count_new_items}`})
}


function initEventParseItem(){
  id = 0;
  $(".parse-item").mouseover(function(){
    hoverTime = 2000
    if(id == 0){
      id = $(this).data("id")
      new_id = id
      t = setTimeout('changeStatus(new_id)', hoverTime)
    }
  })
  $(".parse-item").mouseout(function(){
    id = 0
  })
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
  options = {
    html: true,
  }  
  $('[data-toggle="popover"]').popover(options)
  $('[data-toggle="popover"]').on('shown.bs.popover', function () {
    $('.btn-sign-out-js').attr({"data-method": "delete"})
  })
}

function initReadMoreLink(){
  $(".read-more-js").click(function(event){
    console.log("click more more")
    //event.preventDefault()
    let card = $(this).closest(".card")
    let body = $(card).find(".card-body")
    console.log(body)
    console.log(body.offsetHeight)

    $(body).animate({
      height: body.scrollHeight
    }, 1000)
    
  })
}

function initTestParse(){
  $('.test-parse-js').on("ajax:success", function(event){
    [data, status, xhr] = event.detail
    $('body').append(data.content)
  })
}

// function initSearchForm() {
//   $('.search-js').submit(function(event){
//     event.preventDefault();
//     const formData = new FormData(this);
//     $.ajax({
//       method: "GET",
//       dataType: 'json',
//       url: "/",
//       data: { search: formData.get("search")},
//       success: function(data) {
//         $('.parse-items').replaceWith(data.content)
//       }
//     })
//   })
// }

function initSearchForm() {
  $('.search-form').change(function(event) {
    const formData = new FormData(this);
    $.ajax({
      method: "GET",
      dataType: 'json',
      url: "/",
      data: { title: formData.get("title"), 
              created_at: formData.get("created_at"),
              chosen: formData.get("chosen"),
              status: formData.get("status")},
      success: function(data) {
        $('.parse-items').replaceWith(data.content)
      }
    })
  })
}

function initOpenSeachForm() {
  $('.btn-open-search').click(() => {
    $('.search-form').fadeIn();
  });
}

function initStarEvent(){
  $('.star-js').click((e) => {
    pi = $(e.target).closest('.parse-item');
    parseItemId = $(pi).data("id");
    $.ajax({
      method: 'POST',
      url: `parse_items/${parseItemId}/chosen`,
      dataType: 'json',
      success: function(data){
        parse_item = $(`.parse-item[data-id=${data.id}] .parse-item__status`);
        star = $(parse_item).find('.star-js');
        console.log(data)
        if (data.chosen) {
          star.addClass('.star-js_chosen');
        }
        else {
          star.removeClass('.star-js_chosen');
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

function initUpload() {
  if (document.querySelector('.custom-file-input'))
    document.querySelector('.custom-file-input').addEventListener("change", function() {
      this.nextElementSibling.innerText = this.files[0].name;
      readUrl(this);
    })
}

function readUrl(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function(e) {
      $('.current-image').hide();
      console.log(e.target.result);
      $('.file-upload-image').attr('src', e.target.result);
    };

    reader.readAsDataURL(input.files[0]);
  }
}

function initDatePicker() {
  $('#datepicker').datepicker({
    onSelect: function(formattedData, date, inst) {
      $('.search-form').change();
    }
  });
}

initEvents = function() {
  initEventParseItem();
  initEventButtonUp();
  initPopper();
  initTestParse();
  initSearchForm();
  initOpenSeachForm();
  initStarEvent();
  initTariffBuyEvent();
  initUpload();
  initDatePicker();
  // initSubmitStripe();

  setTimeout(() => {
    $('.alert').fadeOut("slow");
  }, 4000);
}

$(document).ready(initEvents);
$(document).on("turbolinks:load", initEvents);


