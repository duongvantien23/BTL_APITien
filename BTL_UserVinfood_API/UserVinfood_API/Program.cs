using BussinessLayer;
using BussinessLayer.Interface;
using DataAccessLayer;
using DataAccessLayer.Interface;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(option =>
{
    option.AddPolicy("MyCors", build =>
    {
        build.WithOrigins("*").AllowAnyMethod().AllowAnyHeader();
    });
});

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddTransient<IDatabaseHelper, DatabaseHelper>();
builder.Services.AddTransient<IDanhMucBusiness, DanhMucBusiness>();
builder.Services.AddTransient<IDanhMucRepository, DanhMucRepository>();
builder.Services.AddTransient<ISanPhamBusiness, SanPhamBusiness>();
builder.Services.AddTransient<ISanPhamRepository, SanPhamRepository>();
builder.Services.AddTransient<ITinTucBusiness, TinTucBusiness>();
builder.Services.AddTransient<ITinTucRepository, TinTucRepository>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseCors("MyCors");
app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
