# Slovníky

Další základní datový typ, který si představíme –
po číslech, řetězcích, seznamech a <var>n</var>-ticích –
je *slovník* (angl. *dictionary*, `dict`).

Představ si překladový slovník, třeba tenhle česko-anglický:

* **Jablko**: Apple
* **Knoflík**: Button
* **Myš**: Mouse

Slovník v Pythonu obsahuje *záznamy*. Každý záznam přiřazuje
nějakému *klíči* nějakou *hodnotu*.
V našem příkladu je klíči *Jablko* přiřazena hodnota *Apple*,
klíči *Knoflík* náleží hodnota *Button*
a klíč *Myš* ukazuje na *Mouse*.

V Pythonu by se takový slovník napsal následovně:

``` pycon
>>> slovnik = {'Jablko': 'Apple', 'Knoflík': 'Button', 'Myš': 'Mouse'}
>>> slovnik
{'Jablko': 'Apple', 'Knoflík': 'Button', 'Myš': 'Mouse'}
```
Pozor na všechny ty symboly!
V tomhle slovníku jsou klíče i hodnoty řetězce, takže jsou v uvozovkách.
Každý klíč je od své hodnoty oddělený dvojtečkou;
jednotlivé dvojice jsou od sebe oddělené čárkou.
A celý slovník je uzavřený ve složených závorkách.

Když budeš chtít v takovém slovníku něco najít, potřebuješ vědět co hledat.
Konkrétně potřebuješ *klíč*.
Ten dáš do hranatých závorek:

``` pycon
>>> slovnik['Jablko']
'Apple'
```

Je to podobné jako u seznamů, jen v hranatých závorkách není index
(pořadové číslo prvku) nebo rozmezí s dvojtečkou, ale právě klíč.

> [note]
> Naopak to nejde – slovník neumožňuje podle hodnoty přímo zjistit klíč.
> Na překlad z angličtiny do češtiny bys potřeboval{{a}} druhý slovník.

## Měnění slovníků

Co se stane, když klíč ve slovníku není?

``` pycon
>>> slovnik['Pes']
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
KeyError: 'Pes'
```

Python si postěžuje na `KeyError` – chybu klíče.

Podobně jako seznamy se ale slovníky dají měnit.
Nový záznam vytvoříš takhle:

``` pycon
>>> slovnik['Pes'] = 'Dog'
>>> slovnik
{'Jablko': 'Apple', 'Knoflík': 'Button', 'Myš': 'Mouse', 'Pes': 'Dog'}
```

> [note]
> Na rozdíl od překladového slovníku nemusí být Pythonní slovník seřazený
> podle abecedy.
> Není to potřeba, počítač umí rychle vyhledávat i bez seřazení.

Kdybys potřeboval{{a}} změnit už existující záznam, použij stejný příkaz.
K jednomu klíči může být přiřazena jen jedna hodnota.

``` pycon
>>> slovnik['Pes'] = 'Power strip'
>>> slovnik
{'Jablko': 'Apple', 'Knoflík': 'Button', 'Myš': 'Mouse', 'Pes': 'Power strip'}
```

Chceš-li ze slovníku nějaký záznam smazat, dělá se to podobně jako
u seznamů – příkazem `del`:

``` pycon
>>> del slovnik['Pes']
>>> slovnik
{'Jablko': 'Apple', 'Knoflík': 'Button', 'Myš': 'Mouse'}
```

Když budeš chtít zjistit, kolik je ve slovníku záznamů,
zeptáš se podobně jako na počet znaků řetězce nebo prvků seznamu.
Použiješ funkci `len()`.

``` pycon
>>> len(slovnik)
3
```

A pomocí `in` můžeš zjistit, jestli slovník obsahuje daný klíč.
Funguje to opravdu jen pro klíče, ne pro přiřazené hodnoty:

``` pycon
>>> 'Myš' in slovnik
True
>>> 'Mouse' in slovnik
False
```

## Iterace

Když slovník projdeš cyklem `for`, dostaneš *klíče* jednotlivých záznamů:

```pycon
>>> for klic in slovnik:
...     print(klic)
Jablko
Knoflík
Myš
```

Kdybys chtěl{{a}} projít místo klíčů hodnoty, použij metodu `values`,
která vrací iterátor hodnot:

```pycon
>>> for hodnota in slovnik.values():
...     print(hodnota)
Apple
Button
Mouse
```

Většinou ale potřebuješ jak klíče tak hodnoty.
K tomu mají slovníky metodu `items`, která vrací iterátor dvojic.
Často využiješ možnost každou dvojici přímo rozbalit v cyklu `for`,
jako se to dělá se `zip` nebo `enumerate`:

```pycon
>>> for klic, hodnota in slovnik.items():
...     print('{}: {}'.format(klic, hodnota))
Jablko: Apple
Knoflík: Button
Myš: Mouse
```

