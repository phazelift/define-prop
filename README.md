#define-prop

###Easy and type safe custom object property define

- object descriptors in a space seperated string for fast inline value creation
- dynamically type checked



###Usage:

> `<object> defineProperty( <object> obj, <string>/<number> key, <any type> value, <string> descriptorNames )`


Default, the enumerable, configurable and writable descriptor values are set to false, which is the default behaviour of Object.defineProperty. You can set them individually to true by passing their names as last argument in a space seperated string.


```javascript
var defineProperty= require( 'define-prop' );

var obj= {};

// let's define obj.hello and give it the value 'world!', it will be 
// immutable by default, we only set enumerable to be able to log it now
defineProperty( obj, 'hello', 'world!', 'enumerable' );
obj.hello= 'into a black hole';

console.log( obj );
//	{ hello: 'world!' }

// define a getter and setter as you would with Object.defineProperty
defineProperty( obj, 'count', {
	 get: () => obj.value
	,set: ( value ) => obj.value= value
});

obj.count= 0;
console.log( ++obj.count );
// 1
```


