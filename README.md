# Crousty Click & Collect

Site de commande à emporter pour l'enseigne **Tasty Crousty** : le client choisit son restaurant, remplit son panier, choisit l'heure à laquelle il vient chercher sa commande ; en cuisine, l'équipier voit les commandes arriver et les fait avancer.

Projet réalisé en équipe, en méthode Scrum, dans le cadre du **BTS SIO option SLAM**.

> **Scénario pédagogique.** L'enseigne existe, mais le besoin est inventé pour le projet. Les restaurants, les prix et les personnes sont fictifs.

---

## L'équipe

<!--
  TODO S1-01 (sprint 1) : présenter votre équipe.
    Consigne : remplacer la ligne « À compléter » par une ligne par membre, et indiquer
               à quel sprint chacun sera Scrum Master (le rôle change à chaque sprint).
    Indice   : dans un tableau Markdown, chaque ligne commence et finit par « | ».
               Cliquez sur « Preview » (GitHub) pour voir le résultat.
-->

| Prénom Nom | Pseudo GitHub | Scrum Master au sprint |
|---|---|---|
| _Sébastien Esparza_ | _kito2020_ | _Sébastien S1-01_ |

---

## Ce que fait le site aujourd'hui

Au départ, le site **démarre et fonctionne**, mais il fait peu de choses : la page d'accueil vérifie que la base de données répond, les autres pages existent mais sont vides. À chaque sprint, vous complétez les parties marquées `TODO` (voir [Où est mon travail ?](#où-est-mon-travail-)).

---

## Prérequis

Deux façons de travailler. Choisissez **l'une ou l'autre**.

