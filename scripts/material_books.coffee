CIRCLE_TOKEN = process.env.MATERIAL_BOOKS_CIRCLE_TOKEN
PROJECT = "ken1flan/material_books"
BRANCH = "master"
CIRCLE_API_URL = "https://circleci.com/api/v1/project/#{PROJECT}/tree/#{BRANCH}?circle-token=#{CIRCLE_TOKEN}"

module.exports = (robot) ->
  robot.updateMaterialBooksGems = (proc) ->
    data = JSON.stringify({
      build_parameters:
        BUNDLE_UPDATE: "true"
    } )
    request = robot.http(CIRCLE_API_URL)
      .header('Content-Type', 'application/json')
      .post(data)
    request (err, res, body) ->
      proc(err)
