module.exports = (robot) ->
  robot.respond /ROOM_ID/i, (msg) ->
    message =
      "idobataのROOM_IDですか？ " +
      msg.message.data.room_id +
      "ですにゃ。"
    msg.reply message
