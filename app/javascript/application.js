// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

// Initialize Bootstrap
document.addEventListener("turbo:load", () => {
  // Initialize all tooltips
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })

  // Initialize all popovers
  var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
  })

  // Initialize all dropdowns
  var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'))
  dropdownElementList.map(function (dropdownToggleEl) {
    return new bootstrap.Dropdown(dropdownToggleEl)
  })

  // Initialize all collapsible elements (including the mobile nav)
  var collapseElementList = [].slice.call(document.querySelectorAll('.collapse'))
  collapseElementList.map(function (collapseEl) {
    return new bootstrap.Collapse(collapseEl, {
      toggle: false
    })
  })

  var accordionElement = document.querySelector('#orderAccordion');
  if (accordionElement) {
    var collapse = new bootstrap.Collapse(accordionElement, {
      toggle: false
    });
  }
})

const application = Application.start()

// Import controllers manually
import DropzoneController from "./controllers/dropzone_controller"

// Register controllers manually
application.register("dropzone", DropzoneController)

// Add any other controllers you have in a similar manner
// application.register("other-controller", OtherController)

console.log("Stimulus loaded");
