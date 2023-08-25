# Vrátit nebo vypsat?

Podívejme se teď na následující program, který vypíše obsah elipsy:

```python
from math import pi

def obsah_elipsy(a, b):
    return pi * a * b

print('Obsah elipsy s poloosami 3 a 5 je', obsah_elipsy(3, 5), 'cm2')
```

Takový program se teoreticky dá napsat i s procedurou, tedy funkcí, která nic
nevrací.
Procedura může výsledek třeba vypsat na obrazovku:

```python
from math import pi

def obsah_elipsy(a, b):
    print('Obsah je', pi * a * b)  # Pozor, `print` místo `return`!

obsah_elipsy(3, 5)
```

Program takhle funguje, ale přichází o jednu z hlavních výhod funkcí:
možnost vrácenou hodnotu použít i jinak než jen v `print`.

Funkci, která *vrací* výsledek, můžeš použít v dalších výpočtech:

```python
def objem_eliptickeho_valce(a, b, vyska):
    return obsah_elipsy(a, b) * vyska

print(objem_eliptickeho_valce(3, 5, 3))
```

... ale s procedurou, která výsledek přímo vypíše, by to nešlo.
Proto je dobré psát funkce, které spočítané hodnoty vrací,
a zpracování výsledku (např. vypsání) nechat na kód mimo funkci.

Další důvod, proč hodnoty spíš vracet než vypisovat je ten, že jedna funkce se
dá použít v různých situacích.
Proceduru s `print` by nešlo rozumně použít tehdy, když nás příkazová
řádka vůbec nezajímá – třeba v grafické hře, webové aplikaci nebo pro ovládání
robota.

Podobně je to se vstupem: když použiju v rámci své funkce `input`, bude se
moje funkce dát použít jen v situacích, kdy je u počítače klávesnice a za ní
člověk.
Proto je lepší funkcím potřebné informace předávat jako argumenty
a volání `input` (nebo čtení textového políčka či měření čidlem robota)
nemít ve funkci, ale vně, v kódu, který funkci volá:

```python
from math import pi

def obsah_elipsy(a, b):
    """Vrátí obsah elipsy s poloosami daných délek"""
    # Jen samotný výpočet:
    return pi * a * b

# print a input jsou "venku":
x = float(input('Zadej délku poloosy 1: '))
y = float(input('Zadej délku poloosy 2: '))
print('Obsah je', obsah_elipsy(x, y))
```

Samozřejmě existují výjimky: procedura, která přímo vytváří textový výpis
(např. tabulku), může používat `print`; funkce, která načítá textové informace
(jako `ano_nebo_ne` výše), zase `input`.
Když ale funkce něco *počítá*, nebo když si nejsi jist{{gnd('ý', 'á')}},
je dobré ve funkci `print` ani `input` nemít.


## None

Když funkce neskončí příkazem `return`,
automaticky se vrátí hodnota `None`.

Je to hodnota zabudovaná přímo do Pythonu, podobně jako `True` nebo `False`,
a znamená „nic“.

```python
def nic():
     """Tahle funkce nic nedělá """

print(nic())
```

Procedury v Pythonu vracejí právě toto „nic“.
