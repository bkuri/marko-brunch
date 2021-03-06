marko-brunch
------------

Adds [marko](http://markojs.com) support to [brunch](http://brunch.io).

Usage
-----

Install the plugin via npm with `npm install --save marko-brunch`.

Or, do manual install:

-	Add `"marko-brunch": "~x.y.z"` to `package.json` of your brunch app.
-	If you want to use git version of plugin, use the GitHub URI`"marko-brunch": "bkuri/marko-brunch"`.

Currently only static templates are supported. Remember to place your marko templates inside the `assets` directory.

You can specify local variables inside the `plugins` section of your brunch config file like so:

```js
plugins: {
  marko: {
    data: {
      key1: 'value1',
      key2: 'value2'
    }
  }
}
```

You can specify indented html output by setting `indent` to a value larger than `0`. The default value for `indent` is `0` when in production mode and `2` otherwise.

```js
plugins: {
  marko: {
    indent: 2
  }
}
```

Note: Starting in v1.0.4, Marko's `hot-reload` module will only be activated if `brunch.persistent` is set to `true`.

License
-------

The MIT License (MIT)

Copyright (c) 2017 Bernardo Kuri (http://bkuri.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
