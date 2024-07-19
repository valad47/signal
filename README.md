### About

This is simple implementation of signal in Lua.

### Instalation

To install this library, simply copy/symlink `src/signal.lua` into your luarocks folder.

For example, installing signal library globally on Linux:
```
git clone https://github.com/VALAD47/signal.git
cd signal
sudo cp src/signal.lua /usr/share/lua/5.4/
```

### Usage

First of all, require this library:
```
local signal = require("signal")
```

To create a signal, do this:
```
local foo = {}
foo.foo_signal = signal.new()
```

To create a connection to signal, do this:
```
foo.foo_signal:connect(f)
```
Where `f` is your function. This function can claim any arguments.

To fire a signal, do this:
```
foo.foo_signal:fire(...)
```
Where `...` is any arguments you want.
When firing a signal, all functions that were connected to a signal will be called.

If you want to connection run in "multi-thread", you have to install library [task](https://github.com/VALAD47/task), and set `signal.MULTI_THREAD = true`