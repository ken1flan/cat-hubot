KITTENIZE_DICTIONARY = {
  "な": "にゃ",
  "ま": "みゃ",
  "む": "みゅ",
  "よう": "にゃう",
  "。": "にゃ。",
  "！": "にゃ！",
  "？": "にゃ？",
  "[^。！？]$" : "にゃ",
}

module.exports = (robot) ->
  robot.kitteninze = (text) ->
    output = text
    for key, value of KITTENIZE_DICTIONARY
      output = output.replace(RegExp(key, 'm'), value)
    output
