// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Volt
import "./admin/volt.js"
// === 以下を読み込むと何故かActionTextが表示されなくなる ===
// === なくても問題なさそうなので一旦コメントアウト ===
// import "./admin/vendor/popper.min.js"
// import "./admin/vendor/on-screen.umd.min.js"
// import "./admin/vendor/nouislider.min.js"
// import "./admin/vendor/jarallax.min.js"
// import "./admin/vendor/smooth-scroll.polyfills.min.js"
// import "./admin/vendor/countUp.umd.js"
// import "./admin/vendor/chartist.min.js"
// import "./admin/vendor/chartist-plugin-tooltip.min.js"
// import "./admin/vendor/datepicker.min.js"
// import "./admin/vendor/simplebar.min.js"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// ActionText
require("trix")
require("@rails/actiontext")
