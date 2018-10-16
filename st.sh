# 16-10-2018 JHZ

git add README.md
git commit -m "README"
for d in INSTALL.md PARALLEL.md st.sh
do
   git add $d
   git commit -m "$d"
done
git push
