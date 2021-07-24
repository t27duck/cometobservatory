const { merge } = require('webpack-merge')

const baseConfig = require('./base')
const devServer = require('../dev_server')
const { runningWebpackDevServer } = require('../env')

const { outputPath: contentBase, publicPath } = require('../config')

let devConfig = {
  mode: 'development',
  devtool: 'cheap-module-source-map'
}

if (runningWebpackDevServer) {
  if (devServer.hmr) {
    devConfig = merge(devConfig, {
      output: { filename: '[name]-[hash].js' }
    })
  }
// devserver useLocalIp: devServer.use_local_ip,
//  devserver inline: devServer.inline || devServer.hmr,
// devserver quiet: devServer.quiet,
// devserver clientLogLevel: 'none',
// devserver static  ...devServer.static,
  devConfig = merge(devConfig, {
    stats: {
      colors: true,
      entrypoints: false,
      errorDetails: true,
      modules: false,
      moduleTrace: false
    },
    devServer: {
      client: {
        overlay: devServer.overlay
      },
      devMiddleware: {
        publicPath
      },
      compress: devServer.compress,
      allowedHosts: devServer.allowed_hosts,
      host: devServer.host,
      port: devServer.port,
      https: devServer.https,
      hot: devServer.hmr,
      historyApiFallback: { disableDotRule: true },
      headers: devServer.headers,
      static: [
        contentBase
      ]
    }
  })
}

module.exports = merge(baseConfig, devConfig)
