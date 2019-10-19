// eslint-disable-next-line @typescript-eslint/no-var-requires
const path = require('path');
// eslint-disable-next-line @typescript-eslint/no-var-requires
const webpack = require('webpack');
// eslint-disable-next-line @typescript-eslint/no-var-requires
const HtmlWebpackPlugin = require('html-webpack-plugin');
// eslint-disable-next-line @typescript-eslint/no-var-requires
const CheckPlugin = require('awesome-typescript-loader');


const resolve = (...paths) => path.join(__dirname, ...paths)
module.exports = {
  externals: {
    react: 'React',
    'react-dom': 'ReactDOM'
  },
  entry: {
    app: './src/index.js',
  },
  output: {
    filename: '[name].js',
    path: resolve('build')
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js', '.jsx', ''],
    alias: {
      'vue$': 'vue/dist/vue.esm.js',
      '@': resolve('src'),
    }
  },
  plugins: [
    new CheckPlugin(),
    new HtmlWebpackPlugin({
      filename: 'index.html',
      template: 'src/app/index.html',
      // excludeChunks: ['background', 'content', 'exchanger'],
      inject: true,
    }),
    new CleanWebpackPlugin(['build']),
    // devServer {
    new webpack.NamedModulesPlugin(),
    new webpack.HotModuleReplacementPlugin(),
    // }
  ],
  devServer: {
    contentBase: './build',
    port: 8888,
    hot: true
  },
  performance: {
    hints: false,
  },
  optimization: {
    splitChunks: {
      name: true,
      minChunks: Infinity,
    },
    minimizer: [],
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        use: ['babel-loader', 'source-map-loader'],
        include: [resolve('src')],
      },
      {
        test: /\.(ts|tsx)$/,
        use: 'awesome-typescript-loader',
        include: [resolve('src')],
      },
      {
        test: /\.styl(us)$/,
        use: [
          'css-loader',
          'stylus-loader',
          'postcss-loader'
        ]
      },
      {
        test: /\.(png|jpg|jpeg|gif)$/,
        use: [{
          loader: 'url-loader',
          options: {
            limit: 8192
            }
          }]
      },
      {
        test: /\.(woff|woff2|eot|ttf|otf)$/,
        use: ['file-loader']
      },
      {
        test: /\.md$/,
        use: [
          { loader: 'html-loader' },
          { loader: 'markdown-loader' },
        ]
      },
    ]
  }
};
