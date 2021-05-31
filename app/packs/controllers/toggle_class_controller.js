import { Controller } from "stimulus"

export default class extends Controller {
  static classes = ["toggle"]
  static targets = ["element"]

  toggle(event) {
    let className = "hidden"
    if (this.hasToggleClass) {
      className = this.toggleClass
    }
    if (this.hasElementTarget) {
      this.elementTargets.map(target => target.classList.toggle(className))
    }
  }
}
