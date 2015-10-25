DOCOMO_API_KEY = process.env.DOCOMO_API_KEY
DIALOGUE_API_URL = 'https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue?APIKEY=' + DOCOMO_API_KEY
KNOWLEDGE_API_URL = 'https://api.apigw.smt.docomo.ne.jp/knowledgeQA/v1/ask?APIKEY=' + DOCOMO_API_KEY

module.exports = (robot) ->
  robot.responseDialogue = (user_talk, proc) ->
    context = robot.brain.get('dialogue_context')
    data = JSON.stringify({
      utt: user_talk,
      context: context
    })
    request = robot.http(DIALOGUE_API_URL)
      .header('Content-Type', 'application/json')
      .post(data)
    request (err, res, body) ->
      json = JSON.parse body
      robot.brain.set('dialogue_context', json['context'])
      proc(json)

  robot.responseKnowledge = (user_talk, proc) ->
    user_talk_encoded = encodeURIComponent(user_talk)
    request = robot.http(KNOWLEDGE_API_URL + '&q=' + user_talk_encoded)
      .header('Content-Type', 'application/json')
      .get()
    request (err, res, body) ->
      json = JSON.parse body
      robot.brain.set('dialogue_context', json['context'])
      proc(json)

  robot.hear /^((?!天気).)*$/i, (msg) ->
    robot.responseDialogue msg.match[0], (json) ->
      response = robot.kitteninze(json['utt'])
      msg.reply response
