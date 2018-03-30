Miscellaneous scripts used by Nico Schottelius

## Notable things usable for others:

### cbacklight

Sets/controls backlight using /sys/class/backlight/*/brightness
directly. Usable for systems that use modesetting instead of intel
driver.

Also: supports multiple backlight outputs at the same time.

```
[14:12] line:~% cbacklight --help
usage: cbacklight [-h] [--inc INC | --dec DEC | --set SET] [--get]

cbacklight

optional arguments:
  -h, --help  show this help message and exit
  --inc INC   Increment by percentage (points)
  --dec DEC   Decrement by percentage (points)
  --set SET   Set to percentage
  --get       Get percentage (default)
[14:12] line:~% cbacklight --inc 5
[14:12] line:~% cbacklight --get
intel_backlight: 72.17%
[14:13] line:~% cbacklight --dec 7 --get
intel_backlight: 65.19%
```

It is basically a smarter / lighter xbacklight replacement