V průběhu iterace (tedy v rámci `for` cyklu) nesmíš
do slovníku přidávat záznamy, ani záznamy odebírat:

```python
>>> for klic in slovnik:
...     del slovnik[klic]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
RuntimeError: dictionary changed size during iteration
```

Hodnoty u už existujících klíčů ale měnit můžeš.

## Jak udělat slovník

Slovník se dá vytvořit několika způsoby.
První, pomocí složených závorek, jsi už viděl{{a}}.
Další způsob využívá funkci `dict`.
Ta, ve stylu `str`, `int` či `list`, převede cokoli co jde na slovník.

Slovník je ovšem dost specifická struktura –
čísla ani většina seznamů na něj převést nejdou.
Můžeš ale na slovník převést *jiný slovník*.
Nový slovník pak žije svým vlastním životem;
můžeš ho měnit nezávisle na tom původním.


Druhá věc, která jde převést na slovník, je
*sekvence dvojic* klíč/hodnota – ať už seznam:

```pycon
>>> data = [(1, 'jedna'), (2, 'dva'), (3, 'tři')]
>>> nazvy_cisel = dict(data)
>>> nazvy_cisel
{1: 'jedna', 2: 'dva', 3: 'tři'}
```

nebo jiný iterovatelný objekt:

```pycon
>>> data = enumerate(['nula', 'jedna', 'dva'])
>>> nazvy_cisel = dict(data)
>>> nazvy_cisel
{0: 'nula', 1: 'jedna', 2: 'dva'}
```

A to je vše, co se na slovník dá převést.

Jako bonus umí funkce `dict` ještě
brát pojmenované argumenty.
Každé jméno argumentu převede na řetězec,
použije ho jako klíč, a přiřadí danou hodnotu:

```python
popisy_funkci = dict(len='délka', str='řetězec', dict='slovník')
print(popisy_funkci['len'])
```

> [note]
> Pozor na to, že v tomhle případě musí být klíče
> pythonní „jména“ – musí být použitelné jako jména proměnných.
> Například takhle nejde zadat jako klíč řetězec
> `"def"` nebo `"propan-butan"`.


### Zaplň prázdný slovník

Nejobecnější způsob vytváření slovníků je podobný tomu, co znáš u seznamů:
vytvoř prázdný slovník a postupně do něj přidávej záznamy, jeden za druhým.

Řekněme, že máš slovník, který přiřazuje ovoci jeho barvu:

```python
barvy = {
    'hruška': 'zelená',
    'jablko': 'červená',
    'meloun': 'zelená',
    'švestka': 'modrá',
    'ředkvička': 'červená',
    'zelí': 'zelená',
    'mrkev': 'červená',
}
```

Následující kód vytvoří slovník se změněnými barvami:

```python
barvy_po_tydnu = {}
for ovoce, barva in barvy.items():
    barvy_po_tydnu[ovoce] = 'černo-hnědo-' + barva

print(barvy_po_tydnu['jablko'])
```


## Typy klíčů a hodnot

Do slovníku můžeš uložit jakoukoli hodnotu: řetězce, seznamy, nebo čísla.

```python
uzivatel = {'jméno': 'Amálka', 'velikost nohy': 36, 'oblíbená čísla': [5, 27]}
```

Jako *klíč* jde ovšem použít jen hodnoty, podle kterých pak Python umí záznam
rychle najít.
A to nejsou všechny. Řetězce a čísla použít jdou:

```python
jmena_cisel = {2: 'dva', 3: 'tři'}
```

Ale seznamy nebo jiné slovníky ne.
Typy, které se dají použít jako klíč ve slovníku, se technicky označují jako
„*hashovatelné*“ (angl. *hashable*).
Tento termín se objevuje v chybových hláškách:

```pycon
>>> jmena_seznamu = {[1, 2, 3]: 'čísla', ['a', 'b', 'c']: 'řetězce'}
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unhashable type: 'list'
```

<var>N</var>-tice jsou hashovatelné, pokud obsahují jen hashovatelné hodnoty:

```pycon
>>> figurky = {('c', 1): 'bílý střelec', ('e', 8): 'černý král'}
>>> figurky['c', 1]
'bílý střelec'
```

```pycon
>>> jmena = {([1, 2, 3], [3, 4, 5]): 'dvojice seznamů'}
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unhashable type: 'list'
```


## A to je zatím ke slovníkům vše

Chceš-li mít všechny triky, které  slovníky umí,
pěkně pohromadě, můžeš si stáhnout
[Slovníkový tahák](https://pyvec.github.io/cheatsheets/dicts/dicts-cs.pdf).

Kompletní popis slovníků najdeš
v [dokumentaci](https://docs.python.org/3/library/stdtypes.html#mapping-types-dict)
Pythonu.
