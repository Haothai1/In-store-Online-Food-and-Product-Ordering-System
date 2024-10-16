console.log("Search controller file loaded");

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "query", "list" ]

  connect() {
    console.log("Search controller connected")
    this.products = window.products
    console.log("Products loaded:", this.products)
  }

  perform() {
    debugger; // Add this line
    console.log("Perform method called")
    const query = this.queryTarget.value.toLowerCase()
    console.log("Search query:", query)
    const filteredProducts = this.products.filter(product => 
      product.name.toLowerCase().includes(query) || 
      product.description.toLowerCase().includes(query)
    )
    console.log("Filtered products:", filteredProducts)
    this.updateTable(filteredProducts)
  }

  updateTable(products) {
    console.log("Updating table with", products.length, "products")
    const rows = products.map(product => `
      <tr data-product-id="${product.id}">
        <td>${product.name}</td>
        <td>${product.description}</td>
        <td>${this.formatCurrency(product.price)}</td>
        <td>${product.category}</td>
        <td>${product.stock_quantity}</td>
        <td><a href="/products/${product.id}">Show</a></td>
        <td><a href="/products/${product.id}/edit">Edit</a></td>
        <td>
          <form action="/products/${product.id}" method="post" data-confirm="Are you sure?">
            <input type="hidden" name="_method" value="delete">
            <input type="submit" value="Destroy">
          </form>
        </td>
      </tr>
    `).join('')

    this.listTarget.innerHTML = rows
  }

  formatCurrency(amount) {
    return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(amount)
  }
}
