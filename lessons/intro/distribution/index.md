Moduly
======

Zatím jsme tvořili programy v Pythonu tak nějak na divoko, tedy v jednom nebo
více souborech bez nějakého zvláštního řádu. V této lekci se podíváme na
to, jak tvořit redistribuovatelné moduly a balíčky, které jdou nahrát na PyPI
(veřejný seznam balíčků pro Python) a instalovat pomocí nástroje pip.

Za příklad si vezmeme kód Ondřeje Caletky, který umožňuje určit české svátky
v zadaném roce. Jako příklad je ideální, protože obsahuje jak funkce, které
můžeme volat z Pythonu, tak lze volat z příkazové řádky.

 * [oskar456/isholiday.py](https://gist.github.com/oskar456/e91ef3ff77476b0dbc4ac19875d0555e)


Volání z příkazové řádky, pomocí příkazu `python isholiday.py` nebo
`python -m isholiday`, zajišťuje blok `if __name__ == '__main__':`.
Toto je rychlý způsob, jak napsat modul, který jde jak importovat, tak spustit.
Když nějaký modul importujeme, má v proměnné `__name__` k dispozici své jméno.
„Hlavní” modul ale není importován a jeho jméno není vždy k dispozici
(např. v `cat isholiday.py | python`).
Python proto `__name__` „hlavního” modulu nastavuje na `'__main__'`,
čehož se často využívá.

Později se podíváme na elegantnější způsob jak to zařídit; teď se vraťme
zpět k balíčkování.

Slovníček pojmů
---------------

Než se pustíme do samotného výkladu, zavedeme některé pojmy tak,
aby mezi nimi nedošlo v textu záměně.
Anglické pojmy v závorce jsou převzaty z oficiálního [glosáře](https://packaging.python.org/glossary).

* **(importovatelný) modul** (_Module_ ∪ _Import Package_) je cokoliv,
  co se dá importovat z Pythonu, v tomto textu tedy především Python soubor nebo adresář s vícero Python soubory;
* **balíček** (_Distribution Package_) je instalovatelný archiv obsahující
  _importovatelné moduly_ pro Python a další potřebné soubory, může být i rozbalený;
* **zdrojový balíček** (_Source Distribution_, `sdist`) je varianta zabaleného _balíčku_ ve zdrojové formě;
* **binární balíček** (_Binary Distribution_, `bdist`, `wheel`) je varianta zabaleného _balíčku_ v nezdrojové (např. zkompilované) formě;
* **projekt** (_Project_) je knihovna, framework, skript, plugin, aplikace apod. (či jejich kombinace), které balíme do _balíčků_.



pyproject.toml
--------------

Základním stavebním kamenem Python balíčku je soubor `pyproject.toml`, který
obsahuje všechna potřebná metadata pro vytvoření zdrojového a binárního balíčku.
TOML je datový formát, který se dobře píše člověkem a čte počítačem.
Jehož plnou specifikaci můžete najít v oficiální [dokumentaci](https://toml.io/en/).

Pojďme vytvořit jeho minimální variantu. Použijeme balíček `setuptools` jako tzv. _build backend_,
tedy program, který náš balíček vytvoří. Existují také jiné _build backendy_ s jinými vlastnostmi -
jaké to jsou a jak je použít, se dozvíte z oficiálního [tutoriálu, jak tvořit Python balíčky](https://packaging.python.org/en/latest/tutorials/packaging-projects/).


```toml
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "isholiday"
version = "0.1.0"
authors = [
  { name="Ondřej Caletka", email="ondrej@caletka.cz" },
]
description = "Finds Czech holiday for given year"
license = {text = "Public Domain"}

[project.urls]
"Homepage" = "https://gist.github.com/oskar456/e91ef3ff77476b0dbc4ac19875d0555e"
```

Všimněte si, že jsme balíček pojmenovali stejně jako soubor se zdrojovým kódem
(tedy stejně jako modul).
Je to dobrá konvence, ale není to technicky nutné.

Balíček můžeme zkusit nainstalovat do virtuálního prostředí:

```console
$ python3.11 -m venv __venv__     # (nebo jinak -- podle vašeho OS)
$ . __venv__/bin/activate        # (nebo jinak -- podle vašeho OS)
(__venv__)$ python -m pip install .
...
(__venv__)$ python
>>> import isholiday
>>> 
(__venv__)$ python -m pip freeze
isholiday @ file:///tmp/isholiday  # cesta k modulu bude u vás vypadat jinak
```

Alternativně můžete použít příkaz `pip install --editable`,
který balíček nainstaluje tak, že změny v souborech se projeví rovnou
(není třeba po každé změněně instalovat znovu).

```console
(__venv__)$ python -m pip install --editable .
...
(__venv__)$ pip freeze
# Editable install with no version control (isholiday==0.1.0)
-e /tmp/isholiday
```

Vytvoření zdrojového a binárního balíčku
----------------------------------------

Pomocí nástroje `pip` můžeme sice nainstalovat náš balíček do vlastního virtuálního prostředí,
ale neřešíme tím základní otázku: distribuci pro širokou veřejnost.

Použijeme nástroj `build`, který přečte _recept na balíček_, obsažen v souboru `pyproject.toml`,
a vytvoří zdrojovou a binární distribuci.

```console
(__venv__)$ python -m pip install build
...
(__venv__)$ python -m build
* Creating venv isolated environment...
* Installing packages in isolated environment... (setuptools>=61.0)
* Getting build dependencies for sdist...
...
Successfully built isholiday-0.1.0.tar.gz and isholiday-0.1.0-py3-none-any.whl
```

Všimněte si nového adresáře v projektu: `dist`, v němž jsou dva archivy:
- `isholiday-0.1.0.tar.gz` - zdrojový balíček
- `isholiday-0.1.0-py3-none-any.whl` - binární balíček (tzv. _wheel_). 

Můžete je rozbalit pomocí systémových nástrojů a podívat se dovnitř.

> [note]
> `whl` je ve skutečnosti stejný formát jako `zip`,
> takže pokud vaše systémové nástroje ho neumí detekovat,
> stačí přejmenovat rozšíření souboru na `.zip`.

Můžete také vytvořit pouze zdrojový nebo pouze binární balíček pomocí přepínačů `--sdist`, resp. `--wheel`.


Extra soubory do zdrojového balíčku
-----------------------------------

Náš projekt nemá `README` – soubor, do kterého se tradičně píšou základní informace o projektu.
Můžeme jej vytvořit a uložit jako `README` přímo v kořenovém adresáři projektu,
tedy tam, kde byste jej nejspíš čekali.

```
Czech public holiday checker...
```

Pojďme vytvořit i další speciální soubor, `LICENSE`, který bude
obsahovat text licence, v tomto případě Public Domain.
Obsah najdete třeba na [CC0].

[CC0]: https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt

Poté vytvoříme balíčky znovu:

```console
(__venv__)$ python -m build
```

Zkontrolujte obsah zdrojového archivu (`isholiday-0.1.0.tar.gz`), který najdete v adresáři `dist`.
Měly by tam být oba soubory.

Hotový balíček pak můžete nainstalovat pomocí nástroje `pip`.
Doporučuji to dělat v jiném virtuálním prostředí – v aktuálním už ho máte
nainstalovaný.

```console
# v jiné konzoli, v jiném adresáři
$ python3 -m venv __venv2__
$ . __venv2__/bin/activate
(__venv2__)$ python -m pip install cesta/k/projektu/dist/isholiday-0.1.0.tar.gz
Processing cesta/k/projektu/dist/isholiday-0.1.0.tar.gz
Installing collected packages: isholiday
  Running setup.py install for isholiday ... done
Successfully installed isholiday-0.1.0
```

Více metadat v pyproject.toml
-----------------------------

Na chvíli se vrátíme k `pyproject.toml` a přidáme co nejvíc dalších
položek.
Jejich vysvětlení najdete [v dokumentaci](https://packaging.python.org/en/latest/specifications/declaring-project-metadata/#declaring-project-metadata).

```toml
[build-system]
requires = ["setuptools>=61.0"]
build-backend = "setuptools.build_meta"

[project]
name = "isholiday"
version = "0.1.0"
authors = [
  { name="Ondřej Caletka", email="ondrej@caletka.cz" },
]
description = "Finds Czech holiday for given year"
license = {file = "LICENSE"}
readme = {"README"}
requires-python = ">=3.6"
keywords = ['holiday', 'dates', 'Czech']
classifiers = [
    'Intended Audience :: Developers',
    'License :: Public Domain',
    'Operating System :: POSIX :: Linux',
    'Programming Language :: Python',
    'Programming Language :: Python :: Implementation :: CPython',
    'Programming Language :: Python :: 3',
    'Programming Language :: Python :: 3.6',
    'Programming Language :: Python :: 3.7',
    'Programming Language :: Python :: 3.8',
    'Programming Language :: Python :: 3.9',
    'Programming Language :: Python :: 3.10',
    'Programming Language :: Python :: 3.11',
    'Programming Language :: Python :: 3.12',
    'Topic :: Software Development :: Libraries',
]

[project.urls]
"Homepage" = "https://gist.github.com/oskar456/e91ef3ff77476b0dbc4ac19875d0555e"

```

Všimněte si argumentu `classifiers`. Jsou to
v podstatě takové tagy nebo strukturované informace o balíčku.
Zásadně si je nevymýšlíme sami, ale hledáme je v
[seznamu](https://pypi.org/pypi?%3Aaction=list_classifiers).
Tyto informace budou později vidět na [PyPI](https://pypi.org) a
půjde podle nich hledat.


Více souborů s Python kódem
---------------------------

Doteď jsme vytvářeli balíček jen s modulem ve formě jednoho zdrojového souboru `isholiday.py`.
Co ale dělat, pokud je náš projekt větší a obsahuje souborů více?

Vytvoříme modul ve formě složky. V našem případě soubor
`isholiday.py` zatím přesuneme do `isholiday/__init__.py`:

```console
(__venv__)$ tree
.
├── LICENSE
├── pyproject.toml
└── isholiday
    └── __init__.py
```

Soubor `__init__.py` jednak značí, že adresář `isholiday` je importovatelný modul,
a také obsahuje kód, který se spustí při importu modulu `isholiday`.

`build` bude této změně automaticky rozumět, což si můžete vyzkoušet vytvořením a prozkoumáním balíčku.

Momentálně máme všechen kód přímo v `__init__.py`, což sice funguje,
ale ideální to není. Dobré je mít kód v samostatných souborech a v `__init__.py`
pouze importovat veřejné rozhraní, tedy to, co budou z vašeho modulu importovat
jeho uživatelé.

V souboru `__init__.py` by tak prakticky žádný kód kromě importů být neměl.
Přesuňte tedy obsah `__init__.py` do `holidays.py` a
do `__init__.py` místo toho napište:

```python
from .holidays import getholidays, isholiday

__all__ = ['getholidays', 'isholiday']
```

Tečka v příkazu `import` není chyba: je to zkratka pro aktuální modul.
Můžeme psát i `from isholiday.holidays import ...`,
což ale trochu ztěžuje případné přejmenování modulu.

Ono `__all__` pak explicitně definuje rozhraní modulu. Například s původním
modulem šlo provést `from isholiday import datetime`, ale asi by nikdo
nečekal, že tahle možnost bude nutně zachována i v příštích verzích knihovny.
Seznamem `__all__` dáte najevo, že tyhle funkce nejsou jen „náhodné importy“,
a zároveň tím zamezíte různým varováním o
importovaném ale nevyužitém modulu, které může hlásit vaše IDE nebo linter.

> [note]
> Python samotný pak `__all__` používá jako seznam proměnných importovaných
> přes `from isholiday import *`. Tento způsob importu nevidíme rádi,
> protože znepřehledňuje kód, to ale neznamená, že to musíme uživatelům
> naší knihovny znepříjemňovat (např. pro interaktivní režim).


Spouštění modulu
----------------

Pokusíme-li se teď program spustit pomocí `python -m isholiday`,
narazíme na problém: na rozdíl od souboru se složka s kódem takto spustit nedá:

```console
$ python -m isholiday
python: No module named isholiday.__main__; 'isholiday' is a package and cannot be directly executed
```

Namísto spuštění souboru (typicky s blokem `if __name__ == '__main__':`) totiž
Python v tomto případě hledá *soubor* pojmenovaný `__main__.py` a spustí ten.

Soubor `__main__.py` není určený k tomu, aby se z něho importovalo, proto
by měl obsahovat co nejméně kódu – ideálně jen volání funkce, která je
definovaná jinde. Vytvořte proto `__main__.py` s následujícím obsahem:

```python
from .holidays import main

main()
```

a v `holidays.py` zaměňte `if __name__ == '__main__':` za `def main():`.

Modul teď bude možné (opět) spustit pomocí `python -m isholiday`.
Bude to fungovat i tehdy, když vytvoříte balíček (`python -m build`)
a nainstalujete ho v jiném virtuálním prostředí.


Programy pro příkazovou řádku
-----------------------------

Pokud chcete, aby váš modul umožňoval spouštění přímo z příkazové řádky,
bez `python -m`, měli byste použít [entry-points].
K tomu je potřeba přidat do `pyproject.toml` příslušný argument:

[entry-points]: https://packaging.python.org/en/latest/specifications/declaring-project-metadata/#entry-points

```toml
[project.scripts]
isholiday_demo = "isholiday.holidays:main"
```

`isholiday_demo` je jméno *entrypointu*, tedy příkazu pro příkazovou řádku.
`isholiday.holidays:main` je pak cesta k funkci ve tvaru `modul:funkce`;
funkce může být v modulu definovaná nebo importovaná.

Skript bude možné použít, je-li aktivní prostředí, kde je nainstalován, jen
zadáním jména *entrypointu*:

```console
(__venv__)$ python -m build
```

```console
# v jiné konzoli, v jiném virtuálním prostředí
(__venv2__)$ python -m pip install --upgrade cesta/k/projektu/dist/isholiday-0.1.0.tar.gz
(__venv2__)$ isholiday_demo
...
Mon Mar 28 00:00:00 2016 True
Tue Mar 28 00:00:00 2017 False
Fri Apr 14 00:00:00 2017 True
```


Specifikace závislostí
----------------------

Balíčky na PyPI mohou záviset na dalších balíčkách. V případě `isholiday` to
potřeba není, ale v úlohách z minulých cvičení ano.

Existuje několik úrovní závislostí, ve většině případů si
vystačíte s klíčem `dependencies`.
Balíček, který závisí na balíčkách `Flask` (jakékoli verze) a
`click` (verze 6 a vyšší) by v `pyproject.toml` měl mít:

```toml
dependencies = [
    "Flask",
    "click>=6",
]
```

### Soubor requirements.txt

Kromě závislostí v `pyproject.toml` se u pythonních projektů často setkáme se souborem
`requirements.txt`, který obsahuje přesné verze všech závislostí, včetně
tranzitivních – t.j. závisí-li náš balíček na `Flask` a `Flask` na `Jinja2`,
najdeme v `requirements.txt` mimo jiné například řádky:

```
Flask==0.11.1
Jinja2==2.8
```

Tento soubor se používá, když je potřeba přesně replikovat prostředí, kde
program běží, například mezi testovacím strojem a produkčním nasazením
webové aplikace.
Tento soubor se dá vygenerovat z aktuálního prostředí zadáním
`python -m pip freeze > requirements.txt` a balíčky v něm se dají nainstalovat
pomocí `python -m pip install -r requirements.txt`.
My ho používat nebudeme, vystačíme si s volnější specifikací závislostí
v `pyproject.toml`.


Nahrání na PyPI
---------------

Balíček jde zaregistrovat a nahrát na PyPI. Použijeme pro to program `twine`
(instalovatelný přes pip).

Budete si potřebovat zařídit
[účet na PyPI](https://pypi.org/account/register/),
[účet na testovací PyPI](https://test.pypi.org/account/register/)
a vytvořit konfigurační soubor `~/.pypirc`:

```ini
[distutils]
index-servers=
    pypi
    testpypi

[pypi]
username = <your user name goes here>
password = <your password goes here>

[testpypi]
repository = https://test.pypi.org/legacy/
username = <your user name goes here>
password = <your password goes here>
```

Hesla můžete vynechat, pokud je budete chtít pokaždé zadávat.

Používáte-li Windows, je potřeba nastavit proměnnou prostředí `HOME` na adresář
se souborem `.pypirc`, např:

```dosvenv
> set HOME=C:\cesta\k\nastaveni
```

Registrace projektu a nahrání na testovací PyPI se provádí pomocí příkazu
`upload`: ten projekt zaregistruje (pokud to jde) a nahraje samotný balíček:

```console
(__venv__)$ twine upload -r testpypi dist/isholiday-0.1.0.tar.gz
Uploading distributions to https://test.pypi.org/legacy/
Uploading isholiday-0.1.0.tar.gz
[================================] 8379/8379 - 00:00:02
```

První nahrání se zdaří, jen pokud jméno projektu již není zabrané.
Další nahrávání je povoleno jen vám, případně uživatelům,
kterým to povlíte přes webové rozhraní.
Po úspěšném nahrání lze nahrávat další verze balíčku, ale musí být novější
než ta, co už na PyPI je. Nejde tedy jednou nahraný balíček přepsat.

Svůj balíček najdete na `https://test.pypi.org/project/<název_balíčku>/`.

Pro nahrání na opravdovou PyPI stačí vynechat `-r testpypi`.
Zabírat jména na opravdové PyPI jen tak není hezké vůči ostatním Pythonistům;
registrujte tedy prosím jen balíčky, které budou nějak pro ostatní užitečné.


Instalace pomocí pip
--------------------

Projekt nahraný na PyPI by mělo jít nainstalovat pomocí pipu.
V případě použití ostré verze PyPI stačí k instalaci zadat název balíčku:

```console
(__venv__)$ python -m pip install <název_balíčku>
```

Pokud však použijeme testovací PyPI, je nutné pipu říct, aby balíček hledal tam.
[Postup](https://packaging.python.org/en/latest/guides/using-testpypi/) uvedený v dokumentaci není
v tomto případě nejvhodnější, protože z testovací PyPI vezme jak náš balíček,
tak i případné závislosti, které mohou být zastaralé, rozbité či jinak škodlivé.

Lepší by bylo, kdyby pip nainstaloval závislosti z ostré PyPI a na testovací
hledal jen náš projekt. Toho se dá docílit přepínačem `--extra-index-url`.

```console
(__venv__)$ python -m pip install --extra-index-url https://test.pypi.org/pypi <název_balíčku>
```

V tomto případě pip nejdřív prohledá ostrou PyPI, a pokud nenajde požadovaný
balíček, použije testovací PyPI. Zde je potřeba dávat pozor na název projektu,
protože případné konflikty mezi ostrou a testovací PyPI se nekontrolují.
Pokud tedy máme projekt na testovací PyPI a na ostré existuje projekt se
stejným názvem, nainstaluje se ten z ostré verze.

V případě, že tento problém nastane, je možné ho částečně obejít specifikací
verze instalovaného balíčku:

```console
(__venv__)$ python -m pip install --extra-index-url https://test.pypi.org/pypi <název_balíčku>==0.3
```

Pokud u duplicitního projektu na ostré PyPI neexistuje požadovaná verze,
nainstaluje se náš balíček z testovací PyPI.

Jiná možnost je zadat přímo cestu k archivu s balíčkem místo jeho názvu.
Zde pak na umístění balíčku ani verzi nezáleží:

```console
(__venv__)$ python -m pip install https://test-files.pythonhosted.org/packages/.../<název_balíčku>-0.3.tar.gz
```

Odkaz na archiv se dá najít na informační stránce o našem projektu na PyPI.


Datové soubory
--------------

Některé moduly kromě samotného kódu potřebují i datové soubory.
Například aplikace ve Flasku potřebují *templates*.

Taková data se dají do balíčku přidat klíčem `tool.setuptools.package_data`:

```toml
[tool.setuptools.packages]
find = {}

[tool.setuptools.package-data]
"*" = ["*.html"]
```

Dodatečnou dokumentaci, jak konfigurovat přidání těchto souborů, najdete v dokumentaci příslušného build backendu.
[Dokumentace k setuptools](https://setuptools.pypa.io/en/latest/userguide/datafiles.html#data-files-support).


Wheel: Binární balíčky
----------------------

Zatím jsme se zabývali jen zdrojovými balíčky (`sdist`).
Existují ale i balíčky „zkompilované” – binární (`wheel`).
Když se instaluje zdrojový balíček, pip prvně vytvoří `wheel`, a následně ho rozbalí
na patříčné místo. Binární balíček se už jen rozbalí.

Z historických důvodů existuje několik různých druhů binárních distribucí,
v současné době je ale důležitý pouze `wheel`:

```console
(__venv__)$ python -m build
```

Výsledek je v souboru `dist/*.whl`.

Obsah binárního balíčku typu wheel můžete prozkoumat, je to obyčejný ZIP.

Naše programy jsou zatím platformně nezávislé a ve wheelu,
i když se jmenuje binární, žádné binární soubory nejsou.
To se ale změní, až se budeme zabývat tvorbou modulů v jazyce C:
`sdist` pak obsahuje zdrojové soubory a `wheel` zkompilované moduly.

Potom je dobré distribuovat oba dva – každý má své výhody:

- *sdist* jde nainstalovat na různých operačních systémech i procesorových
  architekturách,
- *sdist* tradičně obsahuje soubory jako LICENSE a README, ale
- *wheel* při instalaci nepotřebuje např. překladače C (všechno už je přeložené
  pro konkrétní OS a architekturu), a
- *wheel* se rychleji instaluje.

Proces vydání složitějšího softwaru pak může vypadat takto:

```console
(__venv__)$ rm dist/*
(__venv__)$ python -m build
[... kontrola vytvořených balíčků v „čistém“ virtualenvu ...]
(__venv__)$ python -m twine upload dist/*
```


Další
-----

K balíčkování existuje [obsáhlá dokumentace](https://packaging.python.org/).
Budete-li chtít dělat něco, co v tomto kurzu není, podívejte se tam!
