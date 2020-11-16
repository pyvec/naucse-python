# Vnořené seznamy

Seznam může obsahovat jakýkoli typ hodnot: čísla, řetězce a tak dále:

```python
prvocisla = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41]
zviratka = ['pes', 'kočka', 'králík']
odpovedi = [False, False, False, True, False, True, True]
```

Stejně tak může seznam obsahovat i další seznamy.
Podobně jako seznam čísel nebo seznam řetězců tak lze vytvořit seznam seznamů:

```python
seznam_seznamu = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
```

Takový seznam se chová docela normálně – můžeš z něj třeba brát jednotlivé
prvky (které jsou ovšem taky seznamy):

```python
prvni_seznam = seznam_seznamu[0]
print(prvni_seznam)
```

A protože jsou prvky samy seznamy,
dá se mluvit o věcech jako „první prvek druhého seznamu”:

```python
druhy_seznam = seznam_seznamu[1]
prvni_prvek_druheho_seznamu = druhy_seznam[0]
print(prvni_prvek_druheho_seznamu)
```

A protože výraz `seznam_seznamu[1]`
označuje seznam, můžeš brát prvky přímo z něj:

```python
prvni_prvek_druheho_seznamu = (seznam_seznamu[1])[0]
```

Neboli:

```python
prvni_prvek_druheho_seznamu = seznam_seznamu[1][0]
```

A má tahle věc nějaké použití?
Stejně jako vnořené cykly `for` ti umožnily vypsat tabulku, vnořené seznamy
ti umožní si tabulku „zapamatovat”.

```python
def vytvor_radek_tabulky(cislo_radku, velikost):
    """Vrátí seznam – daný řádek tabulky s násobilkou"""
    radek = []
    for cislo_sloupce in range(velikost):
        radek.append(cislo_radku * cislo_sloupce)
    return radek

def vytvor_tabulku(velikost):
    """Vrátí seznam seznamů – tabulku s násobilkou"""
    seznam_radku = []
    for cislo_radku in range(velikost):
        radek = vytvor_radek_tabulky(cislo_radku, velikost)
        seznam_radku.append(radek)
    return seznam_radku

nasobilka = vytvor_tabulku(11)

print(nasobilka[2][3])  # dva krát tři
print(nasobilka[5][2])  # pět krát dva
print(nasobilka[8][7])  # osm krát sedm

# Vypsání celé tabulky
for radek in nasobilka:
    for cislo in radek:
        print(cislo, end=' ')
    print()
```

Co s takovou „zapamatovanou” tabulkou?
Můžeš si do ní uložit třeba pozice
figurek na šachovnici nebo křížků a koleček
ve *2D* piškvorkách.
