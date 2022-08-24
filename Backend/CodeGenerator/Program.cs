// create a runner
using Backend.Hubs;
using Backend.Models;
using DartSignalR;
using DartSignalR.Types;
using Path = System.IO.Path;

var runner = new ConverterRunner();

// Create you convert requests
var requests = new List<ConvertRequest> {
    ConvertRequest.For<WhiteboardHub>(isSignalRHub:true),
    ConvertRequest.For<Board>(editableClass:true),
    ConvertRequest.For<WhiteboardHubChannels>(),
};

// run 
var code = runner.Run(requests);

Console.WriteLine(code);

var fileName = "../../frontend/lib/dart_signalR.g.dart";
File.WriteAllText(Path.Combine(Environment.CurrentDirectory, fileName), code);