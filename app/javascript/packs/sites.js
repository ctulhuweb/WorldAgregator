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
    console.log(data.content)
    $('body').append(data.content)
  })
}

function initSearchForm(){
  $('.search-js').on("ajax:success", function(event){
    [data, status, xhr] = event.detail
    console.log(data)
    $('.parse-items').replaceWith(data.content)
  })
}

function initStarEvent(){
  $('.star-js').click((e) => {
    pi = $(e.target).closest('.parse-item');
    parseItemId = $(pi).data("id");
    $.ajax({
      method: 'POST',
      url: `parse_items/${parseItemId}/chosen`,
      
    });
  });
}

$(document).ready(function(){ 
  initEventParseItem();
  initEventButtonUp();
  initPopper();
  initTestParse();
  initSearchForm();
  initStarEvent();
  //initReadMoreLink()
});
