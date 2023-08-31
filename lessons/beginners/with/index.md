
# Kontext: `with` a `finally`

> [note]
> Čteš-li tyto materiály poprvé, tuto sekci můžeš s klidným svědomím přeskočit.
> Pokročilejším ale doporučuju vsadit věci do širšího kontextu.

Příkaz `with` pracuje s tzv. *kontextem* (tady s kontextem *otevřeného
souboru*), který má začátek a konec a při ukončení je potřeba něco udělat
(tady zavřít soubor).

Kontext je v podstatě zkratka pro `try`/`finally`. Pamatuješ si na `finally`?

Toto:

```python
with open('basnicka.txt', encoding='utf-8') as soubor:
    # Zpracování souboru
    obsah = soubor.read()
```

je zkratka pro:

```python
soubor = open('basnicka.txt', encoding='utf-8')
try:
    # Zpracování souboru
    obsah = soubor.read()
finally:
    # Ukončení kontextu
    soubor.close()
```

Jak `with` tak `finally` zaručí, že se soubor vždy uzavře:
když se zpracování povede, ale i když v něm nastane výjimka,
nebo když z něj vyskočíš pomocí `return` nebo `break`:

```python
def nacti_cele_cislo(jmeno_souboru):
    with open(jmeno_souboru, encoding='utf-8') as soubor:
        return int(soubor.read())
        # I když "return" vyskočí z funkce (nebo int() zbůsobí ValueError),
        # soubor se zavře.


# Pro vyzkoušení napiš do souboru 'cislo.txt' nějaké číslo.
print(nacti_cele_cislo('cislo.txt') * 11)
```


## Kontrola výjimek

Chování příkazu `with` závisí na objektu, se kterým jej použiješ.
Pro soubor – výsledek funkce `open` – se soubor na konci bloku zavře.
Podobných „samozavíracích“ objektů které se dají použít s `with` existuje
v různých knihovnách víc.
Typické jsou objekty, které se starají o připojení např. k jinému počítači
nebo k databázi, kdy je po práci dobré spojení ukončit a „uklidit po sobě“.

Z lekce o testování si možná pamatuješ `with pytest.raises(...):`.
Výsledek `pytest.raises` na konci bloku `with` kontroluje, že v rámci bloku
nastala správná výjimka.
