/*! ngCart v1.0.0 */
 "use strict";angular.module("ngCart",["ngCart.directives"]).config([function(){}]).provider("$ngCart",function(){this.$get=function(){}}).run(["$rootScope","ngCart","ngCartItem","store",function(a,b,c,d){a.$on("ngCart:change",function(){b.$save()}),angular.isObject(d.get("cart"))?b.$restore(d.get("cart")):b.init()}]).service("ngCart",["$rootScope","ngCartItem","store",function(a,b,c){this.init=function(){this.$cart={shipping:null,taxRate:null,tax:null,items:[]}},this.addItem=function(c,d,e,f,g){var h=this.getItemById(c);if("object"==typeof h)h.setQuantity(f,!1);else{var i=new b(c,d,e,f,g);this.$cart.items.push(i),a.$broadcast("ngCart:itemAdded",i)}a.$broadcast("ngCart:change",{})},this.getItemById=function(a){var b=this.getCart().items,c=!1;return angular.forEach(b,function(b){b.getId()===a&&(c=b)}),c},this.setShipping=function(a){return this.$cart.shipping=a,this.getShipping()},this.getShipping=function(){return 0==this.getCart().items.length?0:this.getCart().shipping},this.setTaxRate=function(a){return this.$cart.taxRate=+parseFloat(a).toFixed(2),this.getTaxRate()},this.getTaxRate=function(){return this.$cart.taxRate},this.getTax=function(){return+parseFloat(this.getSubTotal()/100*this.getCart().taxRate).toFixed(2)},this.setCart=function(a){return this.$cart=a,this.getCart()},this.getCart=function(){return this.$cart},this.getItems=function(){return this.getCart().items},this.getTotalItems=function(){var a=0,b=this.getItems();return angular.forEach(b,function(b){a+=b.getQuantity()}),a},this.getTotalUniqueItems=function(){return this.getCart().items.length},this.getSubTotal=function(){var a=0;return angular.forEach(this.getCart().items,function(b){a+=b.getTotal()}),+parseFloat(a).toFixed(2)},this.totalCost=function(){return+parseFloat(this.getSubTotal()+this.getShipping()+this.getTax()).toFixed(2)},this.removeItem=function(b){this.$cart.items.splice(b,1),a.$broadcast("ngCart:itemRemoved",{}),a.$broadcast("ngCart:change",{})},this.removeItemById=function(b){var c=this.getCart();angular.forEach(c.items,function(a,d){a.getId()===b&&c.items.splice(d,1)}),this.setCart(c),a.$broadcast("ngCart:itemRemoved",{}),a.$broadcast("ngCart:change",{})},this.empty=function(){a.$broadcast("ngCart:change",{}),this.$cart.items=[],localStorage.removeItem("cart")},this.isEmpty=function(){return this.$cart.items.length>0?!1:!0},this.toObject=function(){if(0===this.getItems().length)return!1;var a=[];return angular.forEach(this.getItems(),function(b){a.push(b.toObject())}),{shipping:this.getShipping(),tax:this.getTax(),taxRate:this.getTaxRate(),subTotal:this.getSubTotal(),totalCost:this.totalCost(),items:a}},this.$restore=function(a){var c=this;c.init(),c.$cart.shipping=a.shipping,c.$cart.tax=a.tax,angular.forEach(a.items,function(a){c.$cart.items.push(new b(a._id,a._name,a._price,a._quantity,a._data))}),this.$save()},this.$save=function(){return c.set("cart",JSON.stringify(this.getCart()))}}]).factory("ngCartItem",["$rootScope","$log",function(a,b){var c=function(a,b,c,d,e){this.setId(a),this.setName(b),this.setPrice(c),this.setQuantity(d),this.setData(e)};return c.prototype.setId=function(a){a?this._id=a:b.error("An ID must be provided")},c.prototype.getId=function(){return this._id},c.prototype.setName=function(a){a?this._name=a:b.error("A name must be provided")},c.prototype.getName=function(){return this._name},c.prototype.setPrice=function(a){var c=parseFloat(a);c?0>=c?b.error("A price must be over 0"):this._price=c:b.error("A price must be provided")},c.prototype.getPrice=function(){return this._price},c.prototype.setQuantity=function(c,d){var e=parseInt(c);e%1===0?(d===!0?this._quantity+=e:this._quantity=e,this._quantity<1&&(this._quantity=1)):(this._quantity=1,b.info("Quantity must be an integer and was defaulted to 1")),a.$broadcast("ngCart:change",{})},c.prototype.getQuantity=function(){return this._quantity},c.prototype.setData=function(a){a&&(this._data=a)},c.prototype.getData=function(){return this._data?this._data:void b.info("This item has no data")},c.prototype.getTotal=function(){return+parseFloat(this.getQuantity()*this.getPrice()).toFixed(2)},c.prototype.toObject=function(){return{id:this.getId(),name:this.getName(),price:this.getPrice(),quantity:this.getQuantity(),data:this.getData(),total:this.getTotal()}},c}]).service("store",["$window",function(a){return{get:function(b){if(a.localStorage[b]){var c=angular.fromJson(a.localStorage[b]);return JSON.parse(c)}return!1},set:function(b,c){return void 0===c?a.localStorage.removeItem(b):a.localStorage[b]=angular.toJson(c),a.localStorage[b]}}}]).controller("CartController",["$scope","ngCart",function(a,b){a.ngCart=b}]).value("version","1.0.0"),angular.module("ngCart.directives",["ngCart.fulfilment"]).controller("CartController",["$scope","ngCart",function(a,b){a.ngCart=b}]).directive("ngcartAddtocart",["ngCart",function(a){return{restrict:"E",controller:"CartController",scope:{id:"@",name:"@",quantity:"@",quantityMax:"@",price:"@",data:"="},transclude:!0,templateUrl:function(a,b){return"undefined"==typeof b.templateUrl?"template/ngCart/addtocart.html":b.templateUrl},link:function(b,c,d){b.attrs=d,b.inCart=function(){return a.getItemById(d.id)},b.inCart()?b.q=a.getItemById(d.id).getQuantity():b.q=parseInt(b.quantity),b.qtyOpt=[];for(var e=1;e<=b.quantityMax;e++)b.qtyOpt.push(e)}}}]).directive("ngcartCart",[function(){return{restrict:"E",controller:"CartController",scope:{},templateUrl:function(a,b){return"undefined"==typeof b.templateUrl?"template/ngCart/cart.html":b.templateUrl},link:function(a,b,c){}}}]).directive("ngcartSummary",[function(){return{restrict:"E",controller:"CartController",scope:{},transclude:!0,templateUrl:function(a,b){return"undefined"==typeof b.templateUrl?"template/ngCart/summary.html":b.templateUrl}}}]).directive("ngcartCheckout",[function(){return{restrict:"E",controller:["$rootScope","$scope","ngCart","fulfilmentProvider",function(a,b,c,d){b.ngCart=c,b.checkout=function(){d.setService(b.service),d.setSettings(b.settings),d.checkout().success(function(b,c,d,e){a.$broadcast("ngCart:checkout_succeeded",b)}).error(function(b,c,d,e){a.$broadcast("ngCart:checkout_failed",{statusCode:c,error:b})})}}],scope:{service:"@",settings:"="},transclude:!0,templateUrl:function(a,b){return"undefined"==typeof b.templateUrl?"template/ngCart/checkout.html":b.templateUrl}}}]),angular.module("ngCart.fulfilment",[]).service("fulfilmentProvider",["$injector",function(a){this._obj={service:void 0,settings:void 0},this.setService=function(a){this._obj.service=a},this.setSettings=function(a){this._obj.settings=a},this.checkout=function(){var b=a.get("ngCart.fulfilment."+this._obj.service);return b.checkout(this._obj.settings)}}]).service("ngCart.fulfilment.log",["$q","$log","ngCart",function(a,b,c){this.checkout=function(){var d=a.defer();return b.info(c.toObject()),d.resolve({cart:c.toObject()}),d.promise}}]).service("ngCart.fulfilment.http",["$http","ngCart",function(a,b){this.checkout=function(c){return a.post(c.url,{data:b.toObject(),options:c.options})}}]).service("ngCart.fulfilment.paypal",["$http","ngCart",function(a,b){}]);