import { Controller } from "@hotwired/stimulus"
// show cart count in the header
export default class extends Controller {
  static targets = [ "count" ]

  connect() {
    console.log("Cart controller connected")
  }

  updateCount(event) {
    const [data, status, xhr] = event.detail
    if (this.hasCountTarget) {
      this.countTarget.innerHTML = data
    }
  }
}
