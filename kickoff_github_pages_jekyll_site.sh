#!/bin/sh

# Create a dir for the new page.
site_path="github-pages-jekyll-site-$(date '+%Y-%m-%d-%H-%M')"
mkdir $site_path
cd $site_path

# Install dependencies to vendor/bundle directory.
mkdir -p vendor/bundle
echo '---' > vendor/bundle/config
echo 'BUNDLE_PATH: "vendor/bundle"' >> vendor/bundle/config

# Create a new Gemfile with the github-pages gem.
bundle init
echo 'gem "github-pages", group: :jekyll_plugins' >> Gemfile

# Install dependencies and create a new Jekyll site in the current directory.
bundle install --path vendor/bundle
bundle exec jekyll new --force --skip-bundle .

# Comment out the jekyll gem and uncomment the github-pages gem. The Gemfile
# itself suggests to use github-pages instead of jekyll gem for GitHub Pages.
sed -i '/^gem "jekyll",/s/^/# /' Gemfile
sed -i '/^# gem "github-pages",/s/^# //' Gemfile

# Install dependencies again to make sure everything required by github-pages
# gem is installed.
bundle install --path vendor/bundle

# Add vendor directory to .gitignore.
echo "vendor" >> .gitignore

# Copy docker-compose.yml to the new site directory so it can be worked on.
cp ../docker-compose.yml .
