import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "preview" ]

  connect() {
    console.log("Dropzone controller connected")
    this.bindEvents()
  }

  bindEvents() {
    this.element.addEventListener('dragover', this.dragOver.bind(this))
    this.element.addEventListener('dragleave', this.dragLeave.bind(this))
    this.element.addEventListener('drop', this.drop.bind(this))
  }

  dragOver(e) {
    e.preventDefault()
    this.element.classList.add('drag-over')
  }

  dragLeave(e) {
    e.preventDefault()
    this.element.classList.remove('drag-over')
  }

  drop(e) {
    e.preventDefault()
    this.element.classList.remove('drag-over')
    const files = e.dataTransfer.files
    this.handleFiles(files)
  }

  handleFiles(files) {
    Array.from(files).forEach(file => {
      if (file.type.startsWith('image/')) {
        this.previewFile(file)
        this.uploadFile(file)
      }
    })
  }

  previewFile(file) {
    const reader = new FileReader()
    reader.onload = (e) => {
      const img = document.createElement('img')
      img.src = e.target.result
      img.width = 100
      this.previewTarget.appendChild(img)
    }
    reader.readAsDataURL(file)
  }

  uploadFile(file) {
    const input = this.inputTarget
    const dataTransfer = new DataTransfer()
    dataTransfer.items.add(file)
    input.files = dataTransfer.files
  }
}
