# tia-grandgousier

Projet de T.I.A, bot conseiller en vins , partie web app.

## Build Setup

First, configure the API Url by 2 ways :

* Modify API_URL in `web/config/prod.env.js` with the correct URL

* or create a `.env` file at the root of ``web/`` with the following content. Change the API_URL to yours.
```bash
  API_URL="127.0.0.1:8081"
```

``` bash
# install dependencies
npm install

# serve locally with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report

```

As this app was designed as web app, it requires to be deployed on a web server. Built files are meant to be served over an HTTP server. **Opening index.html over file:// won't work.**
To do so, locally and for test purpose, a web server can be executed. Many solutions exist :

* Use BusyBox, pre-installed in most Linux distribution

  ```bash
    busybox httpd -p 127.0.0.1:8080 -h web/dist/  #to start httpd in web/dist
    pkill busybox  # to stop busybo httpd
  ```
* Use Python module SimpleHTTPServer

  ```bash
    cd web/dist   # Move to the build folder
    python -m SimpleHTTPServer 8080  # to start a python web server on port 8080
  ```

* [More details](https://www.pcsuggest.com/best-lightweight-web-server-linux/)

For a detailed explanation on how things work, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).
