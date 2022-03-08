
# ios-mvvm
This project is a simple example of MVVM Architecture.

MVVM architecture offers two-way data binding between view and view-model. It also helps you to automate the propagation of modifications inside View-Model to the view. The view-model makes use of observer pattern to make changes in the view-model.

Let’s see each other this component in detail:

### Model

The model stores data and related logic. It represents data that is being transferred between controller components or any other related business logic.

For example, a Controller object will retrieve the student info from the school database. It manipulates data and sends it back to the database or use it to render the same data.

### View:

The View stands for UI components like HTML, CSS, jQuery, etc. In MVVC pattern view is held responsible for displaying the data which is received from the Controller as an outcome. This View is also transformed Model (s) into the User Interface (UI).

### View Model:

The view model is responsible for presenting functions, commands, methods, to support the state of the View. It is also accountable to operate the model and activate the events in the View.

## Features of MVC

Here are important features of MVC:

-   Easy and frictionless testability. Highly testable, extensible and pluggable framework
-   It also you to leverage existing features offered by ASP.NET, Django, JSP, etc.
-   It offers full control over your HTML as well as your URLs.
-   It supports Test Driven Development (TDD)
-   This architecture offers separation of logic
-   Allows routing for SEO Friendly URLs.
-   Offers to map for comprehensible and searchable URLs.

## Features of MVVM

Here, are features of MVVM architecture:

-   MVVM is written for desktop application with data binding capabilities – XAML and the INotifyPropertyChanged interface
-   If you want to do modification in the View-Model, the View-Model uses an observer pattern.
