/*!
 * remark (http://getbootstrapadmin.com/remark)
 * Copyright 2017 amazingsurge
 * Licensed under the Themeforest Standard Licenses
 */

!function(global,factory){if("function"==typeof define&&define.amd)define("/Plugin/multi-select",["exports","Plugin"],factory);else if("undefined"!=typeof exports)factory(exports,require("Plugin"));else{var mod={exports:{}};factory(mod.exports,global.Plugin),global.PluginMultiSelect=mod.exports}}(this,function(exports,_Plugin2){"use strict";Object.defineProperty(exports,"__esModule",{value:!0});var _Plugin3=babelHelpers.interopRequireDefault(_Plugin2),NAME="multiSelect",MultiSelect=function(_Plugin){function MultiSelect(){return babelHelpers.classCallCheck(this,MultiSelect),babelHelpers.possibleConstructorReturn(this,(MultiSelect.__proto__||Object.getPrototypeOf(MultiSelect)).apply(this,arguments))}return babelHelpers.inherits(MultiSelect,_Plugin),babelHelpers.createClass(MultiSelect,[{key:"getName",value:function(){return NAME}}],[{key:"getDefaults",value:function(){return{}}}]),MultiSelect}(_Plugin3.default);_Plugin3.default.register(NAME,MultiSelect),exports.default=MultiSelect});
