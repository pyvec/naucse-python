Prozatím jsme si při programování vystačili hlavně s operátory.
Sčítali jsme čísla pomocí <code>+</code>, porovnávali jsme pomocí `if`.

V Pythonu je operátorů poměrně málo. Už z nich známe skoro půlku!
Tady jsou všechny Pythonní operátory:

<div>
    <code>==</code> <code>!=</code>
    <code>&lt;</code> <code>&gt;</code>
    <code>&lt;=</code> <code>&gt;=</code>
    <code class="text-muted">|</code> <code class="text-muted">^</code>
    <code class="text-muted">&amp;</code>
    <code class="text-muted">&lt;&lt;</code> <code class="text-muted">&gt;&gt;</code>
    <code>+</code> <code>-</code>
    <code>*</code> <code class="text-muted">@</code> <code>/</code>
    <code>//</code> <code>%</code>
    <code class="text-muted">~</code>
    <code>**</code>
    <code class="text-muted">[ ]</code> <code class="text-muted">( )</code>
    <code class="text-muted">{ }</code>
    <code class="text-muted">.</code>
</div>

<div>
    <code class="text-muted">lambda</code>
    <code class="text-muted">if else</code>
    <code>or</code> <code>and</code> <code>not</code>
    <code class="text-muted">in</code> <code class="text-muted">not in</code>
    <code class="text-muted">is</code> <code class="text-muted">is not</code>
</div>


Asi jste si ale neuvědomili, že jsme pracovali i s funkcemi - třeba s `print`
nebo `input`.

Co je to tedy funkce? Jedná se o kus kódu, který je nějako pojmenovaný, třeba
právě `print`. Tento kód provádí to, co popisuje jeho název - `print`
tiskne text. Funkce mívají vstupy, což jsou hodnoty, se kterými se v kódu dále
pracuje - `print` má jako vstup mj. text, který se má vytisknout. Funkce také mívají
výstup. Díky tomu můžeme výsledek funkce použít v dalších částech programu.

V Pythonu se funkce sdružují do modulů. No modulech není nic složitého -
jsou to jen soubory s příponou <code>.py</code>. Jméno modulu je stejné,
jako jméno souboru.

Příkladem funkce z matematiky je sinus:
* <var>x</var> = sin <var>a</var>

Python má tuto funkci zabudovanou, jenom přidáme závorky,
aby bylo jasnější, k čemu se operace vztahuje:

```python
slovo = 'Ahoj'
delka = len(slovo)      # Vypočítání délky
print(delka)
```

Funkce `sin` se musí *naimportovat* z modulu `math`.

```python
from math import sin

x = sin(1)  # (v radiánech)
print(x)
```

Jak je vidět, funkce sinus je tak trochu schovaná.
Přece jen, `print` nebo `if` potřebují všichni, ale ne všichni mají
rádi matematiku…

> [warning] Import a pojmenování souborů
> Při importování je potřeba si dávat pozor na pojmenování souborů:
> importuješ-li `from math`, nesmí se tvůj program jmenovat `math.py`.
>
> Proč? Když Python v adresáři, ze kterého program pouštíš, najde soubor
> `math.py`, bude se snažit importovat `sin` z něho místo
> z předpřipravené sady matematických funkcí.

## Volání funkcí

Funkci voláme *jménem*.

Je to jméno jako u proměnných – vlastně to *je* proměnná,
jen je v ní, místo čísla nebo řetězce, funkce.

K tomu, abys funkci mohl{{a}} použít, potřebuješ znát její
*jméno* – tady `len`.
Za jméno funkce patří závorky,
do nichž uzavřeš *argument* (neboli *vstup*) funkce.
To je informace, se kterou bude funkce
pracovat – třeba `len` ze svého argumentu vypočítá délku.

Celému výrazu `len(slovo)` se říká *volání funkce* (angl. *function call*).
Jeho výsledek, takzvaná *návratová* hodnota
(angl. *return value*) se dá třeba přiřadit do proměnné.

{{ figure(img=static('call-anatomy.svg'), alt="Diagram volání funkce") }}

> [note] Pro matemati{{gnd('', 'č', both='')}}ky
> Máš-li rád{{a}} matematiku, dej pozor!
> Funkce v Pythonu je něco jiného než funkce v matematice,
> i když se stejně jmenují a podobně zapisují.
> Pythonní funkce může např. mít pro stejný argument různé hodnoty.


### Volání funkce jako výraz

Vzpomínáš si, jak Python vyhodnocuje výrazy?

```python
vysledek = 3 * (5 + 2)
#              ╰──┬──╯
vysledek = 3 *    7
#          ╰─┬────╯
vysledek =  21
```

