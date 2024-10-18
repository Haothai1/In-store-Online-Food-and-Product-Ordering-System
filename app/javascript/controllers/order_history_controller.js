import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["order"]

  connect() {
    console.log("Order history controller connected")
  }

  removeOrder(event) {
    event.preventDefault()
    const orderId = event.params.id

    fetch(`/order_history/${orderId}`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Accept': 'application/json'
      },
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        event.target.closest('[data-order-history-target="order"]').remove()
      } else {
        alert(data.error)
      }
    })
  }
}
