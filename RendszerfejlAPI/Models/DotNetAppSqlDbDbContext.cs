using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace RendszerfejlAPI.Models;

public partial class DotNetAppSqlDbDbContext : DbContext
{
    public DotNetAppSqlDbDbContext()
    {
    }

    public DotNetAppSqlDbDbContext(DbContextOptions<DotNetAppSqlDbDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Alkatresz> Alkatreszs { get; set; }

    public virtual DbSet<Megrendele> Megrendeles { get; set; }

    public virtual DbSet<MigrationHistory> MigrationHistories { get; set; }

    public virtual DbSet<Projekt> Projekts { get; set; }

    public virtual DbSet<Raktar> Raktars { get; set; }

    public virtual DbSet<Todo> Todoes { get; set; }

    public virtual DbSet<UserProfile> UserProfiles { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Data Source=dotnetappsqldbrendszerfejl-dbserver.database.windows.net;Initial Catalog=DotNetAppSqlDb_db;Persist Security Info=True;User ID=sqladmin;Password=PP&a>O>_D?pU-380");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Alkatresz>(entity =>
        {
            entity.HasKey(e => e.ElemId).HasName("PK__Alkatres__0A8C04C5EC4CA50F");

            entity.ToTable("Alkatresz");

            entity.Property(e => e.ElemId).HasColumnName("elem_id");
            entity.Property(e => e.AlkatreszAllapot)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("alkatresz_allapot");
            entity.Property(e => e.ElemAr).HasColumnName("elem_ar");
            entity.Property(e => e.ElemNev)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("elem_nev");
            entity.Property(e => e.Keszlet).HasColumnName("keszlet");
            entity.Property(e => e.LefoglaltKeszlet).HasColumnName("lefoglalt_keszlet");
            entity.Property(e => e.Meret).HasColumnName("meret");
        });

        modelBuilder.Entity<Megrendele>(entity =>
        {
            entity.HasKey(e => e.MegrendelesId).HasName("PK__Megrende__BA5E185110B9DDB4");

            entity.ToTable(tb => tb.HasTrigger("tr_ins_megr"));

            entity.Property(e => e.MegrendelesId).HasColumnName("megrendeles_id");
            entity.Property(e => e.ElemDb).HasColumnName("elem_db");
            entity.Property(e => e.ElemId).HasColumnName("elem_id");
            entity.Property(e => e.ElofoglaltKeszlet).HasColumnName("elofoglalt_keszlet");
            entity.Property(e => e.Foglalt)
                .HasDefaultValueSql("((0))")
                .HasColumnName("foglalt");
            entity.Property(e => e.LefoglalandoKeszlet).HasColumnName("lefoglalando_keszlet");
            entity.Property(e => e.SzabadKeszlet).HasColumnName("szabad_keszlet");
            entity.Property(e => e.SzuksegesKeszlet).HasColumnName("szukseges_keszlet");

            entity.HasOne(d => d.Elem).WithMany(p => p.Megrendeles)
                .HasForeignKey(d => d.ElemId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK__Megrendel__elem___31B762FC");
        });

        modelBuilder.Entity<MigrationHistory>(entity =>
        {
            entity.HasKey(e => new { e.MigrationId, e.ContextKey }).HasName("PK_dbo.__MigrationHistory");

            entity.ToTable("__MigrationHistory");

            entity.Property(e => e.MigrationId).HasMaxLength(150);
            entity.Property(e => e.ContextKey).HasMaxLength(300);
            entity.Property(e => e.ProductVersion).HasMaxLength(32);
        });

        modelBuilder.Entity<Projekt>(entity =>
        {
            entity.HasKey(e => e.ProjektId).HasName("PK__Projekt__C0A091192338A1F5");

            entity.ToTable("Projekt");

            entity.Property(e => e.ProjektId).HasColumnName("projekt_id");
            entity.Property(e => e.Allapot)
                .HasMaxLength(40)
                .IsUnicode(false)
                .HasColumnName("allapot");
            entity.Property(e => e.Datum)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("date")
                .HasColumnName("datum");
            entity.Property(e => e.MegrendelesId).HasColumnName("megrendeles_id");
            entity.Property(e => e.Osszeg).HasColumnName("osszeg");

            entity.HasOne(d => d.Megrendeles).WithMany(p => p.Projekts)
                .HasForeignKey(d => d.MegrendelesId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK__Projekt__megrend__3F115E1A");
        });

        modelBuilder.Entity<Raktar>(entity =>
        {
            entity.HasKey(e => e.RekeszId).HasName("PK__Raktar__CDAEF5B1A332062D");

            entity.ToTable("Raktar");

            entity.Property(e => e.RekeszId).HasColumnName("rekesz_id");
            entity.Property(e => e.ElemId).HasColumnName("elem_id");
            entity.Property(e => e.Oszlop).HasColumnName("oszlop");
            entity.Property(e => e.RekeszMeret).HasColumnName("rekesz_meret");
            entity.Property(e => e.Sor).HasColumnName("sor");
            entity.Property(e => e.Szint).HasColumnName("szint");

            entity.HasOne(d => d.Elem).WithMany(p => p.Raktars)
                .HasForeignKey(d => d.ElemId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("FK__Raktar__elem_id__2EDAF651");
        });

        modelBuilder.Entity<Todo>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK_dbo.Todoes");

            entity.Property(e => e.Id).HasColumnName("ID");
            entity.Property(e => e.CreatedDate).HasColumnType("datetime");
        });

        modelBuilder.Entity<UserProfile>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__UserProf__1788CC4C2C6E8EE7");

            entity.ToTable("UserProfile");

            entity.Property(e => e.Password)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.UserName)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.UserType)
                .HasMaxLength(50)
                .IsUnicode(false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
