
class Bell {
  constructor() {
    this.node = document.querySelector('.fa-bell');
    this.count = this.node.dataset.count;
  }

  turnOff() {
    this.node.classList.remove("text-warning");
    this.node.classList.add("text-secondary");
  }

  update() {
    $(this.node).attr({ "data-content": `New items: ${this.count}` });
    this.node.dataset.count = this.count;
    if (this.count == 0) {
      this.turnOff();
    }
    else {
      this.turnOn();
    }
  }

  decrease() {
    this.count = this.count - 1;
  }

  increase() {
    this.count = parseInt(this.count) + 1;
  }

  turnOn() {
    this.node.classList.remove("text-secondary");
    this.node.classList.add("text-warning");
  }
}

export default Bell;