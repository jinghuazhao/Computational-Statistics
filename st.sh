# 21-5-2019 JHZ

git add README.md
git commit -m "README"
for d in INSTALL.md LANGUAGES.md PARALLEL.md REPRODUCE.mdSYSTEMS.md st.sh
do
   git add $d
   git commit -m "$d"
done
git push
