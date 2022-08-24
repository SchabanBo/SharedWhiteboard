namespace Backend.Models;

public class Board
{
    public string Id { get; set; } = Guid.NewGuid().ToString();

    public string Name { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public int Users { get; set; }

    public bool IsDeleted { get; set; }

    public List<Path> Paths { get; set; } = new();
}