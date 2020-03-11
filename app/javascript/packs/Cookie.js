export default class Cookie {

  getCookie(name){
    var match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
    if (match) return match[2];
  }

  setCookie(name, value){

  }

  delete(name){

  }
}