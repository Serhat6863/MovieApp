MovieApp – Une application de films moderne

![Flutter](https://img.shields.io/badge/Flutter-3.7.2+-blue)
![Dart](https://img.shields.io/badge/Dart-2.19+-blue)
![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-green)
![BLoC](https://img.shields.io/badge/State%20Management-BLoC-purple)

**MovieApp** est une application mobile développée avec **Flutter** qui permet de découvrir, rechercher et explorer des films à travers une interface moderne et intuitive.  
Ce projet met en avant une **architecture modulaire, propre et maintenable**, basée sur le pattern **Clean Architecture + BLoC**.

---

## Fonctionnalités

-  **Découverte de films** – Liste des films populaires ou récents  
-  **Recherche avancée** – Trouvez rapidement un film par titre  
-  **Architecture modulaire** – Séparation claire des couches `data`, `domain` et `presentation`  
-  **Performances optimisées** – Requêtes rapides et gestion d’état fluide via BLoC  
-  **Interface moderne** – UI responsive et élégante  

---

##  Plateformes supportées

-  Android  
-  iOS  

---

## Installation

1. Installer le **Flutter SDK** : [Guide officiel](https://flutter.dev/docs/get-started/install)  
2. Cloner le dépôt :  
```bash
git clone https://github.com/Serhat6863/MovieApp.git
```
3. Accéder au dossier du projet et installer les dépendances :
```bash
cd myapp
flutter pub get
```
4. Générer le code nécessaire (Retrofit, JSON, etc.)
```bash
 flutter pub run build_runner build --delete-conflicting-outputs
```
5. Run the app on your desired platform:
```bash
flutter run
```

---

## Prérequis

Avant de lancer **MovieApp**, assurez-vous d’avoir :

-  **Flutter SDK ≥ 3.7.2**  
-  **Dart SDK ≥ 2.19**
-  **Android Studio** ou **VS Code** avec l’extension Flutter  
-  **Émulateur Android/iOS** ou un appareil physique pour tester l’application

---

## Exécuter un test
-Pour executer un test 
```bash
flutter test
```
---

## Usage

Cette section vous guide à travers les principales fonctionnalités de MovieApp.

## Écran d’accueil

Dès le lancement de l’application, vous accédez à la page d’accueil présentant les films et séries les mieux notés.

-Top Rated Movies : découvrez les films les plus populaires du moment.
-Top Rated TV Shows : explorez les meilleures séries actuelles.
-Vous pouvez faire défiler horizontalement pour parcourir les affiches.

## Écran de recherche

Cet écran vous permet de rechercher n’importe quel film ou série grâce à la barre de recherche située en haut.

-Tapez le nom d’un film ou d’une série (ex. : Batman).
-Les résultats s’affichent instantanément avec les affiches correspondantes.

## Écran de détails

Après avoir sélectionné un film ou une série, vous accédez à une page détaillée :

-Affiche haute qualité
-Titre original
-Date de sortie
-Langue originale
-Note moyenne
-Section “Overview” pour lire le résumé

## Navigation

L’application propose une barre de navigation inférieure vous permettant de passer facilement d’un écran à l’autre :

-Home : accéder à la page principale
-Search : effectuer une recherche rapide

##  Captures d’écran et Démonstration





