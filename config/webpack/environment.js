const { environment } = require('@rails/webpacker')
const webpack = require('webpack')
 
environment.plugins.prepend(
   'Provide',
   new webpack.ProvidePlugin({
       $: 'jquery',
       jQuery: 'jquery',
       jquery: 'jquery',
       Popper: 'popper.js'
   })
)
module.exports = environment
