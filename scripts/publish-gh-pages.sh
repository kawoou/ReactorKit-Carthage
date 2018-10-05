# Clean
rm -rf _temp/

# Publish
mkdir _temp/
git clone git@github.com:kawoou/ReactorKit-Carthage.git -b gh-pages _temp
cd _temp/
git branch -m gh-pages _gh-pages
git checkout --orphan gh-pages
git reset -- *
rm -rf ./*
rm .gitignore
rm .travis.yml
cp ../ReactorKit ./
cp ../ReactorKit-Static ./
git add ./*
git commit -am "Update carthage file."
git push origin gh-pages -f
cd ..

# Clean
rm -rf _temp/

