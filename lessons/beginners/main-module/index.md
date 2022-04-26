# Spouštěcí moduly

Automatické testy musí projít „bez dozoru“.
V praxi se často automaticky spouští, případné chyby se automaticky
oznamují (např. e-mailem) a fungující otestovaný kód se automaticky
začne používat dál (nebo se rovnou vydá zákazníkům).

Co to znamená pro nás?
Funkce `input` v testech nefunguje. Nemá koho by se zeptala; „za klávesnicí“
nemusí nikdo sedět.

To může někdy „ztěžovat práci“. Ukážeme si to na složitějším projektu:
na Kámen-Nůžky-Papír.

Kód pro Kámen-Nůžky-Papír může, velice zjednodušeně, vypadat zhruba takto:

```python
import random  # (příp. import jiných věcí, které budou potřeba)

tah_pocitace = 'kámen'
tah_hrace = input('Co chceš hrát (kámen, nůžky, papír)? ')

# (tady reálně bude spousta zanořených ifů)
if tah_hrace == 'papír':
    print('Vyhrál{{a}} jsi!')
else:
    print('Nevyhrál{{a}} jsi...')

```

Když tenhle modul naimportuješ, Python v něm postupně, odshora dolů,
provede všechny příkazy.

První příkaz, `import`, jen zpřístupní nějaké proměnné a funkce;
je-li importovaný modul správně napsaný, nemá vedlejší účinek.
Definice funkcí (příkazy `def` a všechno v nich) podobně jen definují funkce.
Ale zavoláním funkce `input` se spustí interakce: program potřebuje vstup
od uživatele.

Importuješ-li tenhle modul z testů, `input` selže a import se nepovede.

> [note]
> A kdybys modul importoval{{a}} odjinud – například bys chtěl{{a}} tuhle
> funkčnost použít v nějaké jiné hře – uživatel si bude muset v rámci importu
> zahrát Kámen-Nůžky-Papír!

Volání funkce `input` je vedlejší efekt.
Je potřeba ho odstranit.
Importovatelné moduly by měly pouze dát k dispozici nějaké funkce nebo hodnoty.
Dej tedy hru do funkce:

```python
# knp.py -- importovatelný modul

import random  # (příp. import jiných věci, které budou potřeba)

def hrej_hru():
    tah_pocitace = 'kámen'
    tah_hrace = input('Co chceš hrát (kámen, nůžky, papír)? ')

    # (tady reálně bude spousta zanořených ifů)
    if tah_hrace == 'papír':
        print('Vyhrál{{a}} jsi!')
    else:
        print('Nevyhrál{{a}} jsi...')

```

No jo, ale po takovém odstranění
už nejde jednoduše spustit hra! Co s tím?

Můžeš na to vytvořit nový modul, ve kterém bude jenom volání funkce:

```python
# hra.py -- spouštěcí modul

import knp

knp.hrej_hru()
```

Tenhle modul nebudeš moci testovat (protože nepřímo volá funkci `input`),
ale můžeš ho spustit, když si budeš chtít zahrát.
Protože k němu nemáš napsané testy, nepoznáš
z nich, když se takový spouštěcí modul rozbije.
Spouštěcí modul by proto měl být co nejjednodušší – jeden import a jedno volání.

Původní modul teď můžeš importovat bez obav – ať už z testů nebo z jiných
modulů.
Pořád se ale, kvůli funkcím `input` a `print`, špatně testuje.
Aby se testoval líp, můžeš kousek funkčnosti dát do jiné funkce:

```python
# knp.py -- importovatelný modul

import random  # (příp. import jiných věci, které budou potřeba)

def vyhodnot(tah_pocitace, tah_hrace):
    # (tady reálně bude spousta zanořených ifů)
    if tah_hrace == 'papír':
        return 'Vyhrál{{a}} jsi!'
    else:
        return 'Nevyhrál{{a}} jsi...'


def hrej_hru():
    tah_pocitace = 'kámen'
    tah_hrace = input('Kam chceš hrát?')

    vysledek = vyhodnot(tah_pocitace, tah_hrace)
    print(vysledek)
```

A vida! Funkce `vyhodnot` teď neobsahuje ani `print` ani `input`.
Půjde tedy docela jednoduše otestovat:

```python
# test_knp.py -- testy

import knp

def test_vyhry():
    assert vyhodnot('kámen', 'papír') == 'Vyhrál{{a}} jsi!'
    assert vyhodnot('papír', 'nůžky') == 'Vyhrál{{a}} jsi!'
    assert vyhodnot('nůžky', 'kámen') == 'Vyhrál{{a}} jsi!'
```

Funkce `hrej_hru` ovšem tak dobře otestovat nejde.
Musíš ji testovat ručně.
Protože ale hlavní část programu (`vyhodnot`) jde pokrýt automatickými testy,
ruční testování nemusí být tak důkladné.



## Negativní testy

Test `test_vyhry`, ukázaný výše, není úplný.
Splnila by ho i funkce jako:

```python
def vyhodnot(tah_pocitace, tah_hrace):
    return 'Vyhrál{{a}} jsi!'
```

Kromě „pozitivních“ výsledků je potřeba kontrolovat i ty „negativní“:
ať už očekávaný negativní výsledek (jako prohru nebo remízu)
nebo reakci programu na špatné nebo neočekávané podmínky.

Co třeba má dělat volání `vyhodnot(8, 'kukačka')`?

Testy, které kontrolují reakci na „špatný“ vstup,
se jmenují *negativní testy*.
Často kontrolují to, že nastane nějaká výjimka.

Na otestování výjimky použij příkaz `with` a funkci `raises` naimportovanou
z modulu `pytest`.
Jak příkaz `with` přesně funguje, to se dozvíš později;
teď stačí říct, že `with pytest.raises` ověří, že odsazený blok kódu
pod ním vyvolá danou výjimku:

```python
def test_spatneho_tahu():
    """🤘 vs. 🖖 není správný vstup"""
    with pytest.raises(ValueError):
        vyhodnot('metal', 'spock')
```
