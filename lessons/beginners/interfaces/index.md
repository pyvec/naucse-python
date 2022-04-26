# Rozhraní

Už víš že funkce ti umožňují kousek kódu:

* použít (zavolat) na více místech v programu, i když definice je jen jedna,
* vyčlenit, aby detail (jako načtení čísla od uživatele) „nezavazel“ ve větším
  programu, který tak může být přehlednější, a
* pojmenovat, aby bylo jasné co kód dělá i bez toho, abys musel{{a}} číst
  samotné tělo funkce.

Další výhoda funkce je, že ji můžeš jednoduše vyměnit za jinou,
lepší funkci – pokud má ta lepší funkce stejné *rozhraní* (angl. *interface*).

Aby se ti líp představovalo, o čem budeme povídat, představ si elektrickou
zásuvku ve zdi.
Do takové zásuvky můžeš zapojit počítač, lampu, nabíječku na mobil, vysavač,
nebo rádio.
Zásuvka poskytuje elektrický proud; je jedno, jak ho použiješ.
Stejně tak je jedno jestli je „druhý konec“ zásuvky připojený k solárnímu
panelu nebo k atomové elektrárně.
Zásuvka poskytuje elektrický proud, a jsou u ní důležité určité parametry
(tvar, napětí, frekvence, maximální proud) na kterých se obě strany,
poskytovatel proudu i spotřebič, shodly.
Tyhle parametry tvoří *rozhraní*, které umožňuje připojit jakýkoli spotřebič
k jakékoli elektrárně.


## Rozhraní funkce

Podívej se na tuhle hlavičku funkce.
Je z ní poznat, co ta funkce dělá a jak ji použít?

```python
def ano_nebo_ne(otazka):
    """Zeptá se uživatele na otázku a vrátí True nebo False dle odpovědi"""
    ...
```

Podobnou funkci už jsi napsal{{a}}.
Když zavoláš `ano_nebo_ne('Chutná ti čokoláda?')`, otázka se objeví
na příkazové řádce.
Když uživatel odpoví, funkce vrátí True nebo False.

Co kdybys ale měl{{a}} následující funkci?

```python
def ano_nebo_ne(otazka):
    """Ukáže tlačítka "Ano" a "Ne" a až uživatel jedno zmáčkne, vrátí True
    nebo False dle stisknutého tlačítka."""
    ...
```

<img src="{{ static('yn.png') }}" alt="Screenshot s tlačítky Ano a Ne" style="display:block;float:right;">

Když zavoláš tuhle funkci, `ano_nebo_ne('Chutná ti čokoláda?')`, ukáže se
okýnko se dvěma tlačítky.
Když uživatel jedno zmáčkne, funkce vrátí True nebo False.

Z hlediska programu se nic nemění: jediné co se změní je *definice funkce*;
volání a práce s návratovou hodnotou je pak stejné jako dřív.


### Vyzkoušej si to!

Najdi nějaký svůj program, který používá `ano_nebo_ne`, případně jen `print`
a `input`.

Stáhni si modul <a href="{{ static('tkui.py') }}"><code>tkui.py</code></a>
do adresáře se svým programem.
Naimportuj z něho funkce, které potřebuješ.
Jsou k dispozici čtyři:

```python
from tkui import input, nacti_cislo, ano_nebo_ne, print
```

Tento import *přepíše* vestavěné funkce `input` a `print` variantami,
které mají (téměř) stejné rozhraní – jen dělají něco trochu jinak.

Případné vlastní definice funkcí `nacti_cislo` a `ano_nebo_ne` pak z programu
vyndej, aby se použily ty naimportované.

> [note]
> Funkce `tkui.nacti_cislo` potřebuje Python verze 3.7 nebo vyšší.
> Používáš-li Python 3.6, `nacti_cislo` nenahrazuj.

Program by měl fungovat stejně jako dřív!

Je to tím, že tyto funkce mají stejné *rozhraní* jako jejich dřívější protějšky.
Rozhraní funkce tvoří všechno, co potřebuje kód který funkce volá:

* jméno, kterým se funkce volá,
* argumenty, které bere (např. `input` bere otázku jako řetězec; `print`
  může brát více argumentů k vypsání), a
* návratová hodnota, se kterou program pracuje dál (např. `input` vrací
  řetězec; `print` nevrací nic smysluplného).

Nékteré z těchto informací musíš do hlavičky funkce napsat vždy.
Ty ostatní je dobré popsat v dokumentačním řetězci, aby ten, kdo chce funkci
použít, věděl jak na to.


> [note]
> Modul `tkui` je jen ilustrační. Je udělaný tak, aby se dobře “instaloval”
> spíš než aby ti pomohl psát reálné programy.
> V tomto kurzu se vrátíme zpět k příkazové řádce, která je dělaná tak
> aby byla užitečná pro programátory.
