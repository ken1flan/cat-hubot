KITTENIZE_DICTIONARY = {
  "な": "にゃ",
  "ナ": "ニャ",
  "ま": "みゃ",
  "マ": "ミャ",
  "よう": "にゃう",
  "ヨウ": "ニャウ",
  "([。！？])": "にゃ$1",
  "([^。！？])$" : "$1にゃ",
}

module.exports = (robot) ->
  robot.kitteninze = (text) ->
    output = text
    for key, value of KITTENIZE_DICTIONARY
      output = output.replace(RegExp(key, 'm'), value)
    output
