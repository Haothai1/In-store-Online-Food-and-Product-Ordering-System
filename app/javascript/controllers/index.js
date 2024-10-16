// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "./application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Search filter function
import SearchController from "./search_controller"
application.register("search", SearchController)

console.log("Search controller registered");