Volání funkce je taky výraz.
Stejně jako `a + b` je výraz, který něco udělá podle hodnot `a` a `b`
a výsledek dá k dispozici, `len(slovo)` je výraz, který něco udělá
podle hodnoty `slovo` a výsledek dá k dispozici.

Vždycky, když Python při vyhodnocování narazí na jméno funkce se závorkami,
funkci *zavolá*, zjistí výsledek a dosadí ho:

```python
vysledek = len("Ahoj!")
#          ╰────┬─────╯
vysledek =      5
```

Volání funkce můžeš kombinovat s jinými výrazy, třeba se součtem:

```python
delka = len('Ahoj') + len('!')
#        ╰──┬─────╯    ╰─┬───╯
delka =     4       +    1
#           ╰───────┬────╯
delka =             5
```

Nebo v podmínce ifu – třeba u:

```python
if len('Ahoj!') <= 3:
    print('pozdrav je krátký')
```

… se za `len('Ahoj!') <= 3` nakonec dosadí nepravda (`False`):

```python
   len('Ahoj!') <= 3
#  ╰─────┬────╯
         5      <= 3
#        ╰──────┬──╯
              False
```

Volání funkce můžeš použít i jako argument pro jinou funkci:

```python
print(len('Ahoj'))
#     ╰────┬────╯
print(     4     )   # vypíše 4
```

Nebo to zkombinovat dohromady:

```python
x = 5
print(len('Ahoj') + x)
#     ╰────┬────╯   |
print(     4      + 5)
#          ╰───┬────╯
print(         9     )
```

… a podobně.


### Procedury

Možná sis všiml{{a}}, že jednu funkci už voláš déle: `print("Ahoj!")`
je taky volání funkce.
Stejně jako `len` dostává `print` v závorkách argument – hodnotu, se
kterou pracuje.
Liší se ale návratovou hodnotou.

Funkce `print` sice něco *udělá* – vypíše text
na obrazovku – ale nevrátí žádný smysluplný výsledek, který by zbytek programu
mohl dál zpracovat.

Funkcím, které nic nevrací (jen něco udělají) se občas říká *procedury*.
V Pythonu není hranice mezi „normální“ funkcí a procedurou příliš ostrá,
ale přesto se hodí tento koncept znát.
Pár příkladů:

* Funkce, která vybere náhodné číslo, je „normální“.
  Svůj výsledek vrátí; program s ním může dál pracovat.
* Funkce, která vykreslí na obrazovku kolečko, je *procedura*.
  Žádnou zajímavou hodnotu programu nevrací.
* Funkce, která spočítá průměrný věk obyvatelstva podle informací ze sčítání
  lidu je „normální“. Svůj výsledek vrátí a program s ním může dál pracovat.
* Funkce, která přehraje písničku reproduktorem, je *procedura*.
  Nic zajímavého programu nevrací.

> [note]
> Na rozdíl od ostatních termínů, které se tu učíš, není
> „procedura“ v Pythonu zavedený pojem.
> Je vypůjčený z jazyka Pascal.
> Kdybys o něm diskutoval{{a}} s nějakým zkušeným programátorem,
> odkaž ho prosím na tyto materiály.


## Argumenty

Argument je to, co funkci dáš k dispozici. Hodnota, se kterou funkce pracuje.
Chceš-li délku řetězce `Ahoj!`, použiješ funkci `len` která umí vypočítat
délku *jakéhokoli* řetězce a jako argument, v závorkách, jí dáš tu svoji
konkrétní hodnotu: `len('Ahoj!')`.

Podobně funkce `print` umí vypsat jakoukoli hodnotu.
Tu, kterou má vypsat ve tvém konkrétním případě, jí předáš jako argument.

Některým funkcím můžeš předat i více argumentů.
Třeba zrovna funkci `print`, která všechny své argumenty vypíše na řádek.
Jednotlivé argumenty se oddělují čárkami:

```python
print(1, 2, 3)
```

```python
print("Jedna plus dva je", 1 + 2)
```

Některé funkce nepotřebují žádný argument.
Příkladem je zase `print`.
Je ale nutné použít závorky – i když jsou prázdné.
Hádej, co tohle volání udělá?

```python
print()
```

{% filter solution %}
Funkce `print` zavolaná bez argumentů napíše prázdný řádek.
{% endfilter %}


### Pojmenované argumenty

Některé funkce umí pracovat i s *pojmenovanými* argumenty.
Píšou se podobně jako přiřazení do proměnné,
s rovnítkem, ale uvnitř závorek.

Třeba funkce `print` při výpisu odděluje jednotlivé argumenty mezerou,
ale pomocí argumentu `sep` se dá použít i něco jiného.

```python
print(1, 2, 3, 4, sep=', ')     # Místo mezery odděluj čárkou
```

