# Crear Repositorio GitHub desde Terminal

## Instalar GitHub CLI (opcional)

```bash
# Windows (con Chocolatey)
choco install gh

# Windows (con Scoop)
scoop install gh

# Windows (con winget)
winget install GitHub.cli
```

## Crear repositorio

```bash
# Login a GitHub
gh auth login

# Crear repositorio
gh repo create FamilySync --public --description "🏠 Calendario Familiar Inteligente - Sincronización en tiempo real para familias modernas"

# Conectar repositorio local
git remote add origin https://github.com/[tu-usuario]/FamilySync.git
```

## Push inicial

```bash
git branch -M main
git push -u origin main
```



