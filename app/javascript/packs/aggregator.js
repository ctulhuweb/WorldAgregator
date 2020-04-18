class Aggregator {
  handleClickCard(e) {
    let target = e.target;
    const id = target.closest(".aggregator").dataset.id
    if (target.classList.contains("action_edit")) {
      window.location.href = `/aggregators/${id}/edit`
    } else if (target.classList.contains("action_delete")) {
      this.handleClickDelete(target);
    } else {
      window.location.href = `/aggregators/${id}/sites`;
    }
    
  }

  handleClickDelete(target) {
    let id = target.closest(".aggregator").dataset.id
    $.ajax({
      method: "DELETE",
      url: `aggregators/${id}`,
      dataType: "json",
      success: (e) => {
        $(target.closest(".col-3")).fadeOut();
      }
    });
  }

  initEvents() {
    $('.aggregators').on('click', '.aggregator', (e) => { this.handleClickCard(e); });
  }
}

export default Aggregator;