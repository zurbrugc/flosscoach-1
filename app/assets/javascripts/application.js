// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//



// Core and plugin dependencies

//= require remark/global/vendor/babel-external-helpers/babel-external-helpers
//= require remark/global/vendor/jquery/jquery.js
//= require remark/global/vendor/tether/tether.js

//= require remark/global/vendor/bootstrap/bootstrap.js
//= require remark/global/vendor/animsition/animsition.js
//= require remark/global/vendor/mousewheel/jquery.mousewheel.js
//= require remark/global/vendor/asscrollbar/jquery-asScrollbar.js
//= require remark/global/vendor/asscrollable/jquery-asScrollable.js
//= require remark/global/vendor/ashoverscroll/jquery-asHoverScroll.js
//= require remark/global/vendor/screenfull/screenfull.js
//= require remark/global/vendor/slidepanel/jquery-slidePanel.js

// Template relating scripts

//= require remark/global/js/State.js
//= require remark/global/js/Component.js
//= require remark/global/js/Plugin.js
//= require remark/global/js/Base.js
//= require remark/global/js/Config.js

//= require remark/assets/js/Section/Menubar.js
//= require remark/assets/js/Section/Sidebar.js
//= require remark/assets/js/Section/PageAside.js
//= require remark/assets/js/Plugin/menu.js

//= require remark/assets/js/Site.js


//= require jquery_ujs
//= require_self


(function(document, window, $) {
  'use strict';
  var Site = window.Site;
  $(document).ready(function() {
    Site.run();
  });
})(document, window, jQuery);
