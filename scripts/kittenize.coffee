KITTENIZE_DICTIONARY = {
  "な": "にゃ",
  "ま": "みゃ",
  "よう": "にゃう",
  "([。！？])": "にゃ$1",
  "([^。！？])$" : "$1にゃ",
}

module.exports = (robot) ->
  robot.kitteninze = (text) ->
    console.log "input:" + text
    output = text
    for key, value of KITTENIZE_DICTIONARY
      output = output.replace(RegExp(key, 'm'), value)
    output
