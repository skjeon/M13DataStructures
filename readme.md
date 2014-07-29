<img src="https://raw.github.com/Marxon13/M13DataStructures/master/ReadmeResources/M13DataStructuresBanner.png">

M13DataStructures
============

M13DataStructures includes implementations of several basic data structures in swift. It includes implementations for a Stack, 2D Matrix, and Ordered Dictionary.

Stack:
----------

* Supports:
	* pushing indivual and arrays of items
	* popping indivual and multiple items
	* peeking
	* dropping indivual and multiple items
	* enumeration
	* Defines the += syntax for pushing indivual items, arrays of items, or items from another stack.
	* Defines the + syntax for pushing indivual items, arrays of items, or items from another stack.
	* Follows the sequence protocol.

Matrix:
----------

Currently only a class to organize data into a 2D matrix. 

* Supports:
	* Setting and getting indivual entries via index subscripting.
	* Setting and getting rows and columns via index subscripting.

Once I have determinied how to check if the entry's type supports addition, subtraction, divivision, and multiplication I will add support for that. So if anyone knows how to check, then please let me know. I couldn't find a way for it to work.

Ordered Dictionary
------------------

A dictionary with ordered key-value pairs.

* Supports:
	* All the methods that can be used on a basic Array or Dictionary.
	* Subscripting by key or index. 
	* All entries are key value tuples.
	* Supports enumeration, sorting, maping, and reducing.
	* Follows the sequence, printable, and equatable protocols.

Cocoapods:
-------
Cocoapods currently does not support compiling swift files. Once that support is added, I will add this to the master specs repo.

Notes:
----------
If something is not working, or does not work as expected when compared to Apples's docs. let me know, I'll get it fixed ASAP.

License:
---------
> Copyright 2014 Brandon McQuilkin 
>
>Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

>The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
