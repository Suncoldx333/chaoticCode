// { "framework": "Vue" }

/******/
(function(modules) { // webpackBootstrap
 /******/ // The module cache
 /******/
 var installedModules = {};
 
 /******/ // The require function
 /******/
 function __webpack_require__(moduleId) {
 
 /******/ // Check if module is in cache
 /******/
 if (installedModules[moduleId])
 /******/
 return installedModules[moduleId].exports;
 
 /******/ // Create a new module (and put it into the cache)
 /******/
 var module = installedModules[moduleId] = {
 /******/
 exports: {},
 /******/
 id: moduleId,
 /******/
 loaded: false
 /******/
 };
 
 /******/ // Execute the module function
 /******/
 modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
 
 /******/ // Flag the module as loaded
 /******/
 module.loaded = true;
 
 /******/ // Return the exports of the module
 /******/
 return module.exports;
 /******/
 }
 
 
 /******/ // expose the modules object (__webpack_modules__)
 /******/
 __webpack_require__.m = modules;
 
 /******/ // expose the module cache
 /******/
 __webpack_require__.c = installedModules;
 
 /******/ // __webpack_public_path__
 /******/
 __webpack_require__.p = "";
 
 /******/ // Load entry module and return exports
 /******/
 return __webpack_require__(0);
 /******/
 })
/************************************************************************/
/******/
([
  /* 0 */
  /***/
  function(module, exports, __webpack_require__) {
  
  'use strict';
  
  var _a6ca521551192c868b58a90f9cdd3b = __webpack_require__(1);
  
  var _a6ca521551192c868b58a90f9cdd3b2 = _interopRequireDefault(_a6ca521551192c868b58a90f9cdd3b);
  
  function _interopRequireDefault(obj) {
  return obj && obj.__esModule ? obj : {
  default: obj
  };
  }
  
  _a6ca521551192c868b58a90f9cdd3b2.default.el = '#root';
  new Vue(_a6ca521551192c868b58a90f9cdd3b2.default);
  
  /***/
  },
  /* 1 */
  /***/
  function(module, exports, __webpack_require__) {
  
  var __vue_exports__, __vue_options__
  var __vue_styles__ = []
  
  /* styles */
  __vue_styles__.push(__webpack_require__(2))
  
  /* script */
  __vue_exports__ = __webpack_require__(3)
  
  /* template */
  var __vue_template__ = __webpack_require__(4)
  __vue_options__ = __vue_exports__ = __vue_exports__ || {}
  if (
      typeof __vue_exports__.default === "object" ||
      typeof __vue_exports__.default === "function"
      ) {
  if (Object.keys(__vue_exports__).some(function(key) {
                                        return key !== "default" && key !== "__esModule"
                                        })) {
  console.error("named exports are not supported in *.vue files.")
  }
  __vue_options__ = __vue_exports__ = __vue_exports__.default
  }
  if (typeof __vue_options__ === "function") {
  __vue_options__ = __vue_options__.options
  }
  __vue_options__.__file = "/usr/src/app/raw/07a6ca521551192c868b58a90f9cdd3b.vue"
  __vue_options__.render = __vue_template__.render
  __vue_options__.staticRenderFns = __vue_template__.staticRenderFns
  __vue_options__._scopeId = "data-v-707a1ace"
  __vue_options__.style = __vue_options__.style || {}
  __vue_styles__.forEach(function(module) {
                         for (var name in module) {
                         __vue_options__.style[name] = module[name]
                         }
                         })
  if (typeof __register_static_styles__ === "function") {
  __register_static_styles__(__vue_options__._scopeId, __vue_styles__)
  }
  
  module.exports = __vue_exports__
  
  
  /***/
  },
  /* 2 */
  /***/
  function(module, exports) {
  
  module.exports = {
  "wrapper": {
  "backgroundColor": "#e6e6e6",
  "direction": "column",
  "content": "center"
  },
  "sub-image-box": {
  "width": 600,
  "height": 380,
  "backgroundColor": "#ffffff",
  "flexDirection": "row"
  },
  "sub-img": {
  "width": 190,
  "height": 188,
  "marginLeft": 3,
  "marginBottom": 3
  }
  }
  
  /***/
  },
  /* 3 */
  /***/
  function(module, exports) {
  
  'use strict';
  
  Object.defineProperty(exports, "__esModule", {
                        value: true
                        });
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  
  var mymodule = weex.requireModule('eventmodule');
  
  exports.default = {
  data: {
  imageUrl: "http://swapp-test-images.oss-cn-hangzhou.aliyuncs.com/user-head-img/20170805/03173eb4a08da8f6504066247ed0cf05.jpg"
  },
  methods: {
  mWidth: function mWidth() {
  console.log('width = 750');
  return {
  width: 750
  };
  // return {width : mymodule.makescreenwidth()}
  }
  }
  };
  
  /***/
  },
  /* 4 */
  /***/
  function(module, exports) {
  
  module.exports = {
  render: function() {
  var _vm = this;
  var _h = _vm.$createElement;
  var _c = _vm._self._c || _h;
  return _c('div', {
            staticClass: ["wrapper"]
            }, [_c('div', {
                   staticClass: ["sub-image-box"],
                   style: _vm.mWidth()
                   }, [_c('image', {
                          staticClass: ["sub-img"],
                          attrs: {
                          "resize": "cover",
                          "src": _vm.imageUrl
                          }
                          }), _c('image', {
                                 staticClass: ["sub-img"],
                                 attrs: {
                                 "resize": "cover",
                                 "src": _vm.imageUrl
                                 }
                                 }), _c('image', {
                                        staticClass: ["sub-img"],
                                        attrs: {
                                        "resize": "cover",
                                        "src": _vm.imageUrl
                                        }
                                        })])])
  },
  staticRenderFns: []
  }
  module.exports.render._withStripped = true
  
  /***/
  }
  /******/
  ]);
