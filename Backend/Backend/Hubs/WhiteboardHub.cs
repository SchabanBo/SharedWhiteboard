using Backend.Models;
using Microsoft.AspNetCore.SignalR;
using Path = Backend.Models.Path;

namespace Backend.Hubs;

public class WhiteboardHub : Hub
{
    private static IDictionary<string, Board> _boards = new Dictionary<string, Board>();

    public async Task AddBoard(string name)
    {
        var board = new Board { Name = name };
        _boards.Add(board.Id, board);
        await Clients.All.SendAsync(WhiteboardHubChannels.BoardUpdated.ToString(), board);
    }

    public async Task RemoveBoard(string id)
    {
        _boards.Remove(id);
        await Clients.All.SendAsync(WhiteboardHubChannels.BoardUpdated.ToString(), new Board { Id = id, IsDeleted = true });
    }

    public async Task<List<Board>> GetBoards()
    {
        return _boards.Values.Select(b =>
        {
            b.Paths = new List<Path>();
            return b;
        }).ToList();
    }

    public async Task<Board> GetBoard(string id)
    {
        return _boards[id];
    }

    public async Task<string> AddPath(Path path)
    {
        path.Id = Guid.NewGuid().ToString();
        _boards[path.BoardId].Paths.Add(path);
        await Clients.Group(path.BoardId).SendAsync(WhiteboardHubChannels.PathAdded.ToString(), path);

        return path.Id;
    }

    public async Task AddPoint(Point point)
    {
        _boards[point.BoardId].Paths.First(p => p.Id == point.PathId).Points.Add(point);
        await Clients.Group(point.BoardId).SendAsync(WhiteboardHubChannels.PointAdded.ToString(), point);
    }

    public async Task UserUpdate(string boardId, bool isEnter)
    {
        var board = _boards[boardId];

        if (isEnter)
        {
            board.Users++;
            await Groups.AddToGroupAsync(Context.ConnectionId, board.Id);
        }
        else
        {
            board.Users--;
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, board.Id);
        }

        await Clients.All.SendAsync(WhiteboardHubChannels.UserUpdated.ToString(), boardId, isEnter);
    }
}

public enum WhiteboardHubChannels
{
    BoardUpdated,
    PathAdded,
    PointAdded,
    UserUpdated,
}