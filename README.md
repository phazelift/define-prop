#define-prop

###Easy and type safe custom object property define

- object descriptors in a space seperated string for fast inline value creation
- deep freezes non-writable object values
- doesn't throw, but logs on invalid input
- supports custom log so you can throw yourself if needed
- dynamically type checked



###Usage:

> `<object> defineProperty( <object> obj, <string>/<number> key, <any type> value, <string> descriptorNames )`


Default, the enumerable, configurable and writable descriptor values are set to false, which is the default behaviour of Object.defineProperty. You can set them individually to true by passing their names as last arguments or in a space seperated string.


```javascript
var defineProp= require( 'define-prop' );


var obj= {};

// define obj.hello and give it the value 'world!', it will be
// immutable by default, we only set enumerable to be able to log it
defineProp( obj, 'hello', 'world!', 'enumerable' );
obj.hello= 'cannot be set..';

console.log( obj );
//	{ hello: 'world!' }


// define a getter and setter similar to native Object.defineProperty
defineProp( obj, 'count', ( () => {
	var count= 0;
	return {
		 get: () => count
		,set: ( value ) => count= value
	};
})(), 'enumerable' );

obj.count++;
console.log( obj.count );
// 1


// define an object to be deeply immutable
defineProp( obj, 'protected', {
	 notWritable	: 'this is a frozen object'
	,test			: true
}, 'enumerable' );

obj.protected.cannotAssign	= 'when "writable" is not set';
obj.protected.test			= 'futile';

console.log( obj );
// { hello: 'world!',
//   count: [Getter/Setter],
//   protected: { notWritable: 'this is a frozen object', test: true } }


// have custom input error handler
defineProp.log= ( err ) => {
	// do something with err?
};
```

<br/>

<h3>change log</h3>
--

**0.0.5**

- adds support for making object values deeply immutable if descriptor is not set to 'writable'
- adds optional input error logging (default on)

--

**0.0.4**

- adds support for defining a non-getter/setter object

--

**0.0.3**

- changed license to MIT

--

###license

MIT


