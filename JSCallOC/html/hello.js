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
  
  var _ff6f71ec8dafcefebe3f3f0b8a641b = __webpack_require__(1);
  
  var _ff6f71ec8dafcefebe3f3f0b8a641b2 = _interopRequireDefault(_ff6f71ec8dafcefebe3f3f0b8a641b);
  
  function _interopRequireDefault(obj) {
  return obj && obj.__esModule ? obj : {
  default: obj
  };
  }
  
  _ff6f71ec8dafcefebe3f3f0b8a641b2.default.el = '#root';
  new Vue(_ff6f71ec8dafcefebe3f3f0b8a641b2.default);
  
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
  __vue_options__.__file = "/usr/src/app/raw/4ff6f71ec8dafcefebe3f3f0b8a641b6.vue"
  __vue_options__.render = __vue_template__.render
  __vue_options__.staticRenderFns = __vue_template__.staticRenderFns
  __vue_options__._scopeId = "data-v-3d634c21"
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
  "background": {
  "direction": "column",
  "content": "center",
  "backgroundColor": "#e6e6e6"
  },
  "cellView": {
  "height": 1200,
  "backgroundColor": "#ffffff"
  },
  "header": {
  "height": 120,
  "flexDirection": "row"
  },
  "avatar": {
  "width": 60,
  "height": 60,
  "marginLeft": 30,
  "marginRight": 20,
  "marginTop": 30,
  "borderRadius": 30
  },
  "usrInfo": {
  "flexDirection": "column",
  "justifyContent": "center"
  },
  "name": {
  "fontSize": 24,
  "marginBottom": 10
  },
  "subInfo": {
  "flexDirection": "row"
  },
  "school": {
  "fontSize": 18,
  "color": "#b2b2b2",
  "marginRight": 15
  },
  "publishtime": {
  "fontSize": 18,
  "color": "#b2b2b2"
  },
  "momentpic": {
  "height": 750
  },
  "momenttitle": {
  "flexDirection": "column",
  "marginLeft": 30,
  "marginTop": 30,
  "borderBottomStyle": "dashed",
  "borderBottomWidth": 1,
  "borderBottomColor": "#b2b2b2"
  },
  "content": {
  "fontSize": 24,
  "color": "#333333"
  },
  "topic": {
  "marginTop": 30,
  "marginBottom": 30,
  "height": 45,
  "fontSize": 18,
  "color": "#b2b2b2",
  "backgroundColor": "#e6e6e6",
  "paddingLeft": 30,
  "paddingTop": 11
  }
  }
  
  /***/
  },
  /* 3 */
  /***/
  function(module, exports) {
  
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
  //
  //
  //
  //
  //
  //
  
  //   module.exports = {
  //     const mymodule = weex.requireModule('eventmodule');
  
  //     methods:{
  //       mStyle : function(str){
  //         var att = {
  //           string : '',
  //           font : 0
  //         };
  //         att.string = str;
  //         att.font = 18;
  //         return mymodule.getStringWidthby(att)
  //       }
  //     }
  //   }
  
  //
  "use strict";
  
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
  return _vm._m(0)
  },
  staticRenderFns: [function() {
                    var _vm = this;
                    var _h = _vm.$createElement;
                    var _c = _vm._self._c || _h;
                    return _c('div', {
                              staticClass: ["background"]
                              }, [_c('div', {
                                     staticClass: ["cellView"]
                                     }, [_c('div', {
                                            staticClass: ["header"]
                                            }, [_c('image', {
                                                   staticClass: ["avatar"],
                                                   attrs: {
                                                   "src": "http://swapp-test-images.oss-cn-hangzhou.aliyuncs.com/user-head-img/20170805/03173eb4a08da8f6504066247ed0cf05.jpg"
                                                   }
                                                   }), _c('div', {
                                                          staticClass: ["usrInfo"]
                                                          }, [_c('text', {
                                                                 staticClass: ["name"]
                                                                 }, [_vm._v("哈哈哈")]), _c('div', {
                                                                                         staticClass: ["subInfo"]
                                                                                         }, [_c('text', {
                                                                                                staticClass: ["school"]
                                                                                                }, [_vm._v("运动世界科技体育大学")]), _c('text', {
                                                                                                                               staticClass: ["publishtime"]
                                                                                                                               }, [_vm._v("2017.08.07 15:18")])])])]), _c('div', [_c('image', {
                                                                                                                                                                                     staticClass: ["momentpic"],
                                                                                                                                                                                     attrs: {
                                                                                                                                                                                     "src": "http://swapp-test-images.oss-cn-hangzhou.aliyuncs.com/dynamic-img/20170805/80bcdf48c6d46797ca21cbedc5726cde.jpg"
                                                                                                                                                                                     }
                                                                                                                                                                                     })]), _c('div', {
                                                                                                                                                                                              staticClass: ["momenttitle"]
                                                                                                                                                                                              }, [_c('text', {
                                                                                                                                                                                                     staticClass: ["content"]
                                                                                                                                                                                                     }, [_vm._v("从小泡妞")]), _c('text', {
                                                                                                                                                                                                                              staticClass: ["topic"]
                                                                                                                                                                                                                              }, [_vm._v("#话题名称最长最长#")])])])])
                    }]
  }
  module.exports.render._withStripped = true
  
  /***/
  }
  /******/
  ]);
