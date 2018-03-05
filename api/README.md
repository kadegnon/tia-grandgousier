# tia-grandgousier - API

Petit API écrit en Prolog permettant de gerer les vins en DB et de dialoguer avec le bot Grandgousier.

## Routes

- ``/list``     : GET - Liste toutes les routes disponibles à travers l'API.
- ``/api/**/*``     : Les datas envoyées/recues sont au format **JSON**.
- ``/api/appellation`` : **GET** - Liste toutes les appellations de vins disponibles.
- ``/api/bot/`` : **POST** - Questionne Grandgousier
- /api/vino/ : 
    1. **GET** - Liste toutes les vins en DB disponibles.
    2. **GET** - /api/vino/*<vin_id>* Detaille le vin avec l'ID correspondant.
    3. **POST** - /api/vino/*<vin_id>* Ajoute un nouveau vin dans la DB. Les attributs modifiables sont : 
     - *nom[string]* :Nom du vin
     - *description[string]* : Description du vin
     - *annee[integer]* : L'année de fabrication/embouteillage
     - *origine[string]* : Pays d'origine du vin.
     - *appelation[string]* : L'appelation du vin
     - *htva[float]* : Le prix de vente du vin Hors T.V.A.
     - *tvac[float]* : Le prix de vente du vin T.V.A. Compris
    4. **PUT** - /api/vino/<vin_id> Modifie le vin avec l'ID correspondant.
    5. **DELETE** - /api/vino/<vin_id> Supprime le vin avec l'ID correspondant.
