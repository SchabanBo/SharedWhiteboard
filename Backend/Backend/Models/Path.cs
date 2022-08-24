namespace Backend.Models;

public class Path
{
    public string Id { get; set; }

    public string BoardId { get; set; }

    public string Color { get; set; }

    public double Stroke { get; set; }

    public List<Point> Points { get; set; } = new();

}