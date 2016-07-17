//
// define-prop
//
//	Easy and type safe custom object property define
//
//
// Copyright (c) 2015 Dennis Raymondo van der Sluis
//
// This program is free software: you can redistribute it and/or modify
//     it under the terms of the GNU General Public License as published by
//     the Free Software Foundation, either version 3 of the License, or
//     (at your option) any later version.
//
//     This program is distributed in the hope that it will be useful,
//     but WITHOUT ANY WARRANTY; without even the implied warranty of
//     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//     GNU General Public License for more details.
//
//     You should have received a copy of the GNU General Public License
//     along with this program.  If not, see <http://www.gnu.org/licenses/>
//

var types= require( 'types.js' );



var defineProperty= function( obj, key, value, settings ){

	obj		= types.forceObject( obj );
	settings	= settings || '';

	var descriptor= {
		 enumerable		: ~settings.indexOf( 'enumerable' )
	};

	if ( types.isObject(value) ){
		descriptor.get= types.forceFunction( value.get );
		descriptor.set= types.forceFunction( value.set );
	} else {
		descriptor.value			= value;
		descriptor.configurable	= ~settings.indexOf( 'configurable' );
		descriptor.writable		= ~settings.indexOf( 'writable' );
	}

	Object.defineProperty( obj, types.forceString(key), descriptor );
	return obj;
};

module.exports= defineProperty;