@echo off
echo 🚀 Desplegando FamilySync con GitHub Actions...

echo 📝 Agregando archivos...
git add .

echo 💾 Haciendo commit...
git commit -m "Deploy with GitHub Actions - Remove login screen"

echo 🚀 Haciendo push a main...
git push origin main

echo ✅ ¡Listo! GitHub Actions se encargará del resto.
echo 🌐 La app estará disponible en: https://dowhi.github.io/FamilySync
echo ⏱️ Espera 2-3 minutos para que se complete el despliegue.
pause
