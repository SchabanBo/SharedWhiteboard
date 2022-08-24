using Backend.Hubs;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddSignalR();
builder.Services.AddCors();

var app = builder.Build();

app.UseHttpsRedirection();
app.MapHub<WhiteboardHub>("/hubs/white-board");
app.UseCors(builder => builder.AllowAnyOrigin());

app.Run();