| | Poste du lycée (Windows) | Codespace (dans le navigateur) |
|---|---|---|
| Pour qui ? | En séance, au lycée | Chez vous, sans rien installer, depuis n'importe quel ordinateur |
| À installer | SDK .NET 10, Visual Studio 2026 (ou VS Code + extension *C# Dev Kit*), XAMPP, Git | Rien : un compte GitHub suffit |
| Base de données | MariaDB de XAMPP | Préparée automatiquement |

Sur les postes du lycée, ces logiciels sont normalement déjà installés. S'il en manque un, prévenez votre enseignant.

Pour vérifier que .NET est bien là, ouvrez un terminal et tapez `dotnet --version` : le résultat doit commencer par `10.`

---

## Installation sur un poste du lycée

### 1. Récupérer le dépôt de l'équipe

Dans un terminal (Git Bash, ou le terminal de VS Code) :

```bash
git clone https://github.com/PSEUDO-DU-SCRUM-MASTER/NOM-DU-DEPOT.git
cd NOM-DU-DEPOT
```

### 2. Démarrer MySQL

Ouvrez le **panneau de contrôle XAMPP** et cliquez sur **Start** sur la ligne **MySQL**. La ligne doit devenir verte.

### 3. Créer la base de données

Ouvrez **phpMyAdmin** (bouton **Admin** de la ligne MySQL dans XAMPP, ou http://localhost/phpmyadmin). Puis, **dans cet ordre** :

1. onglet **Importer** → choisir `sql/01-schema.sql` → **Importer** (crée la base `crousty` et ses tables) ;
2. onglet **Importer** → `sql/02-donnees.sql` → **Importer** (ajoute les restaurants, la carte, les comptes de test) ;
3. onglet **Importer** → `sql/03-utilisateur-app.sql` → **Importer** (crée le compte MySQL utilisé par le site).

> Le script `01-schema.sql` supprime la base `crousty` si elle existe déjà : phpMyAdmin vous demande de confirmer. C'est normal. Relancer les 3 scripts permet de repartir d'une base propre à tout moment.

### 4. Créer le fichier `.env`

Le fichier `.env` contient les informations de connexion à la base. Il est propre à votre poste et **n'est jamais envoyé sur GitHub**.

Dans le terminal, à la racine du dépôt :

```bash
copy .env.example .env      # sous Windows (invite de commandes)
cp .env.example .env        # sous Git Bash, Mac ou Linux
```

Les valeurs de `.env.example` fonctionnent telles quelles avec XAMPP : vous n'avez rien à modifier.

### 5. Lancer le site

- **Visual Studio** : ouvrez `CroustyClickCollect.sln`, puis appuyez sur **F5** (ou le bouton ▶ vert).
- **Terminal / VS Code** : à la racine du dépôt, tapez :

  ```bash
  dotnet run --project src/CroustyClickCollect
  ```

  puis ouvrez http://localhost:5000 dans le navigateur. Pour arrêter le site : **Ctrl + C** dans le terminal.

### 6. Vérifier

La page d'accueil doit afficher : **✔ Base de données connectée : 9 produits trouvés.**
Si elle affiche ✘, suivez les indications de la page, puis la rubrique [En cas de problème](#en-cas-de-problème).

---

## Installation dans un Codespace

1. Sur la page GitHub du dépôt de l'équipe : bouton vert **Code** → onglet **Codespaces** → **Create codespace on main**.
2. Patientez : la première fois, la préparation prend quelques minutes (installation de .NET, création de la base, copie du fichier `.env`).
3. Dans le terminal du Codespace (en bas), tapez :

   ```bash
   dotnet run --project src/CroustyClickCollect
   ```

4. Une fenêtre propose **Open in Browser** : le site s'ouvre dans un nouvel onglet.

> Un Codespace s'arrête tout seul après 30 minutes sans activité ; il redémarre en un clic depuis https://github.com/codespaces. Le compte GitHub gratuit donne un nombre d'heures limité par mois : pensez à arrêter votre Codespace quand vous avez fini.

---

## Lancer les tests

Les tests unitaires vérifient automatiquement que les règles du site sont respectées (calcul du total, créneaux, horaires…).

- **Visual Studio** : menu **Test** → **Explorateur de tests** → **Exécuter tout**.
- **Terminal** : à la racine du dépôt, tapez `dotnet test`.

Au départ, la plupart des tests sont **ignorés** (`Skip`) : vous les activerez au fil des sprints, quand le code correspondant sera écrit.

Les mêmes tests sont lancés par **GitHub Actions** à chaque push et à chaque pull request : coche verte ✔ = tout va bien, croix rouge ✘ = cliquez dessus pour lire l'erreur.

---

## Comptes de test du personnel

Pour se connecter à l'**Espace personnel** (à partir du sprint 5). Ces comptes n'existent que sur votre poste.

| Identifiant | Rôle | Restaurant |
|---|---|---|
| `equipier.republique` | Équipier | Tasty Crousty République |
| `gerant.republique` | Gérant | Tasty Crousty République |
| `equipier.gare` / `gerant.gare` | Équipier / Gérant | Tasty Crousty Gare |
| `equipier.esplanade` / `gerant.esplanade` | Équipier / Gérant | Tasty Crousty Esplanade |

Mot de passe de tous ces comptes : `Crousty2026!` (valable uniquement en développement).

---

## Organisation du dépôt

```
crousty-click-collect/
├── README.md                  ← ce fichier
├── CroustyClickCollect.sln    ← la « solution » à ouvrir dans Visual Studio
├── .env.example               ← modèle du fichier .env (sans vrai secret)
├── .gitignore                 ← ce que Git ne doit jamais envoyer (dont .env)
├── sql/                       ← scripts de la base, à exécuter dans l'ordre 01, 02, 03
├── docs/                      ← vos documents : sprints, conception, recette, Scrum
├── src/CroustyClickCollect/   ← le site
│   ├── Program.cs             ← démarrage du site (rien à modifier)
│   ├── Controllers/           ← reçoivent les demandes et choisissent la page à afficher
│   ├── Services/              ← les règles métier (panier, créneaux…) : pas de SQL ici
│   ├── Data/                  ← toutes les requêtes SQL, et seulement ici
│   ├── Models/                ← les classes du métier (Produit, Commande…)
│   ├── Views/                 ← les pages Razor (HTML + C#)
│   ├── Outils/                ← lecture du fichier .env (rien à modifier)
│   └── wwwroot/               ← fichiers envoyés tels quels au navigateur (CSS, JavaScript)
├── tests/CroustyClickCollect.Tests/   ← les tests unitaires (xUnit)
├── .github/                   ← robot de vérification (GitHub Actions) et Dependabot
└── .devcontainer/             ← configuration du Codespace
```

Le trajet d'une demande : le navigateur demande `/Carte` → `CarteController` → `ProduitRepository` (SQL) → la base → la liste revient au controller → la vue `Views/Carte/Index.cshtml` fabrique la page HTML.

---

## Où est mon travail ?

Les parties à compléter sont marquées par des **TODO numérotés** : `TODO S1-03` = sprint 1, tâche n°3. Chaque TODO contient une **consigne** et un **indice**.

- **Les retrouver** : recherche dans tous les fichiers (**Ctrl + Maj + F** dans Visual Studio et VS Code), tapez `TODO S1` pour le sprint 1.
- **La liste complète**, sprint par sprint : [docs/SPRINTS.md](docs/SPRINTS.md).
- **Des exemples complets** sont placés juste à côté des TODO (repérez les commentaires `EXEMPLE COMPLET`) : inspirez-vous-en.

À partir du sprint 6, certaines tâches n'ont plus de TODO : c'est à vous de trouver où et comment les faire.

---

## Règles Git de l'équipe

1. On ne travaille **jamais directement sur `main`**.
2. **Une branche par tâche**, avec un nom clair : `s1-03-carte`, `s2-01-restaurants`…
3. Des **petits commits** avec un message qui dit ce qui change : `Affiche la carte depuis la base`.
4. On fait **`git pull`** avant de commencer à travailler.
5. Toute **pull request est relue** par un coéquipier avant d'être fusionnée. Écrivez `Closes #numéro` dans sa description pour fermer l'issue correspondante.
6. **Jamais de mot de passe** dans le dépôt.

---

## Bonnes pratiques déjà en place

Ces bonnes pratiques (bloc 3 du BTS : cybersécurité) sont déjà dans le squelette. Chacune est aussi expliquée en commentaire dans le fichier concerné. **Ne les retirez pas.**

| Bonne pratique | Où la voir | Pourquoi |
|---|---|---|
| Les secrets sont hors du code | `.env.example`, `.gitignore`, `Outils/FichierEnv.cs` | Le mot de passe de la base n'apparaît jamais sur GitHub. |
| Le site n'utilise pas le compte `root` | `sql/03-utilisateur-app.sql` | Si le site est piraté, le compte ne peut ni supprimer une table, ni toucher aux autres bases. |
| Requêtes SQL paramétrées (`@id`) | `Data/RestaurantRepository.cs` (exemple) | Empêche l'injection SQL. |
| Mots de passe hachés | `sql/02-donnees.sql`, `Controllers/CompteController.cs` | La base ne contient que des empreintes, jamais les mots de passe. |
| Message de connexion vague | `Controllers/CompteController.cs` | On ne dit pas si c'est l'identifiant ou le mot de passe qui est faux. |
| Protection anti-CSRF | `Program.cs` | Un autre site ne peut pas envoyer un formulaire à votre place. |
| Pages réservées au personnel | `Controllers/CuisineController.cs` (`[Authorize]`) | Masquer un lien ne suffit pas : l'adresse peut être tapée à la main. |
| Restaurant lu dans le cookie de connexion, jamais dans l'adresse | `Controllers/CuisineController.cs` | Un équipier ne peut pas voir les commandes d'un autre restaurant. |
| Prix relus dans la base | `Controllers/PanierController.cs`, `Services/CommandeService.cs` | Un utilisateur peut modifier ce que son navigateur envoie. |
| Saisies vérifiées par le serveur | `Controllers/CommandeController.cs` | La vérification du navigateur (`required`) peut être contournée. |
| Pas de détail technique en production | `Program.cs`, `Controllers/HomeController.cs` | Un message d'erreur détaillé peut aider un pirate. |
| Cookies inaccessibles au JavaScript | `Program.cs` (`HttpOnly`) | Limite le vol de session en cas de faille XSS. |
| Collecte minimale de données (RGPD) | `Views/Commande/Valider.cshtml` | On ne demande que le prénom et le téléphone. |
| Compilation et tests automatiques | `.github/workflows/ci.yml` | Une erreur est repérée dès la pull request. |
| Bibliothèques surveillées | `.github/dependabot.yml` | GitHub prévient quand une bibliothèque a une faille connue. |

---

## En cas de problème

| Ce que vous voyez | Ce qu'il faut faire |
|---|---|
| `dotnet` n'est pas reconnu | Le SDK .NET n'est pas installé, ou le terminal était ouvert avant l'installation : fermez-le et rouvrez-le. |
| Accueil : ✘ et « Unable to connect » | MySQL n'est pas démarré : cliquez sur **Start** dans XAMPP. |
| Accueil : ✘ et « Access denied for user 'crousty_app' » | Le script `03-utilisateur-app.sql` n'a pas été exécuté, ou le fichier `.env` a été modifié. |
| Accueil : ✘ et « Unknown database 'crousty' » | Exécutez `01-schema.sql` puis `02-donnees.sql`. |
| Message « fichier .env introuvable » dans le terminal | Copiez `.env.example` en `.env` (étape 4). |
| XAMPP : MySQL ne démarre pas (port 3306) | Un autre MySQL tourne déjà sur le poste : prévenez votre enseignant. |
| « Address already in use » (port 5000) | Le site tourne déjà dans un autre terminal : arrêtez-le avec **Ctrl + C**. |
| La croix rouge ✘ apparaît sur GitHub | Cliquez dessus, puis sur l'étape en rouge : l'erreur est écrite, avec le fichier et le numéro de ligne. |
