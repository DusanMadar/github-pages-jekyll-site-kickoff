# GitHub Pages Jekyll site kickoff with Docker

This is a helper repo for anyone who simply wants to create a new Jekyll site
for GitHub Pages [from scratch], but doesn't want to go through the hassle of
installing the right versions of Ruby, Bundler, Jekyll  and friends, setting up
the Gemfile, and so on.

It builds on top of the [jekyll/jekyll Docker image](https://hub.docker.com/r/jekyll/jekyll/),
so all you need to have installed locally is Docker and Docker Compose. At the
time of writing
- GitHub Pages supported Jekyll 3.x
- latest official Jekyll 3.x image available on Docker Hub was 3.8

It's all summed up in the [kickoff_github_pages_jekyll_site.sh](kickoff_github_pages_jekyll_site.sh)
script, which
- creates a new Jekyll site in a dedicated working directory
- provides a [docker-compose.yml](docker-compose.yml) file that allows you to
run the site locally using Docker with a single command

### Disclaimer

My goal was to have an easy to use Docker based solution that would allow me to
quickly bootstrap a new Jekyll site for GitHub Pages.

Please note that I know literally nothing about how Ruby, Bundler, Jekyll and
the ecosystem in general works, so this is just a **quick and dirty solution**
that eventually [after hours of trial and error] **worked for me**.
Perhaps it will help to save you some precious time.

If you have an idea how to improve this, please feel free to open an issue or
submit a pull request.

## Usage

Run the following command in your terminal

```bash
docker run --rm --user $(id -u):$(id -g) -v ".:/srv/jekyll" jekyll/jekyll:3.8 sh kickoff_github_pages_jekyll_site.sh
```

A bit of context for the above command
- `--rm` removes the container after it exits
- `--user $(id -u):$(id -g)` runs the container as the current user, so that
the files created by the container are owned by the current user and not the
root user
  - otherwise, you might run into permission issues when the script tries to
  edit the files created by the container (e.g. when bundler updates Gemfile)
- `-v ".:/srv/jekyll"` mounts the current directory as a volume so that the
files created by the container are available for running the site later on
- `jekyll/jekyll:3.8` is the name and version of the used Docker image
- `sh kickoff_github_pages_jekyll_site.sh` is the command to run inside the
container to bootsrap a new Jekyll site

### Output

After the above command is finished, you should see a new directory in the
format of `github-pages-jekyll-site-<timestamp>` (timestamp being in the format
of `yyyy-mm-dd-HH-MM`).

Say the created directory is called
`github-pages-jekyll-site-2023-09-03-12-00/` and its contents should look like

```bash
$ ls github-pages-jekyll-site-2023-09-03-08-24/
404.html  about.md  _config.yml  docker-compose.yml  Gemfile  Gemfile.lock  index.md  _posts  vendor
```

NOTE: [docker-compose.yml](docker-compose.yml) is copied into the working
directory for convenience.

Feel free to copy the contents of the directory to a new repository for your
Github Pages site.

### Run the site locally with Docker Compose

Now you can run the site locally using Docker Compose

```bash
$ cd github-pages-jekyll-site-2023-09-03-08-24/
$ docker-compose up -V
```

after which you should be able to access the site at http://localhost:4000.

## Credits

- [docker-compose.yml](docker-compose.yml) is based on the one from
[Docker Compose and Jekyll](https://urre.me/writings/docker-compose-and-jekyll/)
- [How to use Develop Jekyll (and GitHub Pages) locally using Docker containers](
https://github.com/BillRaymond/my-jekyll-docker-website)
by Bill Raymond is an excellent resource which proved to be helpful in
putting this guide together
  - it's quite detailed and covers a lot of related topics, but it's a great
  read if you want to understand how the whole thing works
