var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/health", () => Results.Ok("ok"));

app.MapGet("/api/info", () => new
{
    name = "devops-demo",
    env = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "unknown",
    machine = Environment.MachineName
});

app.Run();