Dá se změnit i to, co `print` udělá na konci výpisu.
Normálně přejde na nový řádek, ale argumentem `end` můžeš říct, co se má vypsat 
*místo toho*.

> [note]
> Tenhle příklad je potřeba napsat do souboru; v interaktivní konzoli
> nebude výstup vypadat tak, jak má.

```python
print('1 + 2', end=' ')     # Místo přechodu na nový řádek jen napiš mezeru
print('=', end=' ')
print(1 + 2, end='!')
print()
```


### Funkce je potřeba volat

Pozor na to, že když nenapíšeš závorky, funkce se nezavolá!
Výraz `len(s)` je *volání funkce*, ale `len` bez závorek označuje
*funkci samotnou*.

Výsledek `len(s)` je číslo; `len` je funkce.

Čísla můžeš sečítat, můžeš tedy napsat `len(s) + 1`.
Funkce ale sečítat nejde – `len + 1` nedává smysl.

Často se ale stane, že závorky prostě zapomeneš.
Zkus si, co dělají následující příklady, a pozorně si přečti výsledky
a chybové hlášky, abys pak podobné chyby poznal{{a}}:

```python
print(len('a'))     # Volání funkce (a vypsání výsledku)
print(len)          # Vypsání samotné funkce
print(len + 1)      # Sečtení funkce a čísla
```

## Přehled funkcí

```python
input('zadej vstup: ')
```

### Převádění typů


Co ale když nechceme pracovat s řetězcem, ale třeba s číslem?
Tady nám pomůže skupina funkcí, které umí převádět čísla na řetězce a zpátky.
Každý ze tří <em>typů</em> (angl. <em>types</em>) proměnných, které zatím známe,
má funkci, která vezme nějakou hodnotu a vrátí podobnou hodnotu „svého“ typu.
Na celá čísla je funkce `int` (z angl. *integer*), na reálná čísla je `float`
(z angl. *floating-point*), a pro řetězce `str` (z angl. *string*).

```python
int(x)              # převod na celé číslo
float(x)            # převod na reálné číslo
str(x)              # převod na řetězec
```

Příklady:

```python
3 == int('3') == int(3.0) == int(3.141) == int(3)
8.12 == float('8.12') == float(8.12)
8.0 == float(8) == float('8') == float(8.0)
'3' == str(3) == str('3')
'3.141' == str(3.141) == str('3.141')
```
Ne všechny převody jsou možné:

```python
int('blablabla')    # chyba!
float('blablabla')  # chyba!
int('8.9')          # chyba!
```

…a jak si poradit s chybou, která nastane,
když použiješ špatnou hodnotu, si řekneme později.
{%- if var('pyladies') %}
Teď je hlavní to, že už víš, jak funguje
`int(input('zadej číslo: '))` z minula!
{% endif %}


### Matematické funkce

Matematika je občas potřeba, takže se pojďme
podívat, jak v Pythonu pracovat s čísly.

Jedna zajímavá matematická funkce je k dispozici vždy:

```python
round(cislo)    # zaokrouhlení
```

Spousta dalších se dá importovat z modulu `math`:

```python
from math import sin, cos, tan, sqrt, floor, ceil

sin(uhel)       # sinus
cos(uhel)       # kosinus
tan(uhel)       # tangens
sqrt(cislo)     # druhá odmocnina

floor(cislo)    # zaokrouhlení dolů
ceil(cislo)     # zaokrouhlení nahoru
```

### Náhoda

Nakonec si ukážeme dvě funkce z modulu
`random`, které jsou velice
užitečné pro hry.

```python
from random import randrange, uniform

randrange(a, b)   # náhodné celé číslo od a do b-1
uniform(a, b)     # náhodné reálné číslo od a do b
```

Pozor na to, že <code>randrange(a, b)</code>
nikdy nevrátí samotné <code>b</code>.
Pokud potřebujeme náhodně vybrat ze tří možností,
použij <code>randrange(0, 3)</code>,
což vrátí <code>0</code>, <code>1</code>, nebo
<code>2</code>:

```python
from random import randrange

cislo = randrange(0, 3)  # číslo je od 0, 1, nebo 2
if cislo == 0:
    print('Kolečko')
elif cislo == 1:
    print('Čtvereček')
else:  # 2
    print('Trojúhelníček')
```

> [note]
> Pamatuj, když importuješ z modulu `random`, nesmí se tvůj soubor
> jmenovat `random.py`.

### A další
Python dává k dispozici obrovské množství dalších
funkcí a modulů, i když ne všem budeš ze začátku
rozumět.
Všechny jsou – anglicky – popsány v dokumentaci Pythonu, např.
<a href="https://docs.python.org/3/library/functions.html">vestavěné funkce</a>,
<a href="https://docs.python.org/3/library/math.html">matematika</a>.
