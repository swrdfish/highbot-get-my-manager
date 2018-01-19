# Description
#   a hubot script that tells who your official manager is
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot hello - <what the respond trigger does>
#   orly - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#    <aditya-atul>

Axios = require 'axios'

module.exports = (robot) ->

  regex = /(\bwho\s*is\s*my\s*manager)|(\bget\s*my\s*manager)|(my\s*man)/i

  robot.hear regex, (res) ->
    if res.message.token == undefined
      res.send 'someone who earns more than you :P'
    else
      Axios({
        url: '/me/manager',
        method: 'get',
        baseURL: 'https://graph.microsoft.com/v1.0/',
        headers: {'Authorization': 'Bearer ' + res.message.token},
        responseType: 'json', 
      }).then((response)=>
        reply = "Your manager is: <a href=\"mailto:" + response.data.mail + "\">" + response.data.displayName + "</a>" 
        res.send reply
      ).catch((error) =>
        console.log(error)
        res.send 'someone who earns more than you :P'
      )


