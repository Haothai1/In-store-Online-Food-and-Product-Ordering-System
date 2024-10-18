import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["count", "item", "total"]

  connect() {
    console.log("Cart controller connected")
  }

  removeItem(event) {
    event.preventDefault()
    const itemId = event.params.id

    fetch(`/cart/remove_item/${itemId}`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Accept': 'application/json'
      },
    })
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        this.updateCartCount(data.cart_count)
        this.updateTotal(data.cart_total)
        event.target.closest('[data-cart-target="item"]').remove()
      }
    })
  }

  updateCartCount(count) {
    this.countTargets.forEach(el => el.textContent = count)
  }

  updateTotal(total) {
    if (this.hasTotalTarget) {
      this.totalTarget.textContent = total
    }
  }
}
