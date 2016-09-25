#
# define-prop
#
#	Easy and type safe custom object property define
#
# MIT License
#
# Copyright (c) 2015 Dennis Raymondo van der Sluis
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#


types			= require 'types.js'
deepFreeze	= require 'deep-freeze'



defineProp=  ( object, key, value, settings... ) ->

	if not key= types.forceString key
		defineProp.log 'define-prop: error, invalid or missing key!'
		return

	if types.notFunction(object) and (typeof object isnt 'object')
		defineProp.log 'define-prop: error, invalid or missing object!'
		return

	descriptor=
		enumerable		: ~settings.indexOf 'enumerable'

	if (types.isObject value) and (types.hasFunction value.get, value.set)
		descriptor.get= types.forceFunction value.get
		descriptor.set= types.forceFunction value.set
	else
		descriptor.value			= value
		descriptor.configurable	= ~settings.indexOf 'configurable'
		descriptor.writable		= ~settings.indexOf 'writable'
		if not descriptor.writable
			descriptor.value= deepFreeze descriptor.value

	Object.defineProperty object, key, descriptor
	return object

defineProp.log= console?.log


module.exports= defineProp;