import { Controller } from "stimulus"
import {enter, leave} from "el-transition";

export default class extends Controller {
  static targets = ["userMenu", "mobileMenuButton"]

  toggleUserMenu() {
    if(this.userMenuTarget.classList.contains('hidden')) {
      enter(this.userMenuTarget)
    } else {
      leave(this.userMenuTarget)
    }
  }

  toggleMobileMenuButton() {
    this.mobileMenuButtonTargets.forEach((t) => {
      t.classList.toggle("hidden")
      t.classList.toggle("block")
    });
  }
}
