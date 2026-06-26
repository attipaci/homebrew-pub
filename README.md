# Attila's Homebrew packages

![supernovas version](https://img.shields.io/badge/dynamic/json.svg?url=https://raw.githubusercontent.com/attipaci/homebrew-pub/pkginfo/supernovas.json&query=$.versions.stable&label=supernovas)
![xchange version](https://img.shields.io/badge/dynamic/json.svg?url=https://raw.githubusercontent.com/attipaci/homebrew-pub/pkginfo/xchange.json&query=$.versions.stable&label=xchange)
![redisx version](https://img.shields.io/badge/dynamic/json.svg?url=https://raw.githubusercontent.com/attipaci/homebrew-pub/pkginfo/redisx.json&query=$.versions.stable&label=redisx)
<br clear="all">


This repo contains Homebrew packages from [Attila Kovács](https://www.sigmyne.com/attila). To use the tap, you must enable it first:

```bash
  brew tap attipaci/pub
``` 

After that you can install any of the packages with the `.rb` extension. For `<packagename>.rb` you would then:

```bash
  brew install <packagename>
```

Unlike the packages in the official Homebrew repo, these packages can be installed with additional options tailored to your needs. To see what options are available, you can run `brew info` first on the package:

```bash
  brew info <packagename>
```

So, for example, the `supernovas` package will by default install [SuperNOVAS](https://sigmyne.github.io/SuperNOVAS/) in its full configuration, including the C++ API, and with `curl` and `calceph` support and dependecies, but without the HTML developer documentation.
If you prefer to install it without C++ support, and with developer docs, then:

```bash
  brew install supernovas --without-c++ --with-doxygen
``` 


------------------------------------------------------------------------------
(C) 2026 Attila Kovács
