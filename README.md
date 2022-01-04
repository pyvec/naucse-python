# Nauč se Python

Otevřené materiály pro výuku Pythonu.

Tento repozitář obsahuje kurzy pro samouky, které najdeš (se spoustou dalších)
na [naucse.python.cz](https://naucse.python.cz).


## Instalace a spuštění

Chceš-li server spustit na svém počítači, např. proto, že se chceš zapojit
do vývoje, je potřeba ho nejdřív nainstalovat:

* Přepni se do adresáře s kódem projektu.
* Nainstaluj `poetry`. Můžeš instalovat podle [oficiálního návodu](https://python-poetry.org/docs/#installation), nebo:

  * Vytvoř a aktivuj si [virtuální prostředí](https://naucse.python.cz/lessons/beginners/install/) v Pythonu 3.9+.

  * Linux/MacOS:

    ```console
    $ python3 -m pip install poetry
    ```

  * Windows:

    ```doscon
    > py -3 -m pip install poetry
    ```

* Vytvoř si prostředí a nainstaluj závislosti:

    ```doscon
    $ poetry install
    ```

Nainstalovanou aplikaci spustíš následovně:

* Spusť vývojový server:
  ```console
  $ poetry run python -m naucse serve
  ```
* Program vypíše adresu (např. `http://127.0.0.1:8003/`); tu navštiv v prohlížeči.


## Licence

Obsah kurzů má vlastní licenci, která je uvedena v metadatech.
Používáme pouze [licence pro otevřený obsah][free content licenses].
Všechen obsah musí mít uvedenou licenci.

---

Content has its own license specified in the appropriate matadata.
Only [free content licenses] are used. By contributing to an already licensed
document, you agree to have it licensed under the same license.
(And feel free to add yourself to the authors list in its metadata.)
When contributing new document(s) a license must be specified in the metadata.

[free content licenses]: https://en.wikipedia.org/wiki/List_of_free_content_licenses
