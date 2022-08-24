# Shared Whiteboard

- [Shared Whiteboard](#shared-whiteboard)
  - [Backend](#backend)
    - [Models](#models)
    - [SignalR Hub](#signalr-hub)
    - [Dart code generator](#dart-code-generator)
  - [Frontend](#frontend)
    - [Pages](#pages)
      - [Splash](#splash)
      - [Boards](#boards)
      - [Board](#board)

This project is a whiteboard application where users can create and share whiteboards with each other.

The [Backend](#backend) is **.NET Core** uses **SignalR** for the socket and [DartSignalR](https://www.nuget.org/packages/DartSignalR) for generated the signalr client dart class.

The [Frontend](#frontend) is **flutter** with **MVVM** as design pattern and use these packages:

- [reactable](https://github.com/SchabanBo/reactable): a reactive state management package.
- [signalr_core](https://pub.dev/packages/signalr_core): for connecting to the socket.

## Backend

The backend contains:

### Models

- **Board:** The board information with all paths in it.
- **Path:** The path that user draw on the board with the pen color and width and all the points.
- **Point:** the points of a path.

### SignalR Hub

The hub that connect all users to each other. have all the methods that user can call.

- **AddBoard**: a method to create a new board and notify all users.
- **RemoveBoard**: a method to remove a board and notify all users.
- **GetBoards**: a method to get all available boards.
- **GetBoard**: a method to get a board info by id.
- **AddPath**: a method to add a new path to a board and notify all users.
- **AddPoint**: a method to add a new point to a path and notify all users.
- **UserUpdate**: If user joins or leaves a board, the hub will send the update to all users.

### Dart code generator

A project that generate the dart code for the dart client from the backend hub class. Read more about it [here](https://github.com/SchabanBo/DartSignalR).

## Frontend

### Pages

#### Splash

This page is the first page in the app where the app will try to connect to the server. When the app is connected, it will go to the [Boards](#boards) page. otherwise, it will show the error message.

#### Boards

This page will show all available boards to join and the board information

Board information includes:
- Board name
- Board creation time.
- How many users are currently in the board.

From this page, users can create a new board, delete a board or join one.

#### Board

In this page the user can draw on the whiteboard. change the color and the size of the pen.